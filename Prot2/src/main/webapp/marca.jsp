<%-- 
    Document   : newjsp
    Created on : 11-ago-2018, 14:50:20
    Author     : Acer
--%>


<%@page import="java.util.Base64"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Marca"%> 
<%@page import="modelo.Pais"%> 
<%@page import="modelo.TipoMarca"%>  
<%@page import="modeloMng.MarcaJpaController"%> 
<%@page import="modeloMng.TipoMarcaJpaController"%>
<%@page import="modeloMng.PaisJpaController"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            List<Marca> listaMarca ;
            MarcaJpaController marcaControl = new MarcaJpaController();
            listaMarca = marcaControl.findMarcaEntities(); 
            
            
            List<TipoMarca> listaTipoMarca;
            TipoMarcaJpaController tipoMarcaControl = new TipoMarcaJpaController(); 
            listaTipoMarca = tipoMarcaControl.findTipoMarcaEntities(); 
            
            List<Pais> listaPais;
            PaisJpaController paisControl = new PaisJpaController(); 
            listaPais = paisControl.findPaisEntities();  
            
            /*try{
                lista = clasecontrol.findClaseEntities();
            }catch(Exception e){ 
            
            }*/
        %>

        <table>
        <thead>

            <tr>
                <th>ID de Marca</th>
                <th>Signo</th>
                <th>Pais</th>
                <th>Denominación</th>
            </tr>
        </thead>

        <tbody>
            
            <%for (int i = 0; i < listaMarca.size(); i++) {%>
            <tr>
                <td ><%=listaMarca.get(i).getIdMarca()%></td>
                <td ><%=listaMarca.get(i).getIdTipoMarca().getDescripcion()%></td>
                <td ><%=listaMarca.get(i).getIdPais().getPais()%></td>
                <td ><%=listaMarca.get(i).getDenominacion()%></td>
                <td><% if(listaMarca.get(i).getImagenMarca() != null){
                              String imageBase64 = new String(Base64.getEncoder().encode(listaMarca.get(i).getImagenMarca()));
                            %>
                                <img src="data:image/jpg;base64,<%=imageBase64%>" >            
                            <%}%>
                            
                </td>
                <td><form action="<%=request.getContextPath()%>/MarcaServlet" method="get">
                      <input type="text" name = "idMarca" value="<%=listaMarca.get(i).getIdMarca()%>">
                      <input type="submit" name="borrar" value="Borrar">
                    </form>
                </td>
            </tr>
            <%}%>
        </tbody>
        
        
    </table> 
        
        
        <h1>Agregar</h1>
        <div>
            <form id="marcaForm" action="<%=request.getContextPath()%>/MarcaServlet" method="post" enctype="multipart/form-data" >
                
                <label for="idTipoMarca">Tipo de Marca</label>
                <select name="idTipoMarca" form="marcaForm">
                    <%for(int j = 0;j< listaTipoMarca.size();j++){%>
                        <option value="<%=listaTipoMarca.get(j).getIdTipoMarca()%>">
                            <%=listaTipoMarca.get(j).getDescripcion()%>
                        </option>
                    <%}%>
                </select>
                
                <br>
                
                <label for="denominacion">Denominacion</label>
                <input type="text" name="denominacion">
                
                <br>
                
                <label for="idPais">País</label>
                <select name="idPais" form="marcaForm">
                    <%for(int j = 0;j< listaPais.size();j++){%>
                        <option value="<%=listaPais.get(j).getIdPais()%>">
                            <%=listaPais.get(j).getPais()%>
                        </option>
                    <%}%>
                </select>
                
                <br>
                
                <label for="imagenMarca"> Imagen:</label>
                <input type="file" form="marcaForm" name="imagenMarca" accept="image/png, image/jpeg" />
                <input type="submit" name="guardar" value="Guardar">
            </form>
        </div>
                
         
        <h1>Editar</h1>
        <div>
            <form id="marcaEditar" action="<%=request.getContextPath()%>/MarcaServlet" method="post" enctype="multipart/form-data" >
                <input  type="text" name="idMarca" form="marcaEditar">
                
                <label for="idTipoMarca">Tipo de Marca</label>
                <select name="idTipoMarca" form="marcaEditar">
                    <%for(int j = 0;j< listaTipoMarca.size();j++){%>
                        <option value="<%=listaTipoMarca.get(j).getIdTipoMarca()%>">
                            <%=listaTipoMarca.get(j).getDescripcion()%>
                        </option>
                    <%}%>
                </select>
                
                <br>
                
                <label for="denominacion">Denominacion</label>
                <input type="text" name="denominacion">
                
                <br>
                
                <label for="idPais">País</label>
                <select name="idPais" form="marcaEditar">
                    <%for(int j = 0;j< listaPais.size();j++){%>
                        <option value="<%=listaPais.get(j).getIdPais()%>">
                            <%=listaPais.get(j).getPais()%>
                        </option>
                    <%}%>
                </select>
                
                <br>
                
                <label for="imagenMarca"> Imagen:</label>
                <input type="file" form="marcaEditar" name="imagenMarca" accept="image/png, image/jpeg" />
                <input type="submit" name="editar" value="Editar">
            </form>
        </div>
</body>

</html>
