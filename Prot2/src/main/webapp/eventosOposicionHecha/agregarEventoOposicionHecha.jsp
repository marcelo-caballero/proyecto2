<%-- 
    Document   : agregarEventoOposicionHecha
    Created on : 05-nov-2018, 22:41:56
    Author     : User
--%>

<%@page import="modelo.OposicionHecha"%>
<%@page import="modeloMng.OposicionHechaJpaController"%> 
<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.EventoOposicionHechaJpaController"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Evento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idOposicion = (Integer) (request.getSession().getAttribute("idOposicionHecha"));

            OposicionHechaJpaController oposicionControl = new OposicionHechaJpaController();
            OposicionHecha oposicion = oposicionControl.findOposicionHecha(idOposicion);

            Calendar c = Calendar.getInstance();
            c.setTime(new Date());
            c.add(Calendar.DATE, 1);
            Date fechaMinima = c.getTime();


        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
            <%@include file="//WEB-INF/menuOposicionesHechas.jsp" %>     
        </div>

        <div class="container form-control">
            <h2 class="text-justify">Agregar Evento</h2> 
            <br>

            <form id="agregarEvento" 
                  action="<%=request.getContextPath()%>/EventoOposicionHechaServlet?agregar=true"
                  method="post"
                  novalidate>
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label for="">Número de Expediente Opositado:</label>
                </div>
                <div class="col-6">
                    <input form="agregarEvento"
                           name=""
                           class="form-control"
                           type="text"
                           readonly
                           value="<%=oposicion.getNroExpedienteOpositado()%>">  
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label for="nombre">Nombre del evento:</label>
                </div>
                <div class="col-6">
                    <input form="agregarEvento"
                           name="nombre"
                           id="nombre"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el nombre para el evento"
                           maxlength=""
                           required
                           >
                    <div id="nombre-retro"></div>
                </div>
            </div>
                
            <div class="row form-group">    
                <div class="col-3">
                    <label for="prioridad">Prioridad:</label>
                </div>
                <div class="col-6">
                   <select form="agregarEvento" 
                            name="prioridad" 
                            id="prioridad" 
                            required="required"
                            class="form-control">
                            <option value="">  
                                Elija la prioridad 
                            </option>
                            <option value="ALTA">  
                                Alta 
                            </option>
                            <option value="MEDIA">  
                                Media 
                            </option>
                             <option value="BAJA">  
                                Baja 
                            </option>
                    </select>
                    <div id="prioridad-retro"></div>
                </div>
            </div>
                
            
                           
            <div class="row form-group">    
                <div class="col-3">
                    <label for="">Programar para:</label>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-6">
                            <input form="agregarEvento"
                                   name="fecha"
                                   id="fecha"
                                   class="form-control"
                                   type="date"

                                   min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMinima)%>"  
                                   required
                                   >
                            <div id="fecha-retro"></div>
                        </div>
                        <div class="col">
                            <select form="agregarEvento"
                                   name="hora"
                                   id="hora"
                                   class="form-control"
                                   type="number"
                                   required
                                   >
                                   <%for(int i=0;i<24;i++){%> 
                                        <option value="<%= (i<10) ? "0"+i : i%>"><%= (i<10) ? "0"+i : i%></option>
                                   <%}%>
                            </select>
                        </div>
                        <div>:</div>
                        <div class="col">
                            <select form="agregarEvento"
                                   name="minuto"
                                   id="minuto"
                                   class="form-control"
                                   type="number"
                                   required
                                   >
                                   <%for(int i=0;i<60;i++){%>
                                        <option value="<%= (i<10) ? "0"+i : i%>"><%= (i<10) ? "0"+i : i%></option>
                                   <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label for="descripcion">Detalles del evento:</label>
                </div>
                <div class="col-6">
                    <textarea form="agregarEvento"
                              name="descripcion"
                              id="descripcion"
                              class="form-control"
                              rows="6"
                              maxlength=""
                              placeholder="Escriba una breve descripción"
                              required
                              ></textarea>
                    <div id="descripcion-retro"></div>
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
            function validarFormulario() {
                var validoNombre = validarNombre();
                var validoDescripcion = validarDescripcion();
                var validoFecha = validarFecha();
                var validoPrioridad = validarPrioridad();

                //Si todo es correcto, se envía el formulario
                if (validoNombre && validoDescripcion && validoFecha && validoPrioridad) {

                    document.getElementById("agregarEvento").submit();
                }
            }


            function validarNombre() {

                var nombreInput = document.getElementById("nombre");
                var retroNombre = document.getElementById("nombre-retro");
                var strNombre = nombreInput.value.trim();
                nombreInput.value = strNombre;

                if (strNombre.length === 0) {
                    nombreInput.setAttribute("class", "form-control is-invalid");
                    retroNombre.setAttribute("class", "invalid-feedback");
                    retroNombre.textContent = 'El campo esta vacío';

                    return false;
                }

                nombreInput.setAttribute("class", "form-control is-valid");
                retroNombre.setAttribute("class", "valid-feedback");
                retroNombre.textContent = '';

                return true;
            }

            function validarDescripcion() {

                var descripcionInput = document.getElementById("descripcion");
                var retroDescripcion = document.getElementById("descripcion-retro");
                var strDescripcion = descripcionInput.value.trim();
                descripcionInput.value = strDescripcion;

                if (strDescripcion.length === 0) {
                    descripcionInput.setAttribute("class", "form-control is-invalid");
                    retroDescripcion.setAttribute("class", "invalid-feedback");
                    retroDescripcion.textContent = 'El campo esta vacío';

                    return false;
                }

                descripcionInput.setAttribute("class", "form-control is-valid");
                retroDescripcion.setAttribute("class", "valid-feedback");
                retroDescripcion.textContent = '';

                return true;
            }
            
            function validarPrioridad() {
                var retroPrioridad = document.getElementById("prioridad-retro");
                var prioridadInput = document.getElementById("prioridad");
                var strPrioridad = prioridadInput.value.trim();
                prioridadInput.value = strPrioridad;
                if (document.getElementById("prioridad").value === "") {
                    prioridadInput.setAttribute("class", "form-control is-invalid");
                    retroPrioridad.setAttribute("class", "invalid-feedback");
                    retroPrioridad.textContent = 'Elija una opción';

                    return false;
                }

                prioridadInput.setAttribute("class", "form-control is-valid");
                retroPrioridad.setAttribute("class", "valid-feedback");
                retroPrioridad.textContent = '';

                return true;
            }


            function validarFecha() {

                var fechaInput = document.getElementById("fecha");
                var retroFecha = document.getElementById("fecha-retro");
                var strFecha = fechaInput.value.trim();

                if (strFecha.length === 0) {
                    fechaInput.setAttribute("class", "form-control is-invalid");
                    retroFecha.setAttribute("class", "invalid-feedback");
                    retroFecha.textContent = 'El campo esta vacío';

                    return false;
                }

                if (fechaInput.validity.rangeUnderflow) {
                    fechaInput.setAttribute("class", "form-control is-invalid");
                    retroFecha.setAttribute("class", "invalid-feedback");
                    retroFecha.textContent = 'La fecha debe ser después de hoy (<%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>)';

                    return false;
                }

                fechaInput.setAttribute("class", "form-control is-valid");
                retroFecha.setAttribute("class", "valid-feedback");
                retroFecha.textContent = '';

                return true;
            }
        </script>
    </body>
</html>