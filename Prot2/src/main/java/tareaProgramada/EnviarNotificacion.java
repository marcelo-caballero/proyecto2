/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package tareaProgramada;

import java.util.List;
import modelo.Evento;
import modelo.EventoOposicionHecha;
import modeloMng.EventoJpaController;
import modeloMng.EventoOposicionHechaJpaController;

/**
 *
 * @author User
 */
public class EnviarNotificacion  implements Runnable{
    //notificaciones de expediente
    private EventoJpaController eventoControl = new EventoJpaController();
    
    
    //notificaciones de oposiciones hechas
    private EventoOposicionHechaJpaController eventoOposicionControl = new EventoOposicionHechaJpaController();
    
    
    //configuracion 
    private Correo correo;
    
    @Override
    public void run() {
        enviarEventoExpedientes();
        enviarEventoOposicionHecha();
    }
    
    private void enviarEventoExpedientes(){
        correo = new Correo(); 
        List<Evento> lista = eventoControl.getListaEventosNotificacion();
        
        String destinatario = "";
        String mensaje = "";
        String asunto = "Evento del Expediente ";
        
                
        if(!lista.isEmpty()){
            
            for(int i=0;i<lista.size();i++){
                destinatario = lista.get(i).getIdExpediente().getIdAbogado().getEmail();
                asunto = asunto + "Nº: " + lista.get(i).getIdExpediente().getNroExpediente();
                mensaje = "Evento: " + lista.get(i).getNombre()+"\n";
                mensaje = mensaje + "Prioridad: "+ lista.get(i).getPrioridad()+"\n";
                mensaje = mensaje + "Programado: "+lista.get(i).getStringFecha()+" a las "+lista.get(i).getStringHora()+":"+lista.get(i).getStringMinuto()+" hs." + "\n";
                mensaje = mensaje + "Descripción: "+ lista.get(i).getDescripcion()+"\n";
                mensaje = mensaje +"\n\nSistema Taangapp \n";
                
                correo.enviarCorreo(destinatario, asunto, mensaje);
                
                asunto = "Evento del Expediente ";
                mensaje = "";
            }
        }
    }

    private void enviarEventoOposicionHecha() {
        correo = new Correo(); 
        List<EventoOposicionHecha> listaOposicion = eventoOposicionControl.getListaEventosNotificacion();
        
        String destinatario = "";
        String mensaje = "";
        String asunto = "Evento de Oposición ";
        
                
        if(!listaOposicion.isEmpty()){
            
            for(int i=0;i<listaOposicion.size();i++){
                destinatario = listaOposicion.get(i).getIdOposicionHecha().getIdAbogadoOpositante().getEmail(); 
                asunto = asunto + "Nº Expediente Opositado:" + listaOposicion.get(i).getIdOposicionHecha().getNroExpedienteOpositado();
                mensaje = "Evento: " + listaOposicion.get(i).getNombre()+"\n";
                mensaje = mensaje + "Prioridad: "+ listaOposicion.get(i).getPrioridad()+"\n";
                mensaje = mensaje + "Programado: "+listaOposicion.get(i).getStringFecha()+" a las "+listaOposicion.get(i).getStringHora()+":"+listaOposicion.get(i).getStringMinuto()+" hs." + "\n";
                mensaje = mensaje + "Descripción: "+ listaOposicion.get(i).getDescripcion()+"\n";
                mensaje = mensaje +"\n\nSistema Taangapp \n";
                
                correo.enviarCorreo(destinatario, asunto, mensaje);
                
                asunto = "Evento de Oposición ";
                mensaje = "";
            }
        }
    }
}
