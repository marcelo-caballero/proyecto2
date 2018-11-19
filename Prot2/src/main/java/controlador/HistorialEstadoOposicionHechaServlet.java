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
import modelo.OposicionHecha;
import modelo.HistorialEstadoOposicionHecha; 
import modeloMng.HistorialEstadoOposicionHechaJpaController;
import modeloMng.OposicionHechaJpaController;

/**
 *
 * @author User
 */
@WebServlet(name = "HistorialEstadoOposicionHechaServlet", urlPatterns = {"/HistorialEstadoOposicionHechaServlet"})
public class HistorialEstadoOposicionHechaServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        OposicionHechaJpaController oposicionHechaControl = new OposicionHechaJpaController();
        HistorialEstadoOposicionHechaJpaController historialOposicionControl = new HistorialEstadoOposicionHechaJpaController();
       
        if(request.getParameter("eliminar") != null){ 
            try{
                Integer idHistorial = Integer.parseInt(request.getParameter("idHistorial"));
                Integer idOposicion = (Integer) (request.getSession().getAttribute("idOposicionHecha"));

                historialOposicionControl.destroy(idHistorial);
                
                
                //Actualizamos el estado de la oposicion con el ultimo estado en el historial de estado
                OposicionHecha oposicion = oposicionHechaControl.findOposicionHecha(idOposicion);
                
                List<HistorialEstadoOposicionHecha> listaHistorial = historialOposicionControl.getHistorialEstadoOposicionPorIdOposicion(idOposicion);  
                
                oposicion.setIdEstadoOposicion(listaHistorial.get(listaHistorial.size()-1).getIdEstadoOposicion()); 
                oposicion.setFecha(listaHistorial.get(listaHistorial.size()-1).getFecha()); 
                
                oposicionHechaControl.edit(oposicion);
                
            }catch(Exception e){
                
                 request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el registro del Historial de Estado");
            
            }finally{
                
                response.sendRedirect("oposicionesHechas.jsp");
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
