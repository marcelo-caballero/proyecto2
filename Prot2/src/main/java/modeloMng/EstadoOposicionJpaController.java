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
import javax.persistence.criteria.CriteriaBuilder;
import modelo.EstadoOposicion;
import modelo.EstadoOposicion_;
import modelo.OposicionRecibida;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class EstadoOposicionJpaController implements Serializable {

    public EstadoOposicionJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(EstadoOposicion estadoOposicion) {
        if (estadoOposicion.getHistorialEstadoOposicionRecibidaList() == null) {
            estadoOposicion.setHistorialEstadoOposicionRecibidaList(new ArrayList<HistorialEstadoOposicionRecibida>());
        }
        if (estadoOposicion.getOposicionRecibidaList() == null) {
            estadoOposicion.setOposicionRecibidaList(new ArrayList<OposicionRecibida>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<HistorialEstadoOposicionRecibida> attachedHistorialEstadoOposicionRecibidaList = new ArrayList<HistorialEstadoOposicionRecibida>();
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach : estadoOposicion.getHistorialEstadoOposicionRecibidaList()) {
                historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach = em.getReference(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach.getClass(), historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach.getIdHistorial());
                attachedHistorialEstadoOposicionRecibidaList.add(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibidaToAttach);
            }
            estadoOposicion.setHistorialEstadoOposicionRecibidaList(attachedHistorialEstadoOposicionRecibidaList);
            List<OposicionRecibida> attachedOposicionRecibidaList = new ArrayList<OposicionRecibida>();
            for (OposicionRecibida oposicionRecibidaListOposicionRecibidaToAttach : estadoOposicion.getOposicionRecibidaList()) {
                oposicionRecibidaListOposicionRecibidaToAttach = em.getReference(oposicionRecibidaListOposicionRecibidaToAttach.getClass(), oposicionRecibidaListOposicionRecibidaToAttach.getIdOposicion());
                attachedOposicionRecibidaList.add(oposicionRecibidaListOposicionRecibidaToAttach);
            }
            estadoOposicion.setOposicionRecibidaList(attachedOposicionRecibidaList);
            em.persist(estadoOposicion);
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida : estadoOposicion.getHistorialEstadoOposicionRecibidaList()) {
                EstadoOposicion oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida = historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida.getIdEstadoOposicion();
                historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida.setIdEstadoOposicion(estadoOposicion);
                historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida = em.merge(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida);
                if (oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida != null) {
                    oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida.getHistorialEstadoOposicionRecibidaList().remove(historialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida);
                    oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida = em.merge(oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListHistorialEstadoOposicionRecibida);
                }
            }
            for (OposicionRecibida oposicionRecibidaListOposicionRecibida : estadoOposicion.getOposicionRecibidaList()) {
                EstadoOposicion oldIdEstadoOfOposicionRecibidaListOposicionRecibida = oposicionRecibidaListOposicionRecibida.getIdEstado();
                oposicionRecibidaListOposicionRecibida.setIdEstado(estadoOposicion);
                oposicionRecibidaListOposicionRecibida = em.merge(oposicionRecibidaListOposicionRecibida);
                if (oldIdEstadoOfOposicionRecibidaListOposicionRecibida != null) {
                    oldIdEstadoOfOposicionRecibidaListOposicionRecibida.getOposicionRecibidaList().remove(oposicionRecibidaListOposicionRecibida);
                    oldIdEstadoOfOposicionRecibidaListOposicionRecibida = em.merge(oldIdEstadoOfOposicionRecibidaListOposicionRecibida);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(EstadoOposicion estadoOposicion) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            EstadoOposicion persistentEstadoOposicion = em.find(EstadoOposicion.class, estadoOposicion.getIdEstado());
            List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaListOld = persistentEstadoOposicion.getHistorialEstadoOposicionRecibidaList();
            List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaListNew = estadoOposicion.getHistorialEstadoOposicionRecibidaList();
            List<OposicionRecibida> oposicionRecibidaListOld = persistentEstadoOposicion.getOposicionRecibidaList();
            List<OposicionRecibida> oposicionRecibidaListNew = estadoOposicion.getOposicionRecibidaList();
            List<String> illegalOrphanMessages = null;
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListOldHistorialEstadoOposicionRecibida : historialEstadoOposicionRecibidaListOld) {
                if (!historialEstadoOposicionRecibidaListNew.contains(historialEstadoOposicionRecibidaListOldHistorialEstadoOposicionRecibida)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain HistorialEstadoOposicionRecibida " + historialEstadoOposicionRecibidaListOldHistorialEstadoOposicionRecibida + " since its idEstadoOposicion field is not nullable.");
                }
            }
            for (OposicionRecibida oposicionRecibidaListOldOposicionRecibida : oposicionRecibidaListOld) {
                if (!oposicionRecibidaListNew.contains(oposicionRecibidaListOldOposicionRecibida)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain OposicionRecibida " + oposicionRecibidaListOldOposicionRecibida + " since its idEstado field is not nullable.");
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
            estadoOposicion.setHistorialEstadoOposicionRecibidaList(historialEstadoOposicionRecibidaListNew);
            List<OposicionRecibida> attachedOposicionRecibidaListNew = new ArrayList<OposicionRecibida>();
            for (OposicionRecibida oposicionRecibidaListNewOposicionRecibidaToAttach : oposicionRecibidaListNew) {
                oposicionRecibidaListNewOposicionRecibidaToAttach = em.getReference(oposicionRecibidaListNewOposicionRecibidaToAttach.getClass(), oposicionRecibidaListNewOposicionRecibidaToAttach.getIdOposicion());
                attachedOposicionRecibidaListNew.add(oposicionRecibidaListNewOposicionRecibidaToAttach);
            }
            oposicionRecibidaListNew = attachedOposicionRecibidaListNew;
            estadoOposicion.setOposicionRecibidaList(oposicionRecibidaListNew);
            estadoOposicion = em.merge(estadoOposicion);
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida : historialEstadoOposicionRecibidaListNew) {
                if (!historialEstadoOposicionRecibidaListOld.contains(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida)) {
                    EstadoOposicion oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida = historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.getIdEstadoOposicion();
                    historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.setIdEstadoOposicion(estadoOposicion);
                    historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida = em.merge(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida);
                    if (oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida != null && !oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.equals(estadoOposicion)) {
                        oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida.getHistorialEstadoOposicionRecibidaList().remove(historialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida);
                        oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida = em.merge(oldIdEstadoOposicionOfHistorialEstadoOposicionRecibidaListNewHistorialEstadoOposicionRecibida);
                    }
                }
            }
            for (OposicionRecibida oposicionRecibidaListNewOposicionRecibida : oposicionRecibidaListNew) {
                if (!oposicionRecibidaListOld.contains(oposicionRecibidaListNewOposicionRecibida)) {
                    EstadoOposicion oldIdEstadoOfOposicionRecibidaListNewOposicionRecibida = oposicionRecibidaListNewOposicionRecibida.getIdEstado();
                    oposicionRecibidaListNewOposicionRecibida.setIdEstado(estadoOposicion);
                    oposicionRecibidaListNewOposicionRecibida = em.merge(oposicionRecibidaListNewOposicionRecibida);
                    if (oldIdEstadoOfOposicionRecibidaListNewOposicionRecibida != null && !oldIdEstadoOfOposicionRecibidaListNewOposicionRecibida.equals(estadoOposicion)) {
                        oldIdEstadoOfOposicionRecibidaListNewOposicionRecibida.getOposicionRecibidaList().remove(oposicionRecibidaListNewOposicionRecibida);
                        oldIdEstadoOfOposicionRecibidaListNewOposicionRecibida = em.merge(oldIdEstadoOfOposicionRecibidaListNewOposicionRecibida);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = estadoOposicion.getIdEstado();
                if (findEstadoOposicion(id) == null) {
                    throw new NonexistentEntityException("The estadoOposicion with id " + id + " no longer exists.");
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
            EstadoOposicion estadoOposicion;
            try {
                estadoOposicion = em.getReference(EstadoOposicion.class, id);
                estadoOposicion.getIdEstado();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The estadoOposicion with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaListOrphanCheck = estadoOposicion.getHistorialEstadoOposicionRecibidaList();
            for (HistorialEstadoOposicionRecibida historialEstadoOposicionRecibidaListOrphanCheckHistorialEstadoOposicionRecibida : historialEstadoOposicionRecibidaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This EstadoOposicion (" + estadoOposicion + ") cannot be destroyed since the HistorialEstadoOposicionRecibida " + historialEstadoOposicionRecibidaListOrphanCheckHistorialEstadoOposicionRecibida + " in its historialEstadoOposicionRecibidaList field has a non-nullable idEstadoOposicion field.");
            }
            List<OposicionRecibida> oposicionRecibidaListOrphanCheck = estadoOposicion.getOposicionRecibidaList();
            for (OposicionRecibida oposicionRecibidaListOrphanCheckOposicionRecibida : oposicionRecibidaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This EstadoOposicion (" + estadoOposicion + ") cannot be destroyed since the OposicionRecibida " + oposicionRecibidaListOrphanCheckOposicionRecibida + " in its oposicionRecibidaList field has a non-nullable idEstado field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(estadoOposicion);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<EstadoOposicion> findEstadoOposicionEntities() {
        return findEstadoOposicionEntities(true, -1, -1);
    }

    public List<EstadoOposicion> findEstadoOposicionEntities(int maxResults, int firstResult) {
        return findEstadoOposicionEntities(false, maxResults, firstResult);
    }

    private List<EstadoOposicion> findEstadoOposicionEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery cq = cb.createQuery();
            cq.select(cq.from(EstadoOposicion.class));
            cq.orderBy(cb.asc(cq.from(EstadoOposicion.class).get(EstadoOposicion_.descripcion)));
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

    public EstadoOposicion findEstadoOposicion(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(EstadoOposicion.class, id);
        } finally {
            em.close();
        }
    }

    public int getEstadoOposicionCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<EstadoOposicion> rt = cq.from(EstadoOposicion.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
     /**
     * Retorna la lista de estados de oposicion iniciales
     * @return List<EstadoOposicion> 
     */
    public List<EstadoOposicion> getEstadoOposicionIniciales() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from EstadoOposicion e where e.tipo like 'I' order by e.descripcion";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna la lista de estados de oposicion finales
     * @return List<EstadoOposicion> 
     */
    public List<EstadoOposicion> getEstadoOposicionFinales() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from EstadoOposicion e where e.tipo like 'F' ";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
}
