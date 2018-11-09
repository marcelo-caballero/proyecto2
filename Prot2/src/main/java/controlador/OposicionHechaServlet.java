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
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Abogado;
import modelo.EstadoOposicion;
import modelo.Expediente;
import modelo.HistorialEstadoOposicionHecha;
import modelo.OposicionHecha;
import modeloMng.AbogadoJpaController;
import modeloMng.EstadoOposicionJpaController;
import modeloMng.ExpedienteJpaController;
import modeloMng.HistorialEstadoOposicionHechaJpaController;
import modeloMng.OposicionHechaJpaController;
import modeloMng.exceptions.IllegalOrphanException;

/**
 *
 * @author User
 */
@WebServlet(name = "OposicionHechaServlet", urlPatterns = {"/OposicionHechaServlet"})
public class OposicionHechaServlet extends HttpServlet {

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        OposicionHechaJpaController oposicionHechaControl = new OposicionHechaJpaController();
        EstadoOposicionJpaController  estadoOposicionControl = new EstadoOposicionJpaController();
        ExpedienteJpaController expControl = new ExpedienteJpaController();
        HistorialEstadoOposicionHechaJpaController historialOposicionControl = new HistorialEstadoOposicionHechaJpaController();
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        AbogadoJpaController abogadoControl = new AbogadoJpaController();
        if(request.getParameter("agregar") != null){
            
            try{
                
                Integer nroExpOpositado = Integer.parseInt(request.getParameter("nroExpedienteOpositado"));
                String denominacionOpositada = request.getParameter("denominacionOpositada");
                Integer claseOpositada = Integer.parseInt(request.getParameter("clase"));
                String titularOpositado = request.getParameter("titular");
                String agenteOpositado = request.getParameter("agenteOpositado");
                Integer idExpOpositor = Integer.parseInt(request.getParameter("nroExpedienteOpositor"));
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                Integer idEstado = Integer.parseInt(request.getParameter("idEstado"));
                Integer idAbogadoOpositor = Integer.parseInt(request.getParameter("agenteOpositor"));

                
                
                Expediente expedienteOpositor = expControl.findExpediente(idExpOpositor);

                EstadoOposicion estado = estadoOposicionControl.findEstadoOposicion(idEstado);

                Abogado abogadoOpositor = abogadoControl.findAbogado(idAbogadoOpositor);
                OposicionHecha oposicion = new OposicionHecha();

                oposicion.setNroExpedienteOpositado(nroExpOpositado);
                oposicion.setDenominacionOpositado(denominacionOpositada);
                oposicion.setClaseOpositado(claseOpositada);
                oposicion.setTitularOpositado(titularOpositado);
                oposicion.setAgenteOpositado(agenteOpositado);
                oposicion.setIdExpedienteOpositante(expedienteOpositor);
                oposicion.setFecha(fecha);
                oposicion.setIdEstadoOposicion(estado);
                oposicion.setIdAbogadoOpositante(abogadoOpositor);
                
                oposicionHechaControl.create(oposicion);
                
               
                //Procedimiento para guardar el historial de oposicion
                HistorialEstadoOposicionHecha historialOposicion = new HistorialEstadoOposicionHecha();
                historialOposicion.setFecha(oposicion.getFecha());
                historialOposicion.setIdOposicionHecha(oposicion);
                historialOposicion.setIdEstadoOposicion(oposicion.getIdEstadoOposicion());
                historialOposicion.setFechaRegistro(new Date());
                
                historialOposicionControl.create(historialOposicion);
                //-----------------------------------------------------------------------------------------------
                
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar la oposición");
            }finally{
                response.sendRedirect("oposicionesHechas.jsp");
            }        
        
        }
        
        if(request.getParameter("editar") != null){
            
            try{
                Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
                Integer nroExpOpositado = Integer.parseInt(request.getParameter("nroExpedienteOpositado"));
                String denominacionOpositada = request.getParameter("denominacionOpositada");
                Integer claseOpositada = Integer.parseInt(request.getParameter("clase"));
                String titularOpositado = request.getParameter("titular");
                String agenteOpositado = request.getParameter("agenteOpositado");
                Integer idExpOpositor = Integer.parseInt(request.getParameter("nroExpedienteOpositor"));
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                Integer idEstado = Integer.parseInt(request.getParameter("idEstado"));
                Integer idAbogadoOpositor = Integer.parseInt(request.getParameter("agenteOpositor"));
                String comentario = request.getParameter("comentario");
                
                
                Expediente expedienteOpositor = expControl.findExpediente(idExpOpositor);

                EstadoOposicion estado = estadoOposicionControl.findEstadoOposicion(idEstado);

                Abogado abogadoOpositor = abogadoControl.findAbogado(idAbogadoOpositor);
                OposicionHecha oposicion = oposicionHechaControl.findOposicionHecha(idOposicion);

                oposicion.setNroExpedienteOpositado(nroExpOpositado);
                oposicion.setDenominacionOpositado(denominacionOpositada);
                oposicion.setClaseOpositado(claseOpositada);
                oposicion.setTitularOpositado(titularOpositado);
                oposicion.setAgenteOpositado(agenteOpositado);
                oposicion.setIdExpedienteOpositante(expedienteOpositor);
                oposicion.setFecha(fecha);
                oposicion.setIdEstadoOposicion(estado);
                oposicion.setIdAbogadoOpositante(abogadoOpositor);
                if(comentario != null){
                    oposicion.setComentarioCierre(comentario);
                }
                
                oposicionHechaControl.edit(oposicion);
                
               
                //Procedimiento para guardar el historial de oposicion
                HistorialEstadoOposicionHecha historialOposicion = new HistorialEstadoOposicionHecha();
                historialOposicion.setFecha(oposicion.getFecha());
                historialOposicion.setIdOposicionHecha(oposicion);
                historialOposicion.setIdEstadoOposicion(oposicion.getIdEstadoOposicion());
                historialOposicion.setFechaRegistro(new Date());
                
                historialOposicionControl.create(historialOposicion);
                //-----------------------------------------------------------------------------------------------
                
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar la oposición");
            }finally{
                response.sendRedirect("oposicionesHechas.jsp");
            }        
        
        }
        
        if(request.getParameter("eliminar") != null){
            try {
                Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
                
                //Si la oposicion se encuentra vacio, borramos el historial de estado
                if(oposicionHechaControl.oposicionVacio(idOposicion)){
                    //Vaciamos el historial de estados de la oposicion
                        List<HistorialEstadoOposicionHecha> listaHistorial = historialOposicionControl.getHistorialEstadoOposicionPorIdOposicion(idOposicion);

                        for(int i=0;i<listaHistorial.size();i++){ 
                            historialOposicionControl.destroy(listaHistorial.get(i).getIdHistorial());
                        }
                //-------------------------------------------------------------------------------------------------------
                }
                
                oposicionHechaControl.destroy(idOposicion);
                
            } catch (IllegalOrphanException ex) {
                
                request.getSession().setAttribute("mensajeErrorABM", "Solamente se puede eliminar una oposición vacía");
                
            }catch (Exception e) {
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar la oposición");
                
            }finally{
           
                response.sendRedirect("oposicionesHechas.jsp");
            }
        }
    }

    
    @Override
    public String getServletInfo() {
        return "Servlet Oposicion Hecha";
    }

}
