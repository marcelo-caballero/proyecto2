<%-- 
    Document   : editarExpediente
    Created on : 22-ago-2018, 13:27:25
    Author     : Acer
--%>

<%@page import="modeloMng.HistorialEstadoMarcaJpaController"%>
<%@page import="modelo.HistorialEstadoMarca"%>
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
<%@page import="modeloMng.ExpedienteJpaController"%> 

<%@page import="java.util.List"%>
<%@page import="modelo.Cliente"%>
<%@page import="modelo.Abogado"%>
<%@page import="modelo.EstadoMarca"%> 
<%@page import="modelo.Clase"%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.TipoExpediente"%> 
<%@page import="modelo.Expediente"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Expediente - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="cambiarDescripcionClase()">
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <%  
            
            
            Integer idExp = Integer.parseInt(request.getParameter("idExpediente"));
            
            ExpedienteJpaController expControl = new ExpedienteJpaController();
            Expediente  expediente = expControl.findExpediente(idExp);
            
            
            //Si un abogado se conecta, El abogado es asignado a ese expediente-------------------------
            List<Abogado> listaAbogado;
            AbogadoJpaController abogadoControl = new AbogadoJpaController();
            if(usuario.getAsociado() != null && usuario.getAsociado().equals("ABOGADO")){
                    listaAbogado = usuario.getAbogadoList();
                
            }else{
                
                listaAbogado= abogadoControl.getListaAbogadoActivoConCuentaUsuario(); 
            }
            //------------------------------------------------------------------------------------------------------
            List<Cliente> listaCliente;
            listaCliente = new ClienteJpaController().getListaClienteActivo(); 
            
            List<EstadoMarca> listaEstadoMarca;
            listaEstadoMarca = new EstadoMarcaJpaController().findEstadoMarcaEntities(); 

            List<Marca> listaMarca;
            listaMarca = new MarcaJpaController().findMarcaEntities(); 

            List<Clase> listaClase;
            listaClase = new ClaseJpaController().findClaseEntities();   

            List<TipoExpediente> listaTipoExpediente;
            listaTipoExpediente = new TipoExpedienteJpaController().findTipoExpedienteEntities();  

            //Fecha correspondiente hace 10 años a partir de hoy
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            cal.add(Calendar.YEAR, -10);
            Date fechaLimiteInferior = cal.getTime(); 

            String fechaHaceDiezAños = new SimpleDateFormat("yyyy-MM-dd").format(fechaLimiteInferior);
            String hoy = new SimpleDateFormat("yyyy-MM-dd").format(new Date()); 
            
            //¿El expediente esta Vacio ?
            boolean expedienteVacio = expControl.expedienteVacio(idExp);
            
            //Verificamos si el expediente tiene estado final
            boolean expedienteCerrado = false;
            if(expediente.getIdEstado().getTipo() == null){
                expedienteCerrado = false;
            }else if(expediente.getIdEstado().getTipo().equals("F")){
                expedienteCerrado = true; 
            }
            
            
            //Lista de estados finales de marca
            List<EstadoMarca> listaEstadoMarcaFinales = new EstadoMarcaJpaController().getListaEstadoMarcaFinales();
            
            //Verificamos que el expediente este asociado a una oposicion hecha por el estudio juridico
            Boolean expConOposicion = expControl.expedienteConOposicionesHechas(idExp);
            
             //Lista del Historial de Estados del Expediente
            List<HistorialEstadoMarca> listaHistorialEstado = new HistorialEstadoMarcaJpaController().getHistorialEstadoMarcaPorIdExpediente(idExp);  
        %>
        
        <%--> Input tipo hidden para cambiar el contenido producto 
               segun el número de clase <--%>
        <%for (int j = 0; j < listaClase.size(); j++) {%> 
            <input type="hidden" 
                   id="descripcion-<%=listaClase.get(j).getNroClase()%>" 
                   value="<%=listaClase.get(j).getDescripcion()%>">                          
        <%}%>
        <%--><--%>
        
        <div class ="container form-control">
            <h2 class="text-justify">Editar Expediente</h2> 
            <br>
            <%if(expConOposicion){%>   
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>El expediente se encuentra asociado con oposiciones hechas por el estudio jurídico
                </div>
            <%}%>
            <%if(expedienteCerrado){%>   
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>El expediente se encuentra cerrado, no se puede editar
                </div>
            <%}%>
            
            <br>
            <form id="editarExpediente" 
                  action="<%=request.getContextPath()%>/ExpedienteServlet?editar=true" 
                  method="post" 
                  novalidate>
                <input type="hidden" name="idExpediente" value="<%=idExp%>">
            </form>
               
            <div class = "row form-group">
                <div class="col-3">
                    <label for="nroExpediente">Número del Expediente:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="nroExpediente"
                           id="nroExpediente"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el número de expediente"
                           required
                           value="<%=expediente.getNroExpediente()%>"
                           <%if(!expedienteVacio){%> 
                                readonly
                           <%}%>
                           <%if(expConOposicion){%> 
                                readonly
                           <%}%>
                           onkeypress="return isNumberKey(event)">
                    <div id="nroExpediente-retro"></div> 
                </div>
            </div>
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroClase">Clase:</label>
                </div>
                <div class="col-6">
                    <select form="editarExpediente"
                           name="nroClase"
                           id="nroClase"
                           class="form-control"
                           onchange="cambiarDescripcionClase()"
                           <%if(!expedienteVacio){%>
                                readonly
                           <%}%>
                           required>
                           <option selected value="<%=expediente.getNroClase().getNroClase()%>"> 
                                <%=expediente.getNroClase().getNroClase()%>  
                           </option>
                                        
                            <%if(expedienteVacio){%>
                                <%for (int j = 0; j < listaClase.size(); j++) {
                                    if(listaClase.get(j).getNroClase() != expediente.getNroClase().getNroClase()){%> 
                                         <option value="<%=listaClase.get(j).getNroClase()%>"> 
                                             <%=listaClase.get(j).getNroClase()%>  
                                         </option>
                                     <%}%>
                                <%}%>
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
                    <textarea   form="editarExpediente"
                                name="producto"
                                id="producto"
                                class="form-control"
                                rows="8"
                                maxlength="700"
                                placeholder="Escriba una breve descripción del producto"
                                <%if(!expedienteVacio){%> 
                                    readonly
                                <%}%>
                                required
                                ><%=expediente.getProducto()%></textarea> 
                    <div id="producto-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaSolicitud">Fecha de Solicitud:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="fechaSolicitud"
                           id="fechaSolicitud"
                           type="date" 
                           class="form-control"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(expediente.getFechaSolicitud())%>"
                           min="<%=fechaHaceDiezAños%>"
                           max="<%=hoy%>"
                           <%if(!expedienteVacio){%> 
                                readonly
                           <%}%>
                           <%if(listaHistorialEstado.size()>1){%> 
                                readonly
                           <%}%>
                           required>
                    <div id="fechaSolicitud-retro"></div>
                </div>               
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="idEstadoMarca">Estado Actual:</label>
                </div>  
                <div class="col-6">
                    <select form="editarExpediente" 
                            name="idEstadoMarca" 
                            id="idEstadoMarca" 
                            class="form-control"
                            onchange="mostrarComentarioCierre()"
                            >
                            <option selected value="<%=expediente.getIdEstado().getIdEstado()%>"> 
                                <%=expediente.getIdEstado().getDescripcion()%>   
                            </option>
                            <%for (int j = 0; j < listaEstadoMarca.size(); j++) {
                                if(listaEstadoMarca.get(j).getIdEstado() != expediente.getIdEstado().getIdEstado()){%> 
                                    <option value="<%=listaEstadoMarca.get(j).getIdEstado()%>"> 
                                        <%=listaEstadoMarca.get(j).getDescripcion()%>  
                                    </option>
                                <%}%>
                            <%}%>
                    </select>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaEstado">Fecha de Status:</label>
                </div>
                <div class="col-6">
                    <input form="editarExpediente"
                           name="fechaEstado"
                           id="fechaEstado"
                           type="date" 
                           class="form-control"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(expediente.getFechaEstado())%>"
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
                    <select form="editarExpediente"
                            name="idAbogado" 
                            id="idAbogado"
                            class="form-control">
                            <option selected value="<%= expediente.getIdAbogado().getIdAbogado()%>">  
                                <%= expediente.getIdAbogado().getNombreApellido()%>  
                            </option>
                            <%for (int j = 0; j < listaAbogado.size(); j++) { 
                                if(listaAbogado.get(j).getIdAbogado() != expediente.getIdAbogado().getIdAbogado()){ 
                            %> 
                                    <option value="<%=listaAbogado.get(j).getIdAbogado()%>">  
                                        <%=listaAbogado.get(j).getNombreApellido()%>  
                                    </option>
                                <%}%>
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
                    <select form="editarExpediente"
                            name="idCliente" 
                            id="idCliente"
                            <%if(!expedienteVacio){%> 
                                readonly
                            <%}%>
                            <%if(expConOposicion){%> 
                                readonly
                            <%}%>
                            class="form-control">
                            <option selected value="<%=expediente.getIdCliente().getIdCliente()%>"> 
                                <%=expediente.getIdCliente().getNombreCliente()%>  
                            </option>
                            <%if(expedienteVacio){%>
                                <%if(!expConOposicion){%>
                                    <%for (int j = 0; j < listaCliente.size(); j++) {
                                        if(listaCliente.get(j).getIdCliente() != expediente.getIdCliente().getIdCliente()){
                                        %> 
                                            <option value="<%=listaCliente.get(j).getIdCliente()%>"> 
                                                <%=listaCliente.get(j).getNombreCliente()%> 
                                            </option>
                                        <%}%>
                                    <%}%>
                                <%}%>
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
                    <select form="editarExpediente"
                            name="idMarca" 
                            id="idMarca" 
                            <%if(!expedienteVacio){%> 
                                readonly
                            <%}%>
                            <%if(expConOposicion){%>
                                readonly
                            <%}%>
                            class="form-control">
                            <option selected value="<%=expediente.getIdMarca().getIdMarca()%>"> 
                                <%=expediente.getIdMarca().getDenominacion()%>  
                            </option>
                            <%if(expedienteVacio){%> 
                                <%if(!expConOposicion){%>
                                    <%for (int j = 0; j < listaMarca.size(); j++) {
                                        if(listaMarca.get(j).getIdMarca() != expediente.getIdMarca().getIdMarca()){
                                    %> 
                                            <option value="<%=listaMarca.get(j).getIdMarca()%>"> 
                                                <%=listaMarca.get(j).getDenominacion()%>  
                                            </option>
                                        <%}%>
                                    <%}%>
                                <%}%>
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
                    <select form="editarExpediente"
                            name="idTipoExpediente" 
                            id="idTipoExpediente"
                            class="form-control"
                            <%if(!expedienteVacio){%>
                                readonly
                            <%}%>
                            onchange="habilitarNroCertificado()">
                            <option selected value="<%=expediente.getTipoExpediente().getIdTipoExpediente()%>"> 
                                <%=expediente.getTipoExpediente().getDescripcion()%>  
                            </option>
                            <%if(expedienteVacio){%>
                                <%for (int j = 0; j < listaTipoExpediente.size(); j++) {
                                    if(listaTipoExpediente.get(j).getIdTipoExpediente() != expediente.getTipoExpediente().getIdTipoExpediente()){
                                    %>
                                        <option value="<%=listaTipoExpediente.get(j).getIdTipoExpediente()%>"> 
                                            <%=listaTipoExpediente.get(j).getDescripcion()%>  
                                        </option>
                                    <%}%>
                                <%}%>
                            <%}%>
                    </select>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="nroCertificado">Número de Certificado de Marca:</label>
                </div>
                <div class="col-6">  
                    <input form="editarExpediente"
                            name="nroCertificado" 
                            id="nroCertificado"
                            class="form-control"
                            onkeypress="return isNumberKey(event)"
                            <%if(expediente.getNroCertificado() != null){%>
                                value="<%=expediente.getNroCertificado()%>" 
                                <%if(!expedienteVacio){%>
                                    readonly
                                <%}%>
                            <%}else{%> 
                                disabled
                            <%}%> >
                    <div id="nroCertificado-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="obs">Observación:</label>
                </div>
                <div class="col-6">
                    <textarea   form="editarExpediente"
                                name="obs"
                                id="obs"
                                class="form-control"
                                rows="6"
                                maxlength=""
                                placeholder="Escriba una breve observacion"
                                ><%if(expediente.getObservacion() != null){%><%=expediente.getObservacion()%><%}%></textarea>  
                    <div id="obs-retro"></div>
                </div>
            </div>
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="comentario">Comentario de cierre</label>
                </div>
                <div class="col-6">
                    <textarea   form="editarExpediente"
                                name="comentario"
                                id="comentario"
                                class="form-control"
                                rows="6"
                                maxlength=""
                                disabled
                                placeholder="Escriba un comentario de cierre"
                                ></textarea>  
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
                           <%if(!expedienteCerrado){%> 
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
                var idEstadoMarcaInput = document.getElementById("idEstadoMarca");
                
                if(<%for(int i=0;i<listaEstadoMarcaFinales.size();i++){%>
                        idEstadoMarcaInput.value == <%=listaEstadoMarcaFinales.get(i).getIdEstado()%>
                        <%if(i+1<listaEstadoMarcaFinales.size()){%>
                            ||
                        <%}%>
                    <%}%>)
                {
                    comentarioInput.disabled = false;
                }else{
                    comentarioInput.disabled = true;
                    
                }
            }
            
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
                       
                var comentarioValido = true;
                
                if(!document.getElementById("comentario").disabled){
                    
                    comentarioValido = validarComentario();
                }
                
                if(nroExpedienteValido && 
                    nroClase && 
                    productoValido && 
                    fechaEstadoValido && 
                    fechaSolicitudValido &&
                    marcaValido &&
                    abogadoValido &&
                    clienteValido &&
                    nroCertificadoValido && comentarioValido){
                    
                    validarUnicidadNroExpediente();
                    
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
                "<%=request.getContextPath()%>/ExpedienteServlet?nroExpedienteDuplicado="+strNroExpediente+"&idExp="+<%=idExp%>, 
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

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        } else if(nroExpedienteDuplicado){

                            nroExpedienteInput.setAttribute("class","form-control is-invalid");
                            retroNroExpediente.setAttribute("class","invalid-feedback");
                            retroNroExpediente.textContent = 'Ya existe un expediente con el mismo número';

                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");

                        }else{
                            //se envia formulario
                            document.getElementById("editarExpediente").submit();

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

                    nroExpedienteInput.setAttribute("class","form-control is-invalid");
                    retroNroExpediente.setAttribute("class","invalid-feedback");
                    retroNroExpediente.textContent = 'No se pudo validar que el número de expediente sea único. \n Intente más tarde';

                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
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
                
                //Ver la elección de estado, si no cambia toma como minimo la fecha de estado anterior
                //o si cambia, la fecha del estado actual
                var idEstadoMarcaInput = document.getElementById("idEstadoMarca");
                var fechaMinima = '';
                if(idEstadoMarcaInput.value == <%=expediente.getIdEstado().getIdEstado()%>){
                    <%if(listaHistorialEstado.size() == 1){%>
                        fechaEstadoInput.setAttribute("min",document.getElementById("fechaSolicitud").value);
                        fechaMinima = document.getElementById("fechaSolicitud").value.substring(8,10);
                        fechaMinima = fechaMinima+"/";
                        fechaMinima = fechaMinima + document.getElementById("fechaSolicitud").value.substring(5,7);
                        fechaMinima = fechaMinima+"/";
                        fechaMinima = fechaMinima+document.getElementById("fechaSolicitud").value.substring(0,4);
                        
                    <%}else{%>
                        fechaEstadoInput.setAttribute("min","<%=new SimpleDateFormat("yyyy-MM-dd").format(listaHistorialEstado.get(listaHistorialEstado.size()-2).getFecha())%>");
                        fechaMinima = "<%=new SimpleDateFormat("dd/MM/yyyy").format(listaHistorialEstado.get(listaHistorialEstado.size()-2).getFecha())%>";
                    <%}%>
                }else{
                    fechaEstadoInput.setAttribute("min","<%=new SimpleDateFormat("yyyy-MM-dd").format(listaHistorialEstado.get(listaHistorialEstado.size()-1).getFecha())%>");
                    fechaMinima = "<%=new SimpleDateFormat("dd/MM/yyyy").format(listaHistorialEstado.get(listaHistorialEstado.size()-1).getFecha())%>";
                
                }


                if(strFechaEstado.length == 0){ 
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(!fechaEstadoInput.validity.valid){
                    fechaEstadoInput.setAttribute("class","form-control is-invalid");
                    retroFechaEstado.setAttribute("class","invalid-feedback");
                    retroFechaEstado.textContent = 'La fecha del estado debe entre '+fechaMinima+' y <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>';

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
