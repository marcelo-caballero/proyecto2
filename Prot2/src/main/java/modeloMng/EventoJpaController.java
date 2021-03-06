/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.Evento;
import modelo.Expediente;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class EventoJpaController implements Serializable {

    public EventoJpaController() {
       this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Evento evento) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Expediente idExpediente = evento.getIdExpediente();
            if (idExpediente != null) {
                idExpediente = em.getReference(idExpediente.getClass(), idExpediente.getIdExpediente());
                evento.setIdExpediente(idExpediente);
            }
            em.persist(evento);
            if (idExpediente != null) {
                idExpediente.getEventoList().add(evento);
                idExpediente = em.merge(idExpediente);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Evento evento) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Evento persistentEvento = em.find(Evento.class, evento.getIdEvento());
            Expediente idExpedienteOld = persistentEvento.getIdExpediente();
            Expediente idExpedienteNew = evento.getIdExpediente();
            if (idExpedienteNew != null) {
                idExpedienteNew = em.getReference(idExpedienteNew.getClass(), idExpedienteNew.getIdExpediente());
                evento.setIdExpediente(idExpedienteNew);
            }
            evento = em.merge(evento);
            if (idExpedienteOld != null && !idExpedienteOld.equals(idExpedienteNew)) {
                idExpedienteOld.getEventoList().remove(evento);
                idExpedienteOld = em.merge(idExpedienteOld);
            }
            if (idExpedienteNew != null && !idExpedienteNew.equals(idExpedienteOld)) {
                idExpedienteNew.getEventoList().add(evento);
                idExpedienteNew = em.merge(idExpedienteNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = evento.getIdEvento();
                if (findEvento(id) == null) {
                    throw new NonexistentEntityException("The evento with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Evento evento;
            try {
                evento = em.getReference(Evento.class, id);
                evento.getIdEvento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The evento with id " + id + " no longer exists.", enfe);
            }
            Expediente idExpediente = evento.getIdExpediente();
            if (idExpediente != null) {
                idExpediente.getEventoList().remove(evento);
                idExpediente = em.merge(idExpediente);
            }
            em.remove(evento);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Evento> findEventoEntities() {
        return findEventoEntities(true, -1, -1);
    }

    public List<Evento> findEventoEntities(int maxResults, int firstResult) {
        return findEventoEntities(false, maxResults, firstResult);
    }

    private List<Evento> findEventoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Evento.class));
            Query q = em.createQuery(cq);
            if (!all) {
                q.setMaxResults(maxResults);
                q.setFirstResult(firstResult);
            }
            return q.getResultList();
        } finally {
            em.close();
        }
    }

    public Evento findEvento(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Evento.class, id);
        } finally {
            em.close();
        }
    }

    public int getEventoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Evento> rt = cq.from(Evento.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    public List<Evento> getListaEventosPorAbogados(Integer idAbogado){
        EntityManager em = getEntityManager();
        try {
           
            String consulta = "select e from Evento e where date_trunc('day',e.fecha)>= date_trunc('day',localtimestamp) and date_trunc('day',e.fecha)<= date_trunc('day',(localtimestamp + interval '3 day')) " +
                              " and e.idExpediente in (select ex.idExpediente.idExpediente from Expediente ex where ex.idAbogado.idAbogado = :idAbogado)";
            Query q = em.createQuery(consulta); 
            q.setParameter("idAbogado", idAbogado);
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna una lista de eventos que ocurrirán a partir de hoy hasta una cantidad de días especificado 
     * con una prioridad especificada de cada abogado.
     * Si el abogado es nulo, entonces traerá una lista de todos eventos que ocurriran en todos los expedientes
     * en el rango de tiempo especificado
     * @param dia cantidad de día a partir de hoy
     * @param prioridad puede ser "ALTA", "MEDIA", "BAJA"
     * @param idAbogado el idAbogado
     * @return List<Evento>
     * @throws ParseException 
     */
    public List<Evento> getListaEventos(Integer dia, String prioridad, Integer idAbogado) throws ParseException{
        EntityManager em = getEntityManager();
        try {
            Calendar c = Calendar.getInstance();
            c.setTime(new Date());
            c.add(Calendar.DATE, dia);
            Date traspasadoManana = c.getTime();
            
            SimpleDateFormat formatoHoy = new SimpleDateFormat("yyyy-MM-dd");
            SimpleDateFormat formatoTraspasadoManana = new SimpleDateFormat("yyyy-MM-ddHH:mm:ss");
            Date hoy = formatoHoy.parse(formatoHoy.format(new Date())); 
            traspasadoManana = formatoTraspasadoManana.parse(formatoHoy.format(traspasadoManana)+"23:59:59");
            
            String consulta = "select e from Evento e where e.fecha>= :hoy and e.fecha <= :traspasadoManana and e.prioridad = :prioridad ";
            
            if(idAbogado != null){
             consulta = consulta + "and e.idExpediente.idExpediente in (select ex.idExpediente from Expediente ex where ex.idAbogado.idAbogado = :idAbogado)";
            }
            Query q = em.createQuery(consulta); 
            q.setParameter("hoy", hoy);
            q.setParameter("traspasadoManana", traspasadoManana);
            q.setParameter("prioridad", prioridad);
            
            if(idAbogado != null){
                q.setParameter("idAbogado", idAbogado);
            }
            return q.getResultList();
        }finally {
            em.close();
        }
    }
    
    public List<Evento> getListaEventosNotificacion(){
        EntityManager em = getEntityManager();
        try {
            SimpleDateFormat formatoFecha = new SimpleDateFormat("yyyy-MM-ddHHmm");
            
            Date hoy = formatoFecha.parse(formatoFecha.format(new Date()));
            
            Calendar calendarMañana = Calendar.getInstance();
            calendarMañana.setTime(new Date());
            calendarMañana.add(Calendar.DATE, 1);
            Date mañana = formatoFecha.parse(formatoFecha.format(calendarMañana.getTime()));
            
            Calendar calendarPasadoMañana = Calendar.getInstance();
            calendarPasadoMañana.setTime(new Date());
            calendarPasadoMañana.add(Calendar.DATE, 2);
            Date pasadoMañana = formatoFecha.parse(formatoFecha.format(calendarPasadoMañana.getTime()));
            
            Calendar calendarTrasPasadoMañana = Calendar.getInstance();
            calendarTrasPasadoMañana.setTime(new Date());
            calendarTrasPasadoMañana.add(Calendar.DATE, 3);
            Date trasPasadoMañana = formatoFecha.parse(formatoFecha.format(calendarTrasPasadoMañana.getTime()));
            
            
            String consulta =  "select e from Evento e where (e.fecha = :hoy or e.fecha = :manana) and e.prioridad = 'BAJA' "+
                               "union "+
                               "select e from Evento e where (e.fecha = :hoy or e.fecha = :manana or e.fecha = :pasadoManana) and e.prioridad = 'MEDIA' "+
                               "union "+
                               "select e from Evento e where (e.fecha = :hoy or e.fecha = :manana or e.fecha = :pasadoManana or e.fecha = :trasPasadoManana) and e.prioridad = 'ALTA' ";
                               
            
            
            Query q = em.createQuery(consulta); 
            q.setParameter("hoy", hoy);
            q.setParameter("manana", mañana);
            q.setParameter("pasadoManana", pasadoMañana);
            q.setParameter("trasPasadoManana", trasPasadoMañana);
            
           
            return q.getResultList();
        }catch(ParseException e) {
            System.out.println(e);
            return new ArrayList<Evento>();
            
        }finally {
            em.close();
        }
    }
}
