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
import modeloMng.RolJpaController;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
@WebServlet(name = "RolServlet", urlPatterns = {"/RolServlet"})
public class RolServlet extends HttpServlet {

    

    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        /*Retorna un json a la consulta del ajax
          Si ya existe un nombre porexpediente, retorna true
          caso contrario, false
        */
        RolJpaController rolControl = new RolJpaController();
        Boolean existeRol = null;
        Integer idRol = null;
        
        String rol = request.getParameter("existeRol");
        
        
        //Cuando la operacion es editar 
        
        if(request.getParameter("idRol") != null){
            idRol = Integer.parseInt(request.getParameter("idRol"));
        }
        
        //La operacion es agregar
        if(rol != null){
           
            existeRol = rolControl.existeRolDuplicado(rol,idRol); 
            
            try (PrintWriter out = response.getWriter()) {
                out.println("{\"existeRol\":"+existeRol+"}");
            }
        }
        /**/
     
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        
        
        RolJpaController rolControl = new RolJpaController();
        
        //Eliminar
        if(request.getParameter("eliminar")!= null){
            
            Integer idRol = Integer.parseInt(request.getParameter("idRol")); 
            
            try {
                rolControl.destroy(idRol);
                
            }catch(IllegalOrphanException e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "El rol se encuentra asignado a uno o varios usuarios");
            
            }catch(Exception e){
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo eliminar el rol");
                
            }finally{
                
                response.sendRedirect("roles.jsp");
            }
             
        }
        
        //Guardar
        if(request.getParameter("agregar")!= null){
            try{
                
                String descripcion = request.getParameter("descripcion");
                String nombreRol = request.getParameter("rol");
                
                Rol rol = new Rol();
                rol.setRol(nombreRol);
                rol.setDescripcion(descripcion);
                rol.setEstado("NO ASIGNADO");
                
                rolControl.create(rol);
                
            }catch (Exception e) {
                //System.out.println("Excepcion:\n"+e);
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo agregar el rol");
            
            }finally{
                
                response.sendRedirect("roles.jsp");
            }
        }
        
        //Editar
        if(request.getParameter("editar")!= null){
            try{
                Integer idRol = Integer.parseInt(request.getParameter("idRol"));
                
                Rol rol = rolControl.findRol(idRol);
                String nombreRol = request.getParameter("rol");
                String descripcion = request.getParameter("descripcion");
                
                rol.setRol(nombreRol);
                rol.setDescripcion(descripcion);
                
                if(rol.getEstado().equals("NO ASIGNADO")){
                    rolControl.edit(rol);
                }
                
            }catch (Exception e) {
                
                request.getSession().setAttribute("mensajeErrorABM", "No se pudo editar el rol");
            
            }finally{
                
                response.sendRedirect("roles.jsp");
            }
        }
        
        
    }

    
    @Override
    public String getServletInfo() {
        return "ABM Rol";
    }

}
