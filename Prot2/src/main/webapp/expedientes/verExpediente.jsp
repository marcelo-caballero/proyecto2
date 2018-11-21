<%-- 
    Document   : verExpediente
    Created on : 26-ago-2018, 15:14:31
    Author     : Acer
--%>

<%@page import="modeloMng.HistorialEstadoMarcaJpaController"%>
<%@page import="modelo.HistorialEstadoMarca"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Base64"%>
<%@page import="modelo.Expediente"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.ExpedienteJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expediente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <%
            Integer idExp = null;
            
            
            if(request.getParameter("idExpediente") != null){
                //Cambio de expediente
                idExp  = Integer.parseInt(request.getParameter("idExpediente"));
                request.getSession().setAttribute("idExpediente", idExp);
                
            }else{
                //Estamos en el mismo expediente
                idExp = (Integer)(request.getSession().getAttribute("idExpediente")); 
            }
             
            ExpedienteJpaController expControl = new ExpedienteJpaController();
            Expediente expediente = expControl.findExpediente(idExp);
            
            List<HistorialEstadoMarca> listaEstadoMarca = new HistorialEstadoMarcaJpaController().getHistorialEstadoMarcaPorIdExpediente(idExp);        
            
            //Verificamos si el expediente tiene estado final
            boolean expedienteCerrado = false;
            if(expediente.getIdEstado().getTipo() == null){
                expedienteCerrado = false;
            }else if(expediente.getIdEstado().getTipo().equals("F")){
                expedienteCerrado = true; 
            }
            
            //Si el abogado logueado no es dueño del expediente, éste se encuentra cerrado
            //boolean cerrado = false;
            if(usuario.getAsociado() != null){  
                if(usuario.getAsociado().equals("ABOGADO")){ 
                    
                    if(expediente.getIdAbogado().getIdAbogado() != usuario.getAbogadoList().get(0).getIdAbogado()){ 
                        expedienteCerrado = true; 
                    }
                }
            }
            
        %> 

        
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>

        <div class="container form-control"> 
            <h2 class="text-justify">Expediente</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getNroExpediente()%>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Clase:</label>
                </div>
                <div class="col-6 form-control">
                        <%=expediente.getNroClase().getNroClase()%>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Producto:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getProducto()%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                        <label>Estado:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdEstado().getDescripcion()%>
                </div>
            </div>
                        
            <div class="row form-group">
                <div class="col-3">
                    <label>Agente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdAbogado().getNombreApellido()%>
                </div>
            </div>  
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha Status:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getStringFechaEstado()%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                        <label>Fecha Solicitud:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getStringFechaSolicitud()%>
                </div>
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label>Tipo de trámite:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getTipoExpediente().getDescripcion()%>
                </div>
            </div>
             
            <div class="row form-group">
                <div class="col-3">
                    <label>Signo:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdMarca().getIdTipoMarca().getDescripcion()%> 
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Denominación:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdMarca().getDenominacion()%>  
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Titular:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdCliente().getNombreCliente()%> 
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Dirección Titular:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdCliente().getDireccion()%> 
                </div>
            </div>
             
            <div class="row form-group">
                <div class="col-3">
                    <label>País del titular:</label>
                </div>
                <div class="col-6 form-control">
                    <%=expediente.getIdCliente().getIdPais().getPais()%>   
                </div>
            </div>
                
            <%if(expediente.getIdMarca().getImagenMarca() != null){
                String imageBase64 = new String(Base64.getEncoder().encode(expediente.getIdMarca().getImagenMarca()));
            %>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Imagen:</label>
                    </div>
                    <div class="col-6 form-control form-inline justify-content-center">
                        <img  src="data:image/jpg;base64,<%=imageBase64%>" >    
                    </div>
                </div>
            <%}%>
            
            <% if(expediente.getObservacion() != null){%>  
                <div class="row form-group">
                    <div class="col-3">
                        <label>Observación:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=expediente.getObservacion()%>  
                    </div>
                </div>
            <%}%>
            
            <%if(expediente.getComentarioCierre() != null){%> 
                <div class="row form-group">
                    <div class="col-3">
                        <label>Comentario de cierre:</label>
                    </div>
                    <div class="col-6 form-control">
                        <%=expediente.getComentarioCierre()%> 
                    </div>
                </div>
            <%}%>
            
            <%if(!expediente.getDocumentoList().isEmpty()){%>
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
                            Ver Historial de Estado
                    </button>  
                </div>
            </div>
                
        </div>
        
                
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
                           <%for(int i=0;i<expediente.getDocumentoList().size();i++){%>
                                <div class="row">
                                    <div class="col">
                                        <p><%=expediente.getDocumentoList().get(i).getStringFecha()%></p>
                                    </div>
                                    <div class="col">
                                        <p><%= expediente.getDocumentoList().get(i).getIdTipoDocumento().getDescripcion()%></p>  
                                    </div>
                                    <div class="col">
                                        <p><%= expediente.getDocumentoList().get(i).getDescripcion()%></p>  
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
                    
        <%-- Modal Historial Estado --%>
        <div class="modal fade" id="modal-estado" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Historial de Estado</h4>
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
                           <%for(int i=0;i<listaEstadoMarca.size();i++){%> 
                                <div class="row">
                                    <div class="col-4">
                                        <p><%=listaEstadoMarca.get(i).getStringFecha()%></p> 
                                    </div>
                                    <div class="col">
                                        <p><%=listaEstadoMarca.get(i).getIdEstadoMarca().getDescripcion()%></p>  
                                        
                                    </div>
                                    <div class="col-1">
                                       <%if(i == (listaEstadoMarca.size()-1) && i > 0 && !expedienteCerrado){%>
                                            <button type="button" class="close">
                                                <a href="<%=request.getContextPath()%>/HistorialEstadoMarcaServlet?eliminar=true&idHistorial=<%=listaEstadoMarca.get(i).getIdHistorial()%>">&times;</a> 
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
                       
        <br>
        <script>
            function mostrarModalHistorialAdm() {
                $(document).ready(function () {
                    $("#modal-administrativo").modal();

                });
            }
            
            function mostrarModalHistorialEstado() {
                $(document).ready(function () {
                    $("#modal-estado").modal();

                });
            }
        </script>
        <style>
            img {
                position: static;
                width:  auto;
                height: 200px;
                background-position: 50% 50%;
                background-repeat:   no-repeat;
                background-size:     cover;
            }
        </style>
    </body>
</html>
