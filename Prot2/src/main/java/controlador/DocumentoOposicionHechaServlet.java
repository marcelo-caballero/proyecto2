/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.DocumentoOposicionHecha;
import modeloMng.DocumentoOposicionHechaJpaController;
import modeloMng.OposicionHechaJpaController;
import modeloMng.TipoDocumentoOposicionHechaJpaController;

/**
 *
 * @author User
 */
@MultipartConfig
@WebServlet(name = "DocumentoOposicionHechaServlet", urlPatterns = {"/DocumentoOposicionHechaServlet"})
public class DocumentoOposicionHechaServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        DocumentoOposicionHechaJpaController documentoControl = new DocumentoOposicionHechaJpaController();
        OposicionHechaJpaController oposicionControl= new OposicionHechaJpaController(); 
        TipoDocumentoOposicionHechaJpaController tipoDocControl = new TipoDocumentoOposicionHechaJpaController();
        
        SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-dd");
        

        //Agregar
        if (request.getParameter("agregar") != null) {
            
            try{
                
                Integer idOposicion = (Integer)(request.getSession().getAttribute("idOposicionHecha"));
                String nombre = request.getParameter("nombreDoc");
                Integer idTipoDoc = Integer.parseInt(request.getParameter("idTipoDoc"));
                String descripcion = request.getParameter("descripcionDoc");
                String folioDesde = request.getParameter("folioDesde");
                String folioHasta = request.getParameter("folioHasta");
                
                
                //Convierte string a fecha
                Date fecha = formatoFecha.parse(request.getParameter("fechaDoc"));
                
                Part filePart = request.getPart("archivoDoc");
                byte[] bFile = null;
                //convierte archivo a binario
                if (filePart.getSize() > 0) {
                    bFile = new byte[((int) filePart.getSize())];
                    FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
                    fileInputStream.read(bFile);
                    fileInputStream.close();

                }      
                
                
                DocumentoOposicionHecha documento = new DocumentoOposicionHecha();
                documento.setIdOposicionHecha(oposicionControl.findOposicionHecha(idOposicion));
                documento.setNombre(nombre);
                documento.setIdTipoDocumentoOposicionHecha(tipoDocControl.findTipoDocumentoOposicionHecha(idTipoDoc));
                documento.setDescripcion(descripcion);
                documento.setDocumento(bFile);
                documento.setFecha(fecha);
                documento.setFolioDesde(Integer.parseInt(folioDesde));
                documento.setFolioHasta(Integer.parseInt(folioHasta));

                
                documentoControl.create(documento);
            }catch (Exception e) {
                System.out.println(e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el documento");
            
            }finally{
                
                response.sendRedirect("documentosOposicionesHechas.jsp");
            }    
        }
        
        //Eliminar
        if(request.getParameter("eliminar") != null){
            try {
                Integer idDoc = Integer.parseInt(request.getParameter("idDocumento"));
                
                //El id de la oposicion en donde se encuentra
                Integer idOposicion = (Integer) request.getSession().getAttribute("idOposicionHecha");
                
                DocumentoOposicionHecha ultimoDocumento = documentoControl.getUltimoDocumento(idOposicion);
                
                //Si el documento a eliminar es el ultimo documento guardado en la oposicion, 
                if(idDoc == ultimoDocumento.getIdDocumento()){
                    //lo eliminamos
                     documentoControl.destroy(idDoc);
                }else{
                    //si no informamos que no se puede eliminar
                    request.getSession().setAttribute("mensajeErrorABM", "Solamente se puede eliminar el último documento de la oposición");
                }
                
            } catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el documento");
            }finally{
           
                response.sendRedirect("documentosOposicionesHechas.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar") != null){
            try{
                Integer idDoc = Integer.parseInt(request.getParameter("idDocumento")); 

                DocumentoOposicionHecha documento = documentoControl.findDocumentoOposicionHecha(idDoc);
                
                String nombre = request.getParameter("nombreDoc");
                Integer idTipoDoc = Integer.parseInt(request.getParameter("idTipoDoc"));
                String descripcion = request.getParameter("descripcionDoc");
                String folioDesde = request.getParameter("folioDesde");
                String folioHasta = request.getParameter("folioHasta");
                
                Date fecha = formatoFecha.parse(request.getParameter("fechaDoc"));
                
                Part filePart = request.getPart("archivoDoc");
                byte[] bFile = null;
                
                //convierte archivo a binario
                if (filePart.getSize() > 0) {
                    bFile = new byte[((int) filePart.getSize())];
                    FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
                    fileInputStream.read(bFile);
                    fileInputStream.close();

                }
                
                documento.setNombre(nombre);
                documento.setIdTipoDocumentoOposicionHecha(tipoDocControl.findTipoDocumentoOposicionHecha(idTipoDoc));
                documento.setDescripcion(descripcion);
                documento.setFolioHasta(Integer.parseInt(folioHasta)); 
                documento.setFecha(fecha);
                //Si se selecciona un nuevo archivo, se actualiza
                if(bFile != null){
                    
                    documento.setDocumento(bFile);
                }    
                
                documentoControl.edit(documento); 
            } 
            catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el documento");
            
            }finally{
                
                response.sendRedirect("documentosOposicionesHechas.jsp");
            
            }       
        }
        
    }

    @Override
    public String getServletInfo() {
        return "ABM Documento de las oposiciones realizadas por el estudio juridico";
    }

}
