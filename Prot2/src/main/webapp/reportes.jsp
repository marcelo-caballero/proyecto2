<%-- 
    Document   : reportes
    Created on : 19-nov-2018, 18:26:55
    Author     : User
--%>

<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="modelo.Cliente"%>
<%@page import="java.util.List"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <title>Reportes - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    </head>
    <body>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <%
            List<Cliente> listaClientes = new ClienteJpaController().getListaClienteOrdenados();
        %>
        <br>
        <div class="container form-control">
            <h2 class="text-justify">Reportes</h2>
            <br>
            <ul class="nav nav-tabs" role="tablist">
                <li class="nav-item">
                    <a class="nav-link active" data-toggle="tab" href="#home">Ingresos</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu1">Oposiciones recibidas</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu2">Oposiciones realizadas</a>
                </li>
                 <li class="nav-item">
                    <a class="nav-link" data-toggle="tab" href="#menu3">Expedientes</a>
                </li>
            </ul>

            <!-- Tab panes -->
            <div class="tab-content">
                <div id="home" class="container tab-pane active"><br>
                    <h3>Ingresos</h3>
                    <br>
                    <form id="reporteIngresos" 
                        action="<%=request.getContextPath()%>/GenerarReporteIngresosServlet" 
                        method="post" 
                        novalidate
                        onsubmit="">
                    </form>
                        
                    <div class = "row form-group">   
                        <div class="col-3">
                            <label for="">Rango de Fecha:</label>
                        </div>
                        <div class="col-6">    
                            <div class="row">
                                <div class="col">
                                    <input form="reporteIngresos"
                                           id="fechaDesdeIngresos" 
                                           name="fechaDesde"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaDesdeIngresos-retro"></div>
                                </div>
                                
                                <div class="col">
                                    <input form="reporteIngresos"
                                           id="fechaHastaIngresos" 
                                           name="fechaDesdeIngresos"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaHastaIngresos-retro"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Titular:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteIngresos"
                                   name="titular"
                                   id="titularIngresos"
                                   class="form-control"
                                   type="text"
                            >
                                <option>Todos</option>
                                <%for(int i=0; i<listaClientes.size();i++){%>
                                    <option value="<%=listaClientes.get(i).getIdCliente()%>"><%=listaClientes.get(i).getNombreCliente()%></option> 
                                <%}%>
                            </select> 
                            <div id="titularIngresos-retro"></div>
                        </div>    
                    </div>
                    <div class="row form-group">
                        <div class="col-5">
                        </div>
                        <div class="col-2">
                            <input id="editar"
                               type="button"
                               value="Generar Reporte"
                               onclick="validarFormularioReporteIngresos()"
                            >
                        </div>    
                    </div>
                </div>
                            
                            
                <div id="menu1" class="container tab-pane fade"><br>
                    <h3>Oposiciones recibidas</h3>
                    <p>Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.</p>
                </div>
                <div id="menu2" class="container tab-pane fade"><br>
                    <h3>Oposiciones realizadas</h3>
                    <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                </div>
                <div id="menu3" class="container tab-pane fade"><br>
                    <h3>Expedientes</h3>
                    <p>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam.</p>
                </div>
            </div>
        </div>
    </div>
    <script>
            function validarFormularioReporteIngresos(){
                
                document.getElementById("reporteIngresos").submit();
            }
    </script>
    <br>
</body>
</html>