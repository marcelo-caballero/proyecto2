<%-- 
    Document   : agregarDocumentoOposicionHecha
    Created on : 06-nov-2018, 1:15:15
    Author     : User
--%>

<%@page import="modeloMng.HistorialEstadoOposicionHechaJpaController"%>
<%@page import="modelo.HistorialEstadoOposicionHecha"%>
<%@page import="modelo.DocumentoOposicionHecha"%>
<%@page import="modeloMng.DocumentoOposicionHechaJpaController"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.TipoDocumentoOposicionHecha"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.TipoDocumentoOposicionHechaJpaController"%> 

<%@page import="modelo.OposicionHecha"%>
<%@page import="modeloMng.OposicionHechaJpaController"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Documento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="cambiarIdTipo()">
        <%
            Integer idOposicion = (Integer) (request.getSession().getAttribute("idOposicionHecha"));

            OposicionHechaJpaController oposicionControl = new OposicionHechaJpaController(); 
            OposicionHecha oposicion = oposicionControl.findOposicionHecha(idOposicion);

            TipoDocumentoOposicionHechaJpaController tipoDocControl = new TipoDocumentoOposicionHechaJpaController();
            List<TipoDocumentoOposicionHecha> listaTipoDoc = tipoDocControl.findTipoDocumentoOposicionHechaEntities();
            
            DocumentoOposicionHechaJpaController documentoControl = new DocumentoOposicionHechaJpaController();
            DocumentoOposicionHecha documento = documentoControl.getUltimoDocumento(idOposicion);
            
            List<HistorialEstadoOposicionHecha> listaHistorial = new HistorialEstadoOposicionHechaJpaController().getHistorialEstadoOposicionPorIdOposicion(idOposicion); 
            
            Date fechaInferior = null;
            Integer folioDesde = null;
            
            if(documento == null){
                //fechaInferior = oposicion.getFecha();  
                //fechaInferior = oposicion.getHistorialEstadoOposicionHechaList().get(0).getFecha();
                fechaInferior = listaHistorial.get(0).getFecha();
                folioDesde = 1;  
            }else{
                fechaInferior = documento.getFecha();
                folioDesde = documento.getFolioHasta()+1; 
            }
            
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuOposicionesHechas.jsp" %>     
        </div>
        <div class="container form-control">
            <h2 class="text-justify">Agregar Documento</h2> 
            <br>
            
            <form id="agregarDocumento" 
                  action="<%=request.getContextPath()%>/DocumentoOposicionHechaServlet?agregar=true"
                  method="post"
                  enctype="multipart/form-data"
                  novalidate>
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label for="">Número de Expediente Opositado:</label>
                </div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name=""
                           class="form-control"
                           type="text"
                           readonly
                           value="<%=oposicion.getNroExpedienteOpositado()%>">
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaDoc">Fecha: </label>
                </div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name="fechaDoc"
                           id="fecha"
                           class="form-control"
                           type="date"
                           min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaInferior)%>"
                           max="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" 
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaInferior)%>"
                           required> 
                    <div id="fecha-retro"></div>
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label for="nombreDoc">Nombre del documento:</label></div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name="nombreDoc"
                           id="nombreDoc"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el nombre para el documento"
                           required
                           maxlength=""
                           pattern='^[^<>\/:?*"|]+$'>
                    <div id="nombreDoc-retro"></div>
                </div>
            </div>

            

            <div class="row form-group">
                <div class="col-3">
                    <label for="idTipoDoc">Tipo de Documento:</label>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-3">
                            <input id="idDoc" class="form-control" disabled >
                        </div>
                        <div class="col">
                            <select form="agregarDocumento"
                                    name="idTipoDoc" 
                                    class="form-control"
                                    id="idTipoDoc"
                                    onchange="cambiarIdTipo()">

                                <%for (int j = 0; j < listaTipoDoc.size(); j++) {%>

                                <option value="<%=listaTipoDoc.get(j).getIdTipoDocumento()%>" >
                                    <%=listaTipoDoc.get(j).getDescripcion()%>
                                </option>

                                <%}%>
                            </select>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="">Folio: </label>
                </div>
                <div class="col-6">
                    <div class="row">
                        <div class="col-2">
                            <label for="folioDesde">Desde:</label>
                        </div>
                        <div class="col">
                            <input form="agregarDocumento"
                                name="folioDesde"
                                id="folioDesde"
                                class="form-control"
                                type="number"
                                placeholder="desde"
                                required
                                readonly
                                value="<%=folioDesde%>"
                                maxlength="">
                        </div>
                        <div class="col-2">
                            <label for="folioHasta">hasta:</label>
                        </div>
                        <div class="col">
                            <input form="agregarDocumento"
                                    name="folioHasta"
                                    id="folioHasta"
                                    class="form-control"
                                    type="number"
                                    placeholder="hasta"
                                    required
                                    min="<%=folioDesde%>"
                                    maxlength="">
                            <div id="folio-retro"></div>
                        </div>
                    </div>    
                </div>
            </div>
                            
            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Descripción: </label>
                </div>
                <div class="col-6">
                    <textarea   form="agregarDocumento"
                                name="descripcionDoc"
                                id="descripcionDoc"
                                class="form-control"
                                rows="6"
                                maxlength="250"
                                placeholder="Escriba una breve descripción"
                                required
                                ></textarea>
                    <div id="descripcionDoc-retro"></div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label for="archivoDoc">Documento: </label>
                </div>
                <div class="col-6">
                    <input form="agregarDocumento"
                           name="archivoDoc"
                           id="archivoDoc"
                           class="form-control"
                           type="file"
                           required
                           accept=".pdf">
                    <div id="archivoDoc-retro"></div>
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
            function cambiarIdTipo() {
                document.getElementById("idDoc").value = document.getElementById("idTipoDoc").value;
            }
            
            function validarFormulario(){
                
                var nombreValido= validarNombre();
                var descripcionValido = validarDescripcion();
                var archivoValido = validarArchivo();
                var fechaValido = validarFecha();
                var folioHastaValido = validarFolioHasta();
                
                if(nombreValido && descripcionValido && archivoValido && fechaValido && folioHastaValido){
                    
                    document.getElementById("agregarDocumento").submit();
                }
                
                
            }
 
           function validarFolioHasta(){
                
                var folioHastaInput = document.getElementById("folioHasta");
                var retroFolioHasta= document.getElementById("folio-retro");
                //var strFolioHasta = folioHastaInput.value;
               
                
                if(!folioHastaInput.validity.valid ){

                    folioHastaInput.setAttribute("class","form-control is-invalid");
                    retroFolioHasta.setAttribute("class","invalid-feedback");
                    retroFolioHasta.textContent = 'El número es inválido ';
                    
                    return false;
                }
                
                folioHastaInput.setAttribute("class","form-control is-valid");
                retroFolioHasta.setAttribute("class","valid-feedback");
                retroFolioHasta.textContent = '';
                    
                 
                return true;
            }
            
            function validarNombre(){
                
                var nombreDocInput = document.getElementById("nombreDoc");
                var retroNombreDoc = document.getElementById("nombreDoc-retro");
                var strNombre = nombreDocInput.value.trim();
                var patt = new RegExp('[<>\/:?*"|]');
                nombreDocInput.value = strNombre;
                
                //Si contiene caracteres invalidos, lo informa
                
                if(strNombre.length == 0){ 
                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                if(patt.test(strNombre)){

                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.textContent = 'No debe contener los caracteres <>\/:?*"|';
                    return false;
                }
                
                nombreDocInput.setAttribute("class","form-control is-valid");
                retroNombreDoc.setAttribute("class","valid-feedback");
                retroNombreDoc.textContent = '';
                
                return true;
            }
            
            
            //Se valida que la descripcion no este vacía
            function validarDescripcion(){
                
                var descripcionInput = document.getElementById("descripcionDoc");
                var retroDescripcion = document.getElementById("descripcionDoc-retro");
                var strDescripcion = descripcionInput.value.trim();
                descripcionInput.value = strDescripcion;
                
                if(strDescripcion.length == 0){

                    descripcionInput.setAttribute("class","form-control is-invalid");
                    retroDescripcion.setAttribute("class","invalid-feedback");
                    retroDescripcion.textContent = 'Escriba la descripción';
                    
                    return false;
                }
                
                descripcionInput.setAttribute("class","form-control is-valid");
                retroDescripcion.setAttribute("class","valid-feedback");
                retroDescripcion.textContent = '';
                    
                 
                return true;
            }
            
            function validarArchivo(){
                
                var archivoInput = document.getElementById("archivoDoc");
                var retroArchivo = document.getElementById("archivoDoc-retro");
                var strArchivo = archivoInput.value;
                var formato = (strArchivo.substring(strArchivo.lastIndexOf("."))).toLowerCase();
                
                if(strArchivo.length == 0){
                    archivoInput.setAttribute("class","form-control is-invalid");
                    retroArchivo.setAttribute("class","invalid-feedback");
                    retroArchivo.textContent = 'Seleccione un archivo pdf'; 
                    return false; 
                }
                
                if(formato != ".pdf"){
                    archivoInput.setAttribute("class","form-control is-invalid");
                    retroArchivo.setAttribute("class","invalid-feedback");
                    retroArchivo.textContent = 'El formato debe ser pdf'; 
                    
                    return false;
                    
                }
                
                archivoInput.setAttribute("class","form-control is-valid");
                retroArchivo.setAttribute("class","valid-feedback");
                retroArchivo.textContent = ''; 
                    
                
                return true;
            }  
            
            function validarFecha(){
                
                var fechaInput = document.getElementById("fecha");
                var retroFecha = document.getElementById("fecha-retro");
                var strFecha = fechaInput.value.trim(); 
                
                if(strFecha.length == 0){ 
                    fechaInput.setAttribute("class","form-control is-invalid");
                    retroFecha.setAttribute("class","invalid-feedback");
                    retroFecha.textContent = 'El campo esta vacío';
                    
                    return false;
                } 
                
                if(!fechaInput.validity.valid){ 
                    fechaInput.setAttribute("class","form-control is-invalid");
                    retroFecha.setAttribute("class","invalid-feedback");
                    retroFecha.textContent = 'La fecha no debe ser entre <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaInferior)%> a <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>';
                    
                    return false;
                } 
                
                fechaInput.setAttribute("class","form-control is-valid");
                retroFecha.setAttribute("class","valid-feedback");
                retroFecha.textContent = ''; 
                
                return true;
            }
        </script>     
    </body>
</html>
