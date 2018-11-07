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
import modelo.Expediente;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaBuilder;
import modelo.EstadoMarca;
import modelo.EstadoMarca_;
import modelo.HistorialEstadoMarca;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author Acer
 */
public class EstadoMarcaJpaController implements Serializable {

    public EstadoMarcaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(EstadoMarca estadoMarca) {
        if (estadoMarca.getExpedienteList() == null) {
            estadoMarca.setExpedienteList(new ArrayList<Expediente>());
        }
        if (estadoMarca.getHistorialEstadoMarcaList() == null) {
            estadoMarca.setHistorialEstadoMarcaList(new ArrayList<HistorialEstadoMarca>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<Expediente> attachedExpedienteList = new ArrayList<Expediente>();
            for (Expediente expedienteListExpedienteToAttach : estadoMarca.getExpedienteList()) {
                expedienteListExpedienteToAttach = em.getReference(expedienteListExpedienteToAttach.getClass(), expedienteListExpedienteToAttach.getIdExpediente());
                attachedExpedienteList.add(expedienteListExpedienteToAttach);
            }
            estadoMarca.setExpedienteList(attachedExpedienteList);
            List<HistorialEstadoMarca> attachedHistorialEstadoMarcaList = new ArrayList<HistorialEstadoMarca>();
            for (HistorialEstadoMarca historialEstadoMarcaListHistorialEstadoMarcaToAttach : estadoMarca.getHistorialEstadoMarcaList()) {
                historialEstadoMarcaListHistorialEstadoMarcaToAttach = em.getReference(historialEstadoMarcaListHistorialEstadoMarcaToAttach.getClass(), historialEstadoMarcaListHistorialEstadoMarcaToAttach.getIdHistorial());
                attachedHistorialEstadoMarcaList.add(historialEstadoMarcaListHistorialEstadoMarcaToAttach);
            }
            estadoMarca.setHistorialEstadoMarcaList(attachedHistorialEstadoMarcaList);
            em.persist(estadoMarca);
            for (Expediente expedienteListExpediente : estadoMarca.getExpedienteList()) {
                EstadoMarca oldIdEstadoOfExpedienteListExpediente = expedienteListExpediente.getIdEstado();
                expedienteListExpediente.setIdEstado(estadoMarca);
                expedienteListExpediente = em.merge(expedienteListExpediente);
                if (oldIdEstadoOfExpedienteListExpediente != null) {
                    oldIdEstadoOfExpedienteListExpediente.getExpedienteList().remove(expedienteListExpediente);
                    oldIdEstadoOfExpedienteListExpediente = em.merge(oldIdEstadoOfExpedienteListExpediente);
                }
            }
            for (HistorialEstadoMarca historialEstadoMarcaListHistorialEstadoMarca : estadoMarca.getHistorialEstadoMarcaList()) {
                EstadoMarca oldIdEstadoMarcaOfHistorialEstadoMarcaListHistorialEstadoMarca = historialEstadoMarcaListHistorialEstadoMarca.getIdEstadoMarca();
                historialEstadoMarcaListHistorialEstadoMarca.setIdEstadoMarca(estadoMarca);
                historialEstadoMarcaListHistorialEstadoMarca = em.merge(historialEstadoMarcaListHistorialEstadoMarca);
                if (oldIdEstadoMarcaOfHistorialEstadoMarcaListHistorialEstadoMarca != null) {
                    oldIdEstadoMarcaOfHistorialEstadoMarcaListHistorialEstadoMarca.getHistorialEstadoMarcaList().remove(historialEstadoMarcaListHistorialEstadoMarca);
                    oldIdEstadoMarcaOfHistorialEstadoMarcaListHistorialEstadoMarca = em.merge(oldIdEstadoMarcaOfHistorialEstadoMarcaListHistorialEstadoMarca);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(EstadoMarca estadoMarca) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            EstadoMarca persistentEstadoMarca = em.find(EstadoMarca.class, estadoMarca.getIdEstado());
            List<Expediente> expedienteListOld = persistentEstadoMarca.getExpedienteList();
            List<Expediente> expedienteListNew = estadoMarca.getExpedienteList();
            List<HistorialEstadoMarca> historialEstadoMarcaListOld = persistentEstadoMarca.getHistorialEstadoMarcaList();
            List<HistorialEstadoMarca> historialEstadoMarcaListNew = estadoMarca.getHistorialEstadoMarcaList();
            List<String> illegalOrphanMessages = null;
            for (HistorialEstadoMarca historialEstadoMarcaListOldHistorialEstadoMarca : historialEstadoMarcaListOld) {
                if (!historialEstadoMarcaListNew.contains(historialEstadoMarcaListOldHistorialEstadoMarca)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain HistorialEstadoMarca " + historialEstadoMarcaListOldHistorialEstadoMarca + " since its idEstadoMarca field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Expediente> attachedExpedienteListNew = new ArrayList<Expediente>();
            for (Expediente expedienteListNewExpedienteToAttach : expedienteListNew) {
                expedienteListNewExpedienteToAttach = em.getReference(expedienteListNewExpedienteToAttach.getClass(), expedienteListNewExpedienteToAttach.getIdExpediente());
                attachedExpedienteListNew.add(expedienteListNewExpedienteToAttach);
            }
            expedienteListNew = attachedExpedienteListNew;
            estadoMarca.setExpedienteList(expedienteListNew);
            List<HistorialEstadoMarca> attachedHistorialEstadoMarcaListNew = new ArrayList<HistorialEstadoMarca>();
            for (HistorialEstadoMarca historialEstadoMarcaListNewHistorialEstadoMarcaToAttach : historialEstadoMarcaListNew) {
                historialEstadoMarcaListNewHistorialEstadoMarcaToAttach = em.getReference(historialEstadoMarcaListNewHistorialEstadoMarcaToAttach.getClass(), historialEstadoMarcaListNewHistorialEstadoMarcaToAttach.getIdHistorial());
                attachedHistorialEstadoMarcaListNew.add(historialEstadoMarcaListNewHistorialEstadoMarcaToAttach);
            }
            historialEstadoMarcaListNew = attachedHistorialEstadoMarcaListNew;
            estadoMarca.setHistorialEstadoMarcaList(historialEstadoMarcaListNew);
            estadoMarca = em.merge(estadoMarca);
            for (Expediente expedienteListOldExpediente : expedienteListOld) {
                if (!expedienteListNew.contains(expedienteListOldExpediente)) {
                    expedienteListOldExpediente.setIdEstado(null);
                    expedienteListOldExpediente = em.merge(expedienteListOldExpediente);
                }
            }
            for (Expediente expedienteListNewExpediente : expedienteListNew) {
                if (!expedienteListOld.contains(expedienteListNewExpediente)) {
                    EstadoMarca oldIdEstadoOfExpedienteListNewExpediente = expedienteListNewExpediente.getIdEstado();
                    expedienteListNewExpediente.setIdEstado(estadoMarca);
                    expedienteListNewExpediente = em.merge(expedienteListNewExpediente);
                    if (oldIdEstadoOfExpedienteListNewExpediente != null && !oldIdEstadoOfExpedienteListNewExpediente.equals(estadoMarca)) {
                        oldIdEstadoOfExpedienteListNewExpediente.getExpedienteList().remove(expedienteListNewExpediente);
                        oldIdEstadoOfExpedienteListNewExpediente = em.merge(oldIdEstadoOfExpedienteListNewExpediente);
                    }
                }
            }
            for (HistorialEstadoMarca historialEstadoMarcaListNewHistorialEstadoMarca : historialEstadoMarcaListNew) {
                if (!historialEstadoMarcaListOld.contains(historialEstadoMarcaListNewHistorialEstadoMarca)) {
                    EstadoMarca oldIdEstadoMarcaOfHistorialEstadoMarcaListNewHistorialEstadoMarca = historialEstadoMarcaListNewHistorialEstadoMarca.getIdEstadoMarca();
                    historialEstadoMarcaListNewHistorialEstadoMarca.setIdEstadoMarca(estadoMarca);
                    historialEstadoMarcaListNewHistorialEstadoMarca = em.merge(historialEstadoMarcaListNewHistorialEstadoMarca);
                    if (oldIdEstadoMarcaOfHistorialEstadoMarcaListNewHistorialEstadoMarca != null && !oldIdEstadoMarcaOfHistorialEstadoMarcaListNewHistorialEstadoMarca.equals(estadoMarca)) {
                        oldIdEstadoMarcaOfHistorialEstadoMarcaListNewHistorialEstadoMarca.getHistorialEstadoMarcaList().remove(historialEstadoMarcaListNewHistorialEstadoMarca);
                        oldIdEstadoMarcaOfHistorialEstadoMarcaListNewHistorialEstadoMarca = em.merge(oldIdEstadoMarcaOfHistorialEstadoMarcaListNewHistorialEstadoMarca);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = estadoMarca.getIdEstado();
                if (findEstadoMarca(id) == null) {
                    throw new NonexistentEntityException("The estadoMarca with id " + id + " no longer exists.");
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
            EstadoMarca estadoMarca;
            try {
                estadoMarca = em.getReference(EstadoMarca.class, id);
                estadoMarca.getIdEstado();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The estadoMarca with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<HistorialEstadoMarca> historialEstadoMarcaListOrphanCheck = estadoMarca.getHistorialEstadoMarcaList();
            for (HistorialEstadoMarca historialEstadoMarcaListOrphanCheckHistorialEstadoMarca : historialEstadoMarcaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This EstadoMarca (" + estadoMarca + ") cannot be destroyed since the HistorialEstadoMarca " + historialEstadoMarcaListOrphanCheckHistorialEstadoMarca + " in its historialEstadoMarcaList field has a non-nullable idEstadoMarca field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<Expediente> expedienteList = estadoMarca.getExpedienteList();
            for (Expediente expedienteListExpediente : expedienteList) {
                expedienteListExpediente.setIdEstado(null);
                expedienteListExpediente = em.merge(expedienteListExpediente);
            }
            em.remove(estadoMarca);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<EstadoMarca> findEstadoMarcaEntities() {
        return findEstadoMarcaEntities(true, -1, -1);
    }

    public List<EstadoMarca> findEstadoMarcaEntities(int maxResults, int firstResult) {
        return findEstadoMarcaEntities(false, maxResults, firstResult);
    }

    private List<EstadoMarca> findEstadoMarcaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery cq = cb.createQuery();
            cq.select(cq.from(EstadoMarca.class));
            cq.orderBy(cb.asc(cq.from(EstadoMarca.class).get(EstadoMarca_.descripcion)));
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

    public EstadoMarca findEstadoMarca(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(EstadoMarca.class, id);
        } finally {
            em.close();
        }
    }

    public int getEstadoMarcaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<EstadoMarca> rt = cq.from(EstadoMarca.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    /**
     * Retorna la lista de estados de marcas en las que se reciben oposiciones
     * @return List<EstadoMarca> 
     */
    public List<EstadoMarca> getEstadoMarcaOposicion() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from EstadoMarca e where e.tipo like 'O' order by e.descripcion";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna una lista de estados de marcas iniciales
     * @return List<EstadoMarca>
     */
    public List<EstadoMarca> getListaEstadoMarcaIniciales() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from EstadoMarca e where e.tipo like 'I' order by e.descripcion";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna una lista de estados de marcas finales
     * @return List<EstadoMarca>
     */
    public List<EstadoMarca> getListaEstadoMarcaFinales() {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from EstadoMarca e where e.tipo like 'F' order by e.descripcion";
            Query q = em.createQuery(consulta); 
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
}
