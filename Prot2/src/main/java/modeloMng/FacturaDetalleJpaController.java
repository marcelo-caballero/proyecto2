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
import modelo.FacturaCabecera;
import modelo.FacturaDetalle;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class FacturaDetalleJpaController implements Serializable {

    public FacturaDetalleJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(FacturaDetalle facturaDetalle) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            FacturaCabecera idFactura = facturaDetalle.getIdFactura();
            if (idFactura != null) {
                idFactura = em.getReference(idFactura.getClass(), idFactura.getIdFactura());
                facturaDetalle.setIdFactura(idFactura);
            }
            em.persist(facturaDetalle);
            if (idFactura != null) {
                idFactura.getFacturaDetalleList().add(facturaDetalle);
                idFactura = em.merge(idFactura);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(FacturaDetalle facturaDetalle) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            FacturaDetalle persistentFacturaDetalle = em.find(FacturaDetalle.class, facturaDetalle.getIdFacturaDetalle());
            FacturaCabecera idFacturaOld = persistentFacturaDetalle.getIdFactura();
            FacturaCabecera idFacturaNew = facturaDetalle.getIdFactura();
            if (idFacturaNew != null) {
                idFacturaNew = em.getReference(idFacturaNew.getClass(), idFacturaNew.getIdFactura());
                facturaDetalle.setIdFactura(idFacturaNew);
            }
            facturaDetalle = em.merge(facturaDetalle);
            if (idFacturaOld != null && !idFacturaOld.equals(idFacturaNew)) {
                idFacturaOld.getFacturaDetalleList().remove(facturaDetalle);
                idFacturaOld = em.merge(idFacturaOld);
            }
            if (idFacturaNew != null && !idFacturaNew.equals(idFacturaOld)) {
                idFacturaNew.getFacturaDetalleList().add(facturaDetalle);
                idFacturaNew = em.merge(idFacturaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = facturaDetalle.getIdFacturaDetalle();
                if (findFacturaDetalle(id) == null) {
                    throw new NonexistentEntityException("The facturaDetalle with id " + id + " no longer exists.");
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
            FacturaDetalle facturaDetalle;
            try {
                facturaDetalle = em.getReference(FacturaDetalle.class, id);
                facturaDetalle.getIdFacturaDetalle();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The facturaDetalle with id " + id + " no longer exists.", enfe);
            }
            FacturaCabecera idFactura = facturaDetalle.getIdFactura();
            if (idFactura != null) {
                idFactura.getFacturaDetalleList().remove(facturaDetalle);
                idFactura = em.merge(idFactura);
            }
            em.remove(facturaDetalle);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<FacturaDetalle> findFacturaDetalleEntities() {
        return findFacturaDetalleEntities(true, -1, -1);
    }

    public List<FacturaDetalle> findFacturaDetalleEntities(int maxResults, int firstResult) {
        return findFacturaDetalleEntities(false, maxResults, firstResult);
    }

    private List<FacturaDetalle> findFacturaDetalleEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(FacturaDetalle.class));
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

    public FacturaDetalle findFacturaDetalle(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(FacturaDetalle.class, id);
        } finally {
            em.close();
        }
    }

    public int getFacturaDetalleCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<FacturaDetalle> rt = cq.from(FacturaDetalle.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
