

<%@page import="modeloMng.ClienteJpaController"%>
<%@page import="net.sf.jasperreports.engine.JRDataSource"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="javax.persistence.Persistence"%>
<%@page import="javax.persistence.EntityManagerFactory"%>
<%@page import="javax.persistence.EntityManager"%>
<%@page import="net.sf.jasperreports.engine.JREmptyDataSource"%>
<%@page import="java.sql.Connection"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
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

                String url = "jdbc:postgresql://localhost:5432/proyecto2";
                String user ="postgres";
                String pass = "admin";
                Class.forName("org.postgresql.Driver");
                Connection con = DriverManager.getConnection(url, user, pass); 
                
                String fecha = request.getParameter("fecha");
                String cond_venta = request.getParameter("cond_venta");
                String ruc =  request.getParameter("ruc");
                String descripcion =  request.getParameter("descripcion");
                String monto =  request.getParameter("monto");
                String iva =  request.getParameter("iva");
                String numFact =  request.getParameter("numFact");
                
                ClienteJpaController cliente = new ClienteJpaController();
       
                
                File reportfile = new File(application.getRealPath("/WEB-INF/reportes/Factura.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("inicio", numFact);
                parameter.put("ruc", ruc);
                
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
