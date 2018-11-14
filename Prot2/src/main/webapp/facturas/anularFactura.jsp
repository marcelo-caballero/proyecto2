<%-- 
    Document   : anularFactura
    Created on : 14-nov-2018, 10:03:24
    Author     : User
--%>

<%@page import="java.math.BigInteger"%>
<%@page import="modeloMng.FacturaCabeceraJpaController"%>
<%@page import="modelo.FacturaCabecera"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
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
            Integer idFactura = Integer.parseInt(request.getParameter("idFactura"));
            FacturaCabecera factura = new FacturaCabeceraJpaController().findFacturaCabecera(idFactura);
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuFacturacion.jsp" %>     
        </div>
        
        <div class ="container form-control">
        
            <h2 class="text-justify">Anular Factura</h2>
            <br>
            <%if(factura.getEstado().equals("Anulado")){%>   
                <div class="alert alert-info alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>¡Información! </strong>La factura está anulada
                </div>
            <%}%>
            <br> 
        
            <form id="anularFactura" 
                  action="<%=request.getContextPath()%>/FacturaServlet?anular=true" 
                  method="post" 
                  novalidate>
                <input type="hidden" name="idFactura" value="<%=idFactura%>" >
            </form>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="ruc">R.U.C.:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="ruc"
                           id=""
                           class="form-control"
                           type="text" 
                           value="<%=factura.getIdCliente().getRuc()%>"   
                           >
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="cliente">Cliente:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="cliente"
                           id=""
                           class="form-control"
                           type="text" 
                           value="<%=factura.getIdCliente().getNombreCliente()%>"
                            >
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="direccion">Dirección:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="direccion"
                           id=""
                           class="form-control"
                           type="text" 
                           value="<%=factura.getIdCliente().getDireccion()%>"
                            >
                </div> 
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="telefono">Teléfono:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="telefono"
                           id=""
                           class="form-control"
                           type="text" 
                           value="<%=factura.getIdCliente().getTelefono()%>" 
                            >
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="">Fecha: </label>
                </div>
                <div class="col-6">
                    <input form=""
                           name="fecha"
                           id=""
                           class="form-control"
                           type="date"
                           value="<%=new SimpleDateFormat("yyyy-MM-dd").format(factura.getFecha())%>"
                           > 
                </div>
            </div>
                           
            <div class="row form-group">
                <div class="col-3">
                    <label id="label"for="numFact">Número de Factura:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="numFact"
                           id=""
                           class="form-control"
                           type="number"
                           value="<%=factura.getNumeroFactura()%>" 
                           >
                </div> 
            </div>
                  
            
            <div class="row form-group">
                <div class="col-3">
                    <label for="cond_venta">Condición de Venta:</label>
                </div>  
                <div class="col-6">
                    <input form="" 
                            name="cond_venta" 
                            id="" 
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
                    <input form="" 
                            name="forma_pago" 
                            id="" 
                            class="form-control"
                            value="<%=factura.getFormaPago()%>" 
                            >
                </div> 
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Banco: </label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="banco"
                           id=""
                           class="form-control"
                           type="text" 
                           value="<%=factura.getBanco()%>"
                           >
                    <div id="banco-retro"></div>
                </div> 
            </div>
                           
           <%if(factura.getFormaPago().equals("Cheque")){%>
                
                <div class="row form-group">
                    <div class="col-3">
                        <label for="nroFormaPago">Nº de Cheque:</label> 
                    </div>
                    <div class="col-6">
                        <input form=""
                               name="nroFormaPago"
                               id=""
                               class="form-control"
                               type="number" 
                               value="<%=factura.getNumeroCheque()%>"  
                                >
                        
                    </div> 
                </div>
           <%}else{%>
                <div class="row form-group">
                    <div class="col-3">
                        <label for="nroFormaPago">Nº de cuenta Bancaria:</label> 
                    </div>
                    <div class="col-6">
                        <input form=""
                               name="nroFormaPago"
                               id=""
                               class="form-control"
                               type="number" 
                               value="<%=factura.getNumeroCuenta()%>"   
                                >
                        
                    </div> 
                </div>
                <div class="row form-group">
                    <div class="col-3">
                        <label for="nroFormaPago">Nº de transacción:</label> 
                    </div>
                    <div class="col-6">
                        <input form=""
                               name="nroFormaPago"
                               id=""
                               class="form-control"
                               type="number" 
                               value="<%=factura.getNumeroTransaccionTransferenciaBancaria()%>"   
                                >
                    </div> 
                </div>
           <%}%>
           
                    
            <div class="row form-group">
                <div class="col-3">
                    <label for="descripcion">Descripción: </label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="descripcion"
                           id=""
                           class="form-control"
                           type="text" 
                           value="<%=factura.getFacturaDetalleList().get(0).getDescripcion()%>" 
                            >
                </div> 
            </div>
                  
            <div class="row form-group" >
                <div class="col-3">
                    <label for="monto">Monto en Gs.:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="monto"
                           id=""
                           class="form-control"
                           type="number" 
                           value="<%=factura.getFacturaDetalleList().get(0).getMonto()%>"
                           >
                </div> 
            </div>
                    
            <div class="row form-group" >
                <div class="col-3">
                    <label for="cantidad">Cantidad:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="cantidad"
                           id=""
                           class="form-control"
                           value="<%=factura.getFacturaDetalleList().get(0).getCantidad()%>"
                           >
                </div> 
            </div>
                   
            <div class="row form-group" >
                <div class="col-3">
                    <label for="iva">IVA 10%:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name="iva"
                           id=""
                           class="form-control"
                           type="number" 
                           value="<%=factura.getFacturaDetalleList().get(0).getIva()%>"
                           >
                </div> 
            </div>
                    
            <div class="row form-group" >
                <div class="col-3">
                    <label for="">Total:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name=""
                           id=""
                           class="form-control"
                           value="<%= factura.getFacturaDetalleList().get(0).getTotal()%>"   
                           >
                </div> 
            </div>
                          
            <div class="row form-group" >
                <div class="col-3">
                    <label for="">Estado:</label> 
                </div>
                <div class="col-6">
                    <input form=""
                           name=""
                           id=""
                           class="form-control"
                           value="<%= factura.getEstado()%>"   
                           >
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-5">
                </div>
     
                <div class="col-2">
                    <input id="agregar"
                           type="submit"
                           value="Anular Factura"
                           <%if(!factura.getEstado().equals("Anulado")){%>
                                form="anularFactura"
                           <%}%>
                    >
                </div> 
            </div>
       
        </div>
        <br>
        
    </body>
</html>