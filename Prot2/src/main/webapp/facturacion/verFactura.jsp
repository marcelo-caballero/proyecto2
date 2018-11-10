<%-- 
    Document   : agregarFactura
    Created on : 09-nov-2018, 2:28:13
    Author     : User
--%>

<%@page import="modeloMng.FacturaCabeceraJpaController"%>
<%@page import="modelo.FacturaCabecera"%>
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
        <title>Titular - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <% List<Prefijo> prefijo = new PrefijoJpaController().findPrefijoEntities();
           Integer numeroFactura = prefijo.get(0).getId();
           
           String numFactura = numeroFactura+"";
           while(numFactura.length()<6){
               numFactura = "0"+numFactura;
           }
           
           Integer id = Integer.parseInt(request.getParameter("idFactura"));
           FacturaCabecera factura = new FacturaCabeceraJpaController().findFacturaCabecera(id);
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
         
        <div class ="container form-control">
        
            <h2 class="text-justify"> Ver Factura</h2>
            <br> 
        
            <form id="agregarFactura" 
                  action="" 
                  method="post" 
                  novalidate>
                <input type="hidden" name="idCliente" id="idCliente">
            </form>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="ruc">R.U.C.:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="ruc"
                           id="ruc"
                           class="form-control"
                           type="text" 
                           placeholder="Escriba el R.U.C. del titular y oprima Buscar"
                           required
                           value="<%=factura.getIdCliente().getRuc()%>"  
                           >
                    <div id="ruc-retro"></div>
                </div> 
                <div class="col">
                    <input id="buscar" 
                           type="button" 
                           value="Buscar" 
                           onclick="rellenarCliente()">
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="nombre">Cliente:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="nombre"
                           id="nombre"
                           class="form-control"
                           type="text" 
                           readonly
                           value="<%=factura.getIdCliente().getNombreCliente()%>"
                           required >
                    <div id="nombre-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="direccion">Dirección:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="direccion"
                           id="direccion"
                           class="form-control"
                           type="text" 
                           readonly
                           value="<%=factura.getIdCliente().getDireccion()%>"
                           required >
                    <div id="direccion-retro"></div>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="telefono">Teléfono:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="telefono"
                           id="telefono"
                           class="form-control"
                           type="text" 
                           readonly
                           value="<%=factura.getIdCliente().getTelefono()%>"
                           required >
                    <div id="telefono-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="">Fecha: </label>
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="fecha"
                           id="fecha"
                           class="form-control"
                           type="date"
                           readonly
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(factura.getFecha())%>" 
                           required>  
                    <div id="fecha-retro"></div>
                </div>
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="numFact">Número de Factura:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="numFact"
                           id="numFact"
                           class="form-control"
                           type="number" 
                           readonly
                           required 
                           value="<%=factura.getNumeroFactura()%>"
                           onkeypress="return isNumberKey(event)">
                    <div id="ci-retro"></div>
                </div> 
            </div>
                  
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="cond_venta">Condición de Venta:</label>
                </div>  
                <div class="col-6">
                    <input form="agregarFactura" 
                            name="cond_venta" 
                            id="cond_venta" 
                            class="form-control"
                            value="<%=factura.getCondicionVenta()%>"
                            >
                            
                    
                    
                   
                </div>
            </div>
                    
           
                           
            <div class="row form-group" >
                <div class="col-3">
                    <label for="apellido">Forma de pago:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura" 
                            name="forma_pago" 
                            id="forma_pago" 
                            class="form-control"
                            value="<%=factura.getFormaPago()%>"
                            >
                            
                    <div id=""></div>
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Banco: </label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="banco"
                           id="banco"
                           class="form-control"
                           type="text" 
                           value="<%=factura.getBanco()%>"
                           required >
                    <div id="banco-retro"></div>
                </div> 
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Nº de Cheque /Nº de cuenta bancaria: </label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="nroFormaPago"
                           id="nroFormaPago"
                           class="form-control"
                           type="number" 
                           min="0"
                           value="<%=factura.getNumeroFormaPago()%>"
                           onkeypress="return isNumberKey(event)"
                           required >
                    <div id="nroFormaPago-retro"></div>
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Descripción: </label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="descripcion"
                           id="descripcion"
                           class="form-control"
                           type="text" 
                           value=""
                           required >
                    <div id="descripcion-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group" >
                <div class="col-3">
                    <label for="monto">Monto:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="monto"
                           id="monto"
                           class="form-control"
                           type="number" 
                           min="1"
                           onkeypress="return isNumberKey(event)"
                           onchange="calcularIva()"
                           required >
                    <div id="monto-retro"></div>
                </div> 
            </div>
                   
            <div class="row form-group" >
                <div class="col-3">
                    <label for="apellido">IVA 10%:</label> 
                </div>
                <div class="col-6">
                    <input form="agregarFactura"
                           name="iva"
                           id="iva"
                           class="form-control"
                           type="number" 
                           readonly
                           required >
                    <div id="apellido-retro"></div>
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-4">
                </div>
                <div class="col-2">
                    <input id="generarFact"
                           type="button"
                           value="Generar Factura"
                           onclick="generarFactura()">
                </div> 
                <div class="col-2">
                    <input id="agregar"
                           type="button"
                           value="Guardar"
                           onclick="guardarFactura()">
                </div> 
            </div>
       
        </div>
        <br>
        <script>
            function calcularIva(){
                var monto = document.getElementById("monto");
                
                if(monto != null){
                    document.getElementById("iva").value = Math.round(monto.value/11);
                }else{
                    document.getElementById("iva").value = 0;
                }
            }
            function generarFactura(){
               var formularioValido =  validarFormulario();
               
               if(formularioValido){
                   
                   document.getElementById("agregarFactura").setAttribute("action","<%=request.getContextPath()%>/Factura.jsp");         
                   document.getElementById("agregarFactura").submit();
               }
            }
            
            function guardarFactura(){
               var formularioValido =  validarFormulario();
               
               if(formularioValido){
                   document.getElementById("agregarFactura").setAttribute("action","<%=request.getContextPath()%>/FacturaServlet?agregar");    
                   document.getElementById("agregarFactura").submit();
               }
            }
            
            function validarFormulario(){
                
                var rucValido = validarRuc();
                var nombreValido = validarNombre();
                var direccionValido = validarDireccion();
                var telefonoValido = validarTelefono();
                var descripcionValido = validarDescripcion();
                var montoValido = validarMonto();
                var bancoValido = validarBanco();
                var nroFormaPago = validarNroFormaPago();
                
                
                if(rucValido && 
                        nombreValido  && 
                        direccionValido && 
                        telefonoValido && 
                        descripcionValido &&
                        montoValido &&
                        bancoValido &&
                        nroFormaPago){
                   
                   return true;
                }
                
                return false;
            }
            
            //Llenar los campos del cliente
            function rellenarCliente(){

                var idClienteInput = document.getElementById("idCliente");
                
                var rucInput = document.getElementById("ruc");
                var retroRuc = document.getElementById("ruc-retro");
                var strRuc = rucInput.value.trim();
                
                var nombreInput = document.getElementById("nombre");
                var direccionInput = document.getElementById("direccion");
                var telefonoInput = document.getElementById("telefono");
                
                nombreInput.value = "";
                direccionInput.value = "";
                telefonoInput.value = "";

                var xmlHttp = new XMLHttpRequest();
                xmlHttp.open("GET",
                "<%=request.getContextPath()%>/ClienteServlet?rellenarCliente=true&nroRuc="+strRuc, 
                true);

                xmlHttp.onreadystatechange=function(){

                   if (xmlHttp.readyState == 4 && xmlHttp.status == 200) {

                        clearTimeout(xmlHttpTimeout); 

                        var objetoJSON = JSON.parse(this.responseText);
                        var valido = objetoJSON.valido;
                        var cliente = objetoJSON.cliente;
                        var telefono = objetoJSON.telefono;
                        var direccion = objetoJSON.direccion;
                        var idCliente = objetoJSON.idCliente;

                        if(valido == false){

                            rucInput.setAttribute("class","form-control is-invalid");
                            retroRuc.setAttribute("class","invalid-feedback");
                            retroRuc.textContent = '¡Ocurrió un error! El R.U.C. no existe o esta inhabilitado';

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");
                            document.getElementById("generarFact").removeAttribute("disabled");
                            document.getElementById("buscar").removeAttribute("disabled");
                            
                            nombreInput.value = "";
                            direccionInput.value = "";
                            telefonoInput.value = "";

                        } else if(valido == true){

                            rucInput.setAttribute("class","form-control is-valid");
                            retroRuc.setAttribute("class","valid-feedback");
                            retroRuc.textContent = 'Datos del Cliente';
                            
                            nombreInput.value = cliente;
                            direccionInput.value = direccion;
                            telefonoInput.value = telefono;
                            idClienteInput.value= idCliente;
                            

                            //se desbloquea boton agregar
                            document.getElementById("agregar").removeAttribute("disabled");
                            document.getElementById("generarFact").removeAttribute("disabled");
                            document.getElementById("buscar").removeAttribute("disabled");

                        }

                    }
                };

                //bloquear boton agregar
                document.getElementById("agregar").setAttribute("disabled","");
                document.getElementById("generarFact").setAttribute("disabled","");
                document.getElementById("buscar").setAttribute("disabled","");
                xmlHttp.send();

                // Timeout para abortar despues 5 segundos
                var xmlHttpTimeout=setTimeout(ajaxTimeout,5000);
                function ajaxTimeout(){
                    xmlHttp.abort();

                    rucInput.setAttribute("class","form-control is-invalid");
                    retroRuc.setAttribute("class","invalid-feedback");
                    retroRuc.textContent = 'No se pudo conectar al servidor. \n Intente más tarde';

                    nombreInput.value = "";
                    direccionInput.value = "";
                    telefonoInput.value = "";   
                    
                    // Se desbloque boton agregar
                    document.getElementById("agregar").removeAttribute("disabled");
                    document.getElementById("generarFact").removeAttribute("disabled");
                    document.getElementById("buscar").removeAttribute("disabled");
                }

            }
            
            function validarNombre(){
                var nombreInput = document.getElementById("nombre");
                //var retroNombre = document.getElementById("nombre-retro");
                var strNombre = nombreInput.value.trim();
                
                nombreInput.value = strNombre;
                
                if(strNombre.length == 0){ 
                    nombreInput.setAttribute("class","form-control is-invalid");
                   // retroNombre.setAttribute("class","invalid-feedback");
                    //retroNombre.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                nombreInput.setAttribute("class","form-control is-valid");
                //retroNombre.setAttribute("class","valid-feedback");
                //retroNombre.textContent = '';
                    
                return true;
            }
            
            
            
            function validarBanco(){
                var bancoInput = document.getElementById("banco");
                var retroBanco = document.getElementById("banco-retro");
                var strBanco = bancoInput.value.trim();
                
                bancoInput.value = strBanco;
                
                if(strBanco.length == 0){ 
                    bancoInput.setAttribute("class","form-control is-invalid");
                    retroBanco.setAttribute("class","invalid-feedback");
                    retroBanco.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                bancoInput.setAttribute("class","form-control is-valid");
                retroBanco.setAttribute("class","valid-feedback");
                retroBanco.textContent = '';
                    
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
            
            function validarMonto(){
                var montoInput = document.getElementById("monto");
                var retroMonto = document.getElementById("monto-retro");
                //var strMonto = montoInput.value.trim();
                
                //direccionInput.value = strDireccion;
                
                if(!montoInput.validity.valid){ 
                    montoInput.setAttribute("class","form-control is-invalid");
                    retroMonto.setAttribute("class","invalid-feedback");
                    retroMonto.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                montoInput.setAttribute("class","form-control is-valid");
                retroMonto.setAttribute("class","valid-feedback");
                retroMonto.textContent = '';
                    
                return true;
            }
            
            function validarNroFormaPago(){
                var numeroInput = document.getElementById("nroFormaPago");
                var retroNumero = document.getElementById("nroFormaPago-retro");
                //var strMonto = montoInput.value.trim();
                
                //direccionInput.value = strDireccion;
                
                if(!numeroInput.validity.valid){ 
                    numeroInput.setAttribute("class","form-control is-invalid");
                    retroNumero.setAttribute("class","invalid-feedback");
                    retroNumero.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                numeroInput.setAttribute("class","form-control is-valid");
                retroNumero.setAttribute("class","valid-feedback");
                retroNumero.textContent = '';
                    
                return true;
            }
            
            
            function validarTelefono(){
                var telefonoInput = document.getElementById("telefono");
                //var retroTelefono = document.getElementById("telefono-retro");
                var strTelefono = telefonoInput.value.trim();
                
                telefonoInput.value = strTelefono;
                
                if(strTelefono.length == 0){ 
                    telefonoInput.setAttribute("class","form-control is-invalid");
                   // retroTelefono.setAttribute("class","invalid-feedback");
                   // retroTelefono.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                telefonoInput.setAttribute("class","form-control is-valid");
               // retroTelefono.setAttribute("class","valid-feedback");
                //retroTelefono.textContent = '';
                    
                return true;
            }
            
            function validarDireccion(){
                var direccionInput = document.getElementById("direccion");
                //var retroTelefono = document.getElementById("telefono-retro");
                var strDireccion = direccionInput.value.trim();
                
                //direccionInput.value = strTelefono;
                
                if(strDireccion.length == 0){ 
                    direccionInput.setAttribute("class","form-control is-invalid");
                   // retroTelefono.setAttribute("class","invalid-feedback");
                   // retroTelefono.textContent = 'El campo esta vacío';
                    
                    return false;
                }
                
                direccionInput.setAttribute("class","form-control is-valid");
               // retroTelefono.setAttribute("class","valid-feedback");
                //retroTelefono.textContent = '';
                    
                return true;
            }
            
            //Permite unicamente la insercion de numeros
            function isNumberKey(evt){
                var charCode = (evt.which) ? evt.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                    return false;
                return true;
            }
            
           
            function validarRuc(){
                var rucInput = document.getElementById("ruc");
                var retroRuc = document.getElementById("ruc-retro");
                var strRuc = rucInput.value.trim();
                
                rucInput.value = strRuc;
                
                //var tipoPersona = document.getElementById("tipoCliente").value;
                
                //if(strRuc.length == 0 && tipoPersona == "J"){
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
            
           
            
            
        </script>
    </body>
</html>