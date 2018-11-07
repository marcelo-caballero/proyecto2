/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.EventoOposicionHecha;
import modelo.OposicionHecha;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class EventoOposicionHechaJpaController implements Serializable {

    public EventoOposicionHechaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(EventoOposicionHecha eventoOposicionHecha) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            OposicionHecha idOposicionHecha = eventoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHecha != null) {
                idOposicionHecha = em.getReference(idOposicionHecha.getClass(), idOposicionHecha.getIdOposicion());
                eventoOposicionHecha.setIdOposicionHecha(idOposicionHecha);
            }
            em.persist(eventoOposicionHecha);
            if (idOposicionHecha != null) {
                idOposicionHecha.getEventoOposicionHechaList().add(eventoOposicionHecha);
                idOposicionHecha = em.merge(idOposicionHecha);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(EventoOposicionHecha eventoOposicionHecha) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            EventoOposicionHecha persistentEventoOposicionHecha = em.find(EventoOposicionHecha.class, eventoOposicionHecha.getIdEvento());
            OposicionHecha idOposicionHechaOld = persistentEventoOposicionHecha.getIdOposicionHecha();
            OposicionHecha idOposicionHechaNew = eventoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHechaNew != null) {
                idOposicionHechaNew = em.getReference(idOposicionHechaNew.getClass(), idOposicionHechaNew.getIdOposicion());
                eventoOposicionHecha.setIdOposicionHecha(idOposicionHechaNew);
            }
            eventoOposicionHecha = em.merge(eventoOposicionHecha);
            if (idOposicionHechaOld != null && !idOposicionHechaOld.equals(idOposicionHechaNew)) {
                idOposicionHechaOld.getEventoOposicionHechaList().remove(eventoOposicionHecha);
                idOposicionHechaOld = em.merge(idOposicionHechaOld);
            }
            if (idOposicionHechaNew != null && !idOposicionHechaNew.equals(idOposicionHechaOld)) {
                idOposicionHechaNew.getEventoOposicionHechaList().add(eventoOposicionHecha);
                idOposicionHechaNew = em.merge(idOposicionHechaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = eventoOposicionHecha.getIdEvento();
                if (findEventoOposicionHecha(id) == null) {
                    throw new NonexistentEntityException("The eventoOposicionHecha with id " + id + " no longer exists.");
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
            EventoOposicionHecha eventoOposicionHecha;
            try {
                eventoOposicionHecha = em.getReference(EventoOposicionHecha.class, id);
                eventoOposicionHecha.getIdEvento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The eventoOposicionHecha with id " + id + " no longer exists.", enfe);
            }
            OposicionHecha idOposicionHecha = eventoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHecha != null) {
                idOposicionHecha.getEventoOposicionHechaList().remove(eventoOposicionHecha);
                idOposicionHecha = em.merge(idOposicionHecha);
            }
            em.remove(eventoOposicionHecha);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<EventoOposicionHecha> findEventoOposicionHechaEntities() {
        return findEventoOposicionHechaEntities(true, -1, -1);
    }

    public List<EventoOposicionHecha> findEventoOposicionHechaEntities(int maxResults, int firstResult) {
        return findEventoOposicionHechaEntities(false, maxResults, firstResult);
    }

    private List<EventoOposicionHecha> findEventoOposicionHechaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(EventoOposicionHecha.class));
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

    public EventoOposicionHecha findEventoOposicionHecha(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(EventoOposicionHecha.class, id);
        } finally {
            em.close();
        }
    }

    public int getEventoOposicionHechaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<EventoOposicionHecha> rt = cq.from(EventoOposicionHecha.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}