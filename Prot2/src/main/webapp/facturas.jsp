<%-- 
    Document   : facturas
    Created on : 13-nov-2018, 18:08:05
    Author     : User
--%>

<%@page import="modeloMng.FacturaCabeceraJpaController"%>
<%@page import="modelo.FacturaCabecera"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>

        <title>Factura - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    </head>
    <body onload="init()">
        
        <%
            List<FacturaCabecera> lista;
            FacturaCabeceraJpaController facturaControl = new FacturaCabeceraJpaController();
            lista = facturaControl.findFacturaCabeceraEntities();
            /*try{
                lista = clasecontrol.findClaseEntities();
            }catch(Exception e){ 
            
            }*/
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         <div class="container">
           <%@include file="//WEB-INF/menuFacturacion.jsp" %>     
        </div>
        <div class="container form-control">
            <%@include file="//WEB-INF/mensajeErrorABM.jsp" %>
            <h2 class="text-justify">Facturas</h2>
            <br>

            <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                <thead style="background-color:whitesmoke">
                    <tr>
                        <th>Número de Factura</th>
                        <th>R.U.C.</th>
                        <th>Fecha</th>
                        <th>Condición Venta</th>
                        <th>Estado</th>
                        <th>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"agregarFactura.jsp")){%>
                                <i class="fa fa-plus-circle" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/facturas/agregarFactura.jsp"'> 
                                </i>
                            <%}%> 
                        </th>
                    </tr>
                </thead>

                <tbody id='cuerpoTabla'>
                    <%for (int i = 0; i < lista.size(); i++) {%>

                    <tr>
                        <input id="idFactura-<%=i%>" type="hidden"  value="<%=lista.get(i).getIdFactura()%>"/>   
                        <td id="numFactura-<%=i%>"><%=lista.get(i).getNumeroFactura()%></td>
                        <td id=""><%=lista.get(i).getIdCliente().getRuc()%></td>  
                        <td id=""><%=lista.get(i).getStringFecha()%></td>  
                        <td id=""><%=lista.get(i).getCondicionVenta()%></td>  
                        <td id=""><%=lista.get(i).getEstado()%></td>  
                       
                        <td>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"verFactura.jsp")){%> 
                                <i class="fa fa-search" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/facturas/verFactura.jsp?idFactura=<%=lista.get(i).getIdFactura()%>"'> 
                                </i>
                            <%}%>
                            <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"anularFactura.jsp" )){%> 
                                <i class="fa fa-remove" 
                                   style="font-size:24px"  
                                   onmouseover="this.style.cursor = 'pointer'" 
                                   onclick='window.location.href = "<%=request.getContextPath()%>/facturas/anularFactura.jsp?idFactura=<%=lista.get(i).getIdFactura()%>"'> 
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
