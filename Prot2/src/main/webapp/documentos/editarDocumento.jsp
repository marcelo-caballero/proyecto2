<%-- 
    Document   : editarDocumento
    Created on : 27-ago-2018, 16:19:36
    Author     : Acer
--%>

<%@page import="modeloMng.DocumentoJpaController"%>
<%@page import="modelo.Documento"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="modelo.TipoDocumento"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.TipoDocumentoJpaController"%>

<%@page import="modelo.Expediente"%>
<%@page import="modeloMng.ExpedienteJpaController"%>
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
            /*Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));

            ExpedienteJpaController expControl = new ExpedienteJpaController(); 
            Expediente expediente = expControl.findExpediente(idExp);*/

            TipoDocumentoJpaController tipoDocControl = new TipoDocumentoJpaController();
            List<TipoDocumento> listaTipoDoc = tipoDocControl.findTipoDocumentoEntities();

            Integer idDoc = Integer.parseInt(request.getParameter("idDocumento"));
            DocumentoJpaController documentoControl = new DocumentoJpaController();
            
            //El documento actual
            Documento documento = documentoControl.findDocumento(idDoc);
            Integer idExp = documento.getIdExpediente().getIdExpediente();
            
            //El último documento del expediente
            Documento ultimoDocumento = documentoControl.getUltimoDocumento(idExp);
            
            Date fechaLimiteInferior = null; 
            Integer folioDesde = 0;
            Integer folioHasta = 0;
            
            //Si el ultimo documento es el unico documento del expediente
            if(ultimoDocumento.getFolioDesde() == 1){
                
                //entonces la fechaLimiteInferior es la fecha de solicitud del expediente
                fechaLimiteInferior = documento.getIdExpediente().getFechaSolicitud();
                folioDesde = 1;
                
            }else{
                //Caso contrario la fechaLimiteInferior es la fecha del documento anterior al ultimo documento
                fechaLimiteInferior = documentoControl.getFechaDocumentoFolioHasta(ultimoDocumento.getFolioDesde()-1,idExp);
                folioDesde = ultimoDocumento.getFolioDesde();
            }
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        
        <div class="container form-control">
            <%if(documento.getIdDocumento() != ultimoDocumento.getIdDocumento()){%> 
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>Solamente se permite editar el último documento del expediente
                </div>
            <%}%>
            <h2 class="text-justify">Editar Documento</h2> 
            <br>
            
            <form id="editarDocumento" 
                  action="<%=request.getContextPath()%>/DocumentoServlet?editar=true"
                  method="post"
                  enctype="multipart/form-data"
                  novalidate>
            <input type="hidden" name="idDocumento" value="<%=idDoc%>">
            </form>

            <div class="row form-group">
                <div class="col-3">
                    <label for="">Número de Expediente:</label>
                </div>
                <div class="col-6">
                     <input form="editarDocumento"
                       name=""
                       class="form-control"
                       type="text"
                       readonly
                       value="<%=documento.getIdExpediente().getNroExpediente()%>"> 
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
                           value="<%=documento.getNombreDocumento()%>"
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

                                <%for (int j = 0; j < listaTipoDoc.size(); j++) {
                                    if(documento.getIdTipoDocumento().getIdTipoDocumento() 
                                            == listaTipoDoc.get(j).getIdTipoDocumento()){
                                    %>    
                                        <option selected value="<%=listaTipoDoc.get(j).getIdTipoDocumento()%>" >
                                            <%=listaTipoDoc.get(j).getDescripcion()%>
                                        </option>
                                    <%
                                    }else{%>
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

            <%if(documento.getIdDocumento() == ultimoDocumento.getIdDocumento()){%> 
                <div class="row form-group">
                    <div class="col-5">
                    </div>
                    <div class="col-2"><input form="editarDocumento"
                               id="editar"
                               type="button"
                               value="Editar"
                               onclick="validarFormulario()">
                    </div>
                </div>
            <%}%>

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
                    retroFecha.textContent = 'La fecha no debe ser anterior a <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaLimiteInferior)%>';
                    
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

<%-- //Llamada al ajax para validar que nombre
            //del documento no este duplicado por expediente
            //Si esta duplicado informa al cliente
            //Caso contrario, envia el formulario
            function validarNombreNoDuplicado(){
                
                var nombreDocInput = document.getElementById("nombreDoc");
                var retroNombreDoc = document.getElementById("nombreDoc-retro");
                var strNombre = nombreDocInput.value.trim();
                
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/DocumentoServlet?existeNombre="+strNombre+"&idDocumento="+<%=idDoc%>, 
                true);

                xmlHttp.onreadystatechange=function(){
                    
                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                       
                        clearTimeout(xmlHttpTimeout); 
                        
                        var objectoJSON = JSON.parse(this.responseText);
                        var existeNombre = objectoJSON.existeNombre;
                        
                        if(existeNombre == null){
                            
                            nombreDocInput.setAttribute("class","form-control is-invalid");
                            retroNombreDoc.setAttribute("class","invalid-feedback");
                            retroNombreDoc.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad del nombre';
                            
                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");
                        }else if(existeNombre){
                            
                            nombreDocInput.setAttribute("class","form-control is-invalid");
                            retroNombreDoc.setAttribute("class","invalid-feedback");
                            retroNombreDoc.textContent = 'Ya existe un documento con el mismo nombre';
                            
                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");
                            
                        }else{
                            //se envia formulario
                            document.getElementById("editarDocumento").submit();
                            
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
                 
                    nombreDocInput.setAttribute("class","form-control is-invalid");
                    retroNombreDoc.setAttribute("class","invalid-feedback");
                    retroNombreDoc.textContent = 'No se pudo validar que el nombre no sea duplicado. \n Intente más tarde';
                    
                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
                }
                
            }
--%>

