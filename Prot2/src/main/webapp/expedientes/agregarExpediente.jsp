<%-- 
    Document   : agregarExpediente
    Created on : 22-ago-2018, 13:27:25
    Author     : Acer
--%>


<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="modeloMng.AbogadoJpaController"%>
<%@page import="modeloMng.EstadoMarcaJpaController"%>
<%@page import="modeloMng.ClaseJpaController"%>
<%@page import="modeloMng.MarcaJpaController"%>
<%@page import="modeloMng.TipoExpedienteJpaController"%> 

<%@page import="java.util.List"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Abogado"%>
<%@page import="modelo.EstadoMarca"%> 
<%@page import="modelo.Clase"%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.TipoExpediente"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expediente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="cambiarDescripcionClase(),habilitarNroCertificado()">
        <%
            
            List<Cliente> listaCliente;
            ClienteJpaController clienteControl = new ClienteJpaController();
            listaCliente = clienteControl.getListaClienteActivo();
            
            List<Abogado> listaAbogado;
            AbogadoJpaController abogadoControl = new AbogadoJpaController();
            listaAbogado= abogadoControl.getListaAbogadoActivo(); 

            List<EstadoMarca> listaEstadoMarca;
            EstadoMarcaJpaController estadoMarcaControl = new EstadoMarcaJpaController();
            listaEstadoMarca = estadoMarcaControl.getListaEstadoMarcaIniciales();   

            List<Marca> listaMarca;
            MarcaJpaController marcaControl = new MarcaJpaController();
            listaMarca = marcaControl.findMarcaEntities(); 

            List<Clase> listaClase;
            ClaseJpaController claseControl = new ClaseJpaController();
            listaClase = claseControl.findClaseEntities();  

            List<TipoExpediente> listaTipoExpediente;
            TipoExpedienteJpaController tipoExpedienteControl = new TipoExpedienteJpaController();
            listaTipoExpediente = tipoExpedienteControl.findTipoExpedienteEntities();  


            //Fecha correspondiente hace 10 años a partir de hoy
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            cal.add(Calendar.YEAR, -10);
            Date fechaLimiteInferior = cal.getTime(); 

            String fechaHaceDiezAños = new SimpleDateFormat("yyyy-MM-dd").format(fechaLimiteInferior);
            String hoy = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
            
        %>
        <%--> Input tipo hidden para cambiar el contenido producto 
               segun el número de clase <--%>
        <%for (int j = 0; j < listaClase.size(); j++) {%> 
            <input type="hidden" 
                   id="descripcion-<%=listaClase.get(j).getNroClase()%>" 
                   value="<%=listaClase.get(j).getDescripcion()%>">                          
        <%}%>
        <%--><--%>
        
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class ="container form-control">
            <h2 class="text-justify">Agregar Expediente</h2> 
            <br>
          
            <form id="agregarExpediente" 
                  action="<%=request.getContextPath()%>/ExpedienteServlet?agregar=true" 
                  method="post" 
                  novalidate>
            </form>
               
            <div class = "row form-group">
                <div class="col-3">
                    <label for="nroExpediente">Número del Expediente:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="nroExpediente"
                           id="nroExpediente"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el número de expediente"
                           required
                           onkeypress="return isNumberKey(event)">
                    <div id="nroExpediente-retro"></div> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroClase">Clase:</label>
                </div>
                <div class="col-6">
                    <select form="agregarExpediente"
                           name="nroClase"
                           id="nroClase"
                           class="form-control"
                           onchange="cambiarDescripcionClase()"
                           required>
                           <%for (int j = 0; j < listaClase.size(); j++) {%> 
                                <option value="<%=listaClase.get(j).getNroClase()%>"> 
                                    <%=listaClase.get(j).getNroClase()%>  
                                </option>
                           <%}%>
                    </select>
                    <div id="nroClase-retro"></div>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="producto">Descripción de la clase:</label>
                </div>
                <div class="col-6"> 
                    <textarea   id="descripcionClase"
                                class="form-control"
                                rows="8"
                                maxlength="700"
                                readonly
                                ></textarea>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="producto">Producto:</label>
                </div>
                <div class="col-6">
                    <textarea   form="agregarExpediente"
                                name="producto"
                                id="producto"
                                class="form-control"
                                rows="8"
                                maxlength="700"
                                placeholder="Escriba una breve descripción del producto"
                                required
                                ></textarea>
                    <div id="producto-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaSolicitud">Fecha de Solicitud:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="fechaSolicitud"
                           id="fechaSolicitud"
                           type="date"
                           class="form-control" 
                           value="<%=hoy%>"
                           min="<%=fechaHaceDiezAños%>"
                           max="<%=hoy%>"
                           required>
                    <div id="fechaSolicitud-retro"></div>
                </div>               
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="idEstadoMarca">Estado actual:</label>
                </div>  
                <div class="col-6">
                    <select form="agregarExpediente" 
                            name="idEstadoMarca" 
                            id="idEstadoMarca" 
                            class="form-control">
                            <%for (int j = 0; j < listaEstadoMarca.size(); j++) {%> 
                                <option value="<%=listaEstadoMarca.get(j).getIdEstado()%>"> 
                                    <%=listaEstadoMarca.get(j).getDescripcion()%>  
                                </option>
                            <%}%>
                    </select>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaEstado">Fecha de Status:</label>
                </div>
                <div class="col-6">
                    <input form="agregarExpediente"
                           name="fechaEstado"
                           id="fechaEstado"
                           type="date" 
                           class="form-control"
                           value="<%=hoy%>" 
                           max="<%=hoy%>"
                           required>
                    <div id="fechaEstado-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idAbogado">Agente:</label>
                </div>
                <div class="col-6">
                    <select form="agregarExpediente"
                            name="idAbogado" 
                            id="idAbogado"
                            class="form-control">
                            <option value="-1">Seleccione un agente</option>
                            <%for (int j = 0; j < listaAbogado.size(); j++) {%> 
                                <option value="<%=listaAbogado.get(j).getIdAbogado()%>">  
                                    <%=listaAbogado.get(j).getNombreApellido()%>  
                                </option>
                            <%}%>
                    </select>
                    <div id="idAbogado-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="idCliente">Titular:</label>
                </div>
                <div class="col-6">                                                
                    <select form="agregarExpediente"
                            name="idCliente" 
                            id="idCliente"
                            class="form-control">
                            <option value="-1">Seleccione un titular</option>
                            <%for (int j = 0; j < listaCliente.size(); j++) {%> 
                                <option value="<%=listaCliente.get(j).getIdCliente()%>"> 
                                    <%=listaCliente.get(j).getNombreCliente()%> 
                                </option>
                            <%}%>
                    </select>
                    <div id="idCliente-retro"></div>
                </div>
            </div> 
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idMarca">Denominación de la marca:</label>
                </div>
                <div class="col-6">
                    <select form="agregarExpediente"
                            name="idMarca" 
                            id="idMarca" 
                            class="form-control">
                                <option value="-1">Seleccione una marca</option>
                                <%for (int j = 0; j < listaMarca.size(); j++) {%> 
                                    <option value="<%=listaMarca.get(j).getIdMarca()%>"> 
                                        <%=listaMarca.get(j).getDenominacion()%>  
                                    </option>
                                <%}%>
                    </select>
                    <div id="idMarca-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="idTipoExpediente">Tipo de trámite:</label>
                </div>
                <div class="col-6">  
                    <select form="agregarExpediente"
                            name="idTipoExpediente" 
                            id="idTipoExpediente"
                            class="form-control"
                            onchange="habilitarNroCertificado()">
                            <%for (int j = 0; j < listaTipoExpediente.size(); j++) {%> 
                                <option value="<%=listaTipoExpediente.get(j).getIdTipoExpediente()%>"> 
                                    <%=listaTipoExpediente.get(j).getDescripcion()%>  
                                </option>
                            <%}%>
                    </select>
                </div>
            </div>
                 
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroCertificado">Número de Certificado de Marca:</label>
                </div>
                <div class="col-6">  
                    <input form="agregarExpediente"
                            name="nroCertificado" 
                            id="nroCertificado"
                            class="form-control"
                            onkeypress="return isNumberKey(event)">
                    <div id="nroCertificado-retro"></div>
                </div>
            </div>
                   
            <div class="row form-group">
                <div class="col-3">
                    <label for="obs">Observación:</label>
                </div>
                <div class="col-6">
                    <textarea   form="agregarExpediente"
                                name="obs"
                                id="obs"
                                class="form-control"
                                rows="6"
                                maxlength=""
                                placeholder="Escriba una breve observación"
                                ></textarea>
                    <div id="obs-retro"></div>
                </div>
            </div>
                        
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Agregar"
                           onclick="validarFormulario()">
                </div>    
            </div>  
         
        </div>
        <br>
        <script>
            function habilitarNroCertificado(){
                var nroCertificadoInput = document.getElementById("nroCertificado");
                var tipoExpedienteInput = document.getElementById("idTipoExpediente");
                
                var retroNroCertificado = document.getElementById("nroCertificado-retro");
                
                //Si el tipo de expediente es renovacion entonces se solicita un nro certificado marca
                if(tipoExpedienteInput.value == 2){
                    
                    nroCertificadoInput.disabled = false;
                    
                }else{
                    nroCertificadoInput.disabled = true;
                    nroCertificadoInput.value = "";
                    nroCertificadoInput.setAttribute("class","form-control");
                    retroNroCertificado.setAttribute("class","");
                    retroNroCertificado.textContent = '';
                    
                }
                
            }
            
            function validarNroCertificado(){
                var nroCertificadoInput = document.getElementById("nroCertificado"); 
                var retroNroCertificado = document.getElementById("nroCertificado-retro");
                
                if(!nroCertificadoInput.disabled){
                    if(nroCertificadoInput.value.length == 0){
                        nroCertificadoInput.setAttribute("class","form-control is-invalid");
                        retroNroCertificado.setAttribute("class","invalid-feedback");
                        retroNroCertificado.textContent = 'El campo esta vacío';

                        return false;
                    }  
                }
                
                nroCertificadoInput.setAttribute("class","form-control is-valid");
                retroNroCertificado.setAttribute("class","valid-feedback");
                retroNroCertificado.textContent = '';

                return true;
                
            }
            
            
            function cambiarDescripcionClase() {
                var nroClase = document.getElementById("nroClase").value;
                var descripcion = document.getElementById("descripcion-"+nroClase).value;
                
                document.getElementById("descripcionClase").textContent = descripcion;
            }
            
            function validarFormulario(){
                var obsInput = document.getElementById("obs");
                obsInput.value = obsInput.value.trim();
                
                var nroExpedienteValido = validarNroExpediente();
                var nroClase = validarNroClase();
                var productoValido = validarProducto();
                var fechaSolicitudValido = validarFechaSolicitud();
                var fechaEstadoValido = validarFechaEstado(fechaSolicitudValido);
                var marcaValido = validarMarca();
                var abogadoValido = validarAbogado();
                var clienteValido = validarCliente();
                var nroCertificadoValido = validarNroCertificado();
                       
                
                if(nroExpedienteValido && 
                    nroClase && 
                    productoValido && 
                    fechaEstadoValido && 
                    fechaSolicitudValido &&
                    marcaValido &&
                    abogadoValido &&
                    clienteValido &&
                    nroCertificadoValido){
                    
                    validarUnicidadNroExpediente();
                    
                }
            }
                
            //Llamada al ajax para validar que el numero de expediente
            //sea unico
            //Si no es unico, informa al cliente
            //Caso contrario, envia el formulario
            function validarUnicidadNroExpediente(){

                var nroExpedienteInput = document.getElementById("nroExpediente");
                var retroNroExpediente = document.getElementById("nroExpediente-retro");
                var strNroExpediente = nroExpedienteInput.value;

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/ExpedienteServlet?nroExpedienteDuplicado="+strNroExpediente, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var nroExpedienteDuplicado = objectoJSON.nroExpedienteDuplicado;

                        if(nroExpedienteDuplicado == null){

                            nroExpedienteInput.setAttribute("class","form-control is-invalid");
                            retroNroExpediente.setAttribute("class","invalid-feedback");
                            retroNroExpediente.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad del expediente';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        } else if(nroExpedienteDuplicado){

                            nroExpedienteInput.setAttribute("class","form-control is-invalid");
                            retroNroExpediente.setAttribute("class","invalid-feedback");
                            retroNroExpediente.textContent = 'Ya existe un expediente con el mismo número';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("agregarExpediente").submit();

                        }

                    }
                };

                //bloquear boton agregar
                document.getElementById("agregar").setAttribute("disabled","");
                xmlHttp.send();

                // Timeout para abortar despues 5 segundos
                var xmlHttpTimeout=setTimeout(ajaxTimeout,5000);
                function ajaxTimeout(){
                    xmlHttp.abort();

                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'No se pudo validar que el número deexpediente sea único. \n Intente más tarde';

                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                }

            }
               
            
            
            function validarNroExpediente(){
                var nroExpedienteInput = document.getElementById("nroExpediente");
                var retroNroExpediente = document.getElementById("nroExpediente-retro");
                var strNroExpediente = nroExpedienteInput.value;
                
                if(strNroExpediente.length == 0){ 
                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                nroExpedienteInput.setAttribute("class","form-control is-valid");
                retroNroExpediente.setAttribute("class","valid-feedback");
                retroNroExpediente.textContent = '';
                    
                return true;
                
            }
            
            function validarNroClase(){
                var nroClaseInput = document.getElementById("nroClase");
                var retroNroClase = document.getElementById("nroClase-retro");
                var strNroClase = nroClaseInput.value;
                
                if(strNroClase.length == 0){ 
                    nroClaseInput.setAttribute("class","form-control is-invalid");
                    retroNroClase.setAttribute("class","invalid-feedback");
                    retroNroClase.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(Number(strNroClase) <= 0  || Number(strNroClase) > 45){ 
                    nroClaseInput.setAttribute("class","form-control is-invalid");
                    retroNroClase.setAttribute("class","invalid-feedback");
                    retroNroClase.textContent = 'La clase debe ser un número entre 1 y 45';
                    
                    return false;
                }
                
                nroClaseInput.setAttribute("class","form-control is-valid");
                retroNroClase.setAttribute("class","valid-feedback");
                retroNroClase.textContent = '';
                    
                return true;
                
            }
            
            function validarProducto(){
                var productoInput = document.getElementById("producto");
                var retroProducto = document.getElementById("producto-retro");
                var strProducto = productoInput.value.trim();
                productoInput.value = strProducto;
                
                if(strProducto.length == 0){ 
                    productoInput.setAttribute("class","form-control is-invalid");
                    retroProducto.setAttribute("class","invalid-feedback");
                    retroProducto.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                productoInput.setAttribute("class","form-control is-valid");
                retroProducto.setAttribute("class","valid-feedback");
                retroProducto.textContent = '';
                    
                return true;
                
            }
            
            function validarFechaEstado(fechaSolicitudValido){
                var fechaEstadoInput = document.getElementById("fechaEstado");
                var retroFechaEstado = document.getElementById("fechaEstado-retro");
                var strFechaEstado = fechaEstadoInput.value.trim(); 
                
                if(!fechaSolicitudValido){
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'Escriba una fecha de solicitud válida';
                    
                    return false;
                }
                
                fechaEstadoInput.setAttribute("min",document.getElementById("fechaSolicitud").value);


                if(strFechaEstado.length == 0){ 
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(fechaEstadoInput.validity.rangeUnderflow){
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'La fecha del estado no debe ser anterior a la fecha de solicitud';

                    return false;
                }
                
                if(fechaEstadoInput.validity.rangeOverflow){
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'La fecha del estado no debe ser posterior a la fecha de hoy';

                    return false;
                }
                    
                fechaEstadoInput.setAttribute("class","form-control is-valid");
                retroFechaEstado.setAttribute("class","valid-feedback");
                retroFechaEstado.textContent = '';
                    
                return true;
                
            }
            
            function validarFechaSolicitud(){
                var fechaSolicitudInput = document.getElementById("fechaSolicitud");
                var retroFechaSolicitud = document.getElementById("fechaSolicitud-retro");
                var strFechaSolicitud = fechaSolicitudInput.value.trim(); 
                
                if(strFechaSolicitud.length == 0){ 
                    fechaSolicitudInput.setAttribute("class","form-control is-invalid");
                    retroFechaSolicitud.setAttribute("class","invalid-feedback");
                    retroFechaSolicitud.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(!fechaSolicitudInput.validity.valid){
                    
                    fechaSolicitudInput.setAttribute("class","form-control is-invalid");
                    retroFechaSolicitud.setAttribute("class","invalid-feedback");
                    
                    retroFechaSolicitud.textContent = 
                        'La fecha debe estar entre <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaLimiteInferior)%> y <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>';
                    
                    return false;
                    
                }
   
                fechaSolicitudInput.setAttribute("class","form-control is-valid");
                retroFechaSolicitud.setAttribute("class","valid-feedback");
                retroFechaSolicitud.textContent = '';
                    
                return true;
                
            }
            
            
            //Permite unicamente la insercion de numeros
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
            
            function validarAbogado(){
                var idAbogadoSelect = document.getElementById("idAbogado");
                var retroIdAbogado = document.getElementById("idAbogado-retro");
                var strIdAbogado = idAbogadoSelect.value;
                
                if(strIdAbogado == -1){ 
                    idAbogadoSelect.setAttribute("class","form-control is-invalid");
                    retroIdAbogado.setAttribute("class","invalid-feedback");
                    retroIdAbogado.textContent = 'Seleccione un agente válido';
                    
                    return false;
                } 
                
                idAbogadoSelect.setAttribute("class","form-control is-valid");
                retroIdAbogado.setAttribute("class","valid-feedback");
                retroIdAbogado.textContent = '';
                
                return true;
            }
            
            function validarCliente(){
                var idClienteSelect = document.getElementById("idCliente");
                var retroIdCliente = document.getElementById("idCliente-retro");
                var strIdCliente = idClienteSelect.value;
                
                if(strIdCliente == -1){ 
                    idClienteSelect.setAttribute("class","form-control is-invalid");
                    retroIdCliente.setAttribute("class","invalid-feedback");
                    retroIdCliente.textContent = 'Seleccione un titular válido';
                    
                    return false;
                }
                
                idClienteSelect.setAttribute("class","form-control is-valid");
                retroIdCliente.setAttribute("class","valid-feedback");
                retroIdCliente.textContent = '';
                
                return true;
            }
            
            
            function validarMarca(){
                var idMarcaSelect = document.getElementById("idMarca");
                var retroIdMarca = document.getElementById("idMarca-retro");
                var strIdMarca = idMarcaSelect.value;
                
                if(strIdMarca == -1){ 
                    idMarcaSelect.setAttribute("class","form-control is-invalid");
                    retroIdMarca.setAttribute("class","invalid-feedback");
                    retroIdMarca.textContent = 'Seleccione una marca válida';
                    return false
                }
                
                idMarcaSelect.setAttribute("class","form-control is-valid");
                retroIdMarca.setAttribute("class","valid-feedback");
                retroIdMarca.textContent = '';
                return true;
            }
        </script>
    </body>
</html>
