<%-- 
    Document   : notificaciones
    Created on : 08-nov-2018, 14:44:31
    Author     : User
--%>

<%@page import="modelo.EventoOposicionHecha"%>
<%@page import="modeloMng.EventoOposicionHechaJpaController"%>
<%@page import="java.util.List"%>
<%@page import="modeloMng.EventoJpaController"%>
<%@page import="modelo.Evento"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%response.setHeader("Cache-Control", "no-cache");
%>
<!DOCTYPE html>
<html>
    <head>

        <title>Notificaciones - Ta'angapp</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <%@include file="//WEB-INF/paginaCabecera.jsp" %>
        <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.16/css/jquery.dataTables.css">
        <script type="text/javascript" charset="utf-8" src="//cdn.datatables.net/1.10.16/js/jquery.dataTables.js"></script>

    </head>
    <body>
         <%@include file="//WEB-INF/menuCabecera.jsp" %>
        <% 
            request.getSession().removeAttribute("alta");
            request.getSession().removeAttribute("media");
            request.getSession().removeAttribute("baja");
            Integer idAbogado = null; 
            
            if(!usuario.getAbogadoList().isEmpty()){
                idAbogado = usuario.getAbogadoList().get(0).getIdAbogado();
            }
            //Eventos del expedientes
            EventoJpaController eventoControl = new EventoJpaController();
            List<Evento> listaAlta = eventoControl.getListaEventos(3,"ALTA",idAbogado); 
            List<Evento> listaMedia= eventoControl.getListaEventos(2,"MEDIA",idAbogado); 
            List<Evento> listaBaja = eventoControl.getListaEventos(1,"BAJA",idAbogado);   
            
            //Eventos de Oposiciones Hechas
            EventoOposicionHechaJpaController eventoOposicionControl = new EventoOposicionHechaJpaController();
            List<EventoOposicionHecha> listaOposicionAlta = eventoOposicionControl.getListaEventosOposicionHecha(3,"ALTA",idAbogado);
            List<EventoOposicionHecha> listaOposicionMedia= eventoOposicionControl.getListaEventosOposicionHecha(2,"MEDIA",idAbogado);
            List<EventoOposicionHecha> listaOposicionBaja = eventoOposicionControl.getListaEventosOposicionHecha(1,"BAJA",idAbogado);
        %>
        <br>
        <div class="container form-control">
            <h2 class="text-justify">Notificaciones</h2>
            <br>
            
            <ul class="nav nav-tabs" id="myTab" role="tablist">
              <li class="nav-item">
                <a class="nav-link active" id="home-tab" data-toggle="tab" href="#home" role="tab" aria-controls="home" aria-selected="true">Eventos del Expediente</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" id="profile-tab" data-toggle="tab" href="#profile" role="tab" aria-controls="profile" aria-selected="false">Eventos de Oposiciones</a>
              </li>
            </ul>
            <br>
            <div class="tab-content" id="myTabContent">
                <div class="tab-pane fade show active" id="home" role="tabpanel" aria-labelledby="home-tab">
                    <h4 class="text-justify">Eventos del Expediente:</h2>
                    <br>
                    <table id="mytable" class="table table-striped table-bordered dt-responsive nowrap">
                        <thead style="background-color:whitesmoke">
                            <tr>
                                <th>Orden</th>
                                <th>Prioridad</th>
                                <th>Número del expediente</th>
                                <th>Fecha</th>
                                <th>Hora</th>
                                <th>Evento</th>
                            </tr>
                        </thead>

                        <tbody id='cuerpoTabla'>
                            <%for (int i = 0; i < listaAlta.size(); i++) {%>
                                <tr>
                                    <td style="color:#ff3232;">1</td>
                                    <td style="color:#ff3232;">Alta</td>
                                    <td style="color:#ff3232;"><%=listaAlta.get(i).getIdExpediente().getNroExpediente()%></td> 
                                    <td style="color:#ff3232;"><%=listaAlta.get(i).getStringFecha()%></td>
                                    <td style="color:#ff3232;"><%=listaAlta.get(i).getStringHora()%>:<%=listaAlta.get(i).getStringMinuto()%></td>
                                    <td style="color:#ff3232;"><%=listaAlta.get(i).getNombre()%></td> 
                                </tr>
                            <%}%>
                            <%for (int i = 0; i < listaMedia.size(); i++) {%>
                                <tr>
                                    <td style="color:#ccc80c;">2</td>
                                    <td style="color:#ccc80c;">Media</td>
                                    <td style="color:#ccc80c;"><%=listaMedia.get(i).getIdExpediente().getNroExpediente()%></td> 
                                    <td style="color:#ccc80c;"><%=listaMedia.get(i).getStringFecha()%></td>
                                    <td style="color:#ccc80c;"><%=listaMedia.get(i).getStringHora()%>:<%=listaMedia.get(i).getStringMinuto()%></td>
                                    <td style="color:#ccc80c;"><%=listaMedia.get(i).getNombre()%></td> 
                                </tr>
                            <%}%>
                            <%for (int i = 0; i < listaBaja.size(); i++) {%>
                                <tr>
                                    <td style="color:#468847;">3</td>
                                    <td style="color:#468847;">Baja</td>
                                    <td style="color:#468847;"><%=listaBaja.get(i).getIdExpediente().getNroExpediente()%></td> 
                                    <td style="color:#468847;"><%=listaBaja.get(i).getStringFecha()%></td>
                                    <td style="color:#468847;"><%=listaBaja.get(i).getStringHora()%>:<%=listaBaja.get(i).getStringMinuto()%></td>
                                    <td style="color:#468847;"><%=listaBaja.get(i).getNombre()%></td> 
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>

                <div class="tab-pane fade" id="profile" role="tabpanel" aria-labelledby="profile-tab">
                     <h4 class="text-justify">Eventos de Oposición:</h2>
                    <br>
                    <table id="mytableOpo" class="table table-striped table-bordered dt-responsive nowrap">
                        <thead style="background-color:whitesmoke">
                            <tr>
                                <th>Orden</th>
                                <th>Prioridad</th>
                                <th>Nº. Expediente Opositado</th>
                                <th>Fecha</th>
                                <th>Hora</th>
                                <th>Evento</th>
                            </tr>
                        </thead>

                        <tbody>
                            <%for (int i = 0; i < listaOposicionAlta.size(); i++) {%>
                                <tr>
                                    <td style="color:#b94a48;">1</td>
                                    <td style="color:#b94a48;">Alta</td>
                                    <td style="color:#b94a48;"><%=listaOposicionAlta.get(i).getIdOposicionHecha().getNroExpedienteOpositado()%></td> 
                                    <td style="color:#b94a48;"><%=listaOposicionAlta.get(i).getStringFecha()%></td>
                                    <td style="color:#b94a48;"><%=listaOposicionAlta.get(i).getStringHora()%>:<%=listaOposicionAlta.get(i).getStringMinuto()%></td>
                                    <td style="color:#b94a48;"><%=listaOposicionAlta.get(i).getNombre()%></td> 
                                </tr>
                            <%}%>
                            <%for (int i = 0; i < listaOposicionMedia.size(); i++) {%>
                                <tr>
                                    <td style="color:#ccc80c;">2</td>
                                    <td style="color:#ccc80c;">Media</td>
                                    <td style="color:#ccc80c;"><%=listaOposicionMedia.get(i).getIdOposicionHecha().getNroExpedienteOpositado()%></td> 
                                    <td style="color:#ccc80c;"><%=listaOposicionMedia.get(i).getStringFecha()%></td>
                                    <td style="color:#ccc80c;"><%=listaOposicionMedia.get(i).getStringHora()%>:<%=listaOposicionMedia.get(i).getStringMinuto()%></td>
                                    <td style="color:#ccc80c;"><%=listaOposicionMedia.get(i).getNombre()%></td> 
                                </tr>
                            <%}%>
                            <%for (int i = 0; i < listaOposicionBaja.size(); i++) {%>
                                <tr>
                                    <td style="color:#468847;">3</td>
                                    <td style="color:#468847;">Baja</td>
                                    <td style="color:#468847;"><%=listaOposicionBaja.get(i).getIdOposicionHecha().getNroExpedienteOpositado()%></td> 
                                    <td style="color:#468847;"><%=listaOposicionBaja.get(i).getStringFecha()%></td>
                                    <td style="color:#468847;"><%=listaOposicionBaja.get(i).getStringHora()%>:<%=listaOposicionBaja.get(i).getStringMinuto()%></td>
                                    <td style="color:#468847;"><%=listaOposicionBaja.get(i).getNombre()%></td> 
                                </tr>
                            <%}%>
                        </tbody>
                    </table>
                </div>
                </div>
              
            </div>
        </div>
        <script>
            $(document).ready(function () {
                $('#mytable').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
                    }
                });
            });
            
            $(document).ready(function () {
                $('#mytableOpo').DataTable({
                    "language": {
                        "url": "//cdn.datatables.net/plug-ins/1.10.16/i18n/Spanish.json"
                    }
                });
            });
        </script>
        <br>
    </body>
</html>
