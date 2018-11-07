<%-- 
    Document   : editarDocumentoOposicionHecha
    Created on : 06-nov-2018, 1:16:43
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
            
            TipoDocumentoOposicionHechaJpaController tipoDocControl = new TipoDocumentoOposicionHechaJpaController();
            List<TipoDocumentoOposicionHecha> listaTipoDoc = tipoDocControl.findTipoDocumentoOposicionHechaEntities();

            Integer idDoc = Integer.parseInt(request.getParameter("idDocumento"));
            DocumentoOposicionHechaJpaController documentoControl = new DocumentoOposicionHechaJpaController();
            
            //El documento actual
            DocumentoOposicionHecha documento = documentoControl.findDocumentoOposicionHecha(idDoc);
            Integer idOposicion = documento.getIdOposicionHecha().getIdOposicion();
            
            //El último documento de la oposicion
            DocumentoOposicionHecha ultimoDocumento = documentoControl.getUltimoDocumento(idOposicion);
            
            List<HistorialEstadoOposicionHecha> listaHistorial = new HistorialEstadoOposicionHechaJpaController().getHistorialEstadoOposicionPorIdOposicion(idOposicion); 
            
            Date fechaLimiteInferior = null; 
            Integer folioDesde = 0;
            Integer folioHasta = 0;
            
            //Si el ultimo documento es el unico documento de la oposicion
            if(ultimoDocumento.getFolioDesde() == 1){
                
                //entonces la fechaLimiteInferior es la fecha del primer estado de la oposicion
                fechaLimiteInferior =  listaHistorial.get(0).getFecha();
                folioDesde = 1;
                
            }else{
                //Caso contrario la fechaLimiteInferior es la fecha del documento anterior al ultimo documento
                fechaLimiteInferior = documentoControl.getFechaDocumentoFolioHasta(ultimoDocumento.getFolioDesde()-1,idOposicion);
                folioDesde = ultimoDocumento.getFolioDesde();
            }
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuOposicionesHechas.jsp" %>     
        </div>
        
        <div class="container form-control">
            <h2 class="text-justify">Editar Documento</h2> 
            <br>
            <%if(documento.getIdDocumento() != ultimoDocumento.getIdDocumento()){%> 
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>Solamente se permite editar el último documento de la oposición
                </div>
            <%}%>
            <br>
            <form id="editarDocumento" 
                  action="<%=request.getContextPath()%>/DocumentoOposicionHechaServlet?editar=true"
                  method="post"
                  enctype="multipart/form-data"
                  novalidate>
            <input type="hidden" name="idDocumento" value="<%=idDoc%>">
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label for="">Número de Expediente Opositado:</label>
                </div>
                <div class="col-6">
                     <input form="editarDocumento"
                       name=""
                       class="form-control"
                       type="text"
                       readonly
                       value="<%=documento.getIdOposicionHecha().getNroExpedienteOpositado()%>"> 
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaDoc">Fecha: </label>
                </div>
                <div class="col-6">
                     <input form="editarDocumento"
                           name="fechaDoc"
                           id="fecha"
                           class="form-control"
                           type="date"
                           min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaLimiteInferior)%>"
                           max="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(documento.getFecha())%>"
                           required>
                     <div id="fecha-retro"></div>
                </div>
            </div>
                
            <div class="row form-group">    
                <div class="col-3">
                    <label for="nombreDoc">Nombre del documento:</label></div>
                <div class="col-6">
                     <input form="editarDocumento"
                           name="nombreDoc"
                           id="nombreDoc"
                           class="form-control"
                           type="text"
                           placeholder="Escriba el nombre para el documento"
                           value="<%=documento.getNombre()%>"
                           required> 
                     <div id="nombreDoc-retro"></div> 
                </div>
            </div>
            
           
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="idTipoDoc">Tipo de Documento:</label>
                </div>
                <div class="col-6">
                    <div class=" row">
                        <div class="col-3">
                            <input id="idDoc" class="form-control" disabled >
                        </div>
                        <div class="col">
                            <select form="editarDocumento"
                                    name="idTipoDoc" 
                                    class="form-control"
                                    id="idTipoDoc"
                                    onchange="cambiarIdTipo()">
                                    <option selected value="<%=documento.getIdTipoDocumentoOposicionHecha().getIdTipoDocumento() %>" >
                                            <%=documento.getIdTipoDocumentoOposicionHecha().getDescripcion()%>
                                    </option>
                                    <%for (int j = 0; j < listaTipoDoc.size(); j++) {
                                        if(documento.getIdTipoDocumentoOposicionHecha().getIdTipoDocumento()  
                                                != listaTipoDoc.get(j).getIdTipoDocumento()){
                                        %>  
                                            <option value="<%=listaTipoDoc.get(j).getIdTipoDocumento()%>" >
                                                <%=listaTipoDoc.get(j).getDescripcion()%>
                                            </option>
                                        <%}%>
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
                            <input form="editarDocumento"
                                name="folioDesde"
                                id="folioDesde"
                                class="form-control"
                                type="number"
                                placeholder="desde"
                                required
                                readonly
                                value="<%=documento.getFolioDesde()%>" 
                                maxlength="">
                        </div>
                        <div class="col-2">
                            <label for="folioHasta">hasta:</label>
                        </div>
                        <div class="col">
                            <input form="editarDocumento"
                                    name="folioHasta"
                                    id="folioHasta"
                                    class="form-control"
                                    type="number"
                                    placeholder="hasta"
                                    required
                                    min="<%=folioDesde%>"
                                    value="<%=documento.getFolioHasta()%>"
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
                    <textarea form="editarDocumento"
                        name="descripcionDoc"
                        id="descripcionDoc"
                        class="form-control"
                        rows="6"
                        maxlength="250"
                        placeholder=" Escriba una breve descripción"
                        required
                        ><%=documento.getDescripcion()%></textarea>
                    <div id="descripcionDoc-retro"></div>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="archivoDoc">Documento: </label>
                </div>
                <div class="col-6">
                      <input form="editarDocumento"
                           name="archivoDoc"
                           id="archivoDoc"
                           class="form-control"
                           type="file"
                           accept=".pdf">
                      <div id="archivoDoc-retro"></div>
                </div>
            </div>

             
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input form="editarDocumento"
                       id="editar"
                       type="button"
                       value="Editar"
                       <%if(documento.getIdDocumento() == ultimoDocumento.getIdDocumento()){%>
                            onclick="validarFormulario()"
                       <%}%>
                    >
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
                    
                    document.getElementById("editarDocumento").submit();
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
            
            //Se valida que:
            //El nombre no este vacio
            //Que no sea una secuencia de espacios en blanco
            //Que no tenga caracteres especiales
            function validarNombre(){
                
                var nombreDocInput = document.getElementById("nombreDoc");
                var retroNombreDoc = document.getElementById("nombreDoc-retro");
                var strNombre = nombreDocInput.value.trim();
                nombreDocInput.value = strNombre;
                var patt = new RegExp('[<>\/:?*"|]');
                
                //Si contiene caracteres invalidos, lo informa
                
                if(strNombre.length == 0){ 
                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.setAttribute("pattern","");
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
                var strDescripcion = descripcionInput.value;
                descripcionInput.value = strDescripcion;
                
                
                if(strDescripcion.trim().length == 0){

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
                
               
                if(strArchivo.length > 0 && formato !== ".pdf"){
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
                    retroFecha.textContent = 'La fecha no debe ser entre <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaLimiteInferior)%> a <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>'; 
                    
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
