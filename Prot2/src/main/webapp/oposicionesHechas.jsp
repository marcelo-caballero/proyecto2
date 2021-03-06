<%-- 
    Document   : oposicionesHechas
    Created on : 04-nov-2018, 23:57:03
    Author     : User
--%>

<%@page import="modeloMng.OposicionHechaJpaController"%>
<%@page import="modelo.OposicionHecha"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Oposiciones - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>

        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    </head>
    <body>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <%  
        
            OposicionHechaJpaController opoHechaControl = new OposicionHechaJpaController();
            List<OposicionHecha> lista = opoHechaControl.findOposicionHechaEntities();
            
            boolean abogadoLogueado = false;  
            Integer id_Abogado = null; 
            //Verificamos si se conecto un cliente o un abogado
            if(usuario.getAsociado() != null){ 
                if(usuario.getAsociado().equals("CLIENTE")){
                    lista = opoHechaControl.getListaOposicionHechaPorCliente(usuario.getClienteList().get(0).getIdCliente()); 
                }else{
                    //verificamos que el usuario sea abogado
                    abogadoLogueado = true;
                    id_Abogado = usuario.getAbogadoList().get(0).getIdAbogado();
                }
            }
        %>
       
        
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Oposición</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>

                        <th>Nº Exp. Opositado</th>
                        <%--<th>Marca Opositada</th>--%>
                        <th>Titular Opositado</th>
                        <th>Agente Opositor</th>
                        <th>Status</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"agregarOposicionHecha.jsp")){%> 
                                <i class="fa fa-plus-circle" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'"
                                   onclick='window.location.href = "<%=request.getContextPath()%>/oposicionHecha/agregarOposicionHecha.jsp"'
                                   
                                >
                                </i>
                            <%}%>

                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>
                    <tr>
                        <input id="idOposicion-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdOposicion()%>"/>   

                        
                        <td id="nroExp-<%=i%>"><%=lista.get(i).getNroExpedienteOpositado()%></td>   
                        <%--<td id=""><%=lista.get(i).getDenominacionOpositado()%></td> --%>
                        <td id=""><%=lista.get(i).getTitularOpositado()%></td> 
                        <td id=""><%=lista.get(i).getIdAbogadoOpositante().getNombreApellido()%></td>  
                        <td id=""><%=lista.get(i).getIdEstadoOposicion().getDescripcion()%></td>  
                        

                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"verOposicionHecha.jsp")){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/oposicionHecha/verOposicionHecha.jsp?idOposicion=<%=lista.get(i).getIdOposicion()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"editarOposicionHecha.jsp")){%> 
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   <%if(abogadoLogueado && lista.get(i).getIdAbogadoOpositante().getIdAbogado() != id_Abogado){%>    
                                        onclick="mostrarMensajeSoloVer()"
                                   <%}else{%>
                                        onclick='window.location.href = "<%=request.getContextPath()%>/oposicionHecha/editarOposicionHecha.jsp?idOposicion=<%=lista.get(i).getIdOposicion()%>"'
                                   <%}%>
                                >
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"eliminarOposicionHecha")){%>  
                                <i class="fa fa-remove" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   <%if(abogadoLogueado && lista.get(i).getIdAbogadoOpositante().getIdAbogado() != id_Abogado){%>    
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
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/OposicionHechaServlet" method="post">
                            <input name= "idOposicion" id="eliminar-oposicion" type="hidden"/>   
                            <p id="eliminar-mensaje"></p>

                        </form>
                    </div>
                    <div class="modal-footer">
                        <button form="form-eliminar" id="btn-eliminar"  type="submit" name="eliminar" class="btn btn-default" >Eliminar</button>
                    </div>
                </div>
            </div>
        </div>
                            
        <%--Modal MensajeVer --%>
        <div class="modal fade" id="modal-mensaje" role="dialog">
            <div class="modal-dialog">
                <div class="modal-content">

                    <div class="modal-header">
                        <h4 class="modal-title">Información</h4>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <p>Solamente se puede ver la Oposición</p>
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
                    var nroExp = document.getElementById("nroExp-"+fila).textContent;
                    var idOposicion = document.getElementById("idOposicion-"+fila).value; 

                    document.getElementById("eliminar-oposicion").value = idOposicion;
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar la oposición " + nroExp + "?";


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
