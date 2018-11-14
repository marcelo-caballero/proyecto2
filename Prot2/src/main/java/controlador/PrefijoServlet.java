/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Prefijo;
import modeloMng.PrefijoJpaController;

/**
 *
 * @author User
 */
@WebServlet(name = "PrefijoServlet", urlPatterns = {"/PrefijoServlet"})
public class PrefijoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        PrefijoJpaController prefijoControl = new PrefijoJpaController();
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        if(request.getParameter("editar") != null){
            
            try{
                Integer id = Integer.parseInt(request.getParameter("idPrefijo"));
                String ruc = request.getParameter("ruc");
                Integer timbrado = Integer.parseInt(request.getParameter("timbrado"));
                String pref = request.getParameter("prefijo");
                Date fecha = formatoFecha.parse(request.getParameter("fechaValido"));
                Integer inicio = Integer.parseInt(request.getParameter("inicio"));
                Integer fin = Integer.parseInt(request.getParameter("fin"));

                Prefijo prefijo = prefijoControl.findPrefijo(id);  
                prefijo.setRuc(ruc);
                prefijo.setTimbrado(timbrado);
                prefijo.setPrefijo(pref);
                prefijo.setFechaValidoHasta(fecha);
                prefijo.setInicio(inicio);
                prefijo.setProximo(inicio);
                prefijo.setFin(fin);
                
                prefijoControl.edit(prefijo);
                
            }catch(Exception e){
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar los datos de factura");
            }finally{
                response.sendRedirect("prefijos.jsp");
            }
        }
    }

    @Override
    public String getServletInfo() {
        return "Prefijo Servlet";
    }

}
