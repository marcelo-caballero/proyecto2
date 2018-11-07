<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuarioExp = (Usuario) request.getSession().getAttribute("usuario");
   Integer rolUsuarioConectadoExp = usuarioExp.getIdRol().getIdRol();  
   PermisoJpaController permisoControlAccesoExp = new PermisoJpaController();
%>

<ul class="nav nav-tabs" >
    <li class="nav-item">
        <a class="nav-link" 
           href="<%=request.getContextPath()%>/expedientes/verExpediente.jsp"> 
            Detalles</a>
    </li>

    <%if (permisoControlAccesoExp.permisoRolVentana(rolUsuarioConectadoExp,"documentos.jsp")){%>
    <li class="nav-item">
        <a class="nav-link" 
           href="<%=request.getContextPath()%>/documentos.jsp">
            Documentos</a>
    </li>
    <%}%>
    <%if (permisoControlAccesoExp.permisoRolVentana(rolUsuarioConectadoExp,"eventos.jsp")){%>
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/eventos.jsp">
            Eventos</a>
    </li>
    <%}%>
    
    <%if (permisoControlAccesoExp.permisoRolVentana(rolUsuarioConectadoExp,"oposicionesRecibidas.jsp")){%>
    <li class="nav-item">
        <a class="nav-link" href="<%=request.getContextPath()%>/oposicionesRecibidas.jsp">
            Oposiciones</a>
    </li>
    <%}%>
</ul> 