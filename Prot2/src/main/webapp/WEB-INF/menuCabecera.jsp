
<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<% Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
   
   Integer rolUsuarioConectado = usuario.getIdRol().getIdRol();
   PermisoJpaController permisoControlAcceso = new PermisoJpaController();
%>
<div class="container-fluid">
    <br>
    <div class="row">
        <div class="col-10"></div>
        <div class="col">
            <div class="text-center">
                <i class="fa fa-user-circle"></i>
                <% if (usuario != null) {%>

                <p> <%= usuario.getCuenta()%>

                    <br>
                    <a href="<%=request.getContextPath()%>/LoginServlet?desconectar=true">Salir</a>
                </p>
                <%}%>
            </div>
        </div>
    </div>

    <div class="row ">
        <div class="col" id="linea1" ></div>
        <div class="col-9" id="linea2">
            <ul class="nav nav-tabs" >
                <li class="nav-item" >
                    <a class="nav-link" href="<%=request.getContextPath()%>/menu.jsp"><i class="fa fa-home"></i></a>
                </li>
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"marcas.jsp")){%> 
                    <li class="nav-item" >
                        <a class="nav-link" href="<%=request.getContextPath()%>/marcas.jsp">Marcas</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"expedientes.jsp")){%>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/expedientes.jsp">Expedientes</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"abogados.jsp")){%>  
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/abogados.jsp">Agentes</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"clientes.jsp")){%>  
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/clientes.jsp">Titulares</a>
                    </li>
                <%}%>    
                    
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"configuraciones.jsp")){%> 
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/configuraciones.jsp">Configuraciones</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"oposicionesHechas.jsp")){%>
                    <li class="nav-item">
                        <a class="nav-link" href="<%=request.getContextPath()%>/oposicionesHechas.jsp">Oposiciones</a>
                    </li>
                <%}%>
            </ul>
        </div>
    </div>
</div>