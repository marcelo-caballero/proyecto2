/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Rol;
import modelo.Usuario;
import modeloMng.RolJpaController;
import modeloMng.UsuarioJpaController;

/**
 *
 * @author Acer
 */
@WebServlet(name = "UsuarioServlet", urlPatterns = {"/UsuarioServlet"})
public class UsuarioServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        UsuarioJpaController usuarioControl = new UsuarioJpaController(); 
        
        
        Boolean cuentaDuplicado = null;
        Integer idUsuario = null;
        
        String cuenta = request.getParameter("cuentaDuplicado");
         
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idUsuario") != null){
            idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
        }
        
        //La operacion es agregar
        if(cuenta != null){
            
            cuentaDuplicado = usuarioControl.existeCuentaDuplicado(cuenta,idUsuario); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"cuentaDuplicado\":"+cuentaDuplicado+"}");
            }
        }
        
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        UsuarioJpaController usuarioControl = new UsuarioJpaController();
        RolJpaController rolControl = new RolJpaController();
        
        //Eliminar
        if(request.getParameter("eliminar")!= null){
            
            Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario")); 
            
            try {
                usuarioControl.destroy(idUsuario);
                
            } catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el usuario");
            
            }finally{
                
                response.sendRedirect("usuarios.jsp");
            }
             
        }
        
        //Guardar
        if(request.getParameter("agregar")!= null){
            try{
                Integer idRol = Integer.parseInt(request.getParameter("idRol"));
                String cuenta = request.getParameter("cuenta");
                String contraseña = request.getParameter("contrasena");
                
                Rol rol = rolControl.findRol(idRol);
                
                
                Usuario usuario = new Usuario();
                usuario.setIdRol(rol);
                usuario.setCuenta(cuenta);
                usuario.setPassword(contraseña);
                
                usuarioControl.create(usuario);
                
            }catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el usuario");
            
            }finally{
                
                response.sendRedirect("usuarios.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar")!= null){
            try{
                Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
                
                Usuario usuario = usuarioControl.findUsuario(idUsuario);
                
                Integer idRol = Integer.parseInt(request.getParameter("idRol"));
                String cuenta = request.getParameter("cuenta");
                String contraseña = request.getParameter("contrasena");
                
                Rol rol = rolControl.findRol(idRol);
                
                usuario.setIdRol(rol);
                usuario.setCuenta(cuenta);
                usuario.setPassword(contraseña);
                
                usuarioControl.edit(usuario);
                
            }catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el usuario");
            
            }finally{
                
                response.sendRedirect("usuarios.jsp");
            }
        }
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Usuario";
    }

}