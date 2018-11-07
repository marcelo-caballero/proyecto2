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
        <title>Rol - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idRol = Integer.parseInt(request.getParameter("idRol"));
            Rol rol = new RolJpaController().findRol(idRol);
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class="container">
           <%@include file="//WEB-INF/menuConfiguraciones.jsp" %>     
        </div>
        
        <div class ="container form-control">
            
            <h2 class="text-justify">Editar Rol</h2>
            <br> 
            <%if(rol.getEstado().equals("ASIGNADO")){%>
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong> No se puede editar un rol ya asignado a una cuenta de usuario
                </div>
            <%}%>
            <br>
        
            <form id="editarRol" 
                  action="<%=request.getContextPath()%>/RolServlet?editar=true" 
                  method="post"
                  novalidate
                  onsubmit="return false"
                  >
                <input type="hidden" name="idRol" value="<%=idRol%>">
            </form>
          

            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Rol:</label> 
                </div>
                <div class="col-6">
                    <input form="editarRol"
                           name="rol"
                           id="rol"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el nombre del rol"
                           required 
                           value="<%=rol.getRol()%>"
                           >
                    <div id="rol-retro"></div>
                </div> 
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Descripción:</label> 
                </div>
                <div class="col-6">
                    <textarea form="editarRol"
                              name="descripcion"
                              id="descripcion"
                              class="form-control" 
                              placeholder="Escriba una descripción para el rol"
                              required 
                              rows="6"
                              maxlength="250"
                              ><%=rol.getDescripcion()%></textarea>
                    <div id="descripcion-retro"></div>
                </div> 
            </div>
            
  
            
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="editar"
                           type="button"
                           value="Editar"
                           <%if(rol.getEstado().equals("NO ASIGNADO")){%>
                                onclick="validarFormulario()"
                           <%}%>
                    >
                </div>    
            </div>
           
        </div>
        <br>
        <script>
            function validarFormulario(){
                var validoRol = validarRol();
                var validoDescripcion = validarDescripcion();
                
                if(validoRol && validoDescripcion){
                    
                    validarRolNoDuplicado();
                }   
            }
            
            function validarRol(){
                var rolInput = document.getElementById("rol");
                var retroRol = document.getElementById("rol-retro");
                var strRol = rolInput.value.trim();
                rolInput.value = strRol;
                
                if(strRol.length == 0){ 
                    rolInput.setAttribute("class","form-control is-invalid");
                    retroRol.setAttribute("class","invalid-feedback");
                    retroRol.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                rolInput.setAttribute("class","form-control is-valid");
                retroRol.setAttribute("class","valid-feedback");
                retroRol.textContent = '';
                    
                return true;
            }
            
            function validarDescripcion(){
                var descripcionInput = document.getElementById("descripcion");
                var retroDescripcion = document.getElementById("descripcion-retro");
                var strDescripcion = descripcionInput.value.trim();
                
                descripcionInput.value = strDescripcion; 
                
                if(strDescripcion.length == 0){ 
                    descripcionInput.setAttribute("class","form-control is-invalid");
                    retroDescripcion.setAttribute("class","invalid-feedback");
                    retroDescripcion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                descripcionInput.setAttribute("class","form-control is-valid");
                retroDescripcion.setAttribute("class","valid-feedback");
                retroDescripcion.textContent = '';
                    
                return true;
            }
            
            //Llamada al ajax para validar que nombre
            //del rol no este duplicado
            //Si esta duplicado informa al usuario
            //Caso contrario, envia el formulario al servlet
            function validarRolNoDuplicado(){
                
                var rolInput = document.getElementById("rol");
                var retroRol = document.getElementById("rol-retro");
                var strRol = rolInput.value.trim();
                
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/RolServlet?existeRol="+strRol+"&idRol="+<%=idRol%>, 
                true);

                xmlHttp.onreadystatechange=function(){
                    
                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                       
                        clearTimeout(xmlHttpTimeout); 
                        
                        var objectoJSON = JSON.parse(this.responseText);
                        var existeRol = objectoJSON.existeRol;
                        
                        if(existeRol == null){
                            
                            rolInput.setAttribute("class","form-control is-invalid");
                            retroRol.setAttribute("class","invalid-feedback");
                            retroRol.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad del rol';
                            
                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");
                            
                        } else if(existeRol){
                            
                            rolInput.setAttribute("class","form-control is-invalid");
                            retroRol.setAttribute("class","invalid-feedback");
                            retroRol.textContent = 'Ya existe un rol con el mismo nombre';
                            
                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");
                            
                        }else{
                            //se envia formulario
                            document.getElementById("editarRol").submit();
                            
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
                 
                    rolInput.setAttribute("class","form-control is-invalid");
                    retroRol.setAttribute("class","invalid-feedback");
                    retroRol.textContent = 'No se pudo validar que el rol no sea duplicado. \n Intente más tarde';
                    
                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
                }
                
            }
           
        </script>
    </body>
</html>
    