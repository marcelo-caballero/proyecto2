/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import modelo.Evento;
import modelo.EventoOposicionHecha;

import modelo.Usuario;
import modeloMng.EventoJpaController;
import modeloMng.EventoOposicionHechaJpaController;
import modeloMng.UsuarioJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

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
        HttpSession sesion = request.getSession();
        Usuario usuario = (Usuario) sesion.getAttribute("usuario");
        if (request.getParameter("desconectar") != null) {
            if (usuario != null) {
                sesion.removeAttribute("usuario");
                response.sendRedirect("login.jsp");
            }
        }
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * Inicia la sesion del usuario
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession sesion = request.getSession();
        Usuario usuario = null;

        if (request.getParameter("conectar") != null) {

            //String contexto = request.getContextPath();
            //Parametros cuenta y contraseña
            String cuenta = request.getParameter("usuario");
            String contraseña = request.getParameter("contrasena");
            try{
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] messageDigest = md.digest(contraseña.getBytes()); //EN VEZ DE INPUT PASARLE CONTRASEÑA
                BigInteger number = new BigInteger(1, messageDigest);
                String hashtext = number.toString(16);

                while (hashtext.length() < 32) {
                    hashtext = "0" + hashtext;
                }
                
                // Valida Parametros no vacios
                //if (cuenta != null && contraseña != null) {
                UsuarioJpaController usuMng = new UsuarioJpaController();
                usuario = usuMng.getUsuarioLogin(cuenta, hashtext);
                if (usuario == null) {

                    response.sendRedirect("errorLogin.jsp");
                } else {
                    sesion.setAttribute("usuario", usuario);
                    //request.getRequestDispatcher("clienteVista.jsp").forward(request, response);
                    
                    
                    //La notificacion
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

                    if(listaAlta.size()+listaOposicionAlta.size()> 0){
                        sesion.setAttribute("alta", listaAlta.size()+listaOposicionAlta.size());
                    }else if(listaMedia.size()+listaOposicionMedia.size()> 0){
                        sesion.setAttribute("media", listaMedia.size()+listaOposicionMedia.size());
                    }else if(listaBaja.size()+listaOposicionBaja.size()>0){
                         sesion.setAttribute("baja", listaBaja.size()+listaOposicionBaja.size());
                    }
                    //----------------------------------------------------------------------------
                    response.sendRedirect("menu.jsp");
                }
            }catch(Exception e ){
            
            }
                
            
            //}else {
            //response.sendRedirect("errorLogin.jsp");
            //}
        }

    }

    @Override
    public String getServletInfo() {
        return "Servlet encargado del inicio de sesion";
    }// </editor-fold>

}
