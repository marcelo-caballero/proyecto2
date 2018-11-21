<%-- 
    Document   : verOposicionHecha
    Created on : 05-nov-2018, 12:04:00
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="modeloMng.HistorialEstadoOposicionHechaJpaController"%>
<%@page import="modelo.HistorialEstadoOposicionHecha"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.OposicionHecha"%>
<%@page import="modeloMng.OposicionHechaJpaController"%>
<%@page import="modeloMng.ExpedienteJpaController"%>
<%@page import="modelo.Expediente"%>
<html>
    <head>
        <title>Oposición - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body >
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <%
            
            Integer idOposicionHecha = null;
            
            
            if(request.getParameter("idOposicion") != null){
                //Cambio de oposicion hecha
                idOposicionHecha  = Integer.parseInt(request.getParameter("idOposicion"));
                request.getSession().setAttribute("idOposicionHecha", idOposicionHecha);
                
            }else{
                //Estamos en la misma oposicion hecha
                idOposicionHecha = (Integer)(request.getSession().getAttribute("idOposicionHecha")); 
            }
            
            OposicionHechaJpaController oposicionHechaControl = new OposicionHechaJpaController();
            OposicionHecha oposicion = oposicionHechaControl.findOposicionHecha(idOposicionHecha);   
            
            //Expediente exp = new ExpedienteJpaController().findExpediente(idExp);
           List<HistorialEstadoOposicionHecha> listaHistorial = new HistorialEstadoOposicionHechaJpaController().getHistorialEstadoOposicionPorIdOposicion(idOposicionHecha);
            

           //Verificamos si la oposicion esta cerrada
            boolean oposicionCerrada = false;
            if(oposicion.getIdEstadoOposicion().getTipo() == null){
                oposicionCerrada = false;
            }else if(oposicion.getIdEstadoOposicion().getTipo().equals("F")){
                oposicionCerrada = true; 
            }
            
            //Si el abogado logueado no es dueño del expediente, éste se encuentra cerrado
            //boolean cerrado = false;
            if(usuario.getAsociado() != null){  
                if(usuario.getAsociado().equals("ABOGADO")){ 
                    
                    if(oposicion.getIdAbogadoOpositante().getIdAbogado() != usuario.getAbogadoList().get(0).getIdAbogado()){ 
                        oposicionCerrada = true; 
                    }
                }
            }
            
        %>

        
        <div class="container">
           <%@include file="//WEB-INF/menuOposicionesHechas.jsp" %>     
        </div>
        <div class="container form-control">
            <h2 class="text-justify">Ver Oposición</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente Opositado:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getNroExpedienteOpositado()%>  
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de expediente base de oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdExpedienteOpositante().getNroExpediente()%>
                </div>
            </div>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>Titular opositor:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdExpedienteOpositante().getIdCliente().getNombreCliente()%>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Marca base de oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdExpedienteOpositante().getIdMarca().getDenominacion()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Agente a cargo de oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdAbogadoOpositante().getNombreApellido()%>   
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Denominación:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getDenominacionOpositado()%>   
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Clase:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getClaseOpositado()%>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Titular:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getTitularOpositado()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Agente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getAgenteOpositado()%> 
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha del Estado de Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=new SimpleDateFormat("dd/MM/yyyy").format(oposicion.getFecha())%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Estado actual de la Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdEstadoOposicion().getDescripcion()%>  
                </div>
            </div>
                
            <%if(oposicion.getComentarioCierre() != null){%>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Comentario de cierre:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=oposicion.getComentarioCierre()%> 
                    </div>
                </div>
            <%}%>
                
            <%if(!oposicion.getDocumentoOposicionHechaList().isEmpty()){%>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Historial Administrativo:</label>
                    </div>
                    <div class="col-6 ">
                        <button class="btn btn-primary "
                                onclick="mostrarModalHistorialAdm()"> 
                                Ver Historial Administrativo
                        </button>  
                    </div>
                </div>
            <%}%>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Historial de Estado:</label>
                </div>
                <div class="col-6 ">
                    <button class="btn btn-primary "
                            onclick="mostrarModalHistorialEstado()"> 
                            Ver Historial de Oposición
                    </button>  
                </div>
            </div>
        </div>  
        <br>
        
        <%-- Modal Historial Administrativo --%>
        <div class="modal fade" id="modal-administrativo" role="dialog">
            <div class="modal-dialog modal-lg">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Historial Administrativo</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                       <div class="container form-control">
                           <div class="row">
                                <div class="col">
                                    <p class="font-weight-bold">Fecha</p>
                                </div>
                                <div class="col">
                                   <p class="font-weight-bold">Tipo</p>
                                </div>
                                <div class="col">
                                   <p class="font-weight-bold">Descripción</p>
                                </div>
                            </div>
                            <hr>
                           <%for(int i=0;i<oposicion.getDocumentoOposicionHechaList().size();i++){%> 
                                <div class="row">
                                    <div class="col">
                                        <p><%=oposicion.getDocumentoOposicionHechaList().get(i).getStringFecha()%></p> 
                                    </div>
                                    <div class="col">
                                        <p><%=oposicion.getDocumentoOposicionHechaList().get(i).getIdTipoDocumentoOposicionHecha().getDescripcion()%></p>  
                                    </div>
                                    <div class="col">
                                        <p><%=oposicion.getDocumentoOposicionHechaList().get(i).getDescripcion()%></p>  
                                    </div>
                                </div>
                                <hr>
                           <%}%>
                       </div>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" data-dismiss="modal" class="btn btn-default" >Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
                       
        <%-- Modal Historial Oposicion --%>
        <div class="modal fade" id="modal-historialEstadoOposicion" role="dialog">
            <div class="modal-dialog ">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Historial de Estado de Oposición</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                       <div class="container form-control">
                           <div class="row">
                                <div class="col-4">
                                    <p class="font-weight-bold">Fecha</p>
                                </div>
                                <div class="col">
                                   <p class="font-weight-bold">Estado</p>
                                </div>
                                <div class="col-1"></div>
                                <div class="col-1"></div>
                            </div>
                            <hr>
                           <%for(int i=0;i<listaHistorial.size();i++){%>
                                <div class="row">
                                    <div class="col-4">
                                        <p><%=listaHistorial.get(i).getStringFecha()%></p>
                                    </div>
                                    <div class="col">
                                        <p><%=listaHistorial.get(i).getIdEstadoOposicion().getDescripcion()%></p>
                                    </div>
                                     <div class="col-1">
                                       <%if(i == (listaHistorial.size()-1) && i > 0 && !oposicionCerrada){%>  
                                            <button type="button" class="close">
                                                <a href="<%=request.getContextPath()%>/HistorialEstadoOposicionHechaServlet?eliminar=true&idHistorial=<%=listaHistorial.get(i).getIdHistorial()%>">&times;</a>  
                                            </button>
                                       <%}%> 
                                    </div>
                                    <div class="col-1">
                                    </div>
                                </div>
                                <hr>
                           <%}%>
                       </div>
                        
                    </div>
                    <div class="modal-footer">
                        <button type="button" data-dismiss="modal" class="btn btn-default" >Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        
        <script>
            function mostrarModalHistorialEstado() {
                $(document).ready(function () {
                    $("#modal-historialEstadoOposicion").modal();

                });
            }
            
            function mostrarModalHistorialAdm() {
                $(document).ready(function () {
                    $("#modal-administrativo").modal();

                });
            }
        </script>
    </body>
</html>
