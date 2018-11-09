<%-- 
    Document   : agregarOposicionHecha
    Created on : 05-nov-2018, 11:55:32
    Author     : User
--%>

<%@page import="modeloMng.OposicionHechaJpaController"%>
<%@page import="modelo.OposicionHecha"%>
<%@page import="modelo.Abogado"%>
<%@page import="modeloMng.AbogadoJpaController"%>
<%@page import="java.util.Calendar"%>
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
    <body onload="cambiarDatosOpositor()">
        <%
            
            Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
            
            OposicionHechaJpaController oposicionControl = new OposicionHechaJpaController();
            OposicionHecha oposicion = oposicionControl.findOposicionHecha(idOposicion); 
            
            EstadoOposicionJpaController estadoOposicionControl = new EstadoOposicionJpaController();
            List<EstadoOposicion> listaEstadoOposicion = estadoOposicionControl.findEstadoOposicionEntities();
            
            List<Expediente> listaExpediente = new ExpedienteJpaController().findExpedienteEntities();
            
            List<Abogado> listaAbogado = new AbogadoJpaController().getListaAbogadoActivo();
            
            //Limites de fecha de estado
            
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            cal.add(Calendar.YEAR, -1);
            
            Date fechaMin = cal.getTime(); 
            Date fechaMax = new Date();
            
            //Si la oposicion esta vacia
            //boolean oposicionVacia = oposicionControl.oposicionVacio(idOposicion);
            boolean oposicionVacia = false;
            if(oposicion.getDocumentoOposicionHechaList().isEmpty() && oposicion.getEventoOposicionHechaList().isEmpty()){
                oposicionVacia = true;
            }
            
            //Lista de estados finales
            List<EstadoOposicion> listaEstadoOposicionFinales = estadoOposicionControl.getEstadoOposicionFinales();

            //Verificamos si la oposicion esta cerrada
            boolean oposicionCerrada = false;
            if(oposicion.getIdEstadoOposicion().getTipo() == null){
                oposicionCerrada = false;
            }else if(oposicion.getIdEstadoOposicion().getTipo().equals("F")){
                oposicionCerrada = true; 
            }
            
        %>

        <%--> Input tipo hidden para cambiar el marca,cliente,abogado  
               segun el número de expediente <--%>
        <%for (int j = 0; j < listaExpediente.size(); j++) {%> 
            <input type="hidden" 
                   id="marcaOpositor-<%=listaExpediente.get(j).getIdExpediente()%>" 
                   value="<%=listaExpediente.get(j).getIdMarca().getDenominacion()%>"> 
            <input type="hidden" 
                   id="clienteOpositor-<%=listaExpediente.get(j).getIdExpediente()%>" 
                   value="<%=listaExpediente.get(j).getIdCliente().getNombreCliente()%>">
        <%}%>
        <%--><--%>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container form-control">
            <h2 class="text-justify">Editar Oposición</h2> 
            <br>
            <%if(oposicionCerrada){%>   
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>La oposicion se encuentra cerrada, no se puede editar
                </div>
            <%}%>
            <br>
            <form id="agregarOposicion" 
                  action="<%=request.getContextPath()%>/OposicionHechaServlet?editar=true"
                  method="post"
                  novalidate>
                <input type="hidden" name="idOposicion" value="<%=idOposicion%>">
            </form>

            
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroExpedienteOpositado">Número de expediente Opositado:</label>
                </div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           name="nroExpedienteOpositado"
                           id="nroExpedienteOpositado"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el número de expediente de la marca"
                           onkeypress="return isNumberKey(event)"
                           value="<%=oposicion.getNroExpedienteOpositado()%>" 
                           <%if(!oposicionVacia){%>
                                readonly
                           <%}%>
                           required
                           >
                        <div id="nroExpedienteOpositado-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="denominacionOpositada">Denominación:</label></div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           name="denominacionOpositada"
                           id="denominacionOpositada"
                           class="form-control"
                           type="text"
                           placeholder="Escriba la denominación" 
                           value="<%=oposicion.getDenominacionOpositado()%>" 
                           <%if(!oposicionVacia){%>
                                readonly
                           <%}%>
                           required>
                    <div id="denominacionOpositada-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="clase">Clase:</label></div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           name="clase"
                           id="clase"
                           class="form-control"
                           type="number"
                           min="1"
                           max="45"
                           placeholder="Escriba el número de clase"
                           value="<%=oposicion.getClaseOpositado()%>"
                           <%if(!oposicionVacia){%>
                                readonly
                           <%}%>
                           required>
                    <div id="clase-retro"></div>
                </div>
            </div>
                
            <div class="row form-group">    
                <div class="col-3">
                    <label for="titular">Titular:</label></div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           name="titular"
                           id="titular"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el titular"
                           value="<%=oposicion.getTitularOpositado()%>" 
                           <%if(!oposicionVacia){%>
                                readonly
                           <%}%>
                           required>
                    <div id="titular-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="agente">Agente:</label></div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           name="agenteOpositado"
                           id="agenteOpositado"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el nombre y apellido del agente"
                           value="<%=oposicion.getAgenteOpositado()%>"
                           required>
                    <div id="agenteOpositado-retro"></div>
                </div>
            </div>
                  
            <div class="row form-group">    
                <div class="col-3">
                    <label for="nroExpedienteOpositor">Número de expediente base de oposición:</label></div>
                <div class="col-6">
                    <select form="agregarOposicion"
                           name="nroExpedienteOpositor"
                           id="nroExpedienteOpositor"
                           class="form-control"
                           onchange="cambiarDatosOpositor()"
                           <%if(!oposicionVacia){%>
                                readonly
                           <%}%>
                           required>
                           <option selected value="<%=oposicion.getIdExpedienteOpositante().getIdExpediente()%>"><%=oposicion.getIdExpedienteOpositante().getNroExpediente()%></option>
                            <%if(oposicionVacia){%>
                                <%for (int j = 0; j < listaExpediente.size(); j++) {%>
                                    <%if(listaExpediente.get(j).getIdExpediente() != oposicion.getIdExpedienteOpositante().getIdExpediente()){%>
                                        <option value="<%=listaExpediente.get(j).getIdExpediente()%>" >
                                            <%=listaExpediente.get(j).getNroExpediente()%>
                                        </option>
                                    <%}%>
                                <%}%>
                           <%}%>
                    </select>
                    <div id="nroExpedienteOpositor-retro"></div>
                </div>
            </div>
                 
            <div class="row form-group">
                <div class="col-3">
                    <label for="marcaOpositor">Marca base de Oposición:</label>
                </div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           id="marcaOpositor"
                           class="form-control"
                           disabled
                           type="text">
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="clienteOpositor">Titular de base de Oposición </label>
                </div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           id="clienteOpositor"
                           class="form-control"
                           disabled
                           type="text">
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="fecha">Fecha del Estado de Oposición: </label>
                </div>
                <div class="col-6">
                    <input form="agregarOposicion"
                           name="fecha"
                           id="fecha"
                           class="form-control"
                           type="date"
                           min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMin)%>"
                           max="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMax)%>"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(oposicion.getFecha())%>"
                           required> 
                    <div id="fecha-retro"></div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="idEstado">Estado actual de la Oposición:</label>
                </div>
                <div class="col-6">
                    <select form="agregarOposicion"
                            name="idEstado" 
                            class="form-control"
                            onchange="mostrarComentarioCierre()"
                            id="idEstado">
                        <option selected value="<%=oposicion.getIdEstadoOposicion().getIdEstado()%>"><%=oposicion.getIdEstadoOposicion().getDescripcion()%></option>
                        <%for (int j = 0; j < listaEstadoOposicion.size(); j++) {%>
                            <%if(listaEstadoOposicion.get(j).getIdEstado() != oposicion.getIdEstadoOposicion().getIdEstado()){%>
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
                    <label for="agenteOpositor">Agente a cargo:</label></div>
                <div class="col-6">
                    <select form="agregarOposicion"
                           name="agenteOpositor"
                           id="agenteOpositor"
                           class="form-control"
                           required>
                    
                        <option selected value="<%=oposicion.getIdAbogadoOpositante().getIdAbogado()%>"><%=oposicion.getIdAbogadoOpositante().getNombreApellido()%></option>
                            <%for (int j = 0; j < listaAbogado.size(); j++) {%>
                                <%if(listaAbogado.get(j).getIdAbogado() != oposicion.getIdAbogadoOpositante().getIdAbogado()){%>
                                    <option value="<%=listaAbogado.get(j).getIdAbogado()%>" > 
                                        <%=listaAbogado.get(j).getNombreApellido()%>
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                    <div id="agenteOpositor-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">    
                <div class="col-3">
                    <label for="comentario">Comentario de cierre:</label></div>
                <div class="col-6">
                        <textarea form="agregarOposicion"
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
                    <input id="agregar"
                           type="button"
                           value="Editar"
                            <%if(!oposicionCerrada){%> 
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
            
            
            //ACtualiza los datos de Opositor, marca, cliente y abogado según expediente
            function cambiarDatosOpositor() {
                
                var nroExpedienteOpositor = document.getElementById("nroExpedienteOpositor").value;
                if(nroExpedienteOpositor != -1){
                    var marca = document.getElementById("marcaOpositor-"+nroExpedienteOpositor).value;
                    var cliente = document.getElementById("clienteOpositor-"+nroExpedienteOpositor).value;


                    document.getElementById("marcaOpositor").value = marca;
                    document.getElementById("clienteOpositor").value = cliente;
                }else{
                    
                    document.getElementById("marcaOpositor").value = "";
                    document.getElementById("clienteOpositor").value = "";
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
                
                var nroExpOpositadoValido= validarNroExpedienteOpositado();
                var denominacionValido = validarDenominacionOpositada();
                var claseValido = validarClase();
                var titularValido = validarTitular();
                var agenteValido= validarAgente();
                var nroExpOpositor = validarNroExpedienteOpositor();
                var fechaValido = validarFecha();
                var idEstadoValido = validarIdEstado();
                
                var abogadoOpositorValido = validarIdAbogadoOpositor();
                
                var comentarioValido = true;
                if(!document.getElementById("comentario").disabled){
                    
                    comentarioValido = validarComentario();
                }
                
                if(nroExpOpositadoValido && 
                        denominacionValido &&
                        claseValido &&
                        titularValido &&
                        agenteValido && 
                        nroExpOpositor &&
                        fechaValido &&
                        idEstadoValido && 
                        abogadoOpositorValido && 
                        comentarioValido){
                    document.getElementById("agregarOposicion").submit();
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
                    retroTitular.textContent = 'Escriba el nombre del titular';
                    
                    return false;
                }
                
                titularInput.setAttribute("class","form-control is-valid");
                retroTitular.setAttribute("class","valid-feedback");
                retroTitular.textContent = '';
                    
                 
                return true;
            }
            
           
            
            function validarDenominacionOpositada(){
                
                var denominacionInput = document.getElementById("denominacionOpositada");
                var retroDenominacion = document.getElementById("denominacionOpositada-retro");
                var strDenominacion= denominacionInput.value.trim();
                denominacionInput.value = strDenominacion;
                
                if(strDenominacion.length == 0){

                    denominacionInput.setAttribute("class","form-control is-invalid");
                    retroDenominacion.setAttribute("class","invalid-feedback");
                    retroDenominacion.textContent = 'Escriba la denominación';
                    
                    return false;
                }
                
                denominacionInput.setAttribute("class","form-control is-valid");
                retroDenominacion.setAttribute("class","valid-feedback");
                retroDenominacion.textContent = '';
                    
                 
                return true;
            }
            
            
            function validarAgente(){
                
                var agenteInput = document.getElementById("agenteOpositado");
                var retroAgente = document.getElementById("agenteOpositado-retro");
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
            
            function validarNroExpedienteOpositado(){
                
                var nroExpedienteInput = document.getElementById("nroExpedienteOpositado");
                var retroNroExpediente = document.getElementById("nroExpedienteOpositado-retro");
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
            
            function validarNroExpedienteOpositor(){
                var nroExpSelect = document.getElementById("nroExpedienteOpositor");
                var retroNroExpSelect = document.getElementById("nroExpedienteOpositor-retro");
                var strNroExp = nroExpSelect.value;
              
                
                if(strNroExp == -1){

                    nroExpSelect.setAttribute("class","form-control is-invalid");
                    retroNroExpSelect.setAttribute("class","invalid-feedback");
                    retroNroExpSelect.textContent = 'Seleccione un número de expediente base de oposición';
                    
                    return false;
                }
                
                nroExpSelect.setAttribute("class","form-control is-valid");
                retroNroExpSelect.setAttribute("class","valid-feedback");
                retroNroExpSelect.textContent = '';
                    
                 
                return true;
                
            }
            
            
            function validarIdAbogadoOpositor(){
                
                var idAbogadoSelect = document.getElementById("agenteOpositor");
                var retroIdAbogado = document.getElementById("agenteOpositor-retro");
                var strIdAbogado= idAbogadoSelect.value;
              
                
                if(strIdAbogado == -1){

                    idAbogadoSelect.setAttribute("class","form-control is-invalid");
                    retroIdAbogado.setAttribute("class","invalid-feedback");
                    retroIdAbogado.textContent = 'Seleccione un agente a cargo de la oposición';
                    
                    return false;
                }
                
                idAbogadoSelect.setAttribute("class","form-control is-valid");
                retroIdAbogado.setAttribute("class","valid-feedback");
                retroIdAbogado.textContent = '';
                    
                 
                return true;
            }
            
            function validarIdEstado(){
                
                var idEstadoSelect = document.getElementById("idEstado");
                var retroIdEstado = document.getElementById("idEstado-retro");
                var strIdEstado= idEstadoSelect.value;
              
                
                if(strIdEstado == -1){

                    idEstadoSelect.setAttribute("class","form-control is-invalid");
                    retroIdEstado.setAttribute("class","invalid-feedback");
                    retroIdEstado.textContent = 'Seleccione un estado de oposición válido';
                    
                    return false;
                }
                
                idEstadoSelect.setAttribute("class","form-control is-valid");
                retroIdEstado.setAttribute("class","valid-feedback");
                retroIdEstado.textContent = '';
                    
                 
                return true;
            }
            
        </script>     
    </body>
</html>
