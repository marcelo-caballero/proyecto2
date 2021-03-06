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
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.EstadoOposicion;
import modelo.Expediente;
import modelo.HistorialEstadoOposicionRecibida;
import modelo.OposicionRecibida;
import modeloMng.EstadoOposicionJpaController;
import modeloMng.ExpedienteJpaController;
import modeloMng.HistorialEstadoOposicionRecibidaJpaController;
import modeloMng.OposicionRecibidaJpaController;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
@WebServlet(name = "OposicionRecibidaServlet", urlPatterns = {"/OposicionRecibidaServlet"})
public class OposicionRecibidaServlet extends HttpServlet {


    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        OposicionRecibidaJpaController oposicionRecibidaControl = new OposicionRecibidaJpaController();
        EstadoOposicionJpaController  estadoOposicionControl = new EstadoOposicionJpaController();
        ExpedienteJpaController expControl = new ExpedienteJpaController();
        HistorialEstadoOposicionRecibidaJpaController historialOposicionControl = new HistorialEstadoOposicionRecibidaJpaController();
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        if(request.getParameter("agregar") != null){
            
            try{
                
                
                Integer nroExp = Integer.parseInt(request.getParameter("nroExpediente"));
                String agente = request.getParameter("agente");
                String marca = request.getParameter("marca");
                Integer clase = Integer.parseInt(request.getParameter("clase"));
                String titular = request.getParameter("titular");
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                Integer idEstado = Integer.parseInt(request.getParameter("idEstado"));

                
                //Expediente actual
                Expediente exp = expControl.findExpediente((Integer) request.getSession().getAttribute("idExpediente"));

                EstadoOposicion estado = estadoOposicionControl.findEstadoOposicion(idEstado);

                OposicionRecibida oposicion = new OposicionRecibida();

                oposicion.setIdExpediente(exp);
                oposicion.setMarca(marca);
                oposicion.setClase(clase);
                oposicion.setNroExpediente(nroExp);
                oposicion.setIdEstado(estado);
                oposicion.setAgente(agente);
                oposicion.setFechaEstado(fecha);
                oposicion.setTitular(titular);
                
                oposicionRecibidaControl.create(oposicion);
                
               
                //Procedimiento para guardar el historial de oposicion
                HistorialEstadoOposicionRecibida historialOposicion = new HistorialEstadoOposicionRecibida();
                historialOposicion.setFecha(oposicion.getFechaEstado());
                historialOposicion.setIdOposicionRecibida(oposicion);
                historialOposicion.setIdEstadoOposicion(oposicion.getIdEstado());
                historialOposicion.setFechaRegistro(new Date());
                
                historialOposicionControl.create(historialOposicion);
                //-----------------------------------------------------------------------------------------------
                
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar la oposición");
            }finally{
                response.sendRedirect("oposicionesRecibidas.jsp");
            }        
        
        }
        
        if(request.getParameter("eliminar") != null){
            try {
                Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
                
            //Vaciamos el historial de estados de la oposicion
                List<HistorialEstadoOposicionRecibida> listaHistorial = historialOposicionControl.getHistorialEstadoOposicionPorIdOposicion(idOposicion);
                
                for(int i=0;i<listaHistorial.size();i++){ 
                    historialOposicionControl.destroy(listaHistorial.get(i).getIdHistorial());
                }
                
            //-------------------------------------------------------------------------------------------------------

                oposicionRecibidaControl.destroy(idOposicion);
            } catch (Exception e) {
               System.out.println(e);
               request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar la oposición");
               
            }finally{
                
                response.sendRedirect("oposicionesRecibidas.jsp");
            }
        }
        
        if(request.getParameter("editar") != null){
            
            try{
                
                Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
                Integer nroExp = Integer.parseInt(request.getParameter("nroExpediente"));
                String agente = request.getParameter("agente");
                String marca = request.getParameter("marca");
                Integer clase = Integer.parseInt(request.getParameter("clase"));
                String titular = request.getParameter("titular");
                Date fecha = formatoFecha.parse(request.getParameter("fecha"));
                Integer idEstado = Integer.parseInt(request.getParameter("idEstado"));
                String comentario = request.getParameter("comentario");
                
                boolean registrarHistorial = false;
                
                EstadoOposicion estado = estadoOposicionControl.findEstadoOposicion(idEstado);

                OposicionRecibida oposicion = oposicionRecibidaControl.findOposicionRecibida(idOposicion);
                
                //Verificamos si hay cambios en la fecha y estado de oposicion
                if(!oposicion.getFechaEstado().equals(fecha)){
                    registrarHistorial = true;
                }
                if(!oposicion.getIdEstado().equals(estado)){
                    registrarHistorial = true;
                }

                oposicion.setMarca(marca);
                oposicion.setClase(clase);
                oposicion.setNroExpediente(nroExp);
                oposicion.setIdEstado(estado);
                oposicion.setAgente(agente);
                oposicion.setFechaEstado(fecha);
                oposicion.setTitular(titular);
                if(comentario != null){
                    oposicion.setComentarioCierre(comentario);
                }
                oposicionRecibidaControl.edit(oposicion);
                
                //Creamos HistorialEstadoOposicionRecibida si así es requerida
                if(registrarHistorial){
                    HistorialEstadoOposicionRecibida historialOposicion = new HistorialEstadoOposicionRecibida();
                    List<HistorialEstadoOposicionRecibida> listaHistorial = historialOposicionControl.getHistorialEstadoOposicionPorIdOposicion(idOposicion);
                    
                    //si no hay cambio de estado, se edita la fecha
                    if(listaHistorial.get(listaHistorial.size()-1).getIdEstadoOposicion().getIdEstado() == oposicion.getIdEstado().getIdEstado()){
                        historialOposicion = listaHistorial.get(listaHistorial.size()-1);
                        historialOposicion.setFecha(oposicion.getFechaEstado());
                        historialOposicion.setFechaRegistro(new Date());
                        historialOposicionControl.edit(historialOposicion);
                    }//Si hay cambio de estado, se crea otro historial
                    else{
                        historialOposicion.setFecha(oposicion.getFechaEstado());
                        historialOposicion.setIdOposicionRecibida(oposicion);
                        historialOposicion.setIdEstadoOposicion(oposicion.getIdEstado());
                        historialOposicion.setFechaRegistro(new Date());

                        historialOposicionControl.create(historialOposicion);
                    }
                }
                //---------------------------------------------------------------------------------------------------
                
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar la oposición");
            }finally{
                response.sendRedirect("oposicionesRecibidas.jsp");
            }        
        
        }
        
    }

    
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
