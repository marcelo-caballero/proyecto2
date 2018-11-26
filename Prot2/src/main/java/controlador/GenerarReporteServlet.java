/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modeloMng.ClienteJpaController;
import net.sf.jasperreports.engine.JasperRunManager;

/**
 *
 * @author User
 */
@WebServlet(name = "GenerarReporteServlet", urlPatterns = {"/GenerarReporteServlet"})
public class GenerarReporteServlet extends HttpServlet {

    

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/pdf");
                  
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        
        if(request.getParameter("reporteIngresos") != null){
           try{
                EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
                Map<String, Object> propertiesMap
                        = propertiesMap = entityManagerFactory.getProperties();

                String url = propertiesMap.get("javax.persistence.jdbc.url").toString();
                String user = propertiesMap.get("javax.persistence.jdbc.user").toString();
                String pass = propertiesMap.get("javax.persistence.jdbc.password").toString();
                Class.forName(propertiesMap.get("javax.persistence.jdbc.driver").toString());
                Connection con = DriverManager.getConnection(url, user, pass);
                
                
                
                String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
                String fechaHasta = request.getParameter("fechaHasta");//lo mismo
                String idCliente = request.getParameter("idCliente"); //si es -1 es todes
      
                
                File reportfile = new File(getServletContext().getRealPath("/WEB-INF/reportes/ingresos.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("REPORT_LOCALE", new Locale("es", "ES"));
                parameter.put("idCliente", Integer.parseInt(idCliente));
                parameter.put("fechaDesde", formatoFecha.parse(fechaDesde));
                parameter.put("fechaHasta", formatoFecha.parse(fechaHasta));
                if(idCliente.equals("-1")){
                    parameter.put("cliente", "TODOS");
                }else{
                    parameter.put("cliente", new ClienteJpaController().findCliente(Integer.parseInt(idCliente)).getNombreCliente());
                }
                

                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
                System.out.println("Ingreso"+fechaDesde+" "+fechaHasta+" "+idCliente);
                
                response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes, 0, bytes.length);
            outputstream.flush();
            outputstream.close();
                
           }catch(Exception e){
               
           }
            
        
        }
        
        if(request.getParameter("reporteOposicionRecibida") != null){
            
            try{
                EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
                Map<String, Object> propertiesMap
                        = propertiesMap = entityManagerFactory.getProperties();

                String url = propertiesMap.get("javax.persistence.jdbc.url").toString();
                String user = propertiesMap.get("javax.persistence.jdbc.user").toString();
                String pass = propertiesMap.get("javax.persistence.jdbc.password").toString();
                Class.forName(propertiesMap.get("javax.persistence.jdbc.driver").toString());
                Connection con = DriverManager.getConnection(url, user, pass);
                
                
                
                String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
                String fechaHasta = request.getParameter("fechaHasta");//lo mismo
                //String idCliente = request.getParameter("idCliente"); //si es -1 es todes
                //String idMarca = request.getParameter("idMarca");//si es -1 es todes
                //String idAbogado = request.getParameter("idAbogado");////si es -1 es todes
                //String estadoGanadaOperdida = request.getParameter("ganadaOperdida");//si 0 es ganada y perdida, -1 perdida , 1 ganada

                File reportfile = new File(getServletContext().getRealPath("/WEB-INF/reportes/oposicionesRecibidas.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("REPORT_LOCALE", new Locale("es", "ES"));
                //parameter.put("idCliente", Integer.parseInt(idCliente));
                parameter.put("fechaDesde", formatoFecha.parse(fechaDesde));
                parameter.put("fechaHasta", formatoFecha.parse(fechaHasta));
                /*if(idCliente.equals("-1")){
                    parameter.put("cliente", "TODOS");
                }else{
                    parameter.put("cliente", new ClienteJpaController().findCliente(Integer.parseInt(idCliente)).getNombreCliente());
                }*/
                

                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
                //System.out.println("Ingreso"+fechaDesde+" "+fechaHasta+" "+idCliente);
                
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();
                
            //System.out.println("OR"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+idMarca+" "+idAbogado+" "+estadoGanadaOperdida);
           }catch(Exception e){
               
           }
                
        }
        
        if(request.getParameter("reporteOposicionHecha") != null){
            try{
                EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
                Map<String, Object> propertiesMap
                        = propertiesMap = entityManagerFactory.getProperties();

                String url = propertiesMap.get("javax.persistence.jdbc.url").toString();
                String user = propertiesMap.get("javax.persistence.jdbc.user").toString();
                String pass = propertiesMap.get("javax.persistence.jdbc.password").toString();
                Class.forName(propertiesMap.get("javax.persistence.jdbc.driver").toString());
                Connection con = DriverManager.getConnection(url, user, pass);
            
                String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
                String fechaHasta = request.getParameter("fechaHasta");//lo mismo
                //String idCliente = request.getParameter("idCliente"); //si es -1 es todes
                //String idMarca = request.getParameter("idMarca");//si es -1 es todes
                //String idAbogado = request.getParameter("idAbogado");////si es -1 es todes
                //String estadoGanadaOperdida = request.getParameter("ganadaOperdida");//si 0 es ganada y perdida, -1 perdida , 1 ganada

                //System.out.println("OH"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+idMarca+" "+idAbogado+" "+estadoGanadaOperdida);
             File reportfile = new File(getServletContext().getRealPath("/WEB-INF/reportes/oposicionesHechas.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("REPORT_LOCALE", new Locale("es", "ES"));
                //parameter.put("idCliente", Integer.parseInt(idCliente));
                
                parameter.put("fechaDesde", formatoFecha.parse(fechaDesde));
                parameter.put("fechaHasta", formatoFecha.parse(fechaHasta));
                /*if(idCliente.equals("-1")){
                    parameter.put("cliente", "TODOS");
                }else{
                    parameter.put("cliente", new ClienteJpaController().findCliente(Integer.parseInt(idCliente)).getNombreCliente());
                }*/
                

                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
                //System.out.println("Ingreso"+fechaDesde+" "+fechaHasta+" "+idCliente);
                
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();
                
            //System.out.println("OR"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+idMarca+" "+idAbogado+" "+estadoGanadaOperdida);
           }catch(Exception e){
               
           }
        }
        
        if(request.getParameter("reporteExpediente") != null){
            try{
                EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
                Map<String, Object> propertiesMap
                        = propertiesMap = entityManagerFactory.getProperties();

                String url = propertiesMap.get("javax.persistence.jdbc.url").toString();
                String user = propertiesMap.get("javax.persistence.jdbc.user").toString();
                String pass = propertiesMap.get("javax.persistence.jdbc.password").toString();
                Class.forName(propertiesMap.get("javax.persistence.jdbc.driver").toString());
                Connection con = DriverManager.getConnection(url, user, pass);
                
                String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
                String fechaHasta = request.getParameter("fechaHasta");//lo mismo
                String idCliente = request.getParameter("idCliente"); //si es -1 es todes
                String idAbogado = request.getParameter("idAbogado");////si es -1 es todes
                String idEstadoMarca = request.getParameter("idEstadoMarca");////si es -1 es todes
            
                System.out.println("Exp"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+" "+idAbogado+" "+idEstadoMarca);
                File reportfile = new File(getServletContext().getRealPath("/WEB-INF/reportes/EstadosExpedientes.jasper"));
                Map<String, Object> parameter = new HashMap<>();
                parameter.put("REPORT_LOCALE", new Locale("es", "ES"));
                
                parameter.put("idCliente", Integer.parseInt(idCliente));
                parameter.put("idAbogado", Integer.parseInt(idAbogado));
                parameter.put("idEstado", Integer.parseInt(idEstadoMarca));
                parameter.put("fechaDesde", formatoFecha.parse(fechaDesde));
                parameter.put("fechaHasta", formatoFecha.parse(fechaHasta));
                if(idCliente.equals("-1")){
                    parameter.put("cliente", "TODOS");
                }else{
                    parameter.put("cliente", new ClienteJpaController().findCliente(Integer.parseInt(idCliente)).getNombreCliente());
                }
                

                byte[] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
                
                
                response.setContentLength(bytes.length);
                ServletOutputStream outputstream = response.getOutputStream();
                outputstream.write(bytes, 0, bytes.length);
                outputstream.flush();
                outputstream.close();
                
           }catch(Exception e){
               
           }
        }
        
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
