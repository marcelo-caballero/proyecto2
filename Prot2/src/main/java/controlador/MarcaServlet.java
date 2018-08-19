/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.nio.file.Paths;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import modelo.Marca;
import modeloMng.MarcaJpaController;
import modeloMng.PaisJpaController;
import modeloMng.TipoMarcaJpaController;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
@MultipartConfig//(maxFileSize = 1024*500) // 500 kb permitido
public class MarcaServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet MarcaServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet MarcaServlet at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        MarcaJpaController marcaControl = new MarcaJpaController();
        if (request.getParameter("borrar") != null) {
            Integer idMarca = Integer.parseInt(request.getParameter("idMarca"));

            try {
                marcaControl.destroy(idMarca);
            } catch (IllegalOrphanException | NonexistentEntityException ex) {
                Logger.getLogger(MarcaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            response.sendRedirect("marca.jsp");

        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        TipoMarcaJpaController tipoMarcaControl = new TipoMarcaJpaController();
        PaisJpaController paisControl = new PaisJpaController();
        MarcaJpaController marcaControl = new MarcaJpaController();

        if (request.getParameter("guardar") != null) {
            Integer idMarca;
            Integer idTipoMarca;
            BigDecimal idPais;
            String denominacion;

            Part filePart;
            byte[] bFile;

            Marca marca;
            idTipoMarca = Integer.parseInt(request.getParameter("idTipoMarca"));
            idPais = new BigDecimal(Integer.parseInt(request.getParameter("idPais")));
            denominacion = request.getParameter("denominacion");
            filePart = request.getPart("imagenMarca");

            /*System.out.println(filePart.getName());
            System.out.println(filePart.getSize());
            System.out.println(filePart.getContentType());*/
            bFile = new byte[((int) filePart.getSize())];
            FileInputStream fileInputStream = (FileInputStream) filePart.getInputStream();
            fileInputStream.read(bFile);
            fileInputStream.close();

            marca = new Marca();
            marca.setIdTipoMarca(tipoMarcaControl.findTipoMarca(idTipoMarca));
            marca.setIdPais(paisControl.findPais(idPais));
            marca.setDenominacion(denominacion);
            marca.setImagenMarca(bFile);

            marcaControl.create(marca);

            response.sendRedirect("marca.jsp");

        }

        if (request.getParameter("editar") != null) {
            Integer idMarca;
            Integer idTipoMarca;
            BigDecimal idPais;
            String denominacion;

            Part filePart;
            byte[] bFile;

            Marca marca;

            idMarca = Integer.parseInt(request.getParameter("idMarca"));
            idTipoMarca = Integer.parseInt(request.getParameter("idTipoMarca"));
            idPais = new BigDecimal(Integer.parseInt(request.getParameter("idPais")));
            denominacion = request.getParameter("denominacion");
            
            
            /*filePart = request.getPart("imagenMarca");*/
            
            marca = marcaControl.findMarca(idMarca);
            
            marca.setIdTipoMarca(tipoMarcaControl.findTipoMarca(idTipoMarca));
            marca.setIdPais(paisControl.findPais(idPais));
            marca.setDenominacion(denominacion);
            marca.setImagenMarca(null);
            
            System.out.println(marca.getIdMarca());
            System.out.println(marca.getIdTipoMarca().getDescripcion());
            System.out.println(marca.getIdPais().getPais());
            System.out.println(marca.getDenominacion());
            
            
            try {
                marcaControl.edit(marca);
            } catch (NonexistentEntityException ex) {
                Logger.getLogger(MarcaServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (Exception ex) {
                Logger.getLogger(MarcaServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            
            response.sendRedirect("marca.jsp");
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Marca Servlet";
    }

}
