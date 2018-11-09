

<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reporte de abogado</title>
    </head>
    <body>
        <%

                String url = "jdbc:postgresql://localhost:5432/taangapp";
                String user ="postgres";
                String pass = "admin";
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection(url, user, pass); 
                
                String fecha = request.getParameter("fecha");
                String cond_venta = request.getParameter("cond_venta");
                String ruc =  request.getParameter("ruc");
                String descripcion =  request.getParameter("descripcion");
                String precio =  request.getParameter("monto");
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                
                String iva =  request.getParameter("iva");
                String numFact =  request.getParameter("numFact");
                
                
                System.out.println("Numero factura "+numFact);
                System.out.println("Fecha  "+fecha);
                System.out.println("Nombre "+nombre);
                System.out.println("Telefono "+telefono);
                System.out.println("Direccion "+direccion);
                System.out.println("iva "+iva);
                System.out.println("ruc "+ruc);
                System.out.println("monto "+precio);
                ClienteJpaController cliente = new ClienteJpaController();
       
                
                File reportfile = new File(application.getRealPath("/WEB-INF/reportes/Factura.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("inicio", numFact);
                parameter.put("ruc", ruc);
                parameter.put("fecha", fecha);
                parameter.put("nombre", nombre);
                parameter.put("precio", precio);
                parameter.put("direccion", direccion);
                parameter.put("telefono", telefono);
                parameter.put("iva10", iva); 
                
                
                
                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
                response.setContentType("application/pdf");
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();
                       //Persistence.createEntityManagerFactory("persistence.xml", null);


        %>

        <!--        <form action="<>/FacturaServlet" 
                          method="post" 
                           >
                          <input type="submit" value="Enviar">
                          
                </form>-->
    </body>
</html>
