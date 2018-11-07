<%-- 
    Document   : editarOposicionRecibida
    Created on : 22-oct-2018, 16:50:40
    Author     : User
--%>

<%@page import="modelo.OposicionRecibida"%>
<%@page import="modeloMng.OposicionRecibidaJpaController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="modeloMng.ExpedienteJpaController"%>
<%@page import="modelo.Expediente"%>
<%@page import="modelo.EstadoOposicion"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.EstadoOposicionJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Oposición - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body >
        <%
            Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));
            Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));

            OposicionRecibidaJpaController oposicionControl =  new OposicionRecibidaJpaController();
            
            EstadoOposicionJpaController estadoOposicionControl = new EstadoOposicionJpaController();
            List<EstadoOposicion> listaEstadoOposicion = estadoOposicionControl.findEstadoOposicionEntities();
            
            OposicionRecibida oposicion = oposicionControl.findOposicionRecibida(idOposicion);
            
            Date fechaMin = oposicion.getIdExpediente().getFechaSolicitud();
            Date fechaMax = new Date();
            
            //Lista de estados finales
            List<EstadoOposicion> listaEstadoOposicionFinales = estadoOposicionControl.getEstadoOposicionFinales();
            
            Boolean editable = true;
            //Verificamos que la oposicion es editable
            for(int i=0;i<listaEstadoOposicionFinales.size();i++){
                if(oposicion.getIdEstado().getIdEstado() == listaEstadoOposicionFinales.get(i).getIdEstado()){
                    editable = false;
                } 
            }
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        <div class="container form-control">
            <h2 class="text-justify">Editar Oposición</h2> 
            <br>
            <%if(!editable){%> 
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>La oposición se ha cerrado
                </div>
            <%}%>
            <br>
            <form id="editarOposicion" 
                  action="<%=request.getContextPath()%>/OposicionRecibidaServlet?editar=true"
                  method="post"
                  novalidate>
                <input type="hidden" name="idOposicion" value="<%=idOposicion%>">
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label>Número de expediente:</label>
                </div>
                <div class="col-6">
                    <input class="form-control"
                           type="text"
                           disabled
                           value="<%=oposicion.getIdExpediente().getNroExpediente()%>"> 
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroExpediente">Número de expediente de la marca base de Oposición:</label>
                </div>
                <div class="col-6">
                    <input form="editarOposicion"
                           name="nroExpediente"
                           id="nroExpediente"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el número de expediente de la marca base de oposición"
                           value="<%=oposicion.getNroExpediente()%>"
                           onkeypress="return isNumberKey(event)"
                           required
                           >
                        <div id="nroExpediente-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="agente">Agente opositor:</label></div>
                <div class="col-6">
                    <input form="editarOposicion"
                           name="agente"
                           id="agente"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el nombre y apellido del agente que realiza la oposición"
                           value="<%=oposicion.getAgente()%>" 
                           required>
                    <div id="agente-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="marca">Marca base de Oposición:</label></div>
                <div class="col-6">
                    <input form="editarOposicion"
                           name="marca"
                           id="marca"
                           class="form-control"
                           type="text"
                           placeholder="Escriba la denominación de la marca base de oposición"
                           value="<%=oposicion.getMarca()%>"
                           required>
                    <div id="marca-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="clase">Clase de la marca base de Oposición:</label></div>
                <div class="col-6">
                    <input form="editarOposicion"
                           name="clase"
                           id="clase"
                           class="form-control"
                           type="number"
                           min="1"
                           max="45"
                           placeholder="Escriba el número de clase de la marca base de oposición"
                           value="<%=oposicion.getClase()%>" 
                           required>
                    <div id="clase-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="titular">Titular de la marca base de Oposición:</label></div>
                <div class="col-6">
                    <input form="editarOposicion"
                           name="titular"
                           id="titular"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el titular de la marca base de oposición"
                           value="<%=oposicion.getTitular()%>"  
                           required>
                    <div id="titular-retro"></div>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="fecha">Fecha Status: </label>
                </div>
                <div class="col-6">
                    <input form="editarOposicion"
                           name="fecha"
                           id="fecha"
                           class="form-control"
                           type="date"
                           min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMin)%>"
                           max="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMax)%>"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(oposicion.getFechaEstado())%>"  
                           required> 
                    <div id="fecha-retro"></div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="idEstado">Estado Actual:</label>
                </div>
                <div class="col-6">
                    <select form="editarOposicion"
                            name="idEstado" 
                            class="form-control"
                            id="idEstado"
                            onchange="mostrarComentarioCierre()">
                        <option selected value="<%=oposicion.getIdEstado().getIdEstado()%>"><%= oposicion.getIdEstado().getDescripcion() %></option>
                        <%for (int j = 0; j < listaEstadoOposicion.size(); j++) {%>
                            <% if(listaEstadoOposicion.get(j).getIdEstado() != oposicion.getIdEstado().getIdEstado()){ %> 
                                <option value="<%=listaEstadoOposicion.get(j).getIdEstado()%>" >
                                    <%=listaEstadoOposicion.get(j).getDescripcion()%>
                                </option>
                            <%}%>
                        <%}%>
                    </select>
                    <div id="idEstado-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">    
                <div class="col-3">
                    <label for="comentario">Comentario de cierre:</label></div>
                <div class="col-6">
                        <textarea form="editarOposicion"
                               name="comentario"
                               id="comentario"
                               class="form-control"
                               type="text"
                               placeholder="Escriba el comentario de cierre de la oposición"
                               rows="6"
                               maxlength="250"
                               disabled  
                               required></textarea> 
                    <div id="comentario-retro"></div>
                </div>
            </div>

            
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input id="editar"
                           type="button"
                           value="Editar"
                           <%if(editable){%>
                                onclick="validarFormulario()"
                           <%}%>
                    >
                </div>    
            </div>
            
        </div>  
        <br>
        <script>
            function mostrarComentarioCierre(){
                var comentarioInput = document.getElementById("comentario");
                var idEstadoInput = document.getElementById("idEstado");
                
                if(<%for(int i=0;i<listaEstadoOposicionFinales.size();i++){%>
                        idEstadoInput.value == <%=listaEstadoOposicionFinales.get(i).getIdEstado()%>
                        <%if(i+1<listaEstadoOposicionFinales.size()){%>
                            ||
                        <%}%>
                    <%}%>)
                {
                    comentarioInput.disabled = false;
                }else{
                    comentarioInput.disabled = true;
                    
                }
            }
            //Permite unicamente la insercion de numeros
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
            function validarFormulario(){
                
                var nroExpValido= validarNroExpediente();
                var agenteValido= validarAgente();
                var marcaValido = validarMarca();
                var claseValido = validarClase();
                var titularValido = validarTitular();
                var fechaValido = validarFecha();
                
                var comentarioValido = true;
                
                if(!document.getElementById("comentario").disabled){
                    
                    comentarioValido = validarComentario();
                }
               
                if(nroExpValido && agenteValido  && marcaValido && claseValido && titularValido && fechaValido && comentarioValido){
                    document.getElementById("editarOposicion").submit();
                }
            }
            
            function validarComentario(){
                
                var comentarioInput = document.getElementById("comentario");
                var retroComentario = document.getElementById("comentario-retro");
                var strComentario= comentarioInput.value.trim();
                comentarioInput.value = strComentario;
                
                if(strComentario.length == 0){

                    comentarioInput.setAttribute("class","form-control is-invalid");
                    retroComentario.setAttribute("class","invalid-feedback");
                    retroComentario.textContent = 'Escriba el comentario de cierre';
                    
                    return false;
                }
                
                comentarioInput.setAttribute("class","form-control is-valid");
                retroComentario.setAttribute("class","valid-feedback");
                retroComentario.textContent = '';
                    
                 
                return true;
            }
            
            function validarFecha(){
                
                var fechaInput = document.getElementById("fecha");
                var retroFecha= document.getElementById("fecha-retro");
                //var strFecha= fechaInput.value;
               
                
                if(!fechaInput.validity.valid){

                    fechaInput.setAttribute("class","form-control is-invalid");
                    retroFecha.setAttribute("class","invalid-feedback");
                    retroFecha.textContent = 'Escriba una fecha válida entre <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaMin)%> a <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaMax)%>';
                    
                    return false;
                }
                
                fechaInput.setAttribute("class","form-control is-valid");
                retroFecha.setAttribute("class","valid-feedback");
                retroFecha.textContent = '';
                    
                 
                return true;
            }
            
            function validarTitular(){
                
                var titularInput = document.getElementById("titular");
                var retroTitular = document.getElementById("titular-retro");
                var strTitular= titularInput.value.trim();
                titularInput.value = strTitular;
                
                if(strTitular.length == 0){

                    titularInput.setAttribute("class","form-control is-invalid");
                    retroTitular.setAttribute("class","invalid-feedback");
                    retroTitular.textContent = 'Escriba el nombre del titular base de oposición';
                    
                    return false;
                }
                
                titularInput.setAttribute("class","form-control is-valid");
                retroTitular.setAttribute("class","valid-feedback");
                retroTitular.textContent = '';
                    
                 
                return true;
            }
            
            function validarClase(){
                
                var claseInput = document.getElementById("clase");
                var retroClase = document.getElementById("clase-retro");
                var strClase= claseInput.value;
               
                
                if(!claseInput.validity.valid){

                    claseInput.setAttribute("class","form-control is-invalid");
                    retroClase.setAttribute("class","invalid-feedback");
                    retroClase.textContent = 'Escriba un número de clase válido';
                    
                    return false;
                }
                
                claseInput.setAttribute("class","form-control is-valid");
                retroClase.setAttribute("class","valid-feedback");
                retroClase.textContent = '';
                    
                 
                return true;
            }
            
            function validarMarca(){
                
                var marcaInput = document.getElementById("marca");
                var retroMarca = document.getElementById("marca-retro");
                var strMarca= marcaInput.value.trim();
                marcaInput.value = strMarca;
                
                if(strMarca.length == 0){

                    marcaInput.setAttribute("class","form-control is-invalid");
                    retroMarca.setAttribute("class","invalid-feedback");
                    retroMarca.textContent = 'Escriba la denominación de la marca';
                    
                    return false;
                }
                
                marcaInput.setAttribute("class","form-control is-valid");
                retroMarca.setAttribute("class","valid-feedback");
                retroMarca.textContent = '';
                    
                 
                return true;
            }
            
            function validarAgente(){
                
                var agenteInput = document.getElementById("agente");
                var retroAgente = document.getElementById("agente-retro");
                var strAgente= agenteInput.value.trim();
                agenteInput.value = strAgente;
                
                if(strAgente.length == 0){

                    agenteInput.setAttribute("class","form-control is-invalid");
                    retroAgente.setAttribute("class","invalid-feedback");
                    retroAgente.textContent = 'Escriba el nombre y apellido del agente';
                    
                    return false;
                }
                
                agenteInput.setAttribute("class","form-control is-valid");
                retroAgente.setAttribute("class","valid-feedback");
                retroAgente.textContent = '';
                    
                 
                return true;
            }
            
            function validarNroExpediente(){
                
                var nroExpedienteInput = document.getElementById("nroExpediente");
                var retroNroExpediente = document.getElementById("nroExpediente-retro");
                var strNroExpediente= nroExpedienteInput.value.trim();
              
                
                if(strNroExpediente.length == 0){

                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'Escriba el número de expediente';
                    
                    return false;
                }
                
                nroExpedienteInput.setAttribute("class","form-control is-valid");
                retroNroExpediente.setAttribute("class","valid-feedback");
                retroNroExpediente.textContent = '';
                    
                 
                return true;
            }
            
            
            
        </script>     
    </body>
</html>
