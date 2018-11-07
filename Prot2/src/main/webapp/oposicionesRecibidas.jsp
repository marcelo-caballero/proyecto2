<%-- 
    Document   : oposicionesRecibidas
    Created on : 22-oct-2018, 13:30:07
    Author     : User
--%>


<%@page import="modeloMng.OposicionRecibidaJpaController"%>
<%@page import="modelo.OposicionRecibida"%>
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
        
        <%  Integer idExp = (Integer)(request.getSession().getAttribute("idExpediente"));
        
            List<OposicionRecibida> lista; 
            OposicionRecibidaJpaController opoRecibidaControl = new OposicionRecibidaJpaController();
            lista = opoRecibidaControl.findOposicionRecibidaEntities(); 
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Oposición</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        
                        <th>Titular de oposición</th>
                        <th>Número de expediente</th>
                        <th>Marca</th>
                        <th>Estado</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"agregarOposicionRecibida.jsp")){%> 
                                <i class="fa fa-plus-circle" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/oposicionRecibida/agregarOposicionRecibida.jsp"'> 
                                </i>
                            <%}%>
                            
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>
                    <tr>
                        <input id="idOposicion-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdOposicion()%>"/>   
                        
                        <td id="titular-<%=i%>"><%=lista.get(i).getTitular()%></td>
                        <td id=""><%=lista.get(i).getNroExpediente()%></td>  
                        <td id=""><%=lista.get(i).getMarca()%></td> 
                        <td id=""><%=lista.get(i).getIdEstado().getDescripcion()%></td>      
                       
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"verOposicionRecibida.jsp")){%>
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/oposicionRecibida/verOposicionRecibida.jsp?idOposicion=<%=lista.get(i).getIdOposicion()%>"'>  
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"editarOposicionRecibida.jsp")){%> 
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/oposicionRecibida/editarOposicionRecibida.jsp?idOposicion=<%=lista.get(i).getIdOposicion()%>"'> 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"eliminarOposicionRecibida")){%>  
                                <i class="fa fa-remove" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick="modalEliminar('<%=i%>')"> 
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
                        <form id="form-eliminar" action="<%=request.getContextPath()%>/OposicionRecibidaServlet" method="post">
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
        <br>
        <script>
            function modalEliminar(fila) {
                $(document).ready(function () {

                    $("#modal-eliminar").modal();
                    var titular = document.getElementById("titular-"+fila).textContent;
                    var idOposicion = document.getElementById("idOposicion-"+fila).value; 
                    
                    document.getElementById("eliminar-oposicion").value = idOposicion;
                    document.getElementById("eliminar-mensaje").textContent =
                            "¿Desea eliminar la oposición de " + titular + "?";
                    
                    
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