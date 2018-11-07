<%-- 
    Document   : verDocumentoOposicionHecha
    Created on : 06-nov-2018, 1:16:24
    Author     : User
--%>
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
    <body>
        <%
            //Integer idExp = (Integer) (request.getSession().getAttribute("idExpediente"));

            Integer idDoc = Integer.parseInt(request.getParameter("idDocumento"));
            DocumentoOposicionHecha documento = new DocumentoOposicionHechaJpaController().findDocumentoOposicionHecha(idDoc);

            TipoDocumentoOposicionHechaJpaController tipoDocControl = new TipoDocumentoOposicionHechaJpaController();
            List<TipoDocumentoOposicionHecha> listaTipoDoc = tipoDocControl.findTipoDocumentoOposicionHechaEntities();
            
            String direccionDoc = request.getContextPath(); 
            direccionDoc+= "/obtenerDocumentoOposicionHecha/"+
                            documento.getNombre()+
                            ".pdf?idDocumento="+idDoc;

        %>

        <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <br>
        
        <div class="container">
            <%@include file="//WEB-INF/menuOposicionesHechas.jsp" %>       
        </div>
        
        <div class="container form-control">
            <h2 class="text-justify">Documento</h2> 
            <br>
            
            <div class="row form-group">
                <div class="col-3">
                    <label>Número de Expediente Opositado:</label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getIdOposicionHecha().getNroExpedienteOpositado()%>
                </div>
            </div>

            <div class="row form-group">    
                <div class="col-3">
                    <label>Nombre del documento:</label></div>
                <div class="col-6 form-control">
                    <%=documento.getNombre()%> 
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Fecha: </label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getStringFecha()%>  
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Tipo de Documento:</label>
                </div>
                <div class="col-6">
                    <div class=" row">
                        <div class="col-2 form-control">
                            <%=documento.getIdTipoDocumentoOposicionHecha().getIdTipoDocumento()%>
                        </div>
                        
                        <div class="col-1"></div>
                        
                        <div class="col form-control">
                            <%=documento.getIdTipoDocumentoOposicionHecha().getDescripcion()%> 
                        </div>
                    </div>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Folio: </label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getFolioDesde()%> - <%=documento.getFolioHasta()%>
                </div>
            </div>
                
            <div class="row form-group">
                <div class="col-3">
                    <label>Descripción: </label>
                </div>
                <div class="col-6 form-control">
                    <%=documento.getDescripcion()%>
                </div>
            </div>

            <div class="row form-group">
                <div class="col-3">
                    <label>Documento: </label>
                </div>
                <div class="col-6">
                    <button class="btn btn-primary"
                            onclick="window.open('<%=direccionDoc%>')"> 
                            Leer
                    </button>
                </div>
            </div>
        </div>
        <br>
    </body>
</html>
