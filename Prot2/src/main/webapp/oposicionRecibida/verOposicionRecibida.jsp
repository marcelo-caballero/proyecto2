<%-- 
    Document   : verOposicionRecibida
    Created on : 22-oct-2018, 16:49:58
    Author     : User
--%>


<%@page import="modeloMng.EstadoOposicionJpaController"%>
<%@page import="modelo.EstadoOposicion"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.HistorialEstadoOposicionRecibidaJpaController"%>
<%@page import="modelo.HistorialEstadoOposicionRecibida"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.OposicionRecibida"%>
<%@page import="modeloMng.OposicionRecibidaJpaController"%>
<%@page import="modeloMng.ExpedienteJpaController"%>
<%@page import="modelo.Expediente"%>
<html>
    <head>
        <title>Oposición - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body >
        <%
            Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));
            Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
            
            
            OposicionRecibidaJpaController oposicionRecibidaControl = new OposicionRecibidaJpaController();
            EstadoOposicionJpaController estadoOposicionControl = new EstadoOposicionJpaController();
            OposicionRecibida oposicion = oposicionRecibidaControl.findOposicionRecibida(idOposicion);  
            
            //Expediente exp = new ExpedienteJpaController().findExpediente(idExp);
           List<HistorialEstadoOposicionRecibida> listaHistorial = new HistorialEstadoOposicionRecibidaJpaController().getHistorialEstadoOposicionPorIdOposicion(idOposicion);
            
           //Lista de estados finales
           List<EstadoOposicion> listaEstadoOposicionFinales = estadoOposicionControl.getEstadoOposicionFinales(); 
           Boolean editable = true;
            //Verificamos que la oposicion es editable
            for(int i=0;i<listaEstadoOposicionFinales.size();i++){
                if(oposicion.getIdEstado().getIdEstado() == listaEstadoOposicionFinales.get(i).getIdEstado()){
                    editable = false;
                } 
            }
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        <div class="container form-control">
            <h2 class="text-justify">Ver Oposición</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de expediente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdExpediente().getNroExpediente()%>
                </div>
            </div>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de expediente de la marca base de Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getNroExpediente()%>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Agente opositor:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getAgente()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Marca base de Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getMarca()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Clase de la marca base de Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getClase()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Titular opositor:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getTitular()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha del Estado de Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=new SimpleDateFormat("dd/MM/yyyy").format(oposicion.getFechaEstado())%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Estado actual de la Oposición:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdEstado().getDescripcion()%>  
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
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Historial:</label>
                </div>
                <div class="col-6 ">
                    <button class="btn btn-primary "
                            onclick="mostrarModal()"> 
                            Ver Historial
                    </button>  
                </div>
            </div>
        </div>  
        <br>
        
        <%-- Modal Historial Oposicion --%>
        <div class="modal fade" id="modal-historial" role="dialog">
            <div class="modal-dialog ">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Historial</h4>
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
                                       <%if(i == (listaHistorial.size()-1) && i > 0 && editable){%>
                                            <button type="button" class="close">
                                                <a href="<%=request.getContextPath()%>/HistorialEstadoOposicionRecibidaServlet?eliminar=true&idHistorial=<%=listaHistorial.get(i).getIdHistorial()%>&idOposicion=<%=idOposicion%>">&times;</a> 
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
            function mostrarModal() {
                $(document).ready(function () {
                    $("#modal-historial").modal();

                });
            }
        </script>
    </body>
</html>
