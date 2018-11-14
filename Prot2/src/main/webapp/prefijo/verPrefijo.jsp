<%-- 
    Document   : verRol
    Created on : 19-sep-2018, 2:46:18
    Author     : Acer
--%>

<%@page import="modeloMng.PrefijoJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Prefijo"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Factura- Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer id = Integer.parseInt(request.getParameter("idPrefijo"));
            Prefijo prefijo = new PrefijoJpaController().findPrefijo(id);  
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuFacturacion.jsp" %>     
        </div>
        <div class ="container form-control">
        
            <h2 class="text-justify"> Datos de la Factura</h2>
            <br> 
       
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">R.U.C.:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=prefijo.getRuc()%> 
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Número de Timbrado:</label> 
                </div>
                <div class="col-6 form-control">
                   <%=prefijo.getTimbrado()%> 
                </div>  
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Prefijo:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=prefijo.getPrefijo()%>
                </div>  
            </div>
  
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Válido hasta:</label> 
                </div>
                <div class="col-6 form-control">
                   <%=prefijo.getStringFecha()%> 
                </div>  
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Número de factura inicial:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=prefijo.getInicio()%>  
                </div>  
            </div>
               
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Número de factura final:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=prefijo.getFin()%>    
                </div>  
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Próximo número a utilizar:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=prefijo.getProximo()%>  
                </div>  
            </div>
                
        </div>
        <br>
    </body>
</html>
    