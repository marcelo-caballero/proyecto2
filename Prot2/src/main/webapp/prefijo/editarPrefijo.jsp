<%-- 
    Document   : agregarUsuario
    Created on : 13-sep-2018, 12:47:26
    Author     : Acer
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="modeloMng.PrefijoJpaController"%>
<%@page import="modelo.Prefijo"%>
<%@page import="java.util.List"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Factura - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer id = Integer.parseInt(request.getParameter("idPrefijo"));
            Prefijo prefijo = new PrefijoJpaController().findPrefijo(id);  
            
            //Solamente se puede editar cuando el valor proximo a usar es igual al inicial
            //O que haya expirado las numeraciones de factura
            
            boolean editable = false;
            SimpleDateFormat formatoFecha = new SimpleDateFormat("dd/MM/yyyy");

            Date hoy = formatoFecha.parse(formatoFecha.format(new Date()));
            Date valido = formatoFecha.parse(formatoFecha.format(prefijo.getFechaValidoHasta()));
            
            if(prefijo.getInicio() == prefijo.getProximo()){
                editable = true; 
            }    

            if(prefijo.getFin() == prefijo.getProximo()){
                editable = true;
            }
            
            if(hoy.compareTo(valido)>0){ 
                editable = true; 
            }
            
            //Establecer la fecha minima
            Calendar cal = Calendar.getInstance();
            cal.setTime(new Date());
            cal.add(Calendar.YEAR, -1);
            Date fechaMin = cal.getTime(); 

           
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuFacturacion.jsp" %>     
        </div>
        <div class ="container form-control">
            <%if(!editable){%>
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong> Los datos no son editables porque ya se realizó facturaciones
                </div>
            <%}%>
            <h2 class="text-justify">Editar Datos</h2>
            <br> 
        
            <form id="editarPrefijo" 
                  action="<%=request.getContextPath()%>/PrefijoServlet?editar=true" 
                  method="post"
                  novalidate
                  onsubmit="return false"
                  >
                <input type="hidden" name="idPrefijo" value="<%=id%>">
            </form>
          

            <div class="row form-group">
                <div class="col-3">
                    <label for="ruc">R.U.C.:</label> 
                </div>
                <div class="col-6">
                    <input form="editarPrefijo"
                           name="ruc"
                           id="ruc"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el R.U.C."
                           required 
                           value="<%=prefijo.getRuc()%>"
                           >
                    <div id="ruc-retro"></div>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="timbrado">Número de Timbrado:</label> 
                </div>
                <div class="col-6">
                    <input form="editarPrefijo"
                           name="timbrado"
                           id="timbrado"
                           class="form-control"
                           type="number" 
                           placeholder="Escriba el timbrado"
                           required 
                           min="1"
                           onkeypress="return isNumberKey(event)"
                           value="<%=prefijo.getTimbrado()%>"
                           >
                    <div id="timbrado-retro"></div>
                </div> 
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label for="prefijo">Prefijo:</label> 
                </div>
                <div class="col-6">
                    <input form="editarPrefijo"
                           name="prefijo"
                           id="prefijo"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el prefijo"
                           required 
                           value="<%=prefijo.getPrefijo()%>"
                           >
                    <div id="prefijo-retro"></div>
                </div> 
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label for="fechaValido">Válido hasta:</label> 
                </div>
                <div class="col-6">
                    <input form="editarPrefijo"
                           name="fechaValido"
                           id="fechaValido"
                           class="form-control"
                           type="date" 
                           placeholder="Escriba la fecha"
                           required 
                           min="<%=new SimpleDateFormat("yyyy-MM-dd").format(fechaMin)%>"
                           max="<%=new SimpleDateFormat("yyyy-MM-dd").format(new Date())%>" 
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(prefijo.getFechaValidoHasta())%>" 
                           >
                    <div id="fechaValido-retro"></div>
                </div> 
            </div>
                          
            <div class="row form-group">
                <div class="col-3">
                    <label for="inicio">Número de factura inicial:</label> 
                </div>
                <div class="col-6">
                    <input form="editarPrefijo"
                           name="inicio"
                           id="inicio"
                           class="form-control"
                           type="number" 
                           placeholder="Escriba el número de inicio"
                           required 
                           min="<%=prefijo.getFin()+1%>"
                           value="<%=prefijo.getInicio()%>"
                           onkeypress="return isNumberKey(event)"
                           >
                    <div id="inicio-retro"></div>
                </div> 
            </div>
             
            <div class="row form-group">
                <div class="col-3">
                    <label for="fin">Número de factura final:</label> 
                </div>
                <div class="col-6">
                    <input form="editarPrefijo"
                           name="fin"
                           id="fin"
                           class="form-control"
                           type="number" 
                           placeholder="Escriba el número final"
                           required 
                           min="<%=prefijo.getFin()+1%>"
                           value="<%=prefijo.getFin()%>" 
                           onkeypress="return isNumberKey(event)"
                           >
                    <div id="fin-retro"></div>
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
            function validarFormulario(){
                var rucValido = validarRuc();
                var timbradoValido = validarTimbrado();
                var prefijoValido = validarPrefijo();
                var fechaValido = validarFecha();
                var inicioValido = validarInicio() ;
                var finValido = validarFin();
                
                if(rucValido && timbradoValido && prefijoValido && fechaValido && inicioValido && finValido){
                    document.getElementById("editarPrefijo").submit();    
                }
            }
            
            function validarInicio(){
                var inicioInput = document.getElementById("inicio");
                var retroInicio = document.getElementById("inicio-retro");
                
                if(!inicioInput.validity.valid){
                    inicioInput.setAttribute("class","form-control is-invalid");
                    retroInicio.setAttribute("class","invalid-feedback");
                    retroInicio.textContent = 'El número debe ser mayor que <%=prefijo.getFin()%>';
                    
                    return false;
                    
                }
                
                inicioInput.setAttribute("class","form-control is-valid");
                retroInicio.setAttribute("class","valid-feedback");
                retroInicio.textContent = '';
                
                document.getElementById("fin").setAttribute("min",inicioInput.value);
                
                return true;
            }
            
            function validarFin(){
               
                var finInput = document.getElementById("fin");
                var retroFin = document.getElementById("fin-retro");
                
                var inicioInput = document.getElementById("inicio");

                if(!finInput.validity.valid){
                    finInput.setAttribute("class","form-control is-invalid");
                    retroFin.setAttribute("class","invalid-feedback");
                    retroFin.textContent = 'El número debe ser mayor o igual que el número inicial';

                    return false;
                }
                
                
                finInput.setAttribute("class","form-control is-valid");
                retroFin.setAttribute("class","valid-feedback");
                retroFin.textContent = '';

                return true;
                
            }
            
            function validarRuc(){
                var rucInput = document.getElementById("ruc");
                var retroRuc = document.getElementById("ruc-retro");
                var strRuc = rucInput.value.trim();
                
                rucInput.value = strRuc;
                
                
                if(strRuc.length == 0){
                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'El campo esta vacío';
                    
                    return false;
                } 
                
                if(/\s/.test(strRuc)){

                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'No debe contener espacios';
                    return false;
                } 
                
                rucInput.setAttribute("class","form-control is-valid");
                retroRuc.setAttribute("class","valid-feedback");
                retroRuc.textContent = '';
                    
                return true;
            }
            
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
            function validarTimbrado(){
                var timbradoInput = document.getElementById("timbrado");
                var retroTimbrado = document.getElementById("timbrado-retro");
                var strTimbrado = timbradoInput.value
                
                if(!timbradoInput.validity.valid){ 
                    timbradoInput.setAttribute("class","form-control is-invalid");
                    retroTimbrado.setAttribute("class","invalid-feedback");
                    retroTimbrado.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                timbradoInput.setAttribute("class","form-control is-valid");
                retroTimbrado.setAttribute("class","valid-feedback");
                retroTimbrado.textContent = '';
                    
                return true;
            }
            
            function validarPrefijo(){
                var prefijoInput = document.getElementById("prefijo");
                var retroPrefijo = document.getElementById("prefijo-retro");
                var strPrefijo = prefijoInput.value.trim();
                
                prefijoInput.value = strPrefijo;
                
                if(strPrefijo.length == 0){ 
                    prefijoInput.setAttribute("class","form-control is-invalid");
                    retroPrefijo.setAttribute("class","invalid-feedback");
                    retroPrefijo.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                prefijoInput.setAttribute("class","form-control is-valid");
                retroPrefijo.setAttribute("class","valid-feedback");
                retroPrefijo.textContent = '';
                    
                return true;
            }
            
            function validarFecha(){
                var fechaInput = document.getElementById("fechaValido");
                var retroFecha = document.getElementById("fechaValido-retro");
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
                    
                    retroFecha.textContent = 
                        'La fecha debe estar entre <%=new SimpleDateFormat("dd/MM/yyyy").format(fechaMin)%> y <%=new SimpleDateFormat("dd/MM/yyyy").format(new Date())%>';
                    
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
    