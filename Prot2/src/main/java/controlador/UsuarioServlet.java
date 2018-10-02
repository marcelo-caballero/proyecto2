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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import modelo.Abogado;
import modelo.Cliente;
import modelo.Rol;
import modelo.Usuario;
import modeloMng.AbogadoJpaController;
import modeloMng.ClienteJpaController;
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
        AbogadoJpaController abogadoControl = new AbogadoJpaController();
        ClienteJpaController clienteControl = new ClienteJpaController(); 
        
        //Eliminar
        if(request.getParameter("eliminar")!= null){
            
            Integer idUsuario = Integer.parseInt(request.getParameter("idUsuario")); 
            Usuario usuario = usuarioControl.findUsuario(idUsuario);
            
            try {
                usuario.setEstado("INACTIVO");
                usuarioControl.edit(usuario);
               
                
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
                
                MessageDigest md = MessageDigest.getInstance("MD5");
                byte[] messageDigest = md.digest(contraseña.getBytes()); //EN VEZ DE INPUT PASARLE CONTRASEÑA
                BigInteger number = new BigInteger(1, messageDigest);
                String hashtext = number.toString(16);

                while (hashtext.length() < 32) {
                    hashtext = "0" + hashtext;
                }
                
                Rol rol = rolControl.findRol(idRol);
                
                
                Usuario usuario = new Usuario();
                usuario.setIdRol(rol);
                usuario.setCuenta(cuenta);
                usuario.setPassword(hashtext);
                usuario.setEstado("ACTIVO");
                
                if(rol.getEstado().equals("NO ASIGNADO")){
                    rol.setEstado("ASIGNADO");
                    rolControl.edit(rol);
                }
                
                usuarioControl.create(usuario);
                
               
                
            }catch (Exception e) {
                System.out.println(e);
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
                
                if(usuario.getEstado().equals("ACTIVO")){
                    Integer idRol = Integer.parseInt(request.getParameter("idRol"));
                    String cuenta = request.getParameter("cuenta");
                    String contraseña = request.getParameter("contrasena");
                    String asociado = request.getParameter("asociar");
                    String abogado = request.getParameter("idAbogado");
                    String cliente = request.getParameter("idCliente");

                    MessageDigest md = MessageDigest.getInstance("MD5");
                    byte[] messageDigest = md.digest(contraseña.getBytes()); //EN VEZ DE INPUT PASARLE CONTRASEÑA
                    BigInteger number = new BigInteger(1, messageDigest);
                    String hashtext = number.toString(16);

                    while (hashtext.length() < 32) {
                        hashtext = "0" + hashtext;
                    }

                    Rol rol = rolControl.findRol(idRol);
                    
                    
                    usuario.setIdRol(rol);
                    usuario.setPassword(hashtext);
                    usuario.setCuenta(cuenta);
                    if(asociado != null){
                        if(asociado.length() > 0){
                            usuario.setAsociado(asociado);
                        }
                    }
                    usuarioControl.edit(usuario);
                    

                    if(asociado != null){
                        if(asociado.equals("ABOGADO")){
                            Integer idAbogado = Integer.parseInt(abogado);
                            Abogado abo = abogadoControl.findAbogado(idAbogado);

                            abo.setIdUsuario(usuario);
                            abogadoControl.edit(abo);


                        }

                        if(asociado.equals("CLIENTE")){
                            Integer idCliente = Integer.parseInt(cliente);
                            Cliente cli = clienteControl.findCliente(idCliente);

                            cli.setIdUsuario(usuario);
                            clienteControl.edit(cli);
                        }
                    }
                }else{
                    
                    request.getSession().setAttribute("mensajeErrorABM", "Un usuario con estado Inactivo no se puede editar");
                }
                
                
            }catch (Exception e) {
                System.out.println(e);
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
