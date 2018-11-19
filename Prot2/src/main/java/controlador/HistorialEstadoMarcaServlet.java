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
import modelo.Expediente;
import modelo.HistorialEstadoMarca;
import modeloMng.ExpedienteJpaController;
import modeloMng.HistorialEstadoMarcaJpaController;

/**
 *
 * @author User
 */
@WebServlet(name = "HistorialEstadoMarcaServlet", urlPatterns = {"/HistorialEstadoMarcaServlet"})
public class HistorialEstadoMarcaServlet extends HttpServlet {


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
         request.setCharacterEncoding("UTF-8");
         HistorialEstadoMarcaJpaController historialControl = new HistorialEstadoMarcaJpaController();
         ExpedienteJpaController expedienteControl = new ExpedienteJpaController();
         
         if(request.getParameter("eliminar") != null){ 
            try{
                Integer idHistorial = Integer.parseInt(request.getParameter("idHistorial"));
                Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));

                historialControl.destroy(idHistorial);
                
                
                //Actualizamos el estado del expediente con el ultimo estado en el historial de estado
                Expediente expediente = expedienteControl.findExpediente(idExp);
                
                List<HistorialEstadoMarca> listaHistorial = historialControl.getHistorialEstadoMarcaPorIdExpediente(idExp); 
                
                expediente.setIdEstado(listaHistorial.get(listaHistorial.size()-1).getIdEstadoMarca()); 
                expediente.setFechaEstado(listaHistorial.get(listaHistorial.size()-1).getFecha()); 
                
                expedienteControl.edit(expediente);
                
            }catch(Exception e){
                
                 request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el registro del Historial de Estado");
            
            }finally{
                
                response.sendRedirect("expedientes.jsp");
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
