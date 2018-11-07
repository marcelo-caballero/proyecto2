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
import modelo.DocumentoOposicionHecha;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaBuilder;
import modelo.TipoDocumentoOposicionHecha;
import modelo.TipoDocumentoOposicionHecha_;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class TipoDocumentoOposicionHechaJpaController implements Serializable {

    public TipoDocumentoOposicionHechaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(TipoDocumentoOposicionHecha tipoDocumentoOposicionHecha) {
        if (tipoDocumentoOposicionHecha.getDocumentoOposicionHechaList() == null) {
            tipoDocumentoOposicionHecha.setDocumentoOposicionHechaList(new ArrayList<DocumentoOposicionHecha>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            List<DocumentoOposicionHecha> attachedDocumentoOposicionHechaList = new ArrayList<DocumentoOposicionHecha>();
            for (DocumentoOposicionHecha documentoOposicionHechaListDocumentoOposicionHechaToAttach : tipoDocumentoOposicionHecha.getDocumentoOposicionHechaList()) {
                documentoOposicionHechaListDocumentoOposicionHechaToAttach = em.getReference(documentoOposicionHechaListDocumentoOposicionHechaToAttach.getClass(), documentoOposicionHechaListDocumentoOposicionHechaToAttach.getIdDocumento());
                attachedDocumentoOposicionHechaList.add(documentoOposicionHechaListDocumentoOposicionHechaToAttach);
            }
            tipoDocumentoOposicionHecha.setDocumentoOposicionHechaList(attachedDocumentoOposicionHechaList);
            em.persist(tipoDocumentoOposicionHecha);
            for (DocumentoOposicionHecha documentoOposicionHechaListDocumentoOposicionHecha : tipoDocumentoOposicionHecha.getDocumentoOposicionHechaList()) {
                TipoDocumentoOposicionHecha oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha = documentoOposicionHechaListDocumentoOposicionHecha.getIdTipoDocumentoOposicionHecha();
                documentoOposicionHechaListDocumentoOposicionHecha.setIdTipoDocumentoOposicionHecha(tipoDocumentoOposicionHecha);
                documentoOposicionHechaListDocumentoOposicionHecha = em.merge(documentoOposicionHechaListDocumentoOposicionHecha);
                if (oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha != null) {
                    oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha.getDocumentoOposicionHechaList().remove(documentoOposicionHechaListDocumentoOposicionHecha);
                    oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha = em.merge(oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(TipoDocumentoOposicionHecha tipoDocumentoOposicionHecha) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            TipoDocumentoOposicionHecha persistentTipoDocumentoOposicionHecha = em.find(TipoDocumentoOposicionHecha.class, tipoDocumentoOposicionHecha.getIdTipoDocumento());
            List<DocumentoOposicionHecha> documentoOposicionHechaListOld = persistentTipoDocumentoOposicionHecha.getDocumentoOposicionHechaList();
            List<DocumentoOposicionHecha> documentoOposicionHechaListNew = tipoDocumentoOposicionHecha.getDocumentoOposicionHechaList();
            List<String> illegalOrphanMessages = null;
            for (DocumentoOposicionHecha documentoOposicionHechaListOldDocumentoOposicionHecha : documentoOposicionHechaListOld) {
                if (!documentoOposicionHechaListNew.contains(documentoOposicionHechaListOldDocumentoOposicionHecha)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain DocumentoOposicionHecha " + documentoOposicionHechaListOldDocumentoOposicionHecha + " since its idTipoDocumentoOposicionHecha field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            List<DocumentoOposicionHecha> attachedDocumentoOposicionHechaListNew = new ArrayList<DocumentoOposicionHecha>();
            for (DocumentoOposicionHecha documentoOposicionHechaListNewDocumentoOposicionHechaToAttach : documentoOposicionHechaListNew) {
                documentoOposicionHechaListNewDocumentoOposicionHechaToAttach = em.getReference(documentoOposicionHechaListNewDocumentoOposicionHechaToAttach.getClass(), documentoOposicionHechaListNewDocumentoOposicionHechaToAttach.getIdDocumento());
                attachedDocumentoOposicionHechaListNew.add(documentoOposicionHechaListNewDocumentoOposicionHechaToAttach);
            }
            documentoOposicionHechaListNew = attachedDocumentoOposicionHechaListNew;
            tipoDocumentoOposicionHecha.setDocumentoOposicionHechaList(documentoOposicionHechaListNew);
            tipoDocumentoOposicionHecha = em.merge(tipoDocumentoOposicionHecha);
            for (DocumentoOposicionHecha documentoOposicionHechaListNewDocumentoOposicionHecha : documentoOposicionHechaListNew) {
                if (!documentoOposicionHechaListOld.contains(documentoOposicionHechaListNewDocumentoOposicionHecha)) {
                    TipoDocumentoOposicionHecha oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha = documentoOposicionHechaListNewDocumentoOposicionHecha.getIdTipoDocumentoOposicionHecha();
                    documentoOposicionHechaListNewDocumentoOposicionHecha.setIdTipoDocumentoOposicionHecha(tipoDocumentoOposicionHecha);
                    documentoOposicionHechaListNewDocumentoOposicionHecha = em.merge(documentoOposicionHechaListNewDocumentoOposicionHecha);
                    if (oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha != null && !oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha.equals(tipoDocumentoOposicionHecha)) {
                        oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha.getDocumentoOposicionHechaList().remove(documentoOposicionHechaListNewDocumentoOposicionHecha);
                        oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha = em.merge(oldIdTipoDocumentoOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = tipoDocumentoOposicionHecha.getIdTipoDocumento();
                if (findTipoDocumentoOposicionHecha(id) == null) {
                    throw new NonexistentEntityException("The tipoDocumentoOposicionHecha with id " + id + " no longer exists.");
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
            TipoDocumentoOposicionHecha tipoDocumentoOposicionHecha;
            try {
                tipoDocumentoOposicionHecha = em.getReference(TipoDocumentoOposicionHecha.class, id);
                tipoDocumentoOposicionHecha.getIdTipoDocumento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The tipoDocumentoOposicionHecha with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<DocumentoOposicionHecha> documentoOposicionHechaListOrphanCheck = tipoDocumentoOposicionHecha.getDocumentoOposicionHechaList();
            for (DocumentoOposicionHecha documentoOposicionHechaListOrphanCheckDocumentoOposicionHecha : documentoOposicionHechaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This TipoDocumentoOposicionHecha (" + tipoDocumentoOposicionHecha + ") cannot be destroyed since the DocumentoOposicionHecha " + documentoOposicionHechaListOrphanCheckDocumentoOposicionHecha + " in its documentoOposicionHechaList field has a non-nullable idTipoDocumentoOposicionHecha field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            em.remove(tipoDocumentoOposicionHecha);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<TipoDocumentoOposicionHecha> findTipoDocumentoOposicionHechaEntities() {
        return findTipoDocumentoOposicionHechaEntities(true, -1, -1);
    }

    public List<TipoDocumentoOposicionHecha> findTipoDocumentoOposicionHechaEntities(int maxResults, int firstResult) {
        return findTipoDocumentoOposicionHechaEntities(false, maxResults, firstResult);
    }

    private List<TipoDocumentoOposicionHecha> findTipoDocumentoOposicionHechaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery cq = cb.createQuery();
            cq.select(cq.from(TipoDocumentoOposicionHecha.class));
            cq.orderBy(cb.asc(cq.from(TipoDocumentoOposicionHecha.class).get(TipoDocumentoOposicionHecha_.descripcion)));
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

    public TipoDocumentoOposicionHecha findTipoDocumentoOposicionHecha(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(TipoDocumentoOposicionHecha.class, id);
        } finally {
            em.close();
        }
    }

    public int getTipoDocumentoOposicionHechaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<TipoDocumentoOposicionHecha> rt = cq.from(TipoDocumentoOposicionHecha.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
}
