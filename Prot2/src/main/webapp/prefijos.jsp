

<%@page import="modeloMng.PrefijoJpaController"%>
<%@page import="modelo.Prefijo"%>
<%@page import="modelo.Rol"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.RolJpaController"%>  
<%response.setHeader("Cache-Control", "no-cache");
%>

<!DOCTYPE html>
<html>
    <head>
        <title>Factura</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>
    </head>
    <body>
        <%
           
            List<Prefijo> lista = new PrefijoJpaController().findPrefijoEntities();

        %> 

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuFacturacion.jsp" %>     
        </div>
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Datos de la factura</h2>
            <br>
            
            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        <th>R.U.C.</th>
                        <th>Prefijo</th>
                        <th>Inicio</th>
                        <th>Fin</th>
                        <th>Próximo</th>
                        <th></th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>

                    <tr>
                         
                        <td><%=lista.get(i).getRuc()%></td>
                        <td><%=lista.get(i).getPrefijo()%></td>
                        <td><%=lista.get(i).getInicio()%></td> 
                        <td><%=lista.get(i).getFin()%></td>
                        <td><%=lista.get(i).getProximo()%></td>
                        
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"verPrefijo.jsp")){%> 
                                <i class="fa fa-search" 
                                    style="font-size:24px"  
                                    onmouseover="this.style.cursor = 'pointer'" 
                                    onclick='window.location.href = "<%=request.getContextPath()%>/prefijo/verPrefijo.jsp?idPrefijo=<%=lista.get(i).getId()%>"'> 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"editarPrefijo.jsp")){%>
                                <i class="fa fa-edit" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/prefijo/editarPrefijo.jsp?idPrefijo=<%=lista.get(i).getId()%>"'>  
                                </i>
                            <%}%>
                        </td>
                    </tr>
                    <%}%>
                </tbody>
            </table> 

        </div>
        <br>
        <script>
            
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