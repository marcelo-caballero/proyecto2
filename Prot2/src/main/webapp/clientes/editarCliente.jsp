<%-- 
    Document   : editarCliente
    Created on : 13-sep-2018, 2:02:08
    Author     : Acer
--%>


<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="modelo.Cliente"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Pais"%> 
<%@page import="modeloMng.PaisJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Titular - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="mostrarCamposSegunTipoPersona(),actualizarPais()">
        <%
            Integer idCliente = Integer.parseInt(request.getParameter("idCliente"));
            ClienteJpaController clienteControl = new ClienteJpaController();
            Cliente cliente = clienteControl.findCliente(idCliente);    

            List<Pais> listaPais;
            PaisJpaController paisControl = new PaisJpaController();
            listaPais = paisControl.findPaisEntities();
            

            boolean editable = clienteControl.esEditable(idCliente);
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
            
            <h2 class="text-justify"> Editar Titular</h2>
            <br> 
            <%if(cliente.getEstado().equals("INACTIVO")){%> 
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong> No se puede editar un titular con estado inactivo
                </div>
            <%}%>
            <br>
        
            <form id="editarCliente" 
                  action="<%=request.getContextPath()%>/ClienteServlet?editar=true" 
                  method="post" 
                  novalidate>
                  <input type="hidden" name="idCliente" value="<%=idCliente%>"> 
            </form>
            
                 
            <div class="row form-group">
                <div class="col-3">
                    <label for="tipoCliente">Tipo de Persona:</label>
                </div>  
                <div class="col-6">
                    <select form="editarCliente" 
                            name="tipoCliente" 
                            id="tipoCliente" 
                            class="form-control"
                            onchange="mostrarCamposSegunTipoPersona()">
                            <%if(!editable){%> 
                                <%if(cliente.getTipoCliente().equals("F")){%>
                                    <option selected value="F">  
                                        Física 
                                    </option>
                                <%}else{%>
                                    <option selected value="J">  
                                        Jurídica 
                                    </option>
                                <%}%> 
                            <%}else{%>
                                <%if(cliente.getTipoCliente().equals("F")){%>
                                    <option selected value="F">  
                                        Física 
                                    </option>
                                    <option value="J">  
                                        Jurídica 
                                    </option>
                                <%}else{%>
                                    <option  value="F">  
                                        Física 
                                    </option>
                                    <option selected value="J">  
                                        Jurídica 
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                   
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="ci">C.I.Nº:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="ci"
                           id="ci"
                           class="form-control"
                           type="number" 
                           placeholder="Escriba el número de cédula del titular"
                           required 
                           value="<%=cliente.getCi()%>" 
                           onkeypress="return isNumberKey(event)">
                    <div id="ci-retro"></div>
                </div> 
            </div>
                          
            <div class="row form-group">
                <div class="col-3">
                    <label for="nombre">Nombre:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="nombre"
                           id="nombre"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el nombre del titular"
                           maxlength=""
                           required 
                           <%if(cliente.getNombre() != null){%> 
                                value="<%=cliente.getNombre()%>"
                           <%}%>
                           >
                    <div id="nombre-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group" >
                <div class="col-3">
                    <label for="apellido">Apellido:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="apellido"
                           id="apellido"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el apellido del titular"
                           maxlength=""
                           required 
                           <%if(cliente.getApellido() != null){%> 
                                value="<%=cliente.getApellido()%>"
                           <%}%>
                           
                           >
                    <div id="apellido-retro"></div>
                </div> 
            </div>
                   
            <div class="row form-group">
                <div class="col-3">
                    <label for="ruc">R.U.C.:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="ruc"
                           id="ruc"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el R.U.C. del titular"
                           required
                            <%if(cliente.getRuc() != null){%> 
                                value="<%=cliente.getRuc()%>"
                           <%}%>
                           
                           >
                    <div id="ruc-retro"></div>
                </div> 
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="apellido">Razón Social:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="razonSocial"
                           id="razonSocial"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la razón social del titular"
                           maxlength=""
                           required 
                           <%if(cliente.getRazonSocial() != null){%> 
                                value="<%=cliente.getRazonSocial()%>"
                           <%}%>
                           
                           >
                    <div id="razonSocial-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="direccion">Dirección:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="direccion"
                           id="direccion"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la dirección del titular"
                           maxlength=""
                           required 
                           value="<%=cliente.getDireccion()%>"
                           >
                    <div id="direccion-retro"></div>
                </div> 
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="telefono">Teléfono:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="telefono"
                           id="telefono"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el teléfono del titular"
                           maxlength=""
                           required 
                           value="<%=cliente.getTelefono()%>"
                           >
                    <div id="telefono-retro"></div>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="email">Correo electrónico:</label> 
                </div>
                <div class="col-6">
                    <input form="editarCliente"
                           name="email"
                           id="email"
                           class="form-control"
                           type="email" 
                           placeholder="Escriba el correo electrónico del agente"
                           maxlength=""
                           value="<%=cliente.getEmail()%>" 
                           required >
                    <div id="email-retro"></div>
                </div> 
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label for="idPais">País del titular:</label>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-3">
                            <input id="codigoPais" class="form-control" disabled>
                        </div>
                        <div class="col">
                            <select form="editarCliente"
                                    name="idPais" 
                                    id="idPais"
                                    class="form-control"
                                    onchange="actualizarPais()">
                                    <option value="<%=cliente.getIdPais().getIdPais()%>"> 
                                        <%=cliente.getIdPais().getPais()%>
                                    </option>
                                    <%for (int j = 0; j < listaPais.size(); j++) {%>
                                        <%if (cliente.getIdPais().getIdPais() != listaPais.get(j).getIdPais()) {%> 
                                            <option value="<%=listaPais.get(j).getIdPais()%>">
                                                <%=listaPais.get(j).getPais()%>
                                            </option>
                                        <%}%>
                                    <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>
              
            
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="editar"
                           type="button"
                           value="Editar"
                           <%if(cliente.getEstado().equals("ACTIVO")){%>
                                onclick="validarFormulario()"
                           <%}%>
                    >
                </div>    
            </div>

       
        </div>
        <br>
        <script>
            function actualizarPais(){
                
                document.getElementById("codigoPais").value = document.getElementById("idPais").value;   
            }
            
            function mostrarCamposSegunTipoPersona(){
                
                var tipoPersona = document.getElementById("tipoCliente").value;
                
                if(tipoPersona == "F"){
                    
                    <%if(!editable){%> 
                       document.getElementById("ci").setAttribute("readonly","");
                       document.getElementById("nombre").setAttribute("readonly","");
                       document.getElementById("apellido").setAttribute("readonly","");
                       document.getElementById("ruc").setAttribute("readonly","");
                       
                    <%}%>
                    document.getElementById("ci").removeAttribute("disabled","");
                    document.getElementById("ci").setAttribute("class","form-control");
                    
                    
                    document.getElementById("nombre").removeAttribute("disabled","");
                    document.getElementById("nombre").setAttribute("class","form-control");
                    
                    document.getElementById("apellido").removeAttribute("disabled","");
                    document.getElementById("apellido").setAttribute("class","form-control");
                    
                    
                    //document.getElementById("razonSocial").value = "";
                    document.getElementById("razonSocial").setAttribute("disabled","");
                    document.getElementById("razonSocial").setAttribute("class","form-control");
                    document.getElementById("razonSocial-retro").textContent="";
                    
                    
                }else{
                    //document.getElementById("ci").value = "";
                    
                    <%if(!editable){%> 
                        
                       document.getElementById("razonSocial").setAttribute("readonly","");
                       document.getElementById("ruc").setAttribute("readonly","");
                       
                    <%}%>
                    document.getElementById("ci").setAttribute("disabled","");
                    document.getElementById("ci").setAttribute("class","form-control");
                    document.getElementById("ci-retro").textContent="";
                    
                    //document.getElementById("nombre").value = "";
                    document.getElementById("nombre").setAttribute("disabled","");
                    document.getElementById("nombre").setAttribute("class","form-control");
                    document.getElementById("nombre-retro").textContent="";
                    
                    //document.getElementById("apellido").value = "";
                    document.getElementById("apellido").setAttribute("disabled","");
                    document.getElementById("apellido").setAttribute("class","form-control");
                    document.getElementById("apellido-retro").textContent="";
                    
                   
                    
                    document.getElementById("razonSocial").removeAttribute("disabled","");
                    document.getElementById("razonSocial").setAttribute("class","form-control");
                }
            }
            
            function validarFormulario(){
                var tipoPersona = document.getElementById("tipoCliente").value;
                
                
                if(tipoPersona == "F"){
                    var ciValido = validarCi();
                    var nombreValido = validarNombre();
                    var apellidoValido = validarApellido();
                    var direccionValido = validarDireccion();
                    var telefonoValido = validarTelefono();
                    var rucValido = validarRuc();
                    var emailValido = validarEmail();
                    
                    if(ciValido && nombreValido && apellidoValido && direccionValido && telefonoValido && rucValido && emailValido){
                        validarUnicidadCi();
                    
                    }
                }else{
                    var rucValido = validarRuc();
                    var razonSocialValido = validarRazonSocial();
                    var direccionValido = validarDireccion();
                    var telefonoValido = validarTelefono();
                    var emailValido = validarEmail();
                    
                    if(rucValido && razonSocialValido  && direccionValido && telefonoValido && emailValido){
                        validarUnicidadRuc();
                    
                    }
                    
                }
                
            }
            
            //Llamada al ajax para validar que el numero de cedula del cliente
            //sea unico
            //Si no es unico, informa al usuario
            //Caso contrario, envia el formulario
            function validarUnicidadCi(){

                var ciInput = document.getElementById("ci");
                var retroCi = document.getElementById("ci-retro");
                var strCi = ciInput.value;

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/ClienteServlet?ciDuplicado="+strCi+"&idCliente="+<%=idCliente%>, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var ciDuplicado = objectoJSON.ciDuplicado;

                        if(ciDuplicado == null){

                            ciInput.setAttribute("class","form-control is-invalid");
                            retroCi.setAttribute("class","invalid-feedback");
                            retroCi.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad de la cédula';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        } else if(ciDuplicado){

                            ciInput.setAttribute("class","form-control is-invalid");
                            retroCi.setAttribute("class","invalid-feedback");
                            retroCi.textContent = 'Ya existe un titular con la misma cédula';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("editarCliente").submit();

                        }

                    }
                };

                //bloquear boton editar
                document.getElementById("editar").setAttribute("disabled","");
                xmlHttp.send();

                // Timeout para abortar despues 5 segundos
                var xmlHttpTimeout=setTimeout(ajaxTimeout,5000);
                function ajaxTimeout(){
                    xmlHttp.abort();

                    ciInput.setAttribute("class","form-control is-invalid");
                    retroCi.setAttribute("class","invalid-feedback");
                    retroCi.textContent = 'No se pudo validar que la cédula sea única. \n Intente más tarde';

                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
                }

            }
            
            
            //Llamada al ajax para validar que el ruc del cliente
            //sea unico
            //Si no es unico, informa al usuario
            //Caso contrario, envia el formulario
            function validarUnicidadRuc(){

                var rucInput = document.getElementById("ruc");
                var retroRuc = document.getElementById("ruc-retro");
                var strRuc = rucInput.value.trim(); 

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/ClienteServlet?rucDuplicado="+strRuc+"&idCliente="+<%=idCliente%>, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var rucDuplicado = objectoJSON.rucDuplicado;

                        if(rucDuplicado == null){

                            rucInput.setAttribute("class","form-control is-invalid");
                            retroRuc.setAttribute("class","invalid-feedback");
                            retroRuc.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad del R.U.C.';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        } else if(rucDuplicado){

                            rucInput.setAttribute("class","form-control is-invalid");
                            retroRuc.setAttribute("class","invalid-feedback");
                            retroRuc.textContent = 'Ya existe un titular con el mismo R.U.C.';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("editarCliente").submit();

                        }

                    }
                };

                //bloquear boton editar
                document.getElementById("editar").setAttribute("disabled","");
                xmlHttp.send();

                // Timeout para abortar despues 5 segundos
                var xmlHttpTimeout=setTimeout(ajaxTimeout,5000);
                function ajaxTimeout(){
                    xmlHttp.abort();

                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'No se pudo validar que el R.U.C. sea única. \n Intente más tarde';

                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
                }

            }
               
               
            function validarCi(){
                var ciInput = document.getElementById("ci");
                var retroCi = document.getElementById("ci-retro");
                var strCi = ciInput.value;
                
                if(strCi.length == 0){ 
                    ciInput.setAttribute("class","form-control is-invalid");
                    retroCi.setAttribute("class","invalid-feedback");
                    retroCi.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                ciInput.setAttribute("class","form-control is-valid");
                retroCi.setAttribute("class","valid-feedback");
                retroCi.textContent = '';
                    
                return true;
            }
            
            function validarNombre(){
                var nombreInput = document.getElementById("nombre");
                var retroNombre = document.getElementById("nombre-retro");
                var strNombre = nombreInput.value.trim();
                
                if(strNombre.length == 0){ 
                    nombreInput.setAttribute("class","form-control is-invalid");
                    retroNombre.setAttribute("class","invalid-feedback");
                    retroNombre.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                nombreInput.setAttribute("class","form-control is-valid");
                retroNombre.setAttribute("class","valid-feedback");
                retroNombre.textContent = '';
                    
                return true;
            }
            
            function validarApellido(){
                var apellidoInput = document.getElementById("apellido");
                var retroApellido = document.getElementById("apellido-retro");
                var strApellido = apellidoInput.value.trim();
                
                if(strApellido.length == 0){ 
                    apellidoInput.setAttribute("class","form-control is-invalid");
                    retroApellido.setAttribute("class","invalid-feedback");
                    retroApellido.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                apellidoInput.setAttribute("class","form-control is-valid");
                retroApellido.setAttribute("class","valid-feedback");
                retroApellido.textContent = '';
                    
                return true;
            }
            
            function validarDireccion(){
                var direccionInput = document.getElementById("direccion");
                var retroDireccion = document.getElementById("direccion-retro");
                var strDireccion = direccionInput.value.trim();
                
                if(strDireccion.length == 0){ 
                    direccionInput.setAttribute("class","form-control is-invalid");
                    retroDireccion.setAttribute("class","invalid-feedback");
                    retroDireccion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                direccionInput.setAttribute("class","form-control is-valid");
                retroDireccion.setAttribute("class","valid-feedback");
                retroDireccion.textContent = '';
                    
                return true;
            }
            
            function validarDireccion(){
                var direccionInput = document.getElementById("direccion");
                var retroDireccion = document.getElementById("direccion-retro");
                var strDireccion = direccionInput.value.trim();
                
                if(strDireccion.length == 0){ 
                    direccionInput.setAttribute("class","form-control is-invalid");
                    retroDireccion.setAttribute("class","invalid-feedback");
                    retroDireccion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                direccionInput.setAttribute("class","form-control is-valid");
                retroDireccion.setAttribute("class","valid-feedback");
                retroDireccion.textContent = '';
                    
                return true;
            }
            
            function validarTelefono(){
                var telefonoInput = document.getElementById("telefono");
                var retroTelefono = document.getElementById("telefono-retro");
                var strTelefono = telefonoInput.value.trim();
                
                if(strTelefono.length == 0){ 
                    telefonoInput.setAttribute("class","form-control is-invalid");
                    retroTelefono.setAttribute("class","invalid-feedback");
                    retroTelefono.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                telefonoInput.setAttribute("class","form-control is-valid");
                retroTelefono.setAttribute("class","valid-feedback");
                retroTelefono.textContent = '';
                    
                return true;
            }
            
            //Permite unicamente la insercion de numeros
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
            function validarRazonSocial(){
                var razonSocialInput = document.getElementById("razonSocial");
                var retroRazonSocial = document.getElementById("razonSocial-retro");
                var strRazonSocial = razonSocialInput.value.trim();
                
                if(strRazonSocial.length == 0){ 
                    razonSocialInput.setAttribute("class","form-control is-invalid");
                    retroRazonSocial.setAttribute("class","invalid-feedback");
                    retroRazonSocial.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                razonSocialInput.setAttribute("class","form-control is-valid");
                retroRazonSocial.setAttribute("class","valid-feedback");
                retroRazonSocial.textContent = '';
                    
                return true;
            }
            
            function validarRuc(){
                var rucInput = document.getElementById("ruc");
                var retroRuc = document.getElementById("ruc-retro");
                var strRuc = rucInput.value.trim();
                
                rucInput.value = strRuc;
                
               
                
                if(strRuc.length == 0){ 
                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'El campo esta vacío';
                    
                    return false;
                } 
                
                if(/\s/.test(strRuc)){

                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'No debe contener espacios';
                    return false;
                } 
                
                rucInput.setAttribute("class","form-control is-valid");
                retroRuc.setAttribute("class","valid-feedback");
                retroRuc.textContent = '';
                    
                return true;
            }
            
            function validarEmail(){
                var emailInput = document.getElementById("email");
                var retroEmail = document.getElementById("email-retro");
                var strEmail = emailInput.value.trim();
                
                emailInput.value = strEmail;
                
                if(!emailInput.validity.valid){ 
                    emailInput.setAttribute("class","form-control is-invalid");
                    retroEmail.setAttribute("class","invalid-feedback");
                    retroEmail.textContent = 'Ingrese un correo electrónico válido';
                    
                    return false;
                }
                
                emailInput.setAttribute("class","form-control is-valid");
                retroEmail.setAttribute("class","valid-feedback");
                retroEmail.textContent = '';
                    
                return true;
            }
        </script>
    </body>
</html>
    