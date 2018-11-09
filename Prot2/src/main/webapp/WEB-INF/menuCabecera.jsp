
<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modelo.Rol"%>
<%@page import="modelo.Usuario"%>
<link href="<%=request.getContextPath()%>/css/menu.css" rel="stylesheet">
<style>
        .badge {
          padding: 1px 9px 2px;
          font-size: 12.025px;
          font-weight: bold;
          white-space: nowrap;
          color: #ffffff;
          background-color: #999999;
          -webkit-border-radius: 9px;
          -moz-border-radius: 9px;
          border-radius: 9px;
        }
        .badge:hover {
          color: #ffffff;
          text-decoration: none;
          cursor: pointer;
        }
        .badge-error {
          background-color: #b94a48;
        }
        .badge-error:hover {
          background-color: #953b39;
        }
        .badge-warning {
          background-color: #f89406;
        }
        .badge-warning:hover {
          background-color: #c67605;
        }
        .badge-success {
          background-color: #468847;
        }
        .badge-success:hover {
          background-color: #356635;
        }
        .badge-info {
          background-color: #3a87ad;
        }
        .badge-info:hover {
          background-color: #2d6987;
        }
        .badge-inverse {
          background-color: #333333;
        }
        .badge-inverse:hover {
          background-color: #1a1a1a;
        }
</style>
<% Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
   
   Integer rolUsuarioConectado = usuario.getIdRol().getIdRol();
   PermisoJpaController permisoControlAcceso = new PermisoJpaController();
   
   //Notificacion
   String bagdeNotificacion  ="badge ";
   String valorNotificacion ="";
   if(request.getSession().getAttribute("alta") != null){
       bagdeNotificacion  = bagdeNotificacion  + "badge-error";
       valorNotificacion  = (Integer) request.getSession().getAttribute("alta")+"";
      
   }else if(request.getSession().getAttribute("media") != null){
       bagdeNotificacion  = bagdeNotificacion  + "badge-warning";
       valorNotificacion  = (Integer) request.getSession().getAttribute("media")+"";
       
   }else if(request.getSession().getAttribute("baja") != null){
       bagdeNotificacion  = bagdeNotificacion  + "badge-success";
       valorNotificacion  = (Integer) request.getSession().getAttribute("baja")+"";
       
   }
   //------------------------------------------------------
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
        <div class="col-2" id="linea1" ></div>
        <div class="col" id="linea2">
            <ul class="nav nav-tabs" id="pestana">
                <li class="nav-item" id="pestanaItem" >
                    <a class="nav-link" href="<%=request.getContextPath()%>/menu.jsp"><i class="fa fa-home"></i></a>
                </li>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"notificaciones.jsp")){%> 
                   <li class="nav-item" id="pestanaItem">
                       <a class="nav-link" href="<%=request.getContextPath()%>/notificaciones.jsp">
                           Notificaciones <span class="<%=bagdeNotificacion %>"><%=valorNotificacion %></span>
                        </a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"marcas.jsp")){%> 
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/marcas.jsp">Marcas</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"expedientes.jsp")){%>
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/expedientes.jsp">Expedientes</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"abogados.jsp")){%>  
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/abogados.jsp">Agentes</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"clientes.jsp")){%>  
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/clientes.jsp">Titulares</a>
                    </li>
                <%}%>    
                    
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"configuraciones.jsp")){%> 
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/configuraciones.jsp">Configuraciones</a>
                    </li>
                <%}%>
                
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"oposicionesHechas.jsp")){%>
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/oposicionesHechas.jsp">Oposiciones</a>
                    </li>
                <%}%>
                <%if(permisoControlAcceso.permisoRolVentana(rolUsuarioConectado,"facturaciones.jsp")){%>
                    <li class="nav-item" id="pestanaItem">
                        <a class="nav-link" href="<%=request.getContextPath()%>/facturaciones.jsp">Facturaciones</a>
                    </li>
                <%}%>
            </ul>
        </div>
    </div>
</div>