/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.*;
import modeloMng.*;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;


/**
 *
 * @author Acer
 */
@WebServlet(name = "ExpedienteServlet", urlPatterns = {"/ExpedienteServlet"})
public class ExpedienteServlet extends HttpServlet {


   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        /*Retorna un json a la consulta del ajax
          Si el número de expediente esta duplicado, retorna true
          caso contrario, false
        */
        request.setCharacterEncoding("UTF-8");
        
        ExpedienteJpaController expControl = new ExpedienteJpaController();
        Boolean numeroExpedienteDuplicado = null;
        Integer idExpediente= null;
        
        BigDecimal nroExpediente = new BigDecimal(request.getParameter("nroExpedienteDuplicado"));
        
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idExp") != null){
            idExpediente = Integer.parseInt(request.getParameter("idExp"));
        }
        
        //La operacion es agregar
        if(nroExpediente != null){
           
            numeroExpedienteDuplicado = expControl.existeNumeroExpDuplicado(nroExpediente,idExpediente); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"nroExpedienteDuplicado\":"+numeroExpedienteDuplicado+"}");
            }
        }
        /**/
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        ExpedienteJpaController expControl = new ExpedienteJpaController();
        TipoExpedienteJpaController tipoExpControl = new TipoExpedienteJpaController();
        ClienteJpaController clienteControl = new ClienteJpaController();
        AbogadoJpaController abogadoControl = new AbogadoJpaController();
        EstadoMarcaJpaController estadoMarcaControl = new EstadoMarcaJpaController();
        MarcaJpaController marcaControl = new MarcaJpaController();
        ClaseJpaController claseControl = new ClaseJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        OposicionRecibidaJpaController opoRecibidaControl = new OposicionRecibidaJpaController();
        HistorialEstadoMarcaJpaController historialEstadoMarca = new HistorialEstadoMarcaJpaController();
        
        //agregar
        if(request.getParameter("agregar") != null){
            try{
                BigInteger nroExp = new BigInteger(request.getParameter("nroExpediente"));
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
                Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
                Integer idEstadoMarca = Integer.parseInt(request.getParameter("idEstadoMarca"));
                Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
                Integer nroClase = Integer.parseInt(request.getParameter("nroClase"));
                Integer idTipoExpediente = Integer.parseInt(request.getParameter("idTipoExpediente"));
                String producto = request.getParameter("producto");
                String observacion = request.getParameter("obs");
                Date fechaEstado = formatoFecha.parse(request.getParameter("fechaEstado")); 
                Date fechaSolicitud = formatoFecha.parse(request.getParameter("fechaSolicitud"));
                String nroCertificado = request.getParameter("nroCertificado");
            
            
                Cliente cliente = clienteControl.findCliente(idCliente);
                Abogado abogado = abogadoControl.findAbogado(idAbogado);
                EstadoMarca estadoMarca = estadoMarcaControl.findEstadoMarca(idEstadoMarca);
                Marca marca = marcaControl.findMarca(idMarca);
                Clase clase = claseControl.findClase(nroClase);
                TipoExpediente tipoExpediente = tipoExpControl.findTipoExpediente(idTipoExpediente);
            
                
                Expediente exp = new Expediente();
                exp.setNroExpediente(nroExp);
                exp.setIdCliente(cliente);
                exp.setIdAbogado(abogado);
                exp.setIdEstado(estadoMarca);
                exp.setIdMarca(marca);
                exp.setNroClase(clase);
                exp.setTipoExpediente(tipoExpediente);
                exp.setProducto(producto);
                exp.setFechaEstado(fechaEstado);
                exp.setFechaSolicitud(fechaSolicitud);
                if(observacion.length() > 0){
                   exp.setObservacion(observacion); 
                }
                if(nroCertificado != null){
                    exp.setNroCertificado(Integer.parseInt(nroCertificado)); 
                }
            
                if(!expControl.violaRestriccionUnicaClaseMarcaCliente(nroClase, idMarca, idCliente)){
                    
                    expControl.create(exp);
                    //Agregamos en el historial de estado 
                    HistorialEstadoMarca historial = new HistorialEstadoMarca();
                    historial.setIdExpediente(exp);
                    historial.setIdEstadoMarca(exp.getIdEstado());
                    historial.setFecha(exp.getFechaEstado());
                    historial.setFechaRegistro(new Date());
                    historialEstadoMarca.create(historial);
                    //------------------------------------------------------------
                }else{
                    
                    request.getSession().setAttribute("mensajeErrorABM", "Ya existe un expediente con la misma combinación de clase, marca y titular");
                
                }
                
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el expediente");
            
            }finally{
                response.sendRedirect("expedientes.jsp");
            }
        }
        
         //Eliminar
        if(request.getParameter("eliminar") != null){
            
            try {
                Integer idExp = Integer.parseInt(request.getParameter("idExpediente"));
                
                //Verificamos que el expediente no tenga asociadas oposiciones hechas por el estudio juridico
                if(!expControl.expedienteConOposicionesHechas(idExp)){
                    
                    //Si el expediente se encuentra vacio, borramos el historial de estado
                    if(expControl.expedienteVacio(idExp)){
                        //Vaciamos el historial de estados de la oposicion
                        List<HistorialEstadoMarca> listaHistorial = historialEstadoMarca.getHistorialEstadoMarcaPorIdExpediente(idExp);

                        for(int i=0;i<listaHistorial.size();i++){ 
                            historialEstadoMarca.destroy(listaHistorial.get(i).getIdHistorial());
                        }

                         expControl.destroy(idExp);
                         
                    }else{
                        
                        request.getSession().setAttribute("mensajeErrorABM", "Solamente se puede eliminar un expediente vacío");
                    }
                    
                }else{
                    
                    request.getSession().setAttribute("mensajeErrorABM", "El expediente esta asociado a una oposición realizada por el Estudio Jurídico");
                }
                //-------------------------------------------------------------------------------------------------------
                
               
                
            }catch (Exception e) {
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el expediente");
                
            }finally{
           
                response.sendRedirect("expedientes.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar") != null){
            try{
                Integer idExpediente = Integer.parseInt(request.getParameter("idExpediente"));
                Expediente exp = expControl.findExpediente(idExpediente);
                        
                BigInteger nroExp = new BigInteger(request.getParameter("nroExpediente"));
                Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
                Integer idAbogado = Integer.parseInt(request.getParameter("idAbogado"));
                Integer idEstadoMarca = Integer.parseInt(request.getParameter("idEstadoMarca"));
                Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
                Integer nroClase = Integer.parseInt(request.getParameter("nroClase"));
                Integer idTipoExpediente = Integer.parseInt(request.getParameter("idTipoExpediente"));
                String producto = request.getParameter("producto");
                String observacion = request.getParameter("obs");
                Date fechaEstado = formatoFecha.parse(request.getParameter("fechaEstado")); 
                Date fechaSolicitud = formatoFecha.parse(request.getParameter("fechaSolicitud"));
                String nroCertificado = request.getParameter("nroCertificado");
                String comentario = request.getParameter("comentario");
            
            
                Cliente cliente = clienteControl.findCliente(idCliente);
                Abogado abogado = abogadoControl.findAbogado(idAbogado);
                EstadoMarca estadoMarca = estadoMarcaControl.findEstadoMarca(idEstadoMarca);
                Marca marca = marcaControl.findMarca(idMarca);
                Clase clase = claseControl.findClase(nroClase);
                TipoExpediente tipoExpediente = tipoExpControl.findTipoExpediente(idTipoExpediente);
                
                boolean registrarHistorial = false;
                
                //Verificamos si el expediente esta en estado oposicion(Asuntos Litigiosos) y cambia a otro que no sea estado oposicion
                boolean editarEstado = true;
                List<OposicionRecibida> lista = opoRecibidaControl.getListaOposicionPorIdExpediente(idExpediente);
                
                if(exp.getIdEstado().getTipo() != null){
                    if(!exp.getIdEstado().getTipo().equals("O")){
                        editarEstado = true;
                    }else{
                        if(estadoMarca.getTipo() != null){
                            if(estadoMarca.getTipo().equals("O")){
                                editarEstado = true;
                            }else{
                                //verificar que todas las oposiciones esten cerradas
                                for(int i=0;i<lista.size();i++){ 
                                    if(lista.get(i).getIdEstado().getTipo() != null){
                                        if(!lista.get(i).getIdEstado().getTipo().equals("F")){
                                            editarEstado=false;
                                            i = i + lista.size();
                                        }
                                    }else{
                                        editarEstado=false;
                                        i = i + lista.size();
                                    }
                                }
                            }
                        }else{
                            //verificar que todas las oposiciones esten cerradas
                            for(int i=0;i<lista.size();i++){ 
                                if(lista.get(i).getIdEstado().getTipo() != null){
                                    if(!lista.get(i).getIdEstado().getTipo().equals("F")){
                                        editarEstado=false;
                                        i = i + lista.size();
                                    }
                                }else{
                                    editarEstado=false;
                                    i = i + lista.size();
                                }
                            }
                        }
                    }
                }else{
                    editarEstado=true;
                }
               //---------------------------------------------------------------
               
               
               //Verificamos si hay cambios en la fecha y estado de oposicion
                if(!exp.getFechaEstado().equals(fechaEstado)){
                    registrarHistorial = true;
                }
                if(!exp.getIdEstado().equals(estadoMarca)){
                    registrarHistorial = true;
                }
                //---------------------------------------------------------------
                
                exp.setNroExpediente(nroExp);
                exp.setIdCliente(cliente);
                exp.setIdAbogado(abogado);
                exp.setIdMarca(marca);
                exp.setNroClase(clase);
                exp.setTipoExpediente(tipoExpediente);
                exp.setProducto(producto);
                exp.setFechaSolicitud(fechaSolicitud);
                if(observacion.length() > 0){
                   exp.setObservacion(observacion); 
                }
                if(nroCertificado != null){
                    exp.setNroCertificado(Integer.parseInt(nroCertificado)); 
                }else{
                    exp.setNroCertificado(null);
                }

                if(comentario != null){
                    exp.setComentarioCierre(comentario);
                }
                
               //Si el estado es de Asuntos Litigiosos y pasa a otro estado, las oposiciones deben estar cerradas
               //para modificar la fecha de estado y el estado del expediente
               if(editarEstado){
                    exp.setIdEstado(estadoMarca);
                    exp.setFechaEstado(fechaEstado);
               }else{
                    request.getSession().setAttribute("mensajeErrorABM","No se puede editar el estado actual del expediente porque posee oposiciones sin cerrar");
               }
               
               expControl.edit(exp);
               
               //Creamos HistorialEstadoMarca si así es requerida
                if(registrarHistorial){
                    HistorialEstadoMarca historial = new HistorialEstadoMarca();
                    
                    //si no hay cambio de estado, se edita la fecha
                    List<HistorialEstadoMarca> listaHistorial = historialEstadoMarca.getHistorialEstadoMarcaPorIdExpediente(idExpediente);
                    if(listaHistorial.get(listaHistorial.size()-1).getIdEstadoMarca().getIdEstado() == exp.getIdEstado().getIdEstado()){
                        historial = listaHistorial.get(listaHistorial.size()-1);
                        historial.setFecha(exp.getFechaEstado());
                        historial.setFechaRegistro(new Date());
                        historialEstadoMarca.edit(historial);
                    }//Si hay cambio de estado, se crea otro historial
                    else{
                        historial.setIdExpediente(exp);
                        historial.setIdEstadoMarca(exp.getIdEstado());
                        historial.setFecha(exp.getFechaEstado());
                        historial.setFechaRegistro(new Date());
                        historialEstadoMarca.create(historial);
                    }
                }
                //---------------------------------------------------------------------------------------------------
               
            }catch(Exception e){
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el expediente");
            
            }finally{
                response.sendRedirect("expedientes.jsp");
            }
        }
        
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Expediente";
    }

}
