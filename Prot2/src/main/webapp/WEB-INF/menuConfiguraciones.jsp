<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuarioConfiguracion = (Usuario) request.getSession().getAttribute("usuario");
   Integer rolUsuarioConectadoConfiguracion= usuarioConfiguracion.getIdRol().getIdRol();  
   PermisoJpaController permisoControlAccesoConfiguracion = new PermisoJpaController();
%>
<ul class="nav nav-tabs" >
    <%if(permisoControlAccesoConfiguracion.permisoRolVentana(rolUsuarioConectadoConfiguracion,"usuarios.jsp")){%> 
        <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/usuarios.jsp">Usuarios</a>
        </li>
    <%}%>

    <%if(permisoControlAccesoConfiguracion.permisoRolVentana(rolUsuarioConectadoConfiguracion,"roles.jsp")){%> 
        <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/roles.jsp">Roles</a>
        </li>
    <%}%>

    <%if(permisoControlAccesoConfiguracion.permisoRolVentana(rolUsuarioConectadoConfiguracion,"permisos.jsp")){%>
        <li class="nav-item">
            <a class="nav-link" href="<%=request.getContextPath()%>/permisos.jsp">Permisos</a>
        </li>
    <%}%>

    
</ul> 
