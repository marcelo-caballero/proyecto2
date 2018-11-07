/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.DocumentoOposicionHecha;
import modelo.OposicionHecha;
import modelo.TipoDocumentoOposicionHecha;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class DocumentoOposicionHechaJpaController implements Serializable {

    public DocumentoOposicionHechaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(DocumentoOposicionHecha documentoOposicionHecha) {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            OposicionHecha idOposicionHecha = documentoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHecha != null) {
                idOposicionHecha = em.getReference(idOposicionHecha.getClass(), idOposicionHecha.getIdOposicion());
                documentoOposicionHecha.setIdOposicionHecha(idOposicionHecha);
            }
            TipoDocumentoOposicionHecha idTipoDocumentoOposicionHecha = documentoOposicionHecha.getIdTipoDocumentoOposicionHecha();
            if (idTipoDocumentoOposicionHecha != null) {
                idTipoDocumentoOposicionHecha = em.getReference(idTipoDocumentoOposicionHecha.getClass(), idTipoDocumentoOposicionHecha.getIdTipoDocumento());
                documentoOposicionHecha.setIdTipoDocumentoOposicionHecha(idTipoDocumentoOposicionHecha);
            }
            em.persist(documentoOposicionHecha);
            if (idOposicionHecha != null) {
                idOposicionHecha.getDocumentoOposicionHechaList().add(documentoOposicionHecha);
                idOposicionHecha = em.merge(idOposicionHecha);
            }
            if (idTipoDocumentoOposicionHecha != null) {
                idTipoDocumentoOposicionHecha.getDocumentoOposicionHechaList().add(documentoOposicionHecha);
                idTipoDocumentoOposicionHecha = em.merge(idTipoDocumentoOposicionHecha);
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(DocumentoOposicionHecha documentoOposicionHecha) throws NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            DocumentoOposicionHecha persistentDocumentoOposicionHecha = em.find(DocumentoOposicionHecha.class, documentoOposicionHecha.getIdDocumento());
            OposicionHecha idOposicionHechaOld = persistentDocumentoOposicionHecha.getIdOposicionHecha();
            OposicionHecha idOposicionHechaNew = documentoOposicionHecha.getIdOposicionHecha();
            TipoDocumentoOposicionHecha idTipoDocumentoOposicionHechaOld = persistentDocumentoOposicionHecha.getIdTipoDocumentoOposicionHecha();
            TipoDocumentoOposicionHecha idTipoDocumentoOposicionHechaNew = documentoOposicionHecha.getIdTipoDocumentoOposicionHecha();
            if (idOposicionHechaNew != null) {
                idOposicionHechaNew = em.getReference(idOposicionHechaNew.getClass(), idOposicionHechaNew.getIdOposicion());
                documentoOposicionHecha.setIdOposicionHecha(idOposicionHechaNew);
            }
            if (idTipoDocumentoOposicionHechaNew != null) {
                idTipoDocumentoOposicionHechaNew = em.getReference(idTipoDocumentoOposicionHechaNew.getClass(), idTipoDocumentoOposicionHechaNew.getIdTipoDocumento());
                documentoOposicionHecha.setIdTipoDocumentoOposicionHecha(idTipoDocumentoOposicionHechaNew);
            }
            documentoOposicionHecha = em.merge(documentoOposicionHecha);
            if (idOposicionHechaOld != null && !idOposicionHechaOld.equals(idOposicionHechaNew)) {
                idOposicionHechaOld.getDocumentoOposicionHechaList().remove(documentoOposicionHecha);
                idOposicionHechaOld = em.merge(idOposicionHechaOld);
            }
            if (idOposicionHechaNew != null && !idOposicionHechaNew.equals(idOposicionHechaOld)) {
                idOposicionHechaNew.getDocumentoOposicionHechaList().add(documentoOposicionHecha);
                idOposicionHechaNew = em.merge(idOposicionHechaNew);
            }
            if (idTipoDocumentoOposicionHechaOld != null && !idTipoDocumentoOposicionHechaOld.equals(idTipoDocumentoOposicionHechaNew)) {
                idTipoDocumentoOposicionHechaOld.getDocumentoOposicionHechaList().remove(documentoOposicionHecha);
                idTipoDocumentoOposicionHechaOld = em.merge(idTipoDocumentoOposicionHechaOld);
            }
            if (idTipoDocumentoOposicionHechaNew != null && !idTipoDocumentoOposicionHechaNew.equals(idTipoDocumentoOposicionHechaOld)) {
                idTipoDocumentoOposicionHechaNew.getDocumentoOposicionHechaList().add(documentoOposicionHecha);
                idTipoDocumentoOposicionHechaNew = em.merge(idTipoDocumentoOposicionHechaNew);
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = documentoOposicionHecha.getIdDocumento();
                if (findDocumentoOposicionHecha(id) == null) {
                    throw new NonexistentEntityException("The documentoOposicionHecha with id " + id + " no longer exists.");
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
            DocumentoOposicionHecha documentoOposicionHecha;
            try {
                documentoOposicionHecha = em.getReference(DocumentoOposicionHecha.class, id);
                documentoOposicionHecha.getIdDocumento();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The documentoOposicionHecha with id " + id + " no longer exists.", enfe);
            }
            OposicionHecha idOposicionHecha = documentoOposicionHecha.getIdOposicionHecha();
            if (idOposicionHecha != null) {
                idOposicionHecha.getDocumentoOposicionHechaList().remove(documentoOposicionHecha);
                idOposicionHecha = em.merge(idOposicionHecha);
            }
            TipoDocumentoOposicionHecha idTipoDocumentoOposicionHecha = documentoOposicionHecha.getIdTipoDocumentoOposicionHecha();
            if (idTipoDocumentoOposicionHecha != null) {
                idTipoDocumentoOposicionHecha.getDocumentoOposicionHechaList().remove(documentoOposicionHecha);
                idTipoDocumentoOposicionHecha = em.merge(idTipoDocumentoOposicionHecha);
            }
            em.remove(documentoOposicionHecha);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<DocumentoOposicionHecha> findDocumentoOposicionHechaEntities() {
        return findDocumentoOposicionHechaEntities(true, -1, -1);
    }

    public List<DocumentoOposicionHecha> findDocumentoOposicionHechaEntities(int maxResults, int firstResult) {
        return findDocumentoOposicionHechaEntities(false, maxResults, firstResult);
    }

    private List<DocumentoOposicionHecha> findDocumentoOposicionHechaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(DocumentoOposicionHecha.class));
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

    public DocumentoOposicionHecha findDocumentoOposicionHecha(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(DocumentoOposicionHecha.class, id);
        } finally {
            em.close();
        }
    }

    public int getDocumentoOposicionHechaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<DocumentoOposicionHecha> rt = cq.from(DocumentoOposicionHecha.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
     /**
     * Retorna el ultimo documento guardado de la oposicion
     * @param idOposicion
     * @return DocumentoOposicionHecha
     * 
     */
    public DocumentoOposicionHecha getUltimoDocumento(Integer idOposicion) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta = "select d from DocumentoOposicionHecha d "+ 
                              " where d.idOposicionHecha.idOposicion= :idOposicion "+
                              "and d.folioHasta = (select max(d.folioHasta) from DocumentoOposicionHecha d where d.idOposicionHecha.idOposicion= :idOposicion)";
        
            Query q = em.createQuery(consulta);
            
            q.setParameter("idOposicion", idOposicion);
           
             
           
            DocumentoOposicionHecha documento = ((DocumentoOposicionHecha) q.getSingleResult());
            System.out.println(documento);
            return documento;
            
        } catch(Exception e){
            System.out.println(e);
            return null;
            
        }finally {
            em.close();
        }
    }
    
    
    public Date getFechaDocumentoFolioHasta(Integer hasta, Integer idOposicion) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta = "select d.fecha from DocumentoOposicionHecha d "+ 
                              " where d.idOposicionHecha.idOposicionHecha= :idOposicion "+
                              "and d.folioHasta = :hasta";
        
            Query q = em.createQuery(consulta);
            
            q.setParameter("idOposicion", idOposicion);
            q.setParameter("hasta", hasta);
             
           
            Date fecha = ((Date) q.getSingleResult());
            
            return fecha;
            
        } catch(Exception e){
           
            return null;
            
        }finally {
            em.close();
        }
    }
}
