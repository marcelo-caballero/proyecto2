<%-- 
    Document   : editarPermiso
    Created on : 14-sep-2018, 0:29:19
    Author     : Acer
--%>
<%@page import="modeloMng.PermisoJpaController"%>
<%@page import="modeloMng.VentanaJpaController"%> 
<%@page import="java.util.List"%>
<%@page import="modelo.Permiso"%> 
<%@page import="modelo.Ventana"%>  
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>
        <title>Permiso - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
    </head>
    <body onload="inicial()">
        <%
            Integer idRol = Integer.parseInt(request.getParameter("idRol"));
            PermisoJpaController permisoControl = new PermisoJpaController();
        %>
        <%@include file="//WEB-INF/menuCabecera.jsp"%>
        <br>
        
        <div class="container">
           <%@include file="//WEB-INF/menuConfiguraciones.jsp" %>     
        </div>
        
        <div class ="container form-control">
        
            <h2 class="text-justify">Editar Permiso</h2>
            <br> 
        
            <form id="editarPermiso" 
                  action="<%=request.getContextPath()%>/PermisoServlet?editar=true" 
                  method="post">
                <input type="hidden" name="idRol" value="<%=idRol%>">
            </form>
            
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="notificacion"
                               type="checkbox"
                               value="70"
                               <%if(permisoControl.permisoRolVentana(idRol,"notificaciones.jsp")){%> 
                                  checked
                               <%}%>
                               
                               >Notificaciones
                </div>
            </div>
                               
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuMarca"
                               type="checkbox"
                               value="1"
                               <%if(permisoControl.permisoRolVentana(idRol,"marcas.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuMarcas()"
                               >Menú Marca
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarMarca"
                               type="checkbox"
                               value="2"
                               <%if(permisoControl.permisoRolVentana(idRol,"agregarMarca.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verMarca"
                               type="checkbox"
                               value="3"
                               <%if(permisoControl.permisoRolVentana(idRol, "verMarca.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarMarca"
                               type="checkbox"
                               value="4"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarMarca.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarMarca"
                               type="checkbox"
                               value="5"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarMarca")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuExpediente"
                               type="checkbox"
                               value="6"
                               <%if(permisoControl.permisoRolVentana(idRol, "expedientes.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuExpediente()"
                               >Menú Expediente
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarExp"
                               type="checkbox"
                               value="7"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarExpediente.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verExp"
                               type="checkbox"
                               value="8"
                               <%if(permisoControl.permisoRolVentana(idRol, "verExpediente.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuVerExp()"
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarExp"
                               type="checkbox"
                               value="19"
                               <%if(permisoControl.permisoRolVentana(idRol,"editarExpediente.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarExp"
                               type="checkbox"
                               value="20"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarExpediente")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuDocumento"
                               type="checkbox"
                               value="9"
                               <%if(permisoControl.permisoRolVentana(idRol, "documentos.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuDocumento()"
                               >Menú Documento
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarDoc"
                               type="checkbox"
                               value="10"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarDocumento.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verDoc"
                               type="checkbox"
                               value="11"
                               <%if(permisoControl.permisoRolVentana(idRol,"verDocumento.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarDoc"
                               type="checkbox"
                               value="12"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarDocumento.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarDoc"
                               type="checkbox"
                               value="13"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarDocumento")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuEvento"
                               type="checkbox"
                               value="14"
                               <%if(permisoControl.permisoRolVentana(idRol, "eventos.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuEvento()"
                               >Menú Evento
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarEven"
                               type="checkbox"
                               value="15"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarEvento.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verEven"
                               type="checkbox"
                               value="16"
                               <%if(permisoControl.permisoRolVentana(idRol,"verEvento.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarEven"
                               type="checkbox"
                               value="17"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarEvento.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarEven"
                               type="checkbox"
                               value="18"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarEvento")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuOposicionRecibida"
                               type="checkbox"
                               value="44"
                               <%if(permisoControl.permisoRolVentana(idRol, "oposicionesRecibidas.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuOposicionRecibida()"
                               >Menú Oposiciones Recibidas
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarOposicionRecibida"
                               type="checkbox"
                               value="45"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarOposicionRecibida.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verOposicionRecibida"
                               type="checkbox"
                               value="46"
                               <%if(permisoControl.permisoRolVentana(idRol,"verOposicionRecibida.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarOposicionRecibida"
                               type="checkbox"
                               value="47"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarOposicionRecibida.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarOposicionRecibida"
                               type="checkbox"
                               value="48"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarOposicionRecibida")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                     
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuAgente"
                               type="checkbox"
                               value="21"
                               <%if(permisoControl.permisoRolVentana(idRol, "abogados.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuAgente()"
                               >Menú Agente
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarAgente"
                               type="checkbox"
                               value="22"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarAbogado.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verAgente"
                               type="checkbox"
                               value="23"
                               <%if(permisoControl.permisoRolVentana(idRol, "verAbogado.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarAgente"
                               type="checkbox"
                               value="24"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarAbogado.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarAgente"
                               type="checkbox"
                               value="25"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarAbogado")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuTitular"
                               type="checkbox"
                               value="26"
                               <%if(permisoControl.permisoRolVentana(idRol, "clientes.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuTitular()"
                               >Menú Titular
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarTitular"
                               type="checkbox"
                               value="27"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarCliente.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verTitular"
                               type="checkbox"
                               value="28"
                               <%if(permisoControl.permisoRolVentana(idRol,"verCliente.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarTitular"
                               type="checkbox"
                               value="29"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarCliente.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarTitular"
                               type="checkbox"
                               value="30"
                               <%if(permisoControl.permisoRolVentana(idRol,"eliminarCliente")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="configuraciones"
                               type="checkbox"
                               value="50"
                               <%if(permisoControl.permisoRolVentana(idRol,"configuraciones.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuConfiguraciones()" 
                               >Configuraciones
                </div>
            </div>
                               
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuUsuario"
                               type="checkbox"
                               value="31"
                               <%if(permisoControl.permisoRolVentana(idRol, "usuarios.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuUsuario()"
                               >Menú Usuario
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarUsuario"
                               type="checkbox"
                               value="32"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarUsuario.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verUsuario"
                               type="checkbox"
                               value="33"
                               <%if(permisoControl.permisoRolVentana(idRol, "verUsuario.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarUsuario"
                               type="checkbox"
                               value="34"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarUsuario.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarUsuario"
                               type="checkbox"
                               value="35"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarUsuario")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuRol"
                               type="checkbox"
                               value="36"
                               <%if(permisoControl.permisoRolVentana(idRol, "roles.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuRol()"
                               >Menú Rol
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarRol"
                               type="checkbox"
                               value="37"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarRol.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarRol"
                               type="checkbox"
                               value="38"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarRol.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarRol"
                               type="checkbox"
                               value="39"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarRol")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuPermiso"
                               type="checkbox"
                               value="40"
                               <%if(permisoControl.permisoRolVentana(idRol, "permisos.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuPermiso()"
                               >Menú Permiso
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarPermiso"
                               type="checkbox"
                               value="41"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarPermiso.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verPermiso"
                               type="checkbox"
                               value="42"
                               <%if(permisoControl.permisoRolVentana(idRol, "verPermiso.jsp")){%>  
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    
                </div>
            </div>
  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuOposicionHecha"
                               type="checkbox"
                               value="49"
                               <%if(permisoControl.permisoRolVentana(idRol, "oposicionesHechas.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuOposicionHecha()"
                               >Menú Oposiciones Hechas
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarOposicionHecha"
                               type="checkbox"
                               value="53"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verOposicionHecha"
                               type="checkbox"
                               value="54"
                               <%if(permisoControl.permisoRolVentana(idRol, "verOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuVerOposicionHecha()"
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarOposicionHecha"
                               type="checkbox"
                               value="55"
                               <%if(permisoControl.permisoRolVentana(idRol,"editarOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarOposicionHecha"
                               type="checkbox"
                               value="56"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarOposicionHecha")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuDocumentoOposicionHecha"
                               type="checkbox"
                               value="57"
                               <%if(permisoControl.permisoRolVentana(idRol, "documentosOposicionesHechas.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuDocumentoOposicionHecha()"
                               >Menú Documento Oposiciones Hechas
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarDocumentoOposicionHecha"
                               type="checkbox"
                               value="63"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarDocumentoOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verDocumentoOposicionHecha"
                               type="checkbox"
                               value="64"
                               <%if(permisoControl.permisoRolVentana(idRol,"verDocumentoOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarDocumentoOposicionHecha"
                               type="checkbox"
                               value="67"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarDocumentoOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarDocumentoOposicionHecha"
                               type="checkbox"
                               value="68"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarDocumentoOposicionHecha")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
                  
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuEventoOposicionHecha"
                               type="checkbox"
                               value="58"
                               <%if(permisoControl.permisoRolVentana(idRol, "eventosOposicionesHechas.jsp")){%> 
                                  checked
                               <%}%>
                               onclick="ocultarSubmenuEventoOposicionHecha()"
                               >Menú Evento Oposiciones Hechas
                </div>
                <div class="col-8 form-control">
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="agregarEventoOposicionHecha"
                               type="checkbox"
                               value="59"
                               <%if(permisoControl.permisoRolVentana(idRol, "agregarEventoOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Agregar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="verEventoOposicionHecha"
                               type="checkbox"
                               value="60"
                               <%if(permisoControl.permisoRolVentana(idRol,"verEventoOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Ver
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="editarEventoOposicionHecha"
                               type="checkbox"
                               value="61"
                               <%if(permisoControl.permisoRolVentana(idRol, "editarEventoOposicionHecha.jsp")){%> 
                                  checked
                               <%}%>
                               >Editar
                    </div>
                    <div class="col">
                        <input form="editarPermiso"
                               name="permiso"
                               id="eliminarEventoOposicionHecha"
                               type="checkbox"
                               value="62"
                               <%if(permisoControl.permisoRolVentana(idRol, "eliminarEventoOposicionHecha")){%> 
                                  checked
                               <%}%>
                               >Eliminar
                    </div>
                </div>
            </div>
            
            <div class="row form-group">
                <div class="col-3">
                    <input form="editarPermiso"
                               name="permiso"
                               id="menuFacturacion"
                               type="checkbox"
                               value="69"
                               <%if(permisoControl.permisoRolVentana(idRol,"facturaciones.jsp")){%> 
                                  checked
                               <%}%>
                               >Menú Facturación
                </div>
            </div>
                               
            <div class="row form-group">
                <div class="col-5">
                </div>
                <div class="col-2">
                    <input form="editarPermiso"
                           type="submit"
                           value="Guardar"
                          >
                </div>    
            </div>
       
        </div>
        <br>
        <script>
            function inicial(){
                
                ocultarSubmenuMarcas();
                ocultarSubmenuExpediente();
                ocultarSubmenuDocumento();
                ocultarSubmenuEvento();
                ocultarSubmenuAgente();
                ocultarSubmenuTitular();
                ocultarSubmenuUsuario();
                ocultarSubmenuRol();
                ocultarSubmenuPermiso();
                
                ocultarSubmenuDocumentoOposicionHecha();
                ocultarSubmenuEventoOposicionHecha();
                
                ocultarSubmenuConfiguraciones();
                
                ocultarSubmenuOposicionRecibida();
                
                ocultarSubmenuVerExp();
                
                
                ocultarSubmenuOposicionHecha();
                
                ocultarSubmenuVerOposicionHecha();
            }
            
            function ocultarSubmenuOposicionRecibida(){
                var checkInput = document.getElementById("menuOposicionRecibida");
                    
                if(checkInput.checked){
                    document.getElementById("agregarOposicionRecibida").removeAttribute("disabled","");
                    document.getElementById("verOposicionRecibida").removeAttribute("disabled","");
                    document.getElementById("eliminarOposicionRecibida").removeAttribute("disabled","");
                    document.getElementById("editarOposicionRecibida").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("verOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("eliminarOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("editarOposicionRecibida").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuPermiso(){
                var checkInput = document.getElementById("menuPermiso");
                    
                if(checkInput.checked){
                    document.getElementById("agregarPermiso").removeAttribute("disabled","");
                    document.getElementById("verPermiso").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarPermiso").setAttribute("disabled","");
                    document.getElementById("verPermiso").setAttribute("disabled","");
                    
                }
            }
            
            function ocultarSubmenuRol(){
                var checkInput = document.getElementById("menuRol");
                    
                if(checkInput.checked){
                    document.getElementById("agregarRol").removeAttribute("disabled","");
                    document.getElementById("eliminarRol").removeAttribute("disabled","");
                    document.getElementById("editarRol").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarRol").setAttribute("disabled","");
                    document.getElementById("eliminarRol").setAttribute("disabled","");
                    document.getElementById("editarRol").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuUsuario(){
                var checkInput = document.getElementById("menuUsuario");
                    
                if(checkInput.checked){
                    document.getElementById("agregarUsuario").removeAttribute("disabled","");
                    document.getElementById("verUsuario").removeAttribute("disabled","");
                    document.getElementById("eliminarUsuario").removeAttribute("disabled","");
                    document.getElementById("editarUsuario").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarUsuario").setAttribute("disabled","");
                    document.getElementById("verUsuario").setAttribute("disabled","");
                    document.getElementById("eliminarUsuario").setAttribute("disabled","");
                    document.getElementById("editarUsuario").setAttribute("disabled","");
                }
            }
            
            
            function ocultarSubmenuTitular(){
                var checkInput = document.getElementById("menuTitular");
                    
                if(checkInput.checked){
                    document.getElementById("agregarTitular").removeAttribute("disabled","");
                    document.getElementById("verTitular").removeAttribute("disabled","");
                    document.getElementById("eliminarTitular").removeAttribute("disabled","");
                    document.getElementById("editarTitular").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarTitular").setAttribute("disabled","");
                    document.getElementById("verTitular").setAttribute("disabled","");
                    document.getElementById("eliminarTitular").setAttribute("disabled","");
                    document.getElementById("editarTitular").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuAgente(){
                var checkInput = document.getElementById("menuAgente");
                    
                if(checkInput.checked){
                    document.getElementById("agregarAgente").removeAttribute("disabled","");
                    document.getElementById("verAgente").removeAttribute("disabled","");
                    document.getElementById("eliminarAgente").removeAttribute("disabled","");
                    document.getElementById("editarAgente").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarAgente").setAttribute("disabled","");
                    document.getElementById("verAgente").setAttribute("disabled","");
                    document.getElementById("eliminarAgente").setAttribute("disabled","");
                    document.getElementById("editarAgente").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuMarcas(){
                var checkMarca = document.getElementById("menuMarca");
                    
                if(checkMarca.checked){
                    document.getElementById("agregarMarca").removeAttribute("disabled","");
                    document.getElementById("verMarca").removeAttribute("disabled","");
                    document.getElementById("eliminarMarca").removeAttribute("disabled","");
                    document.getElementById("editarMarca").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarMarca").setAttribute("disabled","");
                    document.getElementById("verMarca").setAttribute("disabled","");
                    document.getElementById("eliminarMarca").setAttribute("disabled","");
                    document.getElementById("editarMarca").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuExpediente(){
                var checkInput= document.getElementById("menuExpediente");
                    
                if(checkInput.checked){
                    document.getElementById("agregarExp").removeAttribute("disabled","");
                    document.getElementById("verExp").removeAttribute("disabled","");
                    document.getElementById("eliminarExp").removeAttribute("disabled","");
                    document.getElementById("editarExp").removeAttribute("disabled","");
                    
                    ocultarSubmenuVerExp();
                    
                }else{
                    document.getElementById("agregarExp").setAttribute("disabled","");
                    document.getElementById("verExp").setAttribute("disabled","");
                    document.getElementById("eliminarExp").setAttribute("disabled","");
                    document.getElementById("editarExp").setAttribute("disabled","");
                    
                    document.getElementById("menuDocumento").setAttribute("disabled","");
                    document.getElementById("agregarDoc").setAttribute("disabled","");
                    document.getElementById("verDoc").setAttribute("disabled","");
                    document.getElementById("eliminarDoc").setAttribute("disabled","");
                    document.getElementById("editarDoc").setAttribute("disabled","");
                    
                    document.getElementById("menuEvento").setAttribute("disabled","");
                    document.getElementById("agregarEven").setAttribute("disabled","");
                    document.getElementById("verEven").setAttribute("disabled","");
                    document.getElementById("eliminarEven").setAttribute("disabled","");
                    document.getElementById("editarEven").setAttribute("disabled","");
                    
                    document.getElementById("menuOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("agregarOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("verOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("eliminarOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("editarOposicionRecibida").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuDocumento(){
                var checkInput= document.getElementById("menuDocumento");
                    
                if(checkInput.checked){
                    document.getElementById("agregarDoc").removeAttribute("disabled","");
                    document.getElementById("verDoc").removeAttribute("disabled","");
                    document.getElementById("eliminarDoc").removeAttribute("disabled","");
                    document.getElementById("editarDoc").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarDoc").setAttribute("disabled","");
                    document.getElementById("verDoc").setAttribute("disabled","");
                    document.getElementById("eliminarDoc").setAttribute("disabled","");
                    document.getElementById("editarDoc").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuEvento(){
                var checkInput= document.getElementById("menuEvento");
                    
                if(checkInput.checked){
                    document.getElementById("agregarEven").removeAttribute("disabled","");
                    document.getElementById("verEven").removeAttribute("disabled","");
                    document.getElementById("eliminarEven").removeAttribute("disabled","");
                    document.getElementById("editarEven").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarEven").setAttribute("disabled","");
                    document.getElementById("verEven").setAttribute("disabled","");
                    document.getElementById("eliminarEven").setAttribute("disabled","");
                    document.getElementById("editarEven").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuVerExp(){
                var checkInput= document.getElementById("verExp");
                
                if(checkInput.checked){
                    document.getElementById("menuDocumento").removeAttribute("disabled","");
                    document.getElementById("menuEvento").removeAttribute("disabled","");
                    document.getElementById("menuOposicionRecibida").removeAttribute("disabled","");
                    
                    ocultarSubmenuDocumento();
                    ocultarSubmenuEvento();
                    ocultarSubmenuOposicionRecibida()
                    
                }else{
                    document.getElementById("menuDocumento").setAttribute("disabled","");
                    document.getElementById("agregarDoc").setAttribute("disabled","");
                    document.getElementById("verDoc").setAttribute("disabled","");
                    document.getElementById("eliminarDoc").setAttribute("disabled","");
                    document.getElementById("editarDoc").setAttribute("disabled","");
                    
                    document.getElementById("menuEvento").setAttribute("disabled","");
                    document.getElementById("agregarEven").setAttribute("disabled","");
                    document.getElementById("verEven").setAttribute("disabled","");
                    document.getElementById("eliminarEven").setAttribute("disabled","");
                    document.getElementById("editarEven").setAttribute("disabled","");
                    
                    document.getElementById("menuOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("agregarOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("verOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("eliminarOposicionRecibida").setAttribute("disabled","");
                    document.getElementById("editarOposicionRecibida").setAttribute("disabled","");
                }
                
            }
            
            function ocultarSubmenuConfiguraciones(){
                var checkInput= document.getElementById("configuraciones");
                    
                if(checkInput.checked){
                    
                    document.getElementById("menuPermiso").removeAttribute("disabled","");
                    document.getElementById("agregarPermiso").removeAttribute("disabled","");
                    document.getElementById("verPermiso").removeAttribute("disabled","");
                    
                    document.getElementById("menuRol").removeAttribute("disabled","");
                    document.getElementById("agregarRol").removeAttribute("disabled","");
                    document.getElementById("eliminarRol").removeAttribute("disabled","");
                    document.getElementById("editarRol").removeAttribute("disabled","");
                    
                    document.getElementById("menuUsuario").removeAttribute("disabled","");
                    document.getElementById("agregarUsuario").removeAttribute("disabled","");
                    document.getElementById("verUsuario").removeAttribute("disabled","");
                    document.getElementById("eliminarUsuario").removeAttribute("disabled","");
                    document.getElementById("editarUsuario").removeAttribute("disabled","");
                    
                    
                }else{
                    
                    document.getElementById("menuPermiso").setAttribute("disabled","");
                    document.getElementById("agregarPermiso").setAttribute("disabled","");
                    document.getElementById("verPermiso").setAttribute("disabled","");
                    
                    document.getElementById("menuRol").setAttribute("disabled","");
                    document.getElementById("agregarRol").setAttribute("disabled","");
                    document.getElementById("eliminarRol").setAttribute("disabled","");
                    document.getElementById("editarRol").setAttribute("disabled","");
                    
                    document.getElementById("menuUsuario").setAttribute("disabled","");
                    document.getElementById("agregarUsuario").setAttribute("disabled","");
                    document.getElementById("verUsuario").setAttribute("disabled","");
                    document.getElementById("eliminarUsuario").setAttribute("disabled","");
                    document.getElementById("editarUsuario").setAttribute("disabled","");
                    
                }
            }
            
            function ocultarSubmenuOposicionHecha(){
                var checkInput= document.getElementById("menuOposicionHecha");
                    
                if(checkInput.checked){
                    document.getElementById("agregarOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("verOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("eliminarOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("editarOposicionHecha").removeAttribute("disabled","");
                    
                    ocultarSubmenuVerOposicionHecha();
                    
                }else{
                    document.getElementById("agregarOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarOposicionHecha").setAttribute("disabled","");
                    
                    document.getElementById("menuDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("agregarDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarDocumentoOposicionHecha").setAttribute("disabled","");
                    
                    document.getElementById("menuEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("agregarEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarEventoOposicionHecha").setAttribute("disabled","");
                    
                }
            }
            
            function ocultarSubmenuVerOposicionHecha(){
                var checkInput= document.getElementById("verOposicionHecha");
                
                if(checkInput.checked){
                    document.getElementById("menuDocumentoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("menuEventoOposicionHecha").removeAttribute("disabled","");
                    
                    ocultarSubmenuDocumentoOposicionHecha();
                    ocultarSubmenuEventoOposicionHecha();
                  
                    
                }else{
                    document.getElementById("menuDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("agregarDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarDocumentoOposicionHecha").setAttribute("disabled","");
                    
                    document.getElementById("menuEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("agregarEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarEventoOposicionHecha").setAttribute("disabled","");
                    
                }
                
            }
            
            function ocultarSubmenuDocumentoOposicionHecha(){
                var checkInput= document.getElementById("menuDocumentoOposicionHecha");
                    
                if(checkInput.checked){
                    document.getElementById("agregarDocumentoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("verDocumentoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("eliminarDocumentoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("editarDocumentoOposicionHecha").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarDocumentoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarDocumentoOposicionHecha").setAttribute("disabled","");
                }
            }
            
            function ocultarSubmenuEventoOposicionHecha(){
                var checkInput= document.getElementById("menuEventoOposicionHecha");
                    
                if(checkInput.checked){
                    document.getElementById("agregarEventoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("verEventoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("eliminarEventoOposicionHecha").removeAttribute("disabled","");
                    document.getElementById("editarEventoOposicionHecha").removeAttribute("disabled","");
                    
                }else{
                    document.getElementById("agregarEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("verEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("eliminarEventoOposicionHecha").setAttribute("disabled","");
                    document.getElementById("editarEventoOposicionHecha").setAttribute("disabled","");
                }
            }
        </script>
    </body>
</html>
    