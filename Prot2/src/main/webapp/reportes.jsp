<%-- 
    Document   : reportes
    Created on : 19-nov-2018, 18:26:55
    Author     : User
--%>

<%@page import="modeloMng.EstadoMarcaJpaController"%>
<%@page import="modelo.EstadoMarca"%>
<%@page import="modeloMng.AbogadoJpaController"%>
<%@page import="modelo.Abogado"%>
<%@page import="modeloMng.MarcaJpaController"%>
<%@page import="modelo.Marca"%>
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
            List<Marca> listaMarca = new MarcaJpaController().findMarcaEntities();
            List<Abogado> listaAbogado = new AbogadoJpaController().getListaTodosAbogadosOrdenadoPorNombre();
            List<EstadoMarca> listaEstadoMarca = new EstadoMarcaJpaController().findEstadoMarcaEntities();
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
                        target="_blank"
                        action="<%=request.getContextPath()%>/GenerarReporteServlet?reporteIngresos=true" 
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
                                           name="fechaHasta"
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
                                   name="idCliente"
                                   id="titularIngresos"
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaClientes.size();i++){%>
                                    <option value="<%=listaClientes.get(i).getIdCliente()%>"><%=listaClientes.get(i).getNombreCliente()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    <div class="row form-group">
                        <div class="col-5">
                        </div>
                        <div class="col-2">
                            <input id=""
                               type="button"
                               value="Generar Reporte"
                               onclick="validarFormularioReporteIngresos()"
                            >
                        </div>    
                    </div>
                </div>
                            
                            
                <div id="menu1" class="container tab-pane fade"><br>
                    <h3>Oposiciones recibidas</h3>
                    <br>
                    <form id="reporteOR"
                        target="_blank"
                        action="<%=request.getContextPath()%>/GenerarReporteServlet?reporteOposicionRecibida=true" 
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
                                    <input form="reporteOR"
                                           id="fechaDesdeOR" 
                                           name="fechaDesde"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaDesdeOR-retro"></div>
                                </div>
                                
                                <div class="col">
                                    <input form="reporteOR"
                                           id="fechaHastaOR" 
                                           name="fechaHasta"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaHastaOR-retro"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%--
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Titular:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOR"
                                   name="idCliente"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaClientes.size();i++){%>
                                    <option value="<%=listaClientes.get(i).getIdCliente()%>"><%=listaClientes.get(i).getNombreCliente()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Marca:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOR"
                                   name="idMarca"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaMarca.size();i++){%>
                                    <option value="<%=listaMarca.get(i).getIdMarca()%>"><%=listaMarca.get(i).getDenominacion()%></option>  
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Agente:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOR"
                                   name="idAbogado"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaAbogado.size();i++){%> 
                                    <option value="<%=listaAbogado.get(i).getIdAbogado()%>"><%=listaAbogado.get(i).getNombreApellido()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div> --%>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Oposiciones:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOR"
                                   name="ganadaOperdida"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="0">Ganadas/Perdidas</option>
                                <%--<option value="1">Ganadas</option>
                                <option value="-1">Perdidas</option>--%>
                                
                            </select> 
                        </div>    
                    </div> 
                    <div class="row form-group">
                        <div class="col-5">
                        </div>
                        <div class="col-2">
                            <input id=""
                               type="button"
                               value="Generar Reporte"
                               onclick="validarFormularioReporteOR()"
                            >
                        </div>    
                    </div>
                </div>
                            
                <div id="menu2" class="container tab-pane fade"><br>
                    <h3>Oposiciones realizadas</h3>
                    <br>
                    <form id="reporteOH" 
                        target="_blank"
                        action="<%=request.getContextPath()%>/GenerarReporteServlet?reporteOposicionHecha=true" 
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
                                    <input form="reporteOH"
                                           id="fechaDesdeOH" 
                                           name="fechaDesde"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaDesdeOH-retro"></div>
                                </div>
                                
                                <div class="col">
                                    <input form="reporteOH"
                                           id="fechaHastaOH" 
                                           name="fechaHasta"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaHastaOH-retro"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                        <%--
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Titular:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOH"
                                   name="idCliente"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaClientes.size();i++){%>
                                    <option value="<%=listaClientes.get(i).getIdCliente()%>"><%=listaClientes.get(i).getNombreCliente()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Marca:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOH"
                                   name="idMarca"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaMarca.size();i++){%>
                                    <option value="<%=listaMarca.get(i).getIdMarca()%>"><%=listaMarca.get(i).getDenominacion()%></option>  
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Agente:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOH"
                                   name="idAbogado"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaAbogado.size();i++){%> 
                                    <option value="<%=listaAbogado.get(i).getIdAbogado()%>"><%=listaAbogado.get(i).getNombreApellido()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div>--%>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Oposiciones:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteOH"
                                   name="ganadaOperdida"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="0">Ganadas/Perdidas</option>
                               <%-- <option value="1">Ganadas</option>
                                <option value="-1">Perdidas</option> --%>
                                
                            </select> 
                        </div>    
                    </div>
                    <div class="row form-group">
                        <div class="col-5">
                        </div>
                        <div class="col-2">
                            <input id=""
                               type="button"
                               value="Generar Reporte"
                               onclick="validarFormularioReporteOH()"
                            >
                        </div>    
                    </div>
                </div>
                <div id="menu3" class="container tab-pane fade"><br>
                    <h3>Estado Actual de los Expedientes</h3>
                    <br>
                    <form id="reporteExp" 
                        target="_blank"
                        action="<%=request.getContextPath()%>/GenerarReporteServlet?reporteExpediente=true" 
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
                                    <input form="reporteExp"
                                           id="fechaDesdeExp" 
                                           name="fechaDesde"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaDesdeExp-retro"></div>
                                </div>
                                
                                <div class="col">
                                    <input form="reporteExp"
                                           id="fechaHastaExp" 
                                           name="fechaHasta"
                                           type="date"
                                           class="form-control" 
                                    >
                                    <div id="fechaHastaExp-retro"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Titular:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteExp"
                                   name="idCliente"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaClientes.size();i++){%>
                                    <option value="<%=listaClientes.get(i).getIdCliente()%>"><%=listaClientes.get(i).getNombreCliente()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Agente:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteExp"
                                   name="idAbogado"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaAbogado.size();i++){%> 
                                    <option value="<%=listaAbogado.get(i).getIdAbogado()%>"><%=listaAbogado.get(i).getNombreApellido()%></option> 
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    <div class = "row form-group">
                        <div class="col-3">
                            <label for="">Estado:</label>
                        </div>
                        <div class="col-6">
                            <select form="reporteExp"
                                   name="idEstadoMarca"
                                   id=""
                                   class="form-control"
                                   type="text"
                            >
                                <option value="-1">Todos</option>
                                <%for(int i=0; i<listaEstadoMarca.size();i++){%> 
                                    <option value="<%=listaEstadoMarca.get(i).getIdEstado()%>"><%=listaEstadoMarca.get(i).getDescripcion()%></option>  
                                <%}%>
                            </select> 
                        </div>    
                    </div>
                    
                    <div class="row form-group">
                        <div class="col-5">
                        </div>
                        <div class="col-2">
                            <input id=""
                               type="button"
                               value="Generar Reporte"
                               onclick="validarFormularioReporteExp()"
                            >
                        </div>    
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
            function validarFormularioReporteIngresos(){
                
                var fechaValido = validarFecha("fechaDesdeIngresos","fechaHastaIngresos","fechaDesdeIngresos-retro","fechaHastaIngresos-retro");
                
                if(fechaValido){
                    document.getElementById("reporteIngresos").submit();
                }
                
            }
            
            function validarFormularioReporteOR(){
                
                var fechaValido = validarFecha("fechaDesdeOR","fechaHastaOR","fechaDesdeOR-retro","fechaHastaOR-retro");
                
                if(fechaValido){
                    document.getElementById("reporteOR").submit();
                }
                
            }
            
            function validarFormularioReporteOH(){
                
                var fechaValido = validarFecha("fechaDesdeOH","fechaHastaOH","fechaDesdeOH-retro","fechaHastaOH-retro");
                
                if(fechaValido){
                    document.getElementById("reporteOH").submit();
                }
                
            }
            
            function validarFormularioReporteExp(){
                
                var fechaValido = validarFecha("fechaDesdeExp","fechaHastaExp","fechaDesdeExp-retro","fechaHastaExp-retro");
                
                if(fechaValido){
                   document.getElementById("reporteExp").submit();
                }
                
            }
            
            function validarFecha(fechaDesdeInput, fechaHastaInput, retroFechaDesde, retroFechaHasta){
                var fechaDesdeInput = document.getElementById(fechaDesdeInput);
                var fechaHastaInput = document.getElementById(fechaHastaInput);
                
                var retroFechaDesde = document.getElementById(retroFechaDesde);
                var retroFechaHasta = document.getElementById(retroFechaHasta);
                
                if(fechaDesdeInput.value.length == 0){
                    fechaDesdeInput.setAttribute("class","form-control is-invalid");
                    retroFechaDesde.setAttribute("class","invalid-feedback");
                    retroFechaDesde.textContent = 'Escriba una fecha válida';
                    
                    fechaHastaInput.setAttribute("class","form-control is-valid");
                    retroFechaHasta.setAttribute("class","valid-feedback");
                    retroFechaHasta.textContent = '';
                    
                    return false;
                }
                
                fechaDesdeInput.setAttribute("class","form-control is-valid");
                retroFechaDesde.setAttribute("class","valid-feedback");
                retroFechaDesde.textContent = '';
                    
                fechaHastaInput.setAttribute("min",fechaDesdeInput.value);
                
                if(fechaHastaInput.value.length == 0){
                    fechaHastaInput.setAttribute("class","form-control is-invalid");
                    retroFechaHasta.setAttribute("class","invalid-feedback");
                    retroFechaHasta.textContent = 'Escriba una fecha válida';
                    
                    return false;
                }
                
                if(!fechaHastaInput.validity.valid){
                    var fechaLimite = fechaDesdeInput.value.substring(8,10);
                    fechaLimite = fechaLimite+"/";
                    fechaLimite = fechaLimite+fechaDesdeInput.value.substring(5,7);
                    fechaLimite = fechaLimite+"/";
                    fechaLimite = fechaLimite+fechaDesdeInput.value.substring(0,4);
                    
                    fechaHastaInput.setAttribute("class","form-control is-invalid");
                    retroFechaHasta.setAttribute("class","invalid-feedback");
                    retroFechaHasta.textContent = 'La fecha no debe ser anterior a '+fechaLimite;
                    
                    return false;
                    
                }
                
                fechaHastaInput.setAttribute("class","form-control is-valid");
                retroFechaHasta.setAttribute("class","valid-feedback");
                retroFechaHasta.textContent = '';
                
                return true;
                /*fechaHastaInput.setAttribute("min",fechaDesdeInput.value);
                
                if(!fechaDesdeInput.value.length == 0 && fechaHastaInput.value.length == 0){
                    fechaHastaInput.setAttribute("class","form-control is-invalid");
                    retroFechaHasta.setAttribute("class","invalid-feedback");
                    retroFechaHasta.textContent = 'Escriba una fecha válida';
                    
                    
                    fechaDesdeInput.setAttribute("class","form-control is-valid");
                    retroFechaDesde.setAttribute("class","valid-feedback");
                    retroFechaDesde.textContent = '';
                    
                    return false;
                }
                
                if(fechaDesdeInput.value.length == 0 && !fechaHastaInput.value.length == 0){
                    fechaDesdeInput.setAttribute("class","form-control is-invalid");
                    retroFechaDesde.setAttribute("class","invalid-feedback");
                    retroFechaDesde.textContent = 'Escriba una fecha válida';
                    
                    fechaHastaInput.setAttribute("class","form-control is-valid");
                    retroFechaHasta.setAttribute("class","valid-feedback");
                    retroFechaHasta.textContent = '';
                    
                    return false;
                }
                
                if(!fechaHastaInput.validity.valid){
                    var fechaLimite = fechaDesdeInput.value.substring(8,10);
                    fechaLimite = fechaLimite+"/";
                    fechaLimite = fechaLimite+fechaDesdeInput.value.substring(5,7);
                    fechaLimite = fechaLimite+"/";
                    fechaLimite = fechaLimite+fechaDesdeInput.value.substring(0,4);
                    
                    fechaHastaInput.setAttribute("class","form-control is-invalid");
                    retroFechaHasta.setAttribute("class","invalid-feedback");
                    retroFechaHasta.textContent = 'La fecha no debe ser anterior a '+fechaLimite;
                    
                    return false;
                    
                }
                
                fechaHastaInput.setAttribute("class","form-control is-valid");
                retroFechaHasta.setAttribute("class","valid-feedback");
                retroFechaHasta.textContent = '';
                
                fechaDesdeInput.setAttribute("class","form-control is-valid");
                retroFechaDesde.setAttribute("class","valid-feedback");
                retroFechaDesde.textContent = '';
                
                return true;*/
                
            }
    </script>
    <br>
</body>
</html>