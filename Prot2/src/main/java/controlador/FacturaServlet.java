/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.FacturaCabecera;
import modelo.FacturaDetalle;
import modelo.Prefijo;
import modeloMng.ClienteJpaController;
import modeloMng.FacturaCabeceraJpaController;
import modeloMng.FacturaDetalleJpaController;
import modeloMng.PrefijoJpaController;

/**
 *
 * @author User
 */
@WebServlet(name = "FacturaServlet", urlPatterns = {"/FacturaServlet"})
public class FacturaServlet extends HttpServlet {

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        FacturaCabeceraJpaController factCabControl = new FacturaCabeceraJpaController();
        ClienteJpaController clienteControl = new ClienteJpaController();
        FacturaDetalleJpaController facturaDetalleControl = new FacturaDetalleJpaController();
        PrefijoJpaController prefijoControl = new PrefijoJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        if(request.getParameter("agregar") != null){
            try{
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));  
                System.out.println(idCliente);
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                System.out.println(fecha);
                BigInteger nroFactura = new BigInteger(request.getParameter("numFact"));
                System.out.println(nroFactura);
                String condVenta = request.getParameter("cond_venta");
                System.out.println(condVenta);
                String formaPago = request.getParameter("forma_pago");
                System.out.println(formaPago);
                String banco = request.getParameter("banco");
                System.out.println(banco);
                String nroFormaPago = request.getParameter("nroFormaPago");
                System.out.println(nroFormaPago);

                String descripcion = request.getParameter("descripcion");
                System.out.println(descripcion);
                BigInteger monto = new BigInteger(request.getParameter("monto"));
                System.out.println(monto);
                BigInteger iva = new BigInteger(request.getParameter("iva"));
                System.out.println(iva);
                
                FacturaCabecera cabecera = new FacturaCabecera();
                cabecera.setIdCliente(clienteControl.findCliente(idCliente));
                cabecera.setFecha(fecha);
                cabecera.setNumeroFactura(nroFactura);
                cabecera.setCondicionVenta(condVenta);
                cabecera.setFormaPago(formaPago);
                if(formaPago.equals("Cheque")){
                    cabecera.setNumeroCheque(nroFormaPago);
                }else{
                    cabecera.setNumeroCuenta(nroFormaPago);
                }
                cabecera.setEstado("Pagado");
                cabecera.setBanco(banco);
                
                factCabControl.create(cabecera);
                
                FacturaDetalle detalle = new FacturaDetalle();
                detalle.setIdFactura(cabecera); 
                detalle.setItem(1);
                detalle.setDescripcion(descripcion);
                detalle.setMonto(monto);
                detalle.setIva(iva);
                
                facturaDetalleControl.create(detalle);
                
                Prefijo prefijo = prefijoControl.findPrefijoEntities().get(0);
                prefijo.setId(prefijo.getId()+1);
                
                prefijoControl.edit(prefijo);
                
                
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar la facturación");
            
            }finally{
                response.sendRedirect("facturaciones.jsp");
            }
            
        }
        
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
