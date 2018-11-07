<%-- 
    Document   : verEventoOposicionHecha
    Created on : 05-nov-2018, 22:42:25
    Author     : User
--%>

<%@page import="java.util.List"%>
<%@page import="modelo.EventoOposicionHecha"%>
<%@page import="modeloMng.EventoOposicionHechaJpaController"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Evento - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body>
        <%

            Integer idEvento = Integer.parseInt(request.getParameter("idEvento"));
            EventoOposicionHecha evento = new EventoOposicionHechaJpaController().findEventoOposicionHecha(idEvento);  
            
        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>

        <div class="container">
            <%@include file="//WEB-INF/menuOposicionesHechas.jsp" %>     
        </div>

        <div class="container form-control">
            <h2 class="text-justify">Evento</h2> 
            <br>

            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente Opositado:</label>
                </div>
                <div class="col-6 form-control" id="nroExp">
                    <%=evento.getIdOposicionHecha().getNroExpedienteOpositado()%>   
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label>Nombre del Evento:</label>
                </div>
                <div class="col-6 form-control" id="nombre">
                    <%=evento.getNombre()%>  
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Programado para: </label>
                </div>
                <div class="col-6 form-control" id="fecha">
                    <%=evento.getStringFecha()%> <label> a las </label> <%=evento.getStringHora()%>:<%=evento.getStringMinuto()%> 
                </div>
            </div>
           
            <div class="row form-group">
                <div class="col-3">
                    <label>Prioridad: </label>
                </div>
                <div class="col-6 form-control" id="fecha">
                    <%=evento.getPrioridad()%>   
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Descripción:</label>
                </div>
                <div class="col-6 form-control" id="descripcion">
                    <%=evento.getDescripcion()%>
                </div>
            </div>
        </div>
        <br>
    </body>
</html>
