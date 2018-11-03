<%-- 
    Document   : verOposicionRecibida
    Created on : 22-oct-2018, 16:49:58
    Author     : User
--%>


<%@page import="java.text.SimpleDateFormat"%>
<%@page import="modelo.OposicionRecibida"%>
<%@page import="modeloMng.OposicionRecibidaJpaController"%>
<%@page import="modeloMng.ExpedienteJpaController"%>
<%@page import="modelo.Expediente"%>
<html>
    <head>
        <title>Oposici�n - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body >
        <%
            Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));
            Integer idOposicion = Integer.parseInt(request.getParameter("idOposicion"));
            
            
            OposicionRecibidaJpaController oposicionRecibidaControl = new OposicionRecibidaJpaController();
            OposicionRecibida oposicion = oposicionRecibidaControl.findOposicionRecibida(idOposicion);  
            
            //Expediente exp = new ExpedienteJpaController().findExpediente(idExp);
           
            
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        <div class="container">
           <%@include file="//WEB-INF/menuExpediente.jsp" %>     
        </div>
        <div class="container form-control">
            <h2 class="text-justify">Ver Oposici�n</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>N�mero de expediente:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdExpediente().getNroExpediente()%>
                </div>
            </div>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>N�mero de expediente de la marca base de Oposici�n:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getNroExpediente()%>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Agente opositor:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getAgente()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Marca base de Oposici�n:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getMarca()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Clase de la marca base de Oposici�n:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getClase()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Titular opositor:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getTitular()%> 
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha del Estado de Oposici�n:</label>
                </div>
                <div class="col-6 form-control">
                    <%=new SimpleDateFormat("dd/MM/yyyy").format(oposicion.getFechaEstado())%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Estado actual de la Oposici�n:</label>
                </div>
                <div class="col-6 form-control">
                    <%=oposicion.getIdEstado().getDescripcion()%>  
                </div>
            </div>
        </div>  
        <br>
    </body>
</html>
