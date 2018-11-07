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
import modelo.EstadoOposicion;
import modelo.HistorialEstadoOposicionHecha;
import modelo.OposicionHecha;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class HistorialEstadoOposicionHechaJpaController implements Serializable {

    public HistorialEstadoOposicionHechaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(HistorialEstadoOposicionHecha historialEstadoOposicionHecha) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            EstadoOposicion idEstadoOposicion = historialEstadoOposicionHecha.getIdEstadoOposicion();
            if (idEstadoOposicion != null) {
                idEstadoOposicion = em.getReference(idEstadoOposicion.getClass(), idEstadoOposicion.getIdEstado());
                historialEstadoOposicionHecha.setIdEstadoOposicion(idEstadoOposicion);
            }
            OposicionHecha idOposicionHecha = historialEstadoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHecha != null) {
                idOposicionHecha = em.getReference(idOposicionHecha.getClass(), idOposicionHecha.getIdOposicion());
                historialEstadoOposicionHecha.setIdOposicionHecha(idOposicionHecha);
            }
            em.persist(historialEstadoOposicionHecha);
            if (idEstadoOposicion != null) {
                idEstadoOposicion.getHistorialEstadoOposicionHechaList().add(historialEstadoOposicionHecha);
                idEstadoOposicion = em.merge(idEstadoOposicion);
            }
            if (idOposicionHecha != null) {
                idOposicionHecha.getHistorialEstadoOposicionHechaList().add(historialEstadoOposicionHecha);
                idOposicionHecha = em.merge(idOposicionHecha);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(HistorialEstadoOposicionHecha historialEstadoOposicionHecha) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            HistorialEstadoOposicionHecha persistentHistorialEstadoOposicionHecha = em.find(HistorialEstadoOposicionHecha.class, historialEstadoOposicionHecha.getIdHistorial());
            EstadoOposicion idEstadoOposicionOld = persistentHistorialEstadoOposicionHecha.getIdEstadoOposicion();
            EstadoOposicion idEstadoOposicionNew = historialEstadoOposicionHecha.getIdEstadoOposicion();
            OposicionHecha idOposicionHechaOld = persistentHistorialEstadoOposicionHecha.getIdOposicionHecha();
            OposicionHecha idOposicionHechaNew = historialEstadoOposicionHecha.getIdOposicionHecha();
            if (idEstadoOposicionNew != null) {
                idEstadoOposicionNew = em.getReference(idEstadoOposicionNew.getClass(), idEstadoOposicionNew.getIdEstado());
                historialEstadoOposicionHecha.setIdEstadoOposicion(idEstadoOposicionNew);
            }
            if (idOposicionHechaNew != null) {
                idOposicionHechaNew = em.getReference(idOposicionHechaNew.getClass(), idOposicionHechaNew.getIdOposicion());
                historialEstadoOposicionHecha.setIdOposicionHecha(idOposicionHechaNew);
            }
            historialEstadoOposicionHecha = em.merge(historialEstadoOposicionHecha);
            if (idEstadoOposicionOld != null && !idEstadoOposicionOld.equals(idEstadoOposicionNew)) {
                idEstadoOposicionOld.getHistorialEstadoOposicionHechaList().remove(historialEstadoOposicionHecha);
                idEstadoOposicionOld = em.merge(idEstadoOposicionOld);
            }
            if (idEstadoOposicionNew != null && !idEstadoOposicionNew.equals(idEstadoOposicionOld)) {
                idEstadoOposicionNew.getHistorialEstadoOposicionHechaList().add(historialEstadoOposicionHecha);
                idEstadoOposicionNew = em.merge(idEstadoOposicionNew);
            }
            if (idOposicionHechaOld != null && !idOposicionHechaOld.equals(idOposicionHechaNew)) {
                idOposicionHechaOld.getHistorialEstadoOposicionHechaList().remove(historialEstadoOposicionHecha);
                idOposicionHechaOld = em.merge(idOposicionHechaOld);
            }
            if (idOposicionHechaNew != null && !idOposicionHechaNew.equals(idOposicionHechaOld)) {
                idOposicionHechaNew.getHistorialEstadoOposicionHechaList().add(historialEstadoOposicionHecha);
                idOposicionHechaNew = em.merge(idOposicionHechaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = historialEstadoOposicionHecha.getIdHistorial();
                if (findHistorialEstadoOposicionHecha(id) == null) {
                    throw new NonexistentEntityException("The historialEstadoOposicionHecha with id " + id + " no longer exists.");
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
            HistorialEstadoOposicionHecha historialEstadoOposicionHecha;
            try {
                historialEstadoOposicionHecha = em.getReference(HistorialEstadoOposicionHecha.class, id);
                historialEstadoOposicionHecha.getIdHistorial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The historialEstadoOposicionHecha with id " + id + " no longer exists.", enfe);
            }
            EstadoOposicion idEstadoOposicion = historialEstadoOposicionHecha.getIdEstadoOposicion();
            if (idEstadoOposicion != null) {
                idEstadoOposicion.getHistorialEstadoOposicionHechaList().remove(historialEstadoOposicionHecha);
                idEstadoOposicion = em.merge(idEstadoOposicion);
            }
            OposicionHecha idOposicionHecha = historialEstadoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHecha != null) {
                idOposicionHecha.getHistorialEstadoOposicionHechaList().remove(historialEstadoOposicionHecha);
                idOposicionHecha = em.merge(idOposicionHecha);
            }
            em.remove(historialEstadoOposicionHecha);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<HistorialEstadoOposicionHecha> findHistorialEstadoOposicionHechaEntities() {
        return findHistorialEstadoOposicionHechaEntities(true, -1, -1);
    }

    public List<HistorialEstadoOposicionHecha> findHistorialEstadoOposicionHechaEntities(int maxResults, int firstResult) {
        return findHistorialEstadoOposicionHechaEntities(false, maxResults, firstResult);
    }

    private List<HistorialEstadoOposicionHecha> findHistorialEstadoOposicionHechaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(HistorialEstadoOposicionHecha.class));
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

    public HistorialEstadoOposicionHecha findHistorialEstadoOposicionHecha(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(HistorialEstadoOposicionHecha.class, id);
        } finally {
            em.close();
        }
    }

    public int getHistorialEstadoOposicionHechaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<HistorialEstadoOposicionHecha> rt = cq.from(HistorialEstadoOposicionHecha.class);
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
     * @return List<HistorialEstadoOposicionHecha>
     */
    public List<HistorialEstadoOposicionHecha> getHistorialEstadoOposicionPorIdOposicion(Integer idOposicion) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select h from HistorialEstadoOposicionHecha h where h.idOposicionHecha.idOposicion = :idOposicion order by h.fechaRegistro";
            
            Query q = em.createQuery(consulta); 
            
            q.setParameter("idOposicion", idOposicion);
            
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
}
