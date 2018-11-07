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
import modelo.EstadoMarca;
import modelo.Expediente;
import modelo.HistorialEstadoMarca;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class HistorialEstadoMarcaJpaController implements Serializable {

    public HistorialEstadoMarcaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU"); 
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(HistorialEstadoMarca historialEstadoMarca) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            EstadoMarca idEstadoMarca = historialEstadoMarca.getIdEstadoMarca();
            if (idEstadoMarca != null) {
                idEstadoMarca = em.getReference(idEstadoMarca.getClass(), idEstadoMarca.getIdEstado());
                historialEstadoMarca.setIdEstadoMarca(idEstadoMarca);
            }
            Expediente idExpediente = historialEstadoMarca.getIdExpediente();
            if (idExpediente != null) {
                idExpediente = em.getReference(idExpediente.getClass(), idExpediente.getIdExpediente());
                historialEstadoMarca.setIdExpediente(idExpediente);
            }
            em.persist(historialEstadoMarca);
            if (idEstadoMarca != null) {
                idEstadoMarca.getHistorialEstadoMarcaList().add(historialEstadoMarca);
                idEstadoMarca = em.merge(idEstadoMarca);
            }
            if (idExpediente != null) {
                idExpediente.getHistorialEstadoMarcaList().add(historialEstadoMarca);
                idExpediente = em.merge(idExpediente);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(HistorialEstadoMarca historialEstadoMarca) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            HistorialEstadoMarca persistentHistorialEstadoMarca = em.find(HistorialEstadoMarca.class, historialEstadoMarca.getIdHistorial());
            EstadoMarca idEstadoMarcaOld = persistentHistorialEstadoMarca.getIdEstadoMarca();
            EstadoMarca idEstadoMarcaNew = historialEstadoMarca.getIdEstadoMarca();
            Expediente idExpedienteOld = persistentHistorialEstadoMarca.getIdExpediente();
            Expediente idExpedienteNew = historialEstadoMarca.getIdExpediente();
            if (idEstadoMarcaNew != null) {
                idEstadoMarcaNew = em.getReference(idEstadoMarcaNew.getClass(), idEstadoMarcaNew.getIdEstado());
                historialEstadoMarca.setIdEstadoMarca(idEstadoMarcaNew);
            }
            if (idExpedienteNew != null) {
                idExpedienteNew = em.getReference(idExpedienteNew.getClass(), idExpedienteNew.getIdExpediente());
                historialEstadoMarca.setIdExpediente(idExpedienteNew);
            }
            historialEstadoMarca = em.merge(historialEstadoMarca);
            if (idEstadoMarcaOld != null && !idEstadoMarcaOld.equals(idEstadoMarcaNew)) {
                idEstadoMarcaOld.getHistorialEstadoMarcaList().remove(historialEstadoMarca);
                idEstadoMarcaOld = em.merge(idEstadoMarcaOld);
            }
            if (idEstadoMarcaNew != null && !idEstadoMarcaNew.equals(idEstadoMarcaOld)) {
                idEstadoMarcaNew.getHistorialEstadoMarcaList().add(historialEstadoMarca);
                idEstadoMarcaNew = em.merge(idEstadoMarcaNew);
            }
            if (idExpedienteOld != null && !idExpedienteOld.equals(idExpedienteNew)) {
                idExpedienteOld.getHistorialEstadoMarcaList().remove(historialEstadoMarca);
                idExpedienteOld = em.merge(idExpedienteOld);
            }
            if (idExpedienteNew != null && !idExpedienteNew.equals(idExpedienteOld)) {
                idExpedienteNew.getHistorialEstadoMarcaList().add(historialEstadoMarca);
                idExpedienteNew = em.merge(idExpedienteNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = historialEstadoMarca.getIdHistorial();
                if (findHistorialEstadoMarca(id) == null) {
                    throw new NonexistentEntityException("The historialEstadoMarca with id " + id + " no longer exists.");
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
            HistorialEstadoMarca historialEstadoMarca;
            try {
                historialEstadoMarca = em.getReference(HistorialEstadoMarca.class, id);
                historialEstadoMarca.getIdHistorial();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The historialEstadoMarca with id " + id + " no longer exists.", enfe);
            }
            EstadoMarca idEstadoMarca = historialEstadoMarca.getIdEstadoMarca();
            if (idEstadoMarca != null) {
                idEstadoMarca.getHistorialEstadoMarcaList().remove(historialEstadoMarca);
                idEstadoMarca = em.merge(idEstadoMarca);
            }
            Expediente idExpediente = historialEstadoMarca.getIdExpediente();
            if (idExpediente != null) {
                idExpediente.getHistorialEstadoMarcaList().remove(historialEstadoMarca);
                idExpediente = em.merge(idExpediente);
            }
            em.remove(historialEstadoMarca);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<HistorialEstadoMarca> findHistorialEstadoMarcaEntities() {
        return findHistorialEstadoMarcaEntities(true, -1, -1);
    }

    public List<HistorialEstadoMarca> findHistorialEstadoMarcaEntities(int maxResults, int firstResult) {
        return findHistorialEstadoMarcaEntities(false, maxResults, firstResult);
    }

    private List<HistorialEstadoMarca> findHistorialEstadoMarcaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(HistorialEstadoMarca.class));
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

    public HistorialEstadoMarca findHistorialEstadoMarca(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(HistorialEstadoMarca.class, id);
        } finally {
            em.close();
        }
    }

    public int getHistorialEstadoMarcaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<HistorialEstadoMarca> rt = cq.from(HistorialEstadoMarca.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    /**
     * Obtiene una lista de estado de marca del expediente
     * @param idExpediente
     * @return List<HistorialEstadoMarca>
     */
     public List<HistorialEstadoMarca> getHistorialEstadoMarcaPorIdExpediente(Integer idExpediente) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select h from HistorialEstadoMarca h where h.idExpediente.idExpediente = :idExpediente order by h.fechaRegistro";
            
            Query q = em.createQuery(consulta); 
            
            q.setParameter("idExpediente", idExpediente);
            
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
}
