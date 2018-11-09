<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuarioOH = (Usuario) request.getSession().getAttribute("usuario");
   Integer rolUsuarioConectadoOH = usuarioOH.getIdRol().getIdRol();  
   PermisoJpaController permisoControlAccesoOH = new PermisoJpaController();
%>

<ul class="nav nav-tabs" >
    <li class="nav-item" id="pestanaItem">
        <a class="nav-link" 
           href="<%=request.getContextPath()%>/oposicionHecha/verOposicionHecha.jsp"> 
            Detalles</a>
    </li>

     <%if (permisoControlAccesoOH.permisoRolVentana(rolUsuarioConectadoOH,"eventosOposicionesHechas.jsp")){%>
    <li class="nav-item" id="pestanaItem">
        <a class="nav-link" href="<%=request.getContextPath()%>/eventosOposicionesHechas.jsp">
            Eventos</a>
    </li>
    <%}%>
    
    <%if (permisoControlAccesoOH.permisoRolVentana(rolUsuarioConectadoOH,"documentosOposicionesHechas.jsp")){%>
    <li class="nav-item" id="pestanaItem">
        <a class="nav-link" 
           href="<%=request.getContextPath()%>/documentosOposicionesHechas.jsp">
            Documentos</a>
    </li>
    <%}%>
   
    
</ul> 
