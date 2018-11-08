
package modeloMng;

import modeloMng.exceptions.NonexistentEntityException;
import modeloMng.exceptions.PreexistingEntityException;
import java.io.Serializable;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.Prefijo;

/**
 *
 * @author Pathy
 */
public class PrefijoJpaController implements Serializable {

    public PrefijoJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Prefijo prefijo) throws PreexistingEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            em.persist(prefijo);
            em.getTransaction().commit();
        } catch (Exception ex) {
            if (findPrefijo(prefijo.getPrefijo()) != null) {
                throw new PreexistingEntityException("Prefijo " + prefijo + " already exists.", ex);
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Prefijo prefijo) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            prefijo = em.merge(prefijo);
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                String id = prefijo.getPrefijo();
                if (findPrefijo(id) == null) {
                    throw new NonexistentEntityException("The prefijo with id " + id + " no longer exists.");
                }
            }
            throw ex;
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void destroy(String id) throws NonexistentEntityException {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Prefijo prefijo;
            try {
                prefijo = em.getReference(Prefijo.class, id);
                prefijo.getPrefijo();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The prefijo with id " + id + " no longer exists.", enfe);
            }
            em.remove(prefijo);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Prefijo> findPrefijoEntities() {
        return findPrefijoEntities(true, -1, -1);
    }

    public List<Prefijo> findPrefijoEntities(int maxResults, int firstResult) {
        return findPrefijoEntities(false, maxResults, firstResult);
    }

    private List<Prefijo> findPrefijoEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(Prefijo.class));
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

    public Prefijo findPrefijo(String id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Prefijo.class, id);
        } finally {
            em.close();
        }
    }

    public int getPrefijoCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Prefijo> rt = cq.from(Prefijo.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
