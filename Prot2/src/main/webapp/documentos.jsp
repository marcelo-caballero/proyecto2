<%-- 
    Document   : documentos
    Created on : 27-ago-2018, 12:44:47
    Author     : Acer
--%>

<%@page import="modelo.Documento"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Expediente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.ExpedienteJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Documentos - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    </head>
    <body>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <%
            Integer idExp = (Integer)(request.getSession().getAttribute("idExpediente"));
            
            ExpedienteJpaController expControl = new ExpedienteJpaController();
            Expediente expediente = expControl.findExpediente(idExp);
            List<Documento> listaDocumentos = expediente.getDocumentoList();
            
            //Verificamos que el expediente esta en un estado final
            boolean estaEstadoFinal = false;
            if(expediente.getIdEstado().getTipo() == null){
                estaEstadoFinal = false;
            }else if(expediente.getIdEstado().getTipo().equals("F")){
                estaEstadoFinal = true; 
            }
            
            //Si el abogado logueado no es dueño del expediente, éste se encuentra cerrado
            boolean cerrado = false;
            if(usuario.getAsociado() != null){  
                if(usuario.getAsociado().equals("ABOGADO")){ 
                    
                    if(expediente.getIdAbogado().getIdAbogado() != usuario.getAbogadoList().get(0).getIdAbogado()){ 
                        cerrado = true;
                    }
                }
            }

        %> 

        
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Documentos</h2>
            <br>
            <%if(estaEstadoFinal){%>  
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>El expediente se encuentra cerrado
                </div>
            <%}%>
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        
                        <th>Nombre del Documento</th>
                        <th>Tipo de Documento</th>
                        <th>Fecha</th>
                        <th>Folio</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"agregarDocumento.jsp")){%> 
                                <i class="fa fa-plus-circle" 
                                    style="font-size:24px"  
                                    onmouseover="this.style.cursor = 'pointer'"
                                    <%if(estaEstadoFinal || cerrado){%>  
                                        onclick="mostrarMensajeSoloVer()"
                                    <%}else{%>
                                        onclick='window.location.href = "<%=request.getContextPath()%>/documentos/agregarDocumento.jsp"'
                                    <%}%>
                                > 
                                </i>
                            <%}%>
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < listaDocumentos.size(); i++) {%>

                    <tr>
                        <input id="idDocumento-<%=i%>" type="hidden"  value="<%=listaDocumentos.get(i).getIdDocumento()%>"/>  
                        <td id="nombre-<%=i%>"><%=listaDocumentos.get(i).getNombreDocumento()%></td>
                        <td id=""><%=listaDocumentos.get(i).getIdTipoDocumento().getDescripcion()%></td>  
                        <td id=""><%=listaDocumentos.get(i).getStringFecha()%></td> 
                        <td id=""><%=listaDocumentos.get(i).getFolioDesde()%> - <%=listaDocumentos.get(i).getFolioHasta()%></td> 
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"verDocumento.jsp")){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/documentos/verDocumento.jsp?idDocumento=<%=listaDocumentos.get(i).getIdDocumento()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"editarDocumento.jsp")){%>
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                    <%if(estaEstadoFinal || cerrado){%>  
                                        onclick="mostrarMensajeSoloVer()"
                                    <%}else{%>
                                        onclick='window.location.href = "<%=request.getContextPath()%>/documentos/editarDocumento.jsp?idDocumento=<%=listaDocumentos.get(i).getIdDocumento()%>"'
                                    <%}%>
                                > 
                                </i>
                            <%}%>
                            
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"eliminarDocumento")){%>
                                <i class="fa fa-remove" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                    <%if(estaEstadoFinal || cerrado){%>  
                                        onclick="mostrarMensajeSoloVer()"
                                    <%}else{%>
                                        onclick="modalEliminar('<%=i%>')"
                                    <%}%>
                                > 
                                </i>
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table> 

        </div>
        <%-- Modal Eliminar --%>
        <div class="modal fade" id="modal-eliminar" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Eliminar</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/DocumentoServlet" method="post">
                            <input name= "idDocumento" id="eliminar-documento" type="hidden"/>   
                            <p id="eliminar-mensaje"></p>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button form="form-eliminar" id="btn-eliminar"  type="submit" name="eliminar" class="btn btn-default" >Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
                            
        <%-- Modal MensajeVer --%>
        <div class="modal fade" id="modal-mensaje" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Información</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p>Solamente se puede ver el Documento</p>
                    </div>
                    <div class="modal-footer">
                        <button  type="button" data-dismiss="modal"  class="btn btn-default" >Cerrar</button>
                    </div>
                </div>
            </div>
        </div>
        
        <br>
        <script>
            function modalEliminar(fila) {
                $(document).ready(function () {

                    $("#modal-eliminar").modal();
                    var nombreDoc = document.getElementById("nombre-"+fila).textContent;
                    var idDocumento = document.getElementById("idDocumento-"+fila).value; 
                    
                    document.getElementById("eliminar-documento").value = idDocumento;
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar el documento " + nombreDoc + "?";
                    
                    
                });
            }
            
            function mostrarMensajeSoloVer() {
                $(document).ready(function () {
                    $("#modal-mensaje").modal();
                });
            }
            
            $(document).ready(function () {
                $('#mytable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
                    }
                });
            });
        </script>
    </body>
</html>
