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
        
        if(request.getParameter("reporteIngresos") != null){
            String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
            String fechaHasta = request.getParameter("fechaHasta");//lo mismo
            String idCliente = request.getParameter("idCliente"); //si es -1 es todes
            
            System.out.println("Ingreso"+fechaDesde+" "+fechaHasta+" "+idCliente);
        
        }
        
        if(request.getParameter("reporteOposicionRecibida") != null){
            
            String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
            String fechaHasta = request.getParameter("fechaHasta");//lo mismo
            String idCliente = request.getParameter("idCliente"); //si es -1 es todes
            String idMarca = request.getParameter("idMarca");//si es -1 es todes
            String idAbogado = request.getParameter("idAbogado");////si es -1 es todes
            String estadoGanadaOperdida = request.getParameter("ganadaOperdida");//si 0 es ganada y perdida, -1 perdida , 1 ganada
            
            System.out.println("OR"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+idMarca+" "+idAbogado+" "+estadoGanadaOperdida);
        }
        
        if(request.getParameter("reporteOposicionHecha") != null){
            
            String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
            String fechaHasta = request.getParameter("fechaHasta");//lo mismo
            String idCliente = request.getParameter("idCliente"); //si es -1 es todes
            String idMarca = request.getParameter("idMarca");//si es -1 es todes
            String idAbogado = request.getParameter("idAbogado");////si es -1 es todes
            String estadoGanadaOperdida = request.getParameter("ganadaOperdida");//si 0 es ganada y perdida, -1 perdida , 1 ganada
            
            System.out.println("OH"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+idMarca+" "+idAbogado+" "+estadoGanadaOperdida);
        }
        
        if(request.getParameter("reporteExpediente") != null){
            
            String fechaDesde = request.getParameter("fechaDesde");//si no se envia fecha es un string con longitud 0
            String fechaHasta = request.getParameter("fechaHasta");//lo mismo
            String idCliente = request.getParameter("idCliente"); //si es -1 es todes
            String idAbogado = request.getParameter("idAbogado");////si es -1 es todes
            String idEstadoMarca = request.getParameter("idEstadoMarca");////si es -1 es todes
            
            System.out.println("Exp"+fechaDesde+" "+fechaHasta+" "+idCliente+" "+" "+idAbogado+" "+idEstadoMarca);
        }
        
    }

   
    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
