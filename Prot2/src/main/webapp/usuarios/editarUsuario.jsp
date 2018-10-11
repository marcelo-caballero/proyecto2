<%-- 
    Document   : editarUsuario
    Created on : 13-sep-2018, 16:26:22
    Author     : Acer
--%>

<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="modelo.Cliente"%>
<%@page import="modeloMng.AbogadoJpaController"%>
<%@page import="modelo.Abogado"%>
<%@page import="modeloMng.UsuarioJpaController"%>
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
            Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario")); 
            Usuario usu = new UsuarioJpaController().findUsuario(idUsuario); 
            List<Rol> listaRol = new RolJpaController().findRolEntities();
            List<Abogado> listaAbogado = new AbogadoJpaController().getListaAbogadoSinUsuario();
            List<Cliente> listaCliente = new ClienteJpaController().getListaClienteSinUsuario(); 
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
            <%if(usu.getEstado().equals("INACTIVO")){%>
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong> No se puede editar un usuario con estado inactivo
                </div>
            <%}%>
            <h2 class="text-justify"> Editar Usuario</h2>
            <br> 
        
            <form id="editarUsuario" 
                  action="<%=request.getContextPath()%>/UsuarioServlet?editar=true" 
                  method="post" 
                  novalidate>
                <input type="hidden" name="idUsuario" value="<%=usu.getIdUsuario()%>"> 
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="idRol">Rol:</label>
                </div>  
                <div class="col-6">
                    <select form="editarUsuario" 
                            name="idRol" 
                            id="idRol" 
                            class="form-control">
                            <%for (int j = 0; j < listaRol.size(); j++) {
                                if(usu.getIdRol().getIdRol() == listaRol.get(j).getIdRol()){
                            %> 
                                    <option selected value="<%=listaRol.get(j).getIdRol()%>">   
                                        <%=listaRol.get(j).getRol()%>  
                                    </option>
                                <%}else{%>
                                    <option value="<%=listaRol.get(j).getIdRol()%>">   
                                        <%=listaRol.get(j).getRol()%>  
                                    </option>
                                <%}%>
                             <%}%>
                    </select>             
                </div>
            </div>
            
            
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="cuenta">Cuenta Usuario:</label> 
                </div>
                <div class="col-6">
                    <input form="editarUsuario"
                           name="cuenta"
                           id="cuenta"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba la cuenta del usuario"
                           required 
                           value="<%=usu.getCuenta()%>"
                           onkeypress="return isLetterNumberKey(event)"
                           <%if(usu.getAsociado() != null){%>
                                readonly
                           <%}%>
                           >
                    <div id="cuenta-retro"></div>
                </div> 
            </div>
  
            <div class="row form-group">
                <div class="col-3">
                    <label for="contrasena">Contraseña:</label> 
                </div>
                <div class="col-6">
                    <input form="editarUsuario"
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
                    <input form="editarUsuario"
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
                     
            <%if(usu.getAsociado() == null){%>
                <div class="row form-group">
                    <div class="col-3">
                        <label for="asociado">Asociar cuenta a:</label>
                    </div>  
                    <div class="col-6">
                        <select form="editarUsuario" 
                                name="asociar" 
                                id="asociar" 
                                onchange="habilitarSelect()"
                                class="form-control">
                                <option selected value="">Ninguno</option>
                                <%if(listaAbogado.size() > 0){%>
                                    <option  value="ABOGADO">Abogado</option>
                                <%}%>
                                <%if(listaCliente.size() > 0){%>
                                    <option  value="CLIENTE">Cliente</option>
                                <%}%>
                        </select>
                    </div>
                </div>

                <div class="row form-group">
                    <div class="col-3">
                        <label for="idAbogado">Abogado:</label>
                    </div>  
                    <div class="col-6">
                        <select form="editarUsuario" 
                                name="idAbogado" 
                                id="idAbogado" 
                                disabled
                                class="form-control">
                                <%for (int j = 0; j < listaAbogado.size(); j++) {%> 
                                    <option value="<%=listaAbogado.get(j).getIdAbogado()%>">  
                                        <%=listaAbogado.get(j).getNombreApellido()%>   
                                    </option>
                                <%}%>
                        </select>
                    </div>
                </div>
                
                <div class="row form-group">
                    <div class="col-3">
                        <label for="idCliente">Cliente</label>
                    </div>  
                    <div class="col-6">
                        <select form="editarUsuario" 
                                name="idCliente" 
                                id="idCliente"
                                disabled
                                class="form-control">
                                <%for (int j = 0; j < listaCliente.size(); j++) {%> 
                                    <option value="<%=listaCliente.get(j).getIdCliente()%>">  
                                        <%=listaCliente.get(j).getNombreCliente()%> 
                                    </option>
                                <%}%>
                        </select>
                    </div>
                </div>
            <%}%> 

            <%if(usu.getEstado().equals("ACTIVO")){%>
                <div class="row form-group">
                    <div class="col-5">
                    </div>
                    <div class="col-2">
                        <input id="editar"
                               type="button"
                               value="Editar"
                               onclick="validarFormulario()">
                    </div>    
                </div>
            <%}%>
            
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
            function habilitarSelect(){
                var asociarSelect = document.getElementById("asociar");
                var abogadoSelect = document.getElementById("idAbogado");
                var clienteSelect = document.getElementById("idCliente");
                if(asociarSelect.value == ""){
                    abogadoSelect.disabled = true;
                    clienteSelect.disabled = true;
                }
                if(asociarSelect.value == "ABOGADO"){
                    
                    abogadoSelect.disabled = false;
                    clienteSelect.disabled = true;
                }
                if(asociarSelect.value == "CLIENTE"){
                    
                    abogadoSelect.disabled = true;
                    clienteSelect.disabled = false;
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
                "<%=request.getContextPath()%>/UsuarioServlet?cuentaDuplicado="+strCuenta+"&idUsuario="+<%=usu.getIdUsuario()%>,  
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

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        } else if(cuentaDuplicado){

                            cuentaInput.setAttribute("class","form-control is-invalid");
                            retroCuenta.setAttribute("class","invalid-feedback");
                            retroCuenta.textContent = 'Ya existe un usuario con el mismo nombre de cuenta';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("editarUsuario").submit();

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

                    cuentaInput.setAttribute("class","form-control is-invalid");
                    retroCuenta.setAttribute("class","invalid-feedback");
                    retroCuenta.textContent = 'No se pudo validar que la cuenta sea única. \n Intente más tarde';

                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
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
            
            
            
           
        </script>
    </body>
</html>