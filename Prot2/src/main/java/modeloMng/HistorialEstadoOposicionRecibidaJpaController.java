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
import modelo.HistorialEstadoOposicionRecibida;
import modelo.OposicionRecibida;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class HistorialEstadoOposicionRecibidaJpaController implements Serializable {

    public HistorialEstadoOposicionRecibidaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(HistorialEstadoOposicionRecibida historialEstadoOposicionRecibida) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            OposicionRecibida idOposicionRecibida = historialEstadoOposicionRecibida.getIdOposicionRecibida();
            if (idOposicionRecibida != null) {
                idOposicionRecibida = em.getReference(idOposicionRecibida.getClass(), idOposicionRecibida.getIdOposicion());
                historialEstadoOposicionRecibida.setIdOposicionRecibida(idOposicionRecibida);
            }
            em.persist(historialEstadoOposicionRecibida);
            if (idOposicionRecibida != null) {
                idOposicionRecibida.getHistorialEstadoOposicionRecibidaList().add(historialEstadoOposicionRecibida);
                idOposicionRecibida = em.merge(idOposicionRecibida);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(HistorialEstadoOposicionRecibida historialEstadoOposicionRecibida) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            HistorialEstadoOposicionRecibida persistentHistorialEstadoOposicionRecibida = em.find(HistorialEstadoOposicionRecibida.class, historialEstadoOposicionRecibida.getIdHistorial());
            OposicionRecibida idOposicionRecibidaOld = persistentHistorialEstadoOposicionRecibida.getIdOposicionRecibida();
            OposicionRecibida idOposicionRecibidaNew = historialEstadoOposicionRecibida.getIdOposicionRecibida();
            if (idOposicionRecibidaNew != null) {
                idOposicionRecibidaNew = em.getReference(idOposicionRecibidaNew.getClass(), idOposicionRecibidaNew.getIdOposicion());
                historialEstadoOposicionRecibida.setIdOposicionRecibida(idOposicionRecibidaNew);
            }
            historialEstadoOposicionRecibida = em.merge(historialEstadoOposicionRecibida);
            if (idOposicionRecibidaOld != null && !idOposicionRecibidaOld.equals(idOposicionRecibidaNew)) {
                idOposicionRecibidaOld.getHistorialEstadoOposicionRecibidaList().remove(historialEstadoOposicionRecibida);
                idOposicionRecibidaOld = em.merge(idOposicionRecibidaOld);
            }
            if (idOposicionRecibidaNew != null && !idOposicionRecibidaNew.equals(idOposicionRecibidaOld)) {
                idOposicionRecibidaNew.getHistorialEstadoOposicionRecibidaList().add(historialEstadoOposicionRecibida);
                idOposicionRecibidaNew = em.merge(idOposicionRecibidaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = historialEstadoOposicionRecibida.getIdHistorial();
                if (findHistorialEstadoOposicionRecibida(id) == null) {
                    throw new NonexistentEntityException("The historialEstadoOposicionRecibida with id " + id + " no longer exists.");
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
            HistorialEstadoOposicionRecibida historialEstadoOposicionRecibida;
            try {
                historialEstadoOposicionRecibida = em.getReference(HistorialEstadoOposicionRecibida.class, id);
                historialEstadoOposicionRecibida.getIdHistorial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The historialEstadoOposicionRecibida with id " + id + " no longer exists.", enfe);
            }
            OposicionRecibida idOposicionRecibida = historialEstadoOposicionRecibida.getIdOposicionRecibida();
            if (idOposicionRecibida != null) {
                idOposicionRecibida.getHistorialEstadoOposicionRecibidaList().remove(historialEstadoOposicionRecibida);
                idOposicionRecibida = em.merge(idOposicionRecibida);
            }
            em.remove(historialEstadoOposicionRecibida);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<HistorialEstadoOposicionRecibida> findHistorialEstadoOposicionRecibidaEntities() {
        return findHistorialEstadoOposicionRecibidaEntities(true, -1, -1);
    }

    public List<HistorialEstadoOposicionRecibida> findHistorialEstadoOposicionRecibidaEntities(int maxResults, int firstResult) {
        return findHistorialEstadoOposicionRecibidaEntities(false, maxResults, firstResult);
    }

    private List<HistorialEstadoOposicionRecibida> findHistorialEstadoOposicionRecibidaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(HistorialEstadoOposicionRecibida.class));
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

    public HistorialEstadoOposicionRecibida findHistorialEstadoOposicionRecibida(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(HistorialEstadoOposicionRecibida.class, id);
        } finally {
            em.close();
        }
    }

    public int getHistorialEstadoOposicionRecibidaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<HistorialEstadoOposicionRecibida> rt = cq.from(HistorialEstadoOposicionRecibida.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    /**
     * Retorna una lista del historial de estado  de la Oposicion
     * dada si Id(clave primaria)
     * @param idOposicion
     * @return List<HistorialEstadoOposicionRecibida>
     */
    public List<HistorialEstadoOposicionRecibida> getHistorialEstadoOposicionPorIdOposicion(Integer idOposicion) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select h from HistorialEstadoOposicionRecibida h where h.idOposicionRecibida.idOposicion = :idOposicion";
            
            Query q = em.createQuery(consulta); 
            
            q.setParameter("idOposicion", idOposicion);
            
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
}
