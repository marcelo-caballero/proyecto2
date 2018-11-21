/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.HistorialEstadoOposicionRecibida;
import modelo.OposicionRecibida;
import modeloMng.HistorialEstadoOposicionRecibidaJpaController;
import modeloMng.OposicionRecibidaJpaController;

/**
 *
 * @author User
 */
@WebServlet(name = "HistorialEstadoOposicionRecibidaServlet", urlPatterns = {"/HistorialEstadoOposicionRecibidaServlet"})
public class HistorialEstadoOposicionRecibidaServlet extends HttpServlet {

    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        OposicionRecibidaJpaController oposicionHechaControl = new OposicionRecibidaJpaController();
        HistorialEstadoOposicionRecibidaJpaController historialOposicionControl = new HistorialEstadoOposicionRecibidaJpaController();
       
        if(request.getParameter("eliminar") != null){ 
            try{
                Integer idHistorial = Integer.parseInt(request.getParameter("idHistorial"));
                Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));

                historialOposicionControl.destroy(idHistorial);
                
                
                //Actualizamos el estado de la oposicion con el ultimo estado en el historial de estado
                OposicionRecibida oposicion = oposicionHechaControl.findOposicionRecibida(idOposicion);
                
                List<HistorialEstadoOposicionRecibida> listaHistorial = historialOposicionControl.getHistorialEstadoOposicionPorIdOposicion(idOposicion);  
                
                oposicion.setIdEstado(listaHistorial.get(listaHistorial.size()-1).getIdEstadoOposicion()); 
                oposicion.setFechaEstado(listaHistorial.get(listaHistorial.size()-1).getFecha()); 
                
                oposicionHechaControl.edit(oposicion);
                
            }catch(Exception e){
                
                 request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el registro del Historial de Estado");
            
            }finally{
                
                response.sendRedirect("oposicionesRecibidas.jsp");
            }
         }
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
