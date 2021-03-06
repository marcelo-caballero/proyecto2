<%-- 
    Document   : expediente
    Created on : 20-ago-2018, 11:58:59
    Author     : Acer
--%>

<%@page import="modeloMng.ExpedienteJpaController"%>
<%@page import="modelo.Expediente"%>
<%@page import="modelo.Abogado"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Clase"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expedientes - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>

        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    </head>
    <body>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <% List<Expediente> lista;
            ExpedienteJpaController expControl = new ExpedienteJpaController();
            lista = expControl.findExpedienteEntities();
            
            boolean abogadoLogueado = false;  
            Integer id_Abogado = null; 
            //Verificamos si se conecto un cliente o un abogado
            if(usuario.getAsociado() != null){ 
                if(usuario.getAsociado().equals("CLIENTE")){
                    lista = expControl.getListaExpedienteCliente(usuario.getClienteList().get(0).getIdCliente()); 
                }else{
                    //verificamos que el usuario sea abogado
                    abogadoLogueado = true;
                    id_Abogado = usuario.getAbogadoList().get(0).getIdAbogado();
                }
            }
        %>
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Expedientes</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        <th>Número</th>
                        <th>Agente</th>
                        <th>Titular</th>
                        <th>Marca</th>
                        <th>Clase</th>
                        <th>Status</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"agregarExpediente.jsp")){%> 
                                <i class="fa fa-plus-circle" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/expedientes/agregarExpediente.jsp"'> 
                                </i>
                            <%}%>
                            
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>
                    <tr>
                        <input id="idExpediente-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdExpediente()%>"/>   
                        <td id="nroExpediente-<%=i%>"><%=lista.get(i).getNroExpediente()%></td> 
                        <td id=""><%=lista.get(i).getIdAbogado().getNombreApellido()%></td>
                        <td id=""><%=lista.get(i).getIdCliente().getNombreCliente()%></td> 
                        <td id=""><%=lista.get(i).getIdMarca().getDenominacion()%></td> 
                        <td id=""><%=lista.get(i).getNroClase().getNroClase()%></td>     
                        <td id=""><%=lista.get(i).getIdEstado().getDescripcion()%></td>  
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"verExpediente.jsp")){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/expedientes/verExpediente.jsp?idExpediente=<%=lista.get(i).getIdExpediente()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"editarExpediente.jsp")){%> 
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'"
                                   <%if(abogadoLogueado && lista.get(i).getIdAbogado().getIdAbogado() != id_Abogado){%>    
                                        onclick="mostrarMensajeSoloVer()"
                                    <%}else{%>
                                        onclick='window.location.href = "<%=request.getContextPath()%>/expedientes/editarExpediente.jsp?idExpediente=<%=lista.get(i).getIdExpediente()%>"'
                                   <%}%>
                                > 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"eliminarExpediente")){%>  
                                <i class="fa fa-remove" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'"
                                    <%if(abogadoLogueado && lista.get(i).getIdAbogado().getIdAbogado() != id_Abogado){%>  
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
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/ExpedienteServlet" method="post">
                            <input name= "idExpediente" id="eliminar-exp" type="hidden"/>   
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
                        <p>Solamente se puede ver el Expediente</p>
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
                    var nroExpediente = document.getElementById("nroExpediente-"+fila).textContent;
                    var idExpediente = document.getElementById("idExpediente-"+fila).value; 
                    
                    document.getElementById("eliminar-exp").value = idExpediente;
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar el expediente " + nroExpediente + "?";
                    
                    
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
