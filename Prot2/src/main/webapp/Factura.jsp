

<%@page import="java.util.Locale"%>
<%@page import="modelo.Cliente"%>
<%@page import="modeloMng.FacturaCabeceraJpaController"%>
<%@page import="modelo.FacturaCabecera"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
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

            
                EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
                Map<String, Object> propertiesMap = 
                    propertiesMap = entityManagerFactory.getProperties();

                
                String url =  propertiesMap.get("javax.persistence.jdbc.url").toString();
                String user = propertiesMap.get("javax.persistence.jdbc.user").toString();
                String pass = propertiesMap.get("javax.persistence.jdbc.password").toString();
                Class.forName(propertiesMap.get("javax.persistence.jdbc.driver").toString());
                Connection con = DriverManager.getConnection(url, user, pass); 
                
                /*String fecha = request.getParameter("fecha");
                String cond_venta = request.getParameter("cond_venta");
                String ruc =  request.getParameter("ruc");
                String descripcion =  request.getParameter("descripcion");
                String precio =  request.getParameter("monto");
                String nombre = request.getParameter("nombre");
                String direccion = request.getParameter("direccion");
                String telefono = request.getParameter("telefono");
                
                String iva =  request.getParameter("iva");*/
                Integer idFactura =  Integer.parseInt(request.getParameter("idFactura"));
                FacturaCabecera fac = new FacturaCabeceraJpaController().findFacturaCabecera(idFactura);
                
                Cliente cliente = fac.getIdCliente();
                
                String numFactura = String.valueOf(fac.getNumeroFactura());
                while(numFactura.length()<6){
                    numFactura = "0"+numFactura;
                }
                System.out.println("ID factura "+idFactura);
                //System.out.println("Fecha  "+fecha);
                //System.out.println("Nombre "+nombre);
                //System.out.println("Telefono "+telefono);
                //System.out.println("Direccion "+direccion);
                //System.out.println("iva "+iva);
                //System.out.println("ruc "+ruc);
                //System.out.println("monto "+precio);
                //ClienteJpaController cliente = new ClienteJpaController();
       
                
                File reportfile = new File(application.getRealPath("/WEB-INF/reportes/Factura.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("REPORT_LOCALE", new Locale("es", "ES"));
                parameter.put("idFactura", idFactura);
                parameter.put("inicio", numFactura);
                parameter.put("fecha", fac.getFecha());
                parameter.put("ruc", cliente.getRuc());
                parameter.put("direccion", cliente.getDireccion());
                parameter.put("telefono", cliente.getTelefono());
                parameter.put("nombre", cliente.getNombreCliente());
                parameter.put("cantidad", fac.getFacturaDetalleList().get(0).getCantidad());
             
                
                
                
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
