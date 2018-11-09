<%-- 
    Document   : agregarFactura
    Created on : 09-nov-2018, 2:28:13
    Author     : User
--%>

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
    <body>
        
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Agregar Factura</h2>
            <br> 
        
            <form id="agregarCliente" 
                  action="<%=request.getContextPath()%>/Factura.jsp" 
                  method="post" 
                  novalidate>
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="numFact">Número de Factura:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarCliente"
                           name="numFact"
                           id="numFact"
                           class="form-control"
                           type="number" 
                           placeholder="Escriba el número de factura"
                           required 
                           onkeypress="return isNumberKey(event)">
                    <div id="ci-retro"></div>
                </div> 
            </div>
                  
                 
            <div class="row form-group">
                <div class="col-3">
                    <label for="tipoCliente">Condición de Venta:</label>
                </div>  
                <div class="col-6">
                    <select form="agregarCliente" 
                            name="cond_venta" 
                            id="" 
                            class="form-control"
                            >
                            <option value="CONTADO">  
                                Contado 
                            </option>
                            <option value="CREDITO">  
                                Crédito 
                            </option>
                    </select>
                   
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="ruc">R.U.C.:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarCliente"
                           name="ruc"
                           id="ruc"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el R.U.C. del titular"
                           required>
                    <div id="ruc-retro"></div>
                </div> 
            </div>
                    
            
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="nombre">Descripción: </label> 
                </div>
                <div class="col-6">
                    <input form="agregarCliente"
                           name="descripcion"
                           id="descripcion"
                           class="form-control"
                           type="text" 
                           placeholder=""
                           maxlength=""
                           required >
                    <div id="nombre-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group" >
                <div class="col-3">
                    <label for="apellido">Monto:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarCliente"
                           name="monto"
                           id=""
                           class="form-control"
                           type="number" 
                           placeholder=""
                           onkeypress="return isNumberKey(event)"
                           required >
                    <div id="apellido-retro"></div>
                </div> 
            </div>
                   
            <div class="row form-group" >
                <div class="col-3">
                    <label for="apellido">Monto:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarCliente"
                           name="iva"
                           id=""
                           class="form-control"
                           type="number" 
                           placeholder=""
                           onkeypress="return isNumberKey(event)"
                           required >
                    <div id="apellido-retro"></div>
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
            function actualizarPais(){
                
                document.getElementById("codigoPais").value = document.getElementById("idPais").value;   
            }
            
            function mostrarCamposSegunTipoPersona(){
                
                var tipoPersona = document.getElementById("tipoCliente").value;
                
                if(tipoPersona == "F"){
                   
                    document.getElementById("ci").removeAttribute("disabled","");
                    document.getElementById("ci").setAttribute("class","form-control");
                    
                    document.getElementById("nombre").removeAttribute("disabled","");
                    document.getElementById("nombre").setAttribute("class","form-control");
                    
                    document.getElementById("apellido").removeAttribute("disabled","");
                    document.getElementById("apellido").setAttribute("class","form-control");
                    
                    
                    document.getElementById("razonSocial").value = "";
                    document.getElementById("razonSocial").setAttribute("disabled","");
                    document.getElementById("razonSocial").setAttribute("class","form-control");
                    document.getElementById("razonSocial-retro").textContent="";
                    
                    
                }else{
                    document.getElementById("ci").value = "";
                    document.getElementById("ci").setAttribute("disabled","");
                    document.getElementById("ci").setAttribute("class","form-control");
                    document.getElementById("ci-retro").textContent="";
                    
                    document.getElementById("nombre").value = "";
                    document.getElementById("nombre").setAttribute("disabled","");
                    document.getElementById("nombre").setAttribute("class","form-control");
                    document.getElementById("nombre-retro").textContent="";
                    
                    document.getElementById("apellido").value = "";
                    document.getElementById("apellido").setAttribute("disabled","");
                    document.getElementById("apellido").setAttribute("class","form-control");
                    document.getElementById("apellido-retro").textContent="";
                    
                   
                    
                    document.getElementById("razonSocial").removeAttribute("disabled","");
                    document.getElementById("razonSocial").setAttribute("class","form-control");
                }
            }
            
            function validarFormulario(){
                /*var tipoPersona = document.getElementById("tipoCliente").value;
                
                
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
                    
                }*/
                document.getElementById("agregarCliente").submit();
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
                "<%=request.getContextPath()%>/ClienteServlet?ciDuplicado="+strCi, 
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

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        } else if(ciDuplicado){

                            ciInput.setAttribute("class","form-control is-invalid");
                            retroCi.setAttribute("class","invalid-feedback");
                            retroCi.textContent = 'Ya existe un titular con la misma cédula';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("agregarCliente").submit();

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

                    ciInput.setAttribute("class","form-control is-invalid");
                    retroCi.setAttribute("class","invalid-feedback");
                    retroCi.textContent = 'No se pudo validar que la cédula sea única. \n Intente más tarde';

                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
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
                "<%=request.getContextPath()%>/ClienteServlet?rucDuplicado="+strRuc, 
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

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        } else if(rucDuplicado){

                            rucInput.setAttribute("class","form-control is-invalid");
                            retroRuc.setAttribute("class","invalid-feedback");
                            retroRuc.textContent = 'Ya existe un titular con el mismo R.U.C.';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("agregarCliente").submit();

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

                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'No se pudo validar que el R.U.C. sea única. \n Intente más tarde';

                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
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
                
                nombreInput.value = strNombre;
                
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
                
                apellidoInput.value = strApellido;
                
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
                
                direccionInput.value = strDireccion;
                
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
                
                telefonoInput.value = strTelefono;
                
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
                
                razonSocialInput.value = strRazonSocial;
                
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
                
                //var tipoPersona = document.getElementById("tipoCliente").value;
                
                //if(strRuc.length == 0 && tipoPersona == "J"){
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