<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuarioFac = (Usuario) request.getSession().getAttribute("usuario");
   Integer rolUsuarioConectadoFac = usuarioFac.getIdRol().getIdRol();  
   PermisoJpaController permisoControlAccesoFac = new PermisoJpaController();
%>

<ul class="nav nav-tabs" >
    <%if (permisoControlAccesoFac.permisoRolVentana(rolUsuarioConectadoFac,"prefijos.jsp")){%>
    <li class="nav-item" id="pestanaItem">
        <a class="nav-link" href="<%=request.getContextPath()%>/prefijos.jsp">
            Datos de Factura</a>
    </li>
    <%}%>
    <%if (permisoControlAccesoFac.permisoRolVentana(rolUsuarioConectadoFac,"facturas.jsp")){%>
    <li class="nav-item" id="pestanaItem">
        <a class="nav-link" href="<%=request.getContextPath()%>/facturas.jsp">
            Facturas</a>
    </li>
    <%}%>
    
</ul> 
