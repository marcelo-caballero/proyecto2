/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.HistorialEstadoOposicionRecibida;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.OposicionRecibida;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class OposicionRecibidaJpaController implements Serializable {

    public OposicionRecibidaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(OposicionRecibida oposicionRecibida) {
        if (oposicionRecibida.getHistorialEstadoOposicionRecibidaList() == null) {
            oposicionRecibida.setHistorialEstadoOposicionRecibidaList(new ArrayList<HistorialEstadoOposicionRecibida>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<HistorialEstadoOposicionRecibida> attachedHistorialEstadoOposicionRecibidaList = new ArrayList<HistorialEstadoOposicionRecibida>();
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach : oposicionRecibida.getHistorialEstadoOposicionRecibidaList()) {
                historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach = em.getReference(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach.getClass(), historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach.getIdHistorial());
                attachedHistorialEstadoOposicionRecibidaList.add(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach);
            }
            oposicionRecibida.setHistorialEstadoOposicionRecibidaList(attachedHistorialEstadoOposicionRecibidaList);
            em.persist(oposicionRecibida);
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida : oposicionRecibida.getHistorialEstadoOposicionRecibidaList()) {
                OposicionRecibida oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida = historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida.getIdOposicionRecibida();
                historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida.setIdOposicionRecibida(oposicionRecibida);
                historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida = em.merge(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida);
                if (oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida != null) {
                    oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida.getHistorialEstadoOposicionRecibidaList().remove(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida);
                    oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida = em.merge(oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(OposicionRecibida oposicionRecibida) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            OposicionRecibida persistentOposicionRecibida = em.find(OposicionRecibida.class, oposicionRecibida.getIdOposicion());
            List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaListOld = persistentOposicionRecibida.getHistorialEstadoOposicionRecibidaList();
            List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaListNew = oposicionRecibida.getHistorialEstadoOposicionRecibidaList();
            List<String> illegalOrphanMessages = null;
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListOldHistorialEstadoOposicionRecibida : historialEstadoOposicionRecibidaListOld) {
                if (!historialEstadoOposicionRecibidaListNew.contains(historialEstadoOposicionRecibidaListOldHistorialEstadoOposicionRecibida)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain HistorialEstadoOposicionRecibida " + historialEstadoOposicionRecibidaListOldHistorialEstadoOposicionRecibida + " since its idOposicionRecibida field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<HistorialEstadoOposicionRecibida> attachedHistorialEstadoOposicionRecibidaListNew = new ArrayList<HistorialEstadoOposicionRecibida>();
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibidaToAttach : historialEstadoOposicionRecibidaListNew) {
                historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibidaToAttach = em.getReference(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibidaToAttach.getClass(), historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibidaToAttach.getIdHistorial());
                attachedHistorialEstadoOposicionRecibidaListNew.add(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibidaToAttach);
            }
            historialEstadoOposicionRecibidaListNew = attachedHistorialEstadoOposicionRecibidaListNew;
            oposicionRecibida.setHistorialEstadoOposicionRecibidaList(historialEstadoOposicionRecibidaListNew);
            oposicionRecibida = em.merge(oposicionRecibida);
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida : historialEstadoOposicionRecibidaListNew) {
                if (!historialEstadoOposicionRecibidaListOld.contains(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida)) {
                    OposicionRecibida oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida = historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.getIdOposicionRecibida();
                    historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.setIdOposicionRecibida(oposicionRecibida);
                    historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida = em.merge(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida);
                    if (oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida != null && !oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.equals(oposicionRecibida)) {
                        oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.getHistorialEstadoOposicionRecibidaList().remove(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida);
                        oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida = em.merge(oldIdOposicionRecibidaOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = oposicionRecibida.getIdOposicion();
                if (findOposicionRecibida(id) == null) {
                    throw new NonexistentEntityException("The oposicionRecibida with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(Integer id) throws IllegalOrphanException, NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            OposicionRecibida oposicionRecibida;
            try {
                oposicionRecibida = em.getReference(OposicionRecibida.class, id);
                oposicionRecibida.getIdOposicion();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The oposicionRecibida with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaListOrphanCheck = oposicionRecibida.getHistorialEstadoOposicionRecibidaList();
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListOrphanCheckHistorialEstadoOposicionRecibida : historialEstadoOposicionRecibidaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This OposicionRecibida (" + oposicionRecibida + ") cannot be destroyed since the HistorialEstadoOposicionRecibida " + historialEstadoOposicionRecibidaListOrphanCheckHistorialEstadoOposicionRecibida + " in its historialEstadoOposicionRecibidaList field has a non-nullable idOposicionRecibida field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(oposicionRecibida);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<OposicionRecibida> findOposicionRecibidaEntities() {
        return findOposicionRecibidaEntities(true, -1, -1);
    }

    public List<OposicionRecibida> findOposicionRecibidaEntities(int maxResults, int firstResult) {
        return findOposicionRecibidaEntities(false, maxResults, firstResult);
    }

    private List<OposicionRecibida> findOposicionRecibidaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(OposicionRecibida.class));
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

    public OposicionRecibida findOposicionRecibida(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(OposicionRecibida.class, id);
        } finally {
            em.close();
        }
    }

    public int getOposicionRecibidaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<OposicionRecibida> rt = cq.from(OposicionRecibida.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
