/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import modeloMng.exceptions.NonexistentEntityException;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.TipoExpediente;

/**
 *
 * @author Acer
 */
public class TipoExpedienteJpaController implements Serializable {

    public TipoExpedienteJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TipoExpediente tipoExpediente) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(tipoExpediente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TipoExpediente tipoExpediente) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            tipoExpediente = em.merge(tipoExpediente);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tipoExpediente.getIdTipoExpediente();
                if (findTipoExpediente(id) == null) {
                    throw new NonexistentEntityException("The tipoExpediente with id " + id + " no longer exists.");
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
            TipoExpediente tipoExpediente;
            try {
                tipoExpediente = em.getReference(TipoExpediente.class, id);
                tipoExpediente.getIdTipoExpediente();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tipoExpediente with id " + id + " no longer exists.", enfe);
            }
            em.remove(tipoExpediente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TipoExpediente> findTipoExpedienteEntities() {
        return findTipoExpedienteEntities(true, -1, -1);
    }

    public List<TipoExpediente> findTipoExpedienteEntities(int maxResults, int firstResult) {
        return findTipoExpedienteEntities(false, maxResults, firstResult);
    }

    private List<TipoExpediente> findTipoExpedienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(TipoExpediente.class));
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

    public TipoExpediente findTipoExpediente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TipoExpediente.class, id);
        } finally {
            em.close();
        }
    }

    public int getTipoExpedienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<TipoExpediente> rt = cq.from(TipoExpediente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
