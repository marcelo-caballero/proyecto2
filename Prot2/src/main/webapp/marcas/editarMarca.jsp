<%-- 
    Document   : verMarca
    Created on : 20-ago-2018, 22:23:44
    Author     : Acer
--%>


<%@page import="modelo.Expediente"%>
<%@page import="java.lang.String"%>
<%@page import="modeloMng.TipoMarcaJpaController"%>
<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Marca"%>
<%@page import="modelo.TipoMarca"%>  
<%@page import="modeloMng.MarcaJpaController"%> 
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Marca - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>

    <body onload="actualizarSigno();">
        <%
            Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));
            MarcaJpaController marcaControl = new MarcaJpaController();
            Marca marca = marcaControl.findMarca(idMarca);

            List<TipoMarca> listaTipoMarca;
            TipoMarcaJpaController tipoMarcaControl = new TipoMarcaJpaController();
            listaTipoMarca = tipoMarcaControl.findTipoMarcaEntities();
            
            //Verificamos que la marca pueda editarse al no estar asociada a un expediente cerrado
            boolean editable = true;
            List<Expediente> listaExpediente = marca.getExpedienteList();
            for(int i=0;i<listaExpediente.size();i++){
                if(listaExpediente.get(i).getIdEstado().getTipo() != null){
                    if(listaExpediente.get(i).getIdEstado().getTipo().equals("F")){
                        editable = false;
                        i = i+ listaExpediente.size(); 
                    }
                }
            }
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>

        <div class ="container form-control">
            
            <h2 class="text-justify"> Editar Marca</h2>
            <br>
            <%if(!editable){%> 
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>No se puede editar porque la marca esta asociada a un expediente cerrado
                </div>
            <%}%>
            <br>
            
            <form id="editarMarca" 
                  action="<%=request.getContextPath()%>/MarcaServlet?editar=true" 
                  method="post" 
                  enctype="multipart/form-data" 
                  novalidate
                  onsubmit="return false">
                <input type="hidden" name="idMarca" value="<%=idMarca%>">
            </form>
                
            <div class = "row form-group">
                <div class="col-3">
                    <label for="denominacion">Denominación:</label>
                </div>
                <div class="col-6">
                    <input form="editarMarca"
                           name="denominacion"
                           id="denominacion"
                           class="form-control"
                           type="text"
                           placeholder="Escriba la denominación para la marca"
                           maxlength=""
                           required
                           value="<%=marca.getDenominacion()%>">
                    <div id="denominacion-retro"></div>
                </div>    
            </div>
                    
            <div class = "row form-group">   
                <div class="col-3">
                    <label for="idTipoMarca">Signo:</label>
                </div>
                <div class="col-6">    
                    <div class="row">
                        <div class="col-3">
                            <input id="codigoTipoMarca" class="form-control" disabled>
                        </div>
                        <div class="col">
                            <select form="editarMarca"
                                    name="idTipoMarca"
                                    id="idTipoMarca"
                                    class="form-control"
                                    onchange="actualizarSigno()">
                                    <option value="<%=marca.getIdTipoMarca().getIdTipoMarca()%>"> 
                                        <%=marca.getIdTipoMarca().getDescripcion()%>
                                    </option>
                                    <%for (int j = 0; j < listaTipoMarca.size(); j++) {%>

                                        <%if (marca.getIdTipoMarca().getIdTipoMarca() != listaTipoMarca.get(j).getIdTipoMarca()) {%>
                                            <option value="<%=listaTipoMarca.get(j).getIdTipoMarca()%>">
                                                <%=listaTipoMarca.get(j).getDescripcion()%>
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
                    <label for="imagenMarca"> Nueva Imagen:</label>
                </div>
                <div class="col-6">
                    <input form="editarMarca" 
                           name="imagenMarca"
                           id="imagenMarca"
                           class="form-control"
                           type="file"    
                           accept="image/png, image/jpeg">
                    <div id="imagenMarca-retro"></div>
                </div>
            </div>
            
            <% if (marca.getImagenMarca() != null) {
                String imageBase64 = new String(Base64.getEncoder().encode(marca.getImagenMarca())); 
            %>
                <div class="row form-group">
                    <div class="col-3">
                        <label>Imagen Actual:</label>
                    </div>
                    <div class="col-6">
                        <div class="form-control form-inline justify-content-center">
                            <img src="data:image/jpg;base64,<%=imageBase64%>">  
                        </div>
                    </div> 
                </div>
             <%}%>  
             
            
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
        <style>
            img {
                
                position: static;
                width:  auto;
                height: 200px;
                background-position: 50% 50%;
                background-repeat:   no-repeat;
                background-size:     cover;
            }
        </style>
        
        <script>
            
            function actualizarSigno(){
                
                var codigoSigno = document.getElementById("codigoTipoMarca")
                        
                codigoSigno.value = document.getElementById("idTipoMarca").value;  
                
                //Si el signo de marca es denominativo  entonces no se acepta imagen
                if(codigoSigno.value ==  <%= new TipoMarca().getNroIdDenominativo()%> ){
                    
                    document.getElementById("imagenMarca").disabled = true;
                    document.getElementById("imagenMarca").value = "";
                }else{
                    
                    document.getElementById("imagenMarca").disabled = false;
                }
                
            }
            
            function validarFormulario(){
                var denominacionValido = validarDenominacion();
                var imagenValido = validarImagen();
                
                if(denominacionValido && imagenValido){
                    
                    validarDenominacionNoDuplicado();
                }
            }
            
            //Llamada al ajax para validar que denominacion
            //de la marca no este duplicado
            //Si esta duplicado informa al cliente
            //Caso contrario, envia el formulario
            function validarDenominacionNoDuplicado(){
                
                var denominacionInput = document.getElementById("denominacion");
                var retroDenominacion = document.getElementById("denominacion-retro");
                var strDenominacion = denominacionInput.value.trim(); 
                
                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/MarcaServlet?existeDenominacion="+strDenominacion+"&idMarca=<%=idMarca%>",  
                true);

                xmlHttp.onreadystatechange=function(){
                    
                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {
                       
                        clearTimeout(xmlHttpTimeout); 
                        
                        var objectoJSON = JSON.parse(this.responseText);
                        var existeDenominacion = objectoJSON.existeDenominacion;
                        
                        if(existeDenominacion ==  null){
                            
                            denominacionInput.setAttribute("class","form-control is-invalid");
                            retroDenominacion.setAttribute("class","invalid-feedback");
                            retroDenominacion.textContent = '¡Ocurrió un fallo! No se pudo comprobar la unicidad de la denominación';
                                                           
                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");
                            
                        }else if(existeDenominacion){
                            
                            denominacionInput.setAttribute("class","form-control is-invalid");
                            retroDenominacion.setAttribute("class","invalid-feedback");
                            retroDenominacion.textContent = 'Ya existe una marca con la misma denominación';
                            
                            //se desbloquea boton editar
                            document.getElementById("editar").removeAttribute("disabled");
                            
                        }else{
                            //se envia formulario
                            document.getElementById("editarMarca").submit();
                            
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
                 
                    denominacionInput.setAttribute("class","form-control is-invalid");
                    retroDenominacion.setAttribute("class","invalid-feedback");
                    retroDenominacion.textContent = 'No se pudo conectar con el servidor. Intente más tarde';
                    
                    // Se desbloque boton editar
                    document.getElementById("editar").removeAttribute("disabled");
                }
                
            }
            
            //Se asegura que la denominacion no este vacia
            function validarDenominacion(){
                
                var denominacionInput = document.getElementById("denominacion");
                var retroDenominacion = document.getElementById("denominacion-retro");
                var strDenominacion = denominacionInput.value.trim();
                
                denominacionInput.value = strDenominacion;
               
                
                //Si contiene caracteres invalidos, lo informa
                
                if(strDenominacion.length == 0){ 
                    denominacionInput.setAttribute("class","form-control is-invalid");
                    retroDenominacion.setAttribute("class","invalid-feedback");
                    retroDenominacion.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                denominacionInput.setAttribute("class","form-control is-valid");
                retroDenominacion.setAttribute("class","valid-feedback");
                retroDenominacion.textContent = '';
                
                return true;
            }
            
            function validarImagen(){
                
                var imagenInput = document.getElementById("imagenMarca");
                var retroImagen = document.getElementById("imagenMarca-retro");
                var strImagen = imagenInput.value;
                var formato = (strImagen.substring(strImagen.lastIndexOf("."))).toLowerCase();
                
                var estaDeshabilitado = document.getElementById("imagenMarca").disabled;
                
                if(!estaDeshabilitado){
                    //Si el signo es denominativa y cambia, exige que se 
                    //seleccione una imagen
                    <%if(marca.getIdTipoMarca().getIdTipoMarca() == new TipoMarca().getNroIdDenominativo()){%>
                        if(strImagen.length == 0 ){
                            imagenInput.setAttribute("class","form-control is-invalid");
                            retroImagen.setAttribute("class","invalid-feedback");
                            retroImagen.textContent = 'Seleccione una imagen con algunos de los siguientes formatos: jpg,jpeg,png'; 
                            return false; 
                        }      
                    <%}%>
                        
                    if(strImagen.length >0 && formato != ".jpg" && formato != ".jpeg" && formato != ".png"){
                        imagenInput.setAttribute("class","form-control is-invalid");
                        retroImagen.setAttribute("class","invalid-feedback");
                        retroImagen.textContent = 'El formato de la imagen debe ser alguno de los siguientes: jpg,jpeg,png'; 

                        return false;

                    }
                }
               
                imagenInput.setAttribute("class","form-control is-valid");
                retroImagen.setAttribute("class","valid-feedback");
                retroImagen.textContent = ''; 
                
                return true;
            }
            
        </script>
    </body>
</html>
