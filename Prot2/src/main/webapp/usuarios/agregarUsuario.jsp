<%-- 
    Document   : agregarUsuario
    Created on : 13-sep-2018, 12:47:26
    Author     : Acer
--%>

<%@page import="modeloMng.RolJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Rol"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Usuario - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            List<Rol> listaRol = new RolJpaController().findRolEntities();
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Agregar Usuario</h2>
            <br> 
        
            <form id="agregarUsuario" 
                  action="<%=request.getContextPath()%>/UsuarioServlet?agregar=true" 
                  method="post" 
                  novalidate>
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="idRol">Rol:</label>
                </div>  
                <div class="col-6">
                    <select form="agregarUsuario" 
                            name="idRol" 
                            id="idRol"
                            <%if(listaRol.size() == 0) {%>
                                class="form-control is-invalid"
                            <%}else{%>
                                class="form-control"
                            <%}%>
                            >
                            <%for (int j = 0; j < listaRol.size(); j++) {%>   
                                <option value="<%=listaRol.get(j).getIdRol()%>">   
                                    <%=listaRol.get(j).getRol()%>   
                                </option>
                            <%}%>
                        <%if(listaRol.size() == 0) {%>
                            <div class="invalid-feedback">Debe existir al menos un rol</div>
                        <%}%>
                    </select>             
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="cuenta">Cuenta Usuario:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarUsuario"
                           name="cuenta"
                           id="cuenta"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la cuenta del usuario"
                           required
                           onkeypress="return isLetterNumberKey(event)">
                    <div id="cuenta-retro"></div>
                </div> 
            </div>
  
            <div class="row form-group">
                <div class="col-3">
                    <label for="contrasena">Contraseña:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarUsuario"
                           name="contrasena"
                           id="contrasena"
                           class="form-control"
                           type="password" 
                           placeholder="Escriba la contraseña"
                           minlength="8"
                           required >
                    <div id="contrasena-retro"></div>
                </div>
                <div class="col-1">
                    <i class="fa fa-eye"
                       id="verContrasena"
                       style="font-size:24px"  
                       onmouseover="this.style.cursor = 'pointer'" 
                       onclick='verPassword()'>  
                    </i>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="contrasena">Confirmación de contraseña:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarUsuario"
                           name=""
                           id="contrasenaConfirmacion"
                           class="form-control"
                           type="password" 
                           placeholder="Escriba de nuevo la contraseña"
                           minlength="8"
                           required >
                    <div id="contrasenaConfirmacion-retro"></div>
                </div>
                <div class="col-1">
                    <i class="fa fa-eye"
                       id="verContrasenaConfirmacion"
                       style="font-size:24px"  
                       onmouseover="this.style.cursor = 'pointer'" 
                       onclick='verPasswordConfirmacion()'>  
                    </i>
                </div>
            </div>
                     
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Guardar"
                           <%if(listaRol.size() == 0) {%>
                                disabled
                           <%}%>
                           onclick="validarFormulario()">
                </div>    
            </div>
       
        </div>
        <br>
        <script>
            
            function verPassword(){
                 var contraseña =  document.getElementById("contrasena");
                 var boton = document.getElementById("verContrasena");
                 
                 if(contraseña.type === "password"){
                     contraseña.type = "text";
                     boton.setAttribute("class","fa fa-eye-slash");
                  
                 }else{
                     contraseña.type = "password";
                     boton.setAttribute("class","fa fa-eye");
                 }
                 
            }
            
            function verPasswordConfirmacion(){
                 
                 var contraseñaConfirmacion = document.getElementById("contrasenaConfirmacion");
                 var boton = document.getElementById("verContrasenaConfirmacion");
                 
                 if(contraseñaConfirmacion.type === "password"){
                     contraseñaConfirmacion.type = "text";
                     boton.setAttribute("class","fa fa-eye-slash");
                 }else{
                     contraseñaConfirmacion.type = "password";
                     boton.setAttribute("class","fa fa-eye");
                    
                 }
                 
            }
            
            function validarFormulario(){
               
                var cuentaValida = validarCuenta();
                var contraseñaValido = validarContraseña();
                var contraseñaConfirmacionValido = validarContraseñaConfirmacion();
                
                if(cuentaValida && contraseñaValido && contraseñaConfirmacionValido){
                    validarUnicidadCuenta();

                }
            }
            
            //Llamada al ajax para validar que la cuenta del usuario 
            //sea unico
            //Si no es unico, informa del error
            //Caso contrario, envia el formulario
            function validarUnicidadCuenta(){

                var cuentaInput = document.getElementById("cuenta");
                var retroCuenta = document.getElementById("cuenta-retro");
                var strCuenta = cuentaInput.value; 

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/UsuarioServlet?cuentaDuplicado="+strCuenta, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objectoJSON = JSON.parse(this.responseText);
                        var cuentaDuplicado = objectoJSON.cuentaDuplicado;

                        if(cuentaDuplicado == null){

                            cuentaInput.setAttribute("class","form-control is-invalid");
                            retroCuenta.setAttribute("class","invalid-feedback");
                            retroCuenta.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad de la cuenta';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        } else if(cuentaDuplicado){

                            cuentaInput.setAttribute("class","form-control is-invalid");
                            retroCuenta.setAttribute("class","invalid-feedback");
                            retroCuenta.textContent = 'Ya existe un usuario con el mismo nombre de cuenta';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("agregarUsuario").submit();

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

                    cuentaInput.setAttribute("class","form-control is-invalid");
                    retroCuenta.setAttribute("class","invalid-feedback");
                    retroCuenta.textContent = 'No se pudo validar que la cuenta sea única. \n Intente más tarde';

                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                }

            }
               
               
            function validarCuenta(){
                var cuentaInput = document.getElementById("cuenta");
                var retroCuenta = document.getElementById("cuenta-retro");
                var strCuenta = cuentaInput.value; 
                
                if(strCuenta.length == 0 ){ 
                    cuentaInput.setAttribute("class","form-control is-invalid");
                    retroCuenta.setAttribute("class","invalid-feedback");
                    retroCuenta.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                cuentaInput.setAttribute("class","form-control is-valid");
                retroCuenta.setAttribute("class","valid-feedback");
                retroCuenta.textContent = '';
                    
                return true;
            }
            
            function validarContraseña(){
                var contrasenaInput = document.getElementById("contrasena");
                var retroContrasena = document.getElementById("contrasena-retro");
                var strContrasena = contrasenaInput.value;
                
                if(strContrasena.length < 8){ 
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe contener mínimo 8 caracteres';
                    
                    return false;
                }
                
                if(!(new RegExp('[abcdefghijklmnñopqrstuvwxyzáéíóú]').test(strContrasena))){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe tener al menos una letra minúscula';
                    
                    return false;
                }
                
                if(!(new RegExp('[ABCDEFGHIJKLMNÑOPQRSTUVWXYZÁÉÍÓÚ]').test(strContrasena))){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe tener al menos una letra mayúscula';
                
                    return false;
                }
                if(!(new RegExp('[0123456789]').test(strContrasena))){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'La contraseña debe tener al menos un número';
                    
                    return false;
                }
                
                contrasenaInput.setAttribute("class","form-control is-valid");
                retroContrasena.setAttribute("class","valid-feedback");
                retroContrasena.textContent = '';
                    
                return true;
            }
            
            
            function validarContraseñaConfirmacion(){
                var contrasenaInput = document.getElementById("contrasenaConfirmacion");
                var retroContrasena = document.getElementById("contrasenaConfirmacion-retro");
                var strContrasena = contrasenaInput.value;
                
                if(strContrasena != document.getElementById("contrasena").value){
                    contrasenaInput.setAttribute("class","form-control is-invalid");
                    retroContrasena.setAttribute("class","invalid-feedback");
                    retroContrasena.textContent = 'No coincide con la contraseña';
                    
                    return false;
                    
                }
                
                contrasenaInput.setAttribute("class","form-control is-valid");
                retroContrasena.setAttribute("class","valid-feedback");
                retroContrasena.textContent = '';
                
                return true;
            }
            
            //Permite unicamente la insercion de numeros y letras
            function isLetterNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 
                        && (charCode < 48 || charCode > 57) 
                        && (charCode < 65 || charCode > 90) 
                        && (charCode < 97 || charCode > 122))
                    return false;
                return true;
            }
            
            
           
        </script>
    </body>
</html>
    