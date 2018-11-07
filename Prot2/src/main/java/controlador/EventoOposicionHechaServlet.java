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
import modelo.EventoOposicionHecha;
import modeloMng.EventoOposicionHechaJpaController;
import modeloMng.OposicionHechaJpaController;

/**
 *
 * @author User
 */
@WebServlet(name = "EventoOposicionHechaServlet", urlPatterns = {"/EventoOposicionHechaServlet"})
public class EventoOposicionHechaServlet extends HttpServlet {

    
    
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        EventoOposicionHechaJpaController eventoControl = new EventoOposicionHechaJpaController(); 
        OposicionHechaJpaController oposicionControl= new OposicionHechaJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-ddHHmm");
        
        //Eliminar
        if(request.getParameter("eliminar")!= null){
            
            Integer idEvento = Integer.parseInt(request.getParameter("idEvento")); 
            
            try {
                eventoControl.destroy(idEvento);
            } catch (Exception e) {
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el evento");
            }finally{
                response.sendRedirect("eventosOposicionesHechas.jsp");
            }
             
        }
        //Agregar
        if(request.getParameter("agregar") != null){
            
            try{
                
                
                Integer idOposicion = (Integer)(request.getSession().getAttribute("idOposicionHecha"));
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String fecha = request.getParameter("fecha");
                String hora = request.getParameter("hora");
                String minuto = request.getParameter("minuto");
                String prioridad = request.getParameter("prioridad");
                
                Date fechaDate = formatoFecha.parse(fecha+hora+minuto);  
                
                EventoOposicionHecha evento = new EventoOposicionHecha();
                
                evento.setIdOposicionHecha(oposicionControl.findOposicionHecha(idOposicion));
                evento.setNombre(nombre);
                evento.setDescripcion(descripcion);
                evento.setFecha(fechaDate);
                evento.setPrioridad(prioridad);
                eventoControl.create(evento);
                
                
            } 
            catch (Exception e) {
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el evento");
            
            }finally{
                
                response.sendRedirect("eventosOposicionesHechas.jsp");
            }
        }
        
        if(request.getParameter("editar") != null){
            
            try{
                Integer idEvento = Integer.parseInt(request.getParameter("idEvento")); 
                
                String nombre = request.getParameter("nombre");
                String descripcion = request.getParameter("descripcion");
                String prioridad = request.getParameter("prioridad");
                String fecha = request.getParameter("fecha");
                String hora = request.getParameter("hora");
                String minuto = request.getParameter("minuto");
                
                Date fechaDate = formatoFecha.parse(fecha+hora+minuto); 
                EventoOposicionHecha evento = eventoControl.findEventoOposicionHecha(idEvento);
                
                evento.setNombre(nombre);
                evento.setDescripcion(descripcion);
                evento.setFecha(fechaDate);
                evento.setPrioridad(prioridad);
                
                eventoControl.edit(evento); 
                
            } 
            catch (Exception e) {
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el evento");
            
            }finally{
                
                response.sendRedirect("eventosOposicionesHechas.jsp");
            }
        }
       
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
