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
import modelo.Cliente;
import modelo.FacturaDetalle;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.FacturaCabecera;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class FacturaCabeceraJpaController implements Serializable {

    public FacturaCabeceraJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(FacturaCabecera facturaCabecera) {
        if (facturaCabecera.getFacturaDetalleList() == null) {
            facturaCabecera.setFacturaDetalleList(new ArrayList<FacturaDetalle>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Cliente idCliente = facturaCabecera.getIdCliente();
            if (idCliente != null) {
                idCliente = em.getReference(idCliente.getClass(), idCliente.getIdCliente());
                facturaCabecera.setIdCliente(idCliente);
            }
            List<FacturaDetalle> attachedFacturaDetalleList = new ArrayList<FacturaDetalle>();
            for (FacturaDetalle facturaDetalleListFacturaDetalleToAttach : facturaCabecera.getFacturaDetalleList()) {
                facturaDetalleListFacturaDetalleToAttach = em.getReference(facturaDetalleListFacturaDetalleToAttach.getClass(), facturaDetalleListFacturaDetalleToAttach.getIdFacturaDetalle());
                attachedFacturaDetalleList.add(facturaDetalleListFacturaDetalleToAttach);
            }
            facturaCabecera.setFacturaDetalleList(attachedFacturaDetalleList);
            em.persist(facturaCabecera);
            if (idCliente != null) {
                idCliente.getFacturaCabeceraList().add(facturaCabecera);
                idCliente = em.merge(idCliente);
            }
            for (FacturaDetalle facturaDetalleListFacturaDetalle : facturaCabecera.getFacturaDetalleList()) {
                FacturaCabecera oldIdFacturaOfFacturaDetalleListFacturaDetalle = facturaDetalleListFacturaDetalle.getIdFactura();
                facturaDetalleListFacturaDetalle.setIdFactura(facturaCabecera);
                facturaDetalleListFacturaDetalle = em.merge(facturaDetalleListFacturaDetalle);
                if (oldIdFacturaOfFacturaDetalleListFacturaDetalle != null) {
                    oldIdFacturaOfFacturaDetalleListFacturaDetalle.getFacturaDetalleList().remove(facturaDetalleListFacturaDetalle);
                    oldIdFacturaOfFacturaDetalleListFacturaDetalle = em.merge(oldIdFacturaOfFacturaDetalleListFacturaDetalle);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(FacturaCabecera facturaCabecera) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            FacturaCabecera persistentFacturaCabecera = em.find(FacturaCabecera.class, facturaCabecera.getIdFactura());
            Cliente idClienteOld = persistentFacturaCabecera.getIdCliente();
            Cliente idClienteNew = facturaCabecera.getIdCliente();
            List<FacturaDetalle> facturaDetalleListOld = persistentFacturaCabecera.getFacturaDetalleList();
            List<FacturaDetalle> facturaDetalleListNew = facturaCabecera.getFacturaDetalleList();
            List<String> illegalOrphanMessages = null;
            for (FacturaDetalle facturaDetalleListOldFacturaDetalle : facturaDetalleListOld) {
                if (!facturaDetalleListNew.contains(facturaDetalleListOldFacturaDetalle)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain FacturaDetalle " + facturaDetalleListOldFacturaDetalle + " since its idFactura field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idClienteNew != null) {
                idClienteNew = em.getReference(idClienteNew.getClass(), idClienteNew.getIdCliente());
                facturaCabecera.setIdCliente(idClienteNew);
            }
            List<FacturaDetalle> attachedFacturaDetalleListNew = new ArrayList<FacturaDetalle>();
            for (FacturaDetalle facturaDetalleListNewFacturaDetalleToAttach : facturaDetalleListNew) {
                facturaDetalleListNewFacturaDetalleToAttach = em.getReference(facturaDetalleListNewFacturaDetalleToAttach.getClass(), facturaDetalleListNewFacturaDetalleToAttach.getIdFacturaDetalle());
                attachedFacturaDetalleListNew.add(facturaDetalleListNewFacturaDetalleToAttach);
            }
            facturaDetalleListNew = attachedFacturaDetalleListNew;
            facturaCabecera.setFacturaDetalleList(facturaDetalleListNew);
            facturaCabecera = em.merge(facturaCabecera);
            if (idClienteOld != null && !idClienteOld.equals(idClienteNew)) {
                idClienteOld.getFacturaCabeceraList().remove(facturaCabecera);
                idClienteOld = em.merge(idClienteOld);
            }
            if (idClienteNew != null && !idClienteNew.equals(idClienteOld)) {
                idClienteNew.getFacturaCabeceraList().add(facturaCabecera);
                idClienteNew = em.merge(idClienteNew);
            }
            for (FacturaDetalle facturaDetalleListNewFacturaDetalle : facturaDetalleListNew) {
                if (!facturaDetalleListOld.contains(facturaDetalleListNewFacturaDetalle)) {
                    FacturaCabecera oldIdFacturaOfFacturaDetalleListNewFacturaDetalle = facturaDetalleListNewFacturaDetalle.getIdFactura();
                    facturaDetalleListNewFacturaDetalle.setIdFactura(facturaCabecera);
                    facturaDetalleListNewFacturaDetalle = em.merge(facturaDetalleListNewFacturaDetalle);
                    if (oldIdFacturaOfFacturaDetalleListNewFacturaDetalle != null && !oldIdFacturaOfFacturaDetalleListNewFacturaDetalle.equals(facturaCabecera)) {
                        oldIdFacturaOfFacturaDetalleListNewFacturaDetalle.getFacturaDetalleList().remove(facturaDetalleListNewFacturaDetalle);
                        oldIdFacturaOfFacturaDetalleListNewFacturaDetalle = em.merge(oldIdFacturaOfFacturaDetalleListNewFacturaDetalle);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = facturaCabecera.getIdFactura();
                if (findFacturaCabecera(id) == null) {
                    throw new NonexistentEntityException("The facturaCabecera with id " + id + " no longer exists.");
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
            FacturaCabecera facturaCabecera;
            try {
                facturaCabecera = em.getReference(FacturaCabecera.class, id);
                facturaCabecera.getIdFactura();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The facturaCabecera with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<FacturaDetalle> facturaDetalleListOrphanCheck = facturaCabecera.getFacturaDetalleList();
            for (FacturaDetalle facturaDetalleListOrphanCheckFacturaDetalle : facturaDetalleListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This FacturaCabecera (" + facturaCabecera + ") cannot be destroyed since the FacturaDetalle " + facturaDetalleListOrphanCheckFacturaDetalle + " in its facturaDetalleList field has a non-nullable idFactura field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Cliente idCliente = facturaCabecera.getIdCliente();
            if (idCliente != null) {
                idCliente.getFacturaCabeceraList().remove(facturaCabecera);
                idCliente = em.merge(idCliente);
            }
            em.remove(facturaCabecera);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<FacturaCabecera> findFacturaCabeceraEntities() {
        return findFacturaCabeceraEntities(true, -1, -1);
    }

    public List<FacturaCabecera> findFacturaCabeceraEntities(int maxResults, int firstResult) {
        return findFacturaCabeceraEntities(false, maxResults, firstResult);
    }

    private List<FacturaCabecera> findFacturaCabeceraEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(FacturaCabecera.class));
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

    public FacturaCabecera findFacturaCabecera(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(FacturaCabecera.class, id);
        } finally {
            em.close();
        }
    }

    public int getFacturaCabeceraCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<FacturaCabecera> rt = cq.from(FacturaCabecera.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
