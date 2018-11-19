/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Locale;
import modelo.Cliente;
import modeloMng.FacturaCabeceraJpaController;
import modelo.FacturaCabecera;
import net.sf.jasperreports.engine.JasperRunManager;
import modeloMng.ClienteJpaController;
import java.sql.DriverManager;
import javax.persistence.Persistence;
import javax.persistence.EntityManagerFactory;
import javax.persistence.EntityManager;
import java.sql.Connection;
import java.util.Map;
import java.util.HashMap;
import java.io.File;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletOutputStream;
import net.sf.jasperreports.engine.JRException;

/**
 *
 * @author User
 */
@WebServlet(name = "GenerarFacturaServlet", urlPatterns = {"/GenerarFacturaServlet"})
public class GenerarFacturaServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");

        try {
            EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
            Map<String, Object> propertiesMap
                    = propertiesMap = entityManagerFactory.getProperties();

            String url = propertiesMap.get("javax.persistence.jdbc.url").toString();
            String user = propertiesMap.get("javax.persistence.jdbc.user").toString();
            String pass = propertiesMap.get("javax.persistence.jdbc.password").toString();
            Class.forName(propertiesMap.get("javax.persistence.jdbc.driver").toString());
            Connection con = DriverManager.getConnection(url, user, pass);

            /*String fecha = request.getParameter("fecha");
            String cond_venta = request.getParameter("cond_venta");
            String ruc =  request.getParameter("ruc");
            String descripcion =  request.getParameter("descripcion");
            String precio =  request.getParameter("monto");
            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            
            String iva =  request.getParameter("iva");*/
            Integer idFactura = Integer.parseInt(request.getParameter("idFactura"));
            FacturaCabecera fac = new FacturaCabeceraJpaController().findFacturaCabecera(idFactura);

            Cliente cliente = fac.getIdCliente();

            String numFactura = String.valueOf(fac.getNumeroFactura());
            while (numFactura.length() < 6) {
                numFactura = "0" + numFactura;
            }
            System.out.println("ID factura " + idFactura);
            //System.out.println("Fecha  "+fecha);
            //System.out.println("Nombre "+nombre);
            //System.out.println("Telefono "+telefono);
            //System.out.println("Direccion "+direccion);
            //System.out.println("iva "+iva);
            //System.out.println("ruc "+ruc);
            //System.out.println("monto "+precio);
            //ClienteJpaController cliente = new ClienteJpaController();

            File reportfile = new File(getServletContext().getRealPath("/WEB-INF/reportes/Factura.jasper"));
            Map<String, Object> parameter = new HashMap<>();
            parameter.put("REPORT_LOCALE", new Locale("es", "ES"));
            parameter.put("idFactura", idFactura);
            parameter.put("inicio", numFactura);
            parameter.put("fecha", fac.getFecha());
            parameter.put("ruc", cliente.getRuc());
            parameter.put("direccion", cliente.getDireccion());
            parameter.put("telefono", cliente.getTelefono());
            parameter.put("nombre", cliente.getNombreCliente());
            parameter.put("cantidad", fac.getFacturaDetalleList().get(0).getCantidad());
            parameter.put("enLetra", cantidadConLetra(String.valueOf(fac.getFacturaDetalleList().get(0).getMonto())));

            byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);

            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(GenerarFacturaServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (JRException ex) {
            Logger.getLogger(GenerarFacturaServlet.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(GenerarFacturaServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        
    }    
        
         

    public static String cantidadConLetra(String s) {
        StringBuilder result = new StringBuilder();
        BigDecimal totalBigDecimal = new BigDecimal(s).setScale(2, BigDecimal.ROUND_DOWN);
        long parteEntera = totalBigDecimal.toBigInteger().longValue();
        int triUnidades = (int) ((parteEntera % 1000));
        int triMiles = (int) ((parteEntera / 1000) % 1000);
        int triMillones = (int) ((parteEntera / 1000000) % 1000);
        int triMilMillones = (int) ((parteEntera / 1000000000) % 1000);

        if (parteEntera == 0) {
            result.append("Cero ");
            return result.toString();
        }

        if (triMilMillones > 0) {
            result.append(triTexto(triMilMillones).toString() + "Mil ");
        }
        if (triMillones > 0) {
            result.append(triTexto(triMillones).toString());
        }

        if (triMilMillones == 0 && triMillones == 1) {
            result.append("Millón ");
        } else if (triMilMillones > 0 || triMillones > 0) {
            result.append("Millones ");
        }

        if (triMiles > 0) {
            result.append(triTexto(triMiles).toString() + "Mil ");
        }
        if (triUnidades > 0) {
            result.append(triTexto(triUnidades).toString());
        }

        return result.toString();
    }

    /**
     * Convierte una cantidad de tres cifras a su representación escrita con
     * letra.
     *
     * @param n La cantidad a convertir.
     * @return Una cadena de texto que contiene la representación con letra del
     * número que se recibió como argumento.
     */
    private static StringBuilder triTexto(int n) {
        StringBuilder result = new StringBuilder();
        int centenas = n / 100;
        int decenas = (n % 100) / 10;
        int unidades = (n % 10);

        switch (centenas) {
            case 0:
                break;
            case 1:
                if (decenas == 0 && unidades == 0) {
                    result.append("Cien ");
                    return result;
                } else {
                    result.append("Ciento ");
                }
                break;
            case 2:
                result.append("Doscientos ");
                break;
            case 3:
                result.append("Trescientos ");
                break;
            case 4:
                result.append("Cuatrocientos ");
                break;
            case 5:
                result.append("Quinientos ");
                break;
            case 6:
                result.append("Seiscientos ");
                break;
            case 7:
                result.append("Setecientos ");
                break;
            case 8:
                result.append("Ochocientos ");
                break;
            case 9:
                result.append("Novecientos ");
                break;
        }

        switch (decenas) {
            case 0:
                break;
            case 1:
                if (unidades == 0) {
                    result.append("Diez ");
                    return result;
                } else if (unidades == 1) {
                    result.append("Once ");
                    return result;
                } else if (unidades == 2) {
                    result.append("Doce ");
                    return result;
                } else if (unidades == 3) {
                    result.append("Trece ");
                    return result;
                } else if (unidades == 4) {
                    result.append("Catorce ");
                    return result;
                } else if (unidades == 5) {
                    result.append("Quince ");
                    return result;
                } else {
                    result.append("Dieci");
                }
                break;
            case 2:
                if (unidades == 0) {
                    result.append("Veinte ");
                    return result;
                } else {
                    result.append("Veinti");
                }
                break;
            case 3:
                result.append("Treinta ");
                break;
            case 4:
                result.append("Cuarenta ");
                break;
            case 5:
                result.append("Cincuenta ");
                break;
            case 6:
                result.append("Sesenta ");
                break;
            case 7:
                result.append("Setenta ");
                break;
            case 8:
                result.append("Ochenta ");
                break;
            case 9:
                result.append("Noventa ");
                break;
        }

        if (decenas > 2 && unidades > 0) {
            result.append("y ");
        }

        switch (unidades) {
            case 0:
                break;
            case 1:
                result.append("Un ");
                break;
            case 2:
                result.append("Dos ");
                break;
            case 3:
                result.append("Tres ");
                break;
            case 4:
                result.append("Cuatro ");
                break;
            case 5:
                result.append("Cinco ");
                break;
            case 6:
                result.append("Seis ");
                break;
            case 7:
                result.append("Siete ");
                break;
            case 8:
                result.append("Ocho ");
                break;
            case 9:
                result.append("Nueve ");
                break;
        }

        return result;
    }



@Override
    public String getServletInfo() {
        return "Short description";
    }
}
