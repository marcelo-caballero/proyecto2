<%-- 
    Document   : verRol
    Created on : 19-sep-2018, 2:46:18
    Author     : Acer
--%>

<%@page import="modeloMng.RolJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Rol"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Rol - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%
            Integer idRol = Integer.parseInt(request.getParameter("idRol"));
            Rol rol = new RolJpaController().findRol(idRol); 
            
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuConfiguraciones.jsp" %>     
        </div>
        
        <div class ="container form-control">
        
            <h2 class="text-justify"> Ver Rol</h2>
            <br> 
       
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Rol:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=rol.getRol()%> 
                </div> 
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Descripción:</label> 
                </div>
                <div class="col-6 form-control">
                   <%=rol.getDescripcion()%>
                </div>  
            </div>
  
            <div class="row form-group">
                <div class="col-3">
                    <label for="rol">Estado:</label> 
                </div>
                <div class="col-6 form-control">
                    <%=rol.getEstado().substring(0,1)+rol.getEstado().substring(1).toLowerCase()%> 
                </div> 
            </div>
                
        </div>
        <br>
    </body>
</html>
    