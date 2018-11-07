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
import modelo.Abogado;
import modelo.Cliente;
import modelo.EstadoOposicion;
import modelo.Marca;
import modelo.EventoOposicionHecha;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import modelo.HistorialEstadoOposicionHecha;
import modelo.DocumentoOposicionHecha;
import modelo.Expediente;
import modelo.OposicionHecha;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class OposicionHechaJpaController implements Serializable {

    public OposicionHechaJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU");
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(OposicionHecha oposicionHecha) {
        if (oposicionHecha.getEventoOposicionHechaList() == null) {
            oposicionHecha.setEventoOposicionHechaList(new ArrayList<EventoOposicionHecha>());
        }
        if (oposicionHecha.getHistorialEstadoOposicionHechaList() == null) {
            oposicionHecha.setHistorialEstadoOposicionHechaList(new ArrayList<HistorialEstadoOposicionHecha>());
        }
        if (oposicionHecha.getDocumentoOposicionHechaList() == null) {
            oposicionHecha.setDocumentoOposicionHechaList(new ArrayList<DocumentoOposicionHecha>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Abogado idAbogadoOpositante = oposicionHecha.getIdAbogadoOpositante();
            if (idAbogadoOpositante != null) {
                idAbogadoOpositante = em.getReference(idAbogadoOpositante.getClass(), idAbogadoOpositante.getIdAbogado());
                oposicionHecha.setIdAbogadoOpositante(idAbogadoOpositante);
            }
            EstadoOposicion idEstadoOposicion = oposicionHecha.getIdEstadoOposicion();
            if (idEstadoOposicion != null) {
                idEstadoOposicion = em.getReference(idEstadoOposicion.getClass(), idEstadoOposicion.getIdEstado());
                oposicionHecha.setIdEstadoOposicion(idEstadoOposicion);
            }
            Expediente idExpedienteOpositante = oposicionHecha.getIdExpedienteOpositante();
            if (idExpedienteOpositante != null) {
                idExpedienteOpositante = em.getReference(idExpedienteOpositante.getClass(), idExpedienteOpositante.getIdExpediente());
                oposicionHecha.setIdExpedienteOpositante(idExpedienteOpositante);
            }
            List<EventoOposicionHecha> attachedEventoOposicionHechaList = new ArrayList<EventoOposicionHecha>();
            for (EventoOposicionHecha eventoOposicionHechaListEventoOposicionHechaToAttach : oposicionHecha.getEventoOposicionHechaList()) {
                eventoOposicionHechaListEventoOposicionHechaToAttach = em.getReference(eventoOposicionHechaListEventoOposicionHechaToAttach.getClass(), eventoOposicionHechaListEventoOposicionHechaToAttach.getIdEvento());
                attachedEventoOposicionHechaList.add(eventoOposicionHechaListEventoOposicionHechaToAttach);
            }
            oposicionHecha.setEventoOposicionHechaList(attachedEventoOposicionHechaList);
            List<HistorialEstadoOposicionHecha> attachedHistorialEstadoOposicionHechaList = new ArrayList<HistorialEstadoOposicionHecha>();
            for (HistorialEstadoOposicionHecha historialEstadoOposicionHechaListHistorialEstadoOposicionHechaToAttach : oposicionHecha.getHistorialEstadoOposicionHechaList()) {
                historialEstadoOposicionHechaListHistorialEstadoOposicionHechaToAttach = em.getReference(historialEstadoOposicionHechaListHistorialEstadoOposicionHechaToAttach.getClass(), historialEstadoOposicionHechaListHistorialEstadoOposicionHechaToAttach.getIdHistorial());
                attachedHistorialEstadoOposicionHechaList.add(historialEstadoOposicionHechaListHistorialEstadoOposicionHechaToAttach);
            }
            oposicionHecha.setHistorialEstadoOposicionHechaList(attachedHistorialEstadoOposicionHechaList);
            List<DocumentoOposicionHecha> attachedDocumentoOposicionHechaList = new ArrayList<DocumentoOposicionHecha>();
            for (DocumentoOposicionHecha documentoOposicionHechaListDocumentoOposicionHechaToAttach : oposicionHecha.getDocumentoOposicionHechaList()) {
                documentoOposicionHechaListDocumentoOposicionHechaToAttach = em.getReference(documentoOposicionHechaListDocumentoOposicionHechaToAttach.getClass(), documentoOposicionHechaListDocumentoOposicionHechaToAttach.getIdDocumento());
                attachedDocumentoOposicionHechaList.add(documentoOposicionHechaListDocumentoOposicionHechaToAttach);
            }
            oposicionHecha.setDocumentoOposicionHechaList(attachedDocumentoOposicionHechaList);
            em.persist(oposicionHecha);
            if (idAbogadoOpositante != null) {
                idAbogadoOpositante.getOposicionHechaList().add(oposicionHecha);
                idAbogadoOpositante = em.merge(idAbogadoOpositante);
            }
            if (idEstadoOposicion != null) {
                idEstadoOposicion.getOposicionHechaList().add(oposicionHecha);
                idEstadoOposicion = em.merge(idEstadoOposicion);
            }
            if (idExpedienteOpositante != null) {
                idExpedienteOpositante.getOposicionHechaList().add(oposicionHecha);
                idExpedienteOpositante = em.merge(idExpedienteOpositante);
            }
            for (EventoOposicionHecha eventoOposicionHechaListEventoOposicionHecha : oposicionHecha.getEventoOposicionHechaList()) {
                OposicionHecha oldIdOposicionHechaOfEventoOposicionHechaListEventoOposicionHecha = eventoOposicionHechaListEventoOposicionHecha.getIdOposicionHecha();
                eventoOposicionHechaListEventoOposicionHecha.setIdOposicionHecha(oposicionHecha);
                eventoOposicionHechaListEventoOposicionHecha = em.merge(eventoOposicionHechaListEventoOposicionHecha);
                if (oldIdOposicionHechaOfEventoOposicionHechaListEventoOposicionHecha != null) {
                    oldIdOposicionHechaOfEventoOposicionHechaListEventoOposicionHecha.getEventoOposicionHechaList().remove(eventoOposicionHechaListEventoOposicionHecha);
                    oldIdOposicionHechaOfEventoOposicionHechaListEventoOposicionHecha = em.merge(oldIdOposicionHechaOfEventoOposicionHechaListEventoOposicionHecha);
                }
            }
            for (HistorialEstadoOposicionHecha historialEstadoOposicionHechaListHistorialEstadoOposicionHecha : oposicionHecha.getHistorialEstadoOposicionHechaList()) {
                OposicionHecha oldIdOposicionHechaOfHistorialEstadoOposicionHechaListHistorialEstadoOposicionHecha = historialEstadoOposicionHechaListHistorialEstadoOposicionHecha.getIdOposicionHecha();
                historialEstadoOposicionHechaListHistorialEstadoOposicionHecha.setIdOposicionHecha(oposicionHecha);
                historialEstadoOposicionHechaListHistorialEstadoOposicionHecha = em.merge(historialEstadoOposicionHechaListHistorialEstadoOposicionHecha);
                if (oldIdOposicionHechaOfHistorialEstadoOposicionHechaListHistorialEstadoOposicionHecha != null) {
                    oldIdOposicionHechaOfHistorialEstadoOposicionHechaListHistorialEstadoOposicionHecha.getHistorialEstadoOposicionHechaList().remove(historialEstadoOposicionHechaListHistorialEstadoOposicionHecha);
                    oldIdOposicionHechaOfHistorialEstadoOposicionHechaListHistorialEstadoOposicionHecha = em.merge(oldIdOposicionHechaOfHistorialEstadoOposicionHechaListHistorialEstadoOposicionHecha);
                }
            }
            for (DocumentoOposicionHecha documentoOposicionHechaListDocumentoOposicionHecha : oposicionHecha.getDocumentoOposicionHechaList()) {
                OposicionHecha oldIdOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha = documentoOposicionHechaListDocumentoOposicionHecha.getIdOposicionHecha();
                documentoOposicionHechaListDocumentoOposicionHecha.setIdOposicionHecha(oposicionHecha);
                documentoOposicionHechaListDocumentoOposicionHecha = em.merge(documentoOposicionHechaListDocumentoOposicionHecha);
                if (oldIdOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha != null) {
                    oldIdOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha.getDocumentoOposicionHechaList().remove(documentoOposicionHechaListDocumentoOposicionHecha);
                    oldIdOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha = em.merge(oldIdOposicionHechaOfDocumentoOposicionHechaListDocumentoOposicionHecha);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(OposicionHecha oposicionHecha) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            OposicionHecha persistentOposicionHecha = em.find(OposicionHecha.class, oposicionHecha.getIdOposicion());
            Abogado idAbogadoOpositanteOld = persistentOposicionHecha.getIdAbogadoOpositante();
            Abogado idAbogadoOpositanteNew = oposicionHecha.getIdAbogadoOpositante();
            EstadoOposicion idEstadoOposicionOld = persistentOposicionHecha.getIdEstadoOposicion();
            EstadoOposicion idEstadoOposicionNew = oposicionHecha.getIdEstadoOposicion();
            Expediente idExpedienteOpositanteOld = persistentOposicionHecha.getIdExpedienteOpositante();
            Expediente idExpedienteOpositanteNew = oposicionHecha.getIdExpedienteOpositante();
            List<EventoOposicionHecha> eventoOposicionHechaListOld = persistentOposicionHecha.getEventoOposicionHechaList();
            List<EventoOposicionHecha> eventoOposicionHechaListNew = oposicionHecha.getEventoOposicionHechaList();
            List<HistorialEstadoOposicionHecha> historialEstadoOposicionHechaListOld = persistentOposicionHecha.getHistorialEstadoOposicionHechaList();
            List<HistorialEstadoOposicionHecha> historialEstadoOposicionHechaListNew = oposicionHecha.getHistorialEstadoOposicionHechaList();
            List<DocumentoOposicionHecha> documentoOposicionHechaListOld = persistentOposicionHecha.getDocumentoOposicionHechaList();
            List<DocumentoOposicionHecha> documentoOposicionHechaListNew = oposicionHecha.getDocumentoOposicionHechaList();
            List<String> illegalOrphanMessages = null;
            for (EventoOposicionHecha eventoOposicionHechaListOldEventoOposicionHecha : eventoOposicionHechaListOld) {
                if (!eventoOposicionHechaListNew.contains(eventoOposicionHechaListOldEventoOposicionHecha)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain EventoOposicionHecha " + eventoOposicionHechaListOldEventoOposicionHecha + " since its idOposicionHecha field is not nullable.");
                }
            }
            for (HistorialEstadoOposicionHecha historialEstadoOposicionHechaListOldHistorialEstadoOposicionHecha : historialEstadoOposicionHechaListOld) {
                if (!historialEstadoOposicionHechaListNew.contains(historialEstadoOposicionHechaListOldHistorialEstadoOposicionHecha)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain HistorialEstadoOposicionHecha " + historialEstadoOposicionHechaListOldHistorialEstadoOposicionHecha + " since its idOposicionHecha field is not nullable.");
                }
            }
            for (DocumentoOposicionHecha documentoOposicionHechaListOldDocumentoOposicionHecha : documentoOposicionHechaListOld) {
                if (!documentoOposicionHechaListNew.contains(documentoOposicionHechaListOldDocumentoOposicionHecha)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain DocumentoOposicionHecha " + documentoOposicionHechaListOldDocumentoOposicionHecha + " since its idOposicionHecha field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idAbogadoOpositanteNew != null) {
                idAbogadoOpositanteNew = em.getReference(idAbogadoOpositanteNew.getClass(), idAbogadoOpositanteNew.getIdAbogado());
                oposicionHecha.setIdAbogadoOpositante(idAbogadoOpositanteNew);
            }
            if (idEstadoOposicionNew != null) {
                idEstadoOposicionNew = em.getReference(idEstadoOposicionNew.getClass(), idEstadoOposicionNew.getIdEstado());
                oposicionHecha.setIdEstadoOposicion(idEstadoOposicionNew);
            }
            if (idExpedienteOpositanteNew != null) {
                idExpedienteOpositanteNew = em.getReference(idExpedienteOpositanteNew.getClass(), idExpedienteOpositanteNew.getIdExpediente());
                oposicionHecha.setIdExpedienteOpositante(idExpedienteOpositanteNew);
            }
            List<EventoOposicionHecha> attachedEventoOposicionHechaListNew = new ArrayList<EventoOposicionHecha>();
            for (EventoOposicionHecha eventoOposicionHechaListNewEventoOposicionHechaToAttach : eventoOposicionHechaListNew) {
                eventoOposicionHechaListNewEventoOposicionHechaToAttach = em.getReference(eventoOposicionHechaListNewEventoOposicionHechaToAttach.getClass(), eventoOposicionHechaListNewEventoOposicionHechaToAttach.getIdEvento());
                attachedEventoOposicionHechaListNew.add(eventoOposicionHechaListNewEventoOposicionHechaToAttach);
            }
            eventoOposicionHechaListNew = attachedEventoOposicionHechaListNew;
            oposicionHecha.setEventoOposicionHechaList(eventoOposicionHechaListNew);
            List<HistorialEstadoOposicionHecha> attachedHistorialEstadoOposicionHechaListNew = new ArrayList<HistorialEstadoOposicionHecha>();
            for (HistorialEstadoOposicionHecha historialEstadoOposicionHechaListNewHistorialEstadoOposicionHechaToAttach : historialEstadoOposicionHechaListNew) {
                historialEstadoOposicionHechaListNewHistorialEstadoOposicionHechaToAttach = em.getReference(historialEstadoOposicionHechaListNewHistorialEstadoOposicionHechaToAttach.getClass(), historialEstadoOposicionHechaListNewHistorialEstadoOposicionHechaToAttach.getIdHistorial());
                attachedHistorialEstadoOposicionHechaListNew.add(historialEstadoOposicionHechaListNewHistorialEstadoOposicionHechaToAttach);
            }
            historialEstadoOposicionHechaListNew = attachedHistorialEstadoOposicionHechaListNew;
            oposicionHecha.setHistorialEstadoOposicionHechaList(historialEstadoOposicionHechaListNew);
            List<DocumentoOposicionHecha> attachedDocumentoOposicionHechaListNew = new ArrayList<DocumentoOposicionHecha>();
            for (DocumentoOposicionHecha documentoOposicionHechaListNewDocumentoOposicionHechaToAttach : documentoOposicionHechaListNew) {
                documentoOposicionHechaListNewDocumentoOposicionHechaToAttach = em.getReference(documentoOposicionHechaListNewDocumentoOposicionHechaToAttach.getClass(), documentoOposicionHechaListNewDocumentoOposicionHechaToAttach.getIdDocumento());
                attachedDocumentoOposicionHechaListNew.add(documentoOposicionHechaListNewDocumentoOposicionHechaToAttach);
            }
            documentoOposicionHechaListNew = attachedDocumentoOposicionHechaListNew;
            oposicionHecha.setDocumentoOposicionHechaList(documentoOposicionHechaListNew);
            oposicionHecha = em.merge(oposicionHecha);
            if (idAbogadoOpositanteOld != null && !idAbogadoOpositanteOld.equals(idAbogadoOpositanteNew)) {
                idAbogadoOpositanteOld.getOposicionHechaList().remove(oposicionHecha);
                idAbogadoOpositanteOld = em.merge(idAbogadoOpositanteOld);
            }
            if (idAbogadoOpositanteNew != null && !idAbogadoOpositanteNew.equals(idAbogadoOpositanteOld)) {
                idAbogadoOpositanteNew.getOposicionHechaList().add(oposicionHecha);
                idAbogadoOpositanteNew = em.merge(idAbogadoOpositanteNew);
            }
            if (idEstadoOposicionOld != null && !idEstadoOposicionOld.equals(idEstadoOposicionNew)) {
                idEstadoOposicionOld.getOposicionHechaList().remove(oposicionHecha);
                idEstadoOposicionOld = em.merge(idEstadoOposicionOld);
            }
            if (idEstadoOposicionNew != null && !idEstadoOposicionNew.equals(idEstadoOposicionOld)) {
                idEstadoOposicionNew.getOposicionHechaList().add(oposicionHecha);
                idEstadoOposicionNew = em.merge(idEstadoOposicionNew);
            }
            if (idExpedienteOpositanteOld != null && !idExpedienteOpositanteOld.equals(idExpedienteOpositanteNew)) {
                idExpedienteOpositanteOld.getOposicionHechaList().remove(oposicionHecha);
                idExpedienteOpositanteOld = em.merge(idExpedienteOpositanteOld);
            }
            if (idExpedienteOpositanteNew != null && !idExpedienteOpositanteNew.equals(idExpedienteOpositanteOld)) {
                idExpedienteOpositanteNew.getOposicionHechaList().add(oposicionHecha);
                idExpedienteOpositanteNew = em.merge(idExpedienteOpositanteNew);
            }
            for (EventoOposicionHecha eventoOposicionHechaListNewEventoOposicionHecha : eventoOposicionHechaListNew) {
                if (!eventoOposicionHechaListOld.contains(eventoOposicionHechaListNewEventoOposicionHecha)) {
                    OposicionHecha oldIdOposicionHechaOfEventoOposicionHechaListNewEventoOposicionHecha = eventoOposicionHechaListNewEventoOposicionHecha.getIdOposicionHecha();
                    eventoOposicionHechaListNewEventoOposicionHecha.setIdOposicionHecha(oposicionHecha);
                    eventoOposicionHechaListNewEventoOposicionHecha = em.merge(eventoOposicionHechaListNewEventoOposicionHecha);
                    if (oldIdOposicionHechaOfEventoOposicionHechaListNewEventoOposicionHecha != null && !oldIdOposicionHechaOfEventoOposicionHechaListNewEventoOposicionHecha.equals(oposicionHecha)) {
                        oldIdOposicionHechaOfEventoOposicionHechaListNewEventoOposicionHecha.getEventoOposicionHechaList().remove(eventoOposicionHechaListNewEventoOposicionHecha);
                        oldIdOposicionHechaOfEventoOposicionHechaListNewEventoOposicionHecha = em.merge(oldIdOposicionHechaOfEventoOposicionHechaListNewEventoOposicionHecha);
                    }
                }
            }
            for (HistorialEstadoOposicionHecha historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha : historialEstadoOposicionHechaListNew) {
                if (!historialEstadoOposicionHechaListOld.contains(historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha)) {
                    OposicionHecha oldIdOposicionHechaOfHistorialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha = historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha.getIdOposicionHecha();
                    historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha.setIdOposicionHecha(oposicionHecha);
                    historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha = em.merge(historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha);
                    if (oldIdOposicionHechaOfHistorialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha != null && !oldIdOposicionHechaOfHistorialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha.equals(oposicionHecha)) {
                        oldIdOposicionHechaOfHistorialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha.getHistorialEstadoOposicionHechaList().remove(historialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha);
                        oldIdOposicionHechaOfHistorialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha = em.merge(oldIdOposicionHechaOfHistorialEstadoOposicionHechaListNewHistorialEstadoOposicionHecha);
                    }
                }
            }
            for (DocumentoOposicionHecha documentoOposicionHechaListNewDocumentoOposicionHecha : documentoOposicionHechaListNew) {
                if (!documentoOposicionHechaListOld.contains(documentoOposicionHechaListNewDocumentoOposicionHecha)) {
                    OposicionHecha oldIdOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha = documentoOposicionHechaListNewDocumentoOposicionHecha.getIdOposicionHecha();
                    documentoOposicionHechaListNewDocumentoOposicionHecha.setIdOposicionHecha(oposicionHecha);
                    documentoOposicionHechaListNewDocumentoOposicionHecha = em.merge(documentoOposicionHechaListNewDocumentoOposicionHecha);
                    if (oldIdOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha != null && !oldIdOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha.equals(oposicionHecha)) {
                        oldIdOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha.getDocumentoOposicionHechaList().remove(documentoOposicionHechaListNewDocumentoOposicionHecha);
                        oldIdOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha = em.merge(oldIdOposicionHechaOfDocumentoOposicionHechaListNewDocumentoOposicionHecha);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = oposicionHecha.getIdOposicion();
                if (findOposicionHecha(id) == null) {
                    throw new NonexistentEntityException("The oposicionHecha with id " + id + " no longer exists.");
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
            OposicionHecha oposicionHecha;
            try {
                oposicionHecha = em.getReference(OposicionHecha.class, id);
                oposicionHecha.getIdOposicion();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The oposicionHecha with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<EventoOposicionHecha> eventoOposicionHechaListOrphanCheck = oposicionHecha.getEventoOposicionHechaList();
            for (EventoOposicionHecha eventoOposicionHechaListOrphanCheckEventoOposicionHecha : eventoOposicionHechaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This OposicionHecha (" + oposicionHecha + ") cannot be destroyed since the EventoOposicionHecha " + eventoOposicionHechaListOrphanCheckEventoOposicionHecha + " in its eventoOposicionHechaList field has a non-nullable idOposicionHecha field.");
            }
            List<HistorialEstadoOposicionHecha> historialEstadoOposicionHechaListOrphanCheck = oposicionHecha.getHistorialEstadoOposicionHechaList();
            for (HistorialEstadoOposicionHecha historialEstadoOposicionHechaListOrphanCheckHistorialEstadoOposicionHecha : historialEstadoOposicionHechaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This OposicionHecha (" + oposicionHecha + ") cannot be destroyed since the HistorialEstadoOposicionHecha " + historialEstadoOposicionHechaListOrphanCheckHistorialEstadoOposicionHecha + " in its historialEstadoOposicionHechaList field has a non-nullable idOposicionHecha field.");
            }
            List<DocumentoOposicionHecha> documentoOposicionHechaListOrphanCheck = oposicionHecha.getDocumentoOposicionHechaList();
            for (DocumentoOposicionHecha documentoOposicionHechaListOrphanCheckDocumentoOposicionHecha : documentoOposicionHechaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This OposicionHecha (" + oposicionHecha + ") cannot be destroyed since the DocumentoOposicionHecha " + documentoOposicionHechaListOrphanCheckDocumentoOposicionHecha + " in its documentoOposicionHechaList field has a non-nullable idOposicionHecha field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Abogado idAbogadoOpositante = oposicionHecha.getIdAbogadoOpositante();
            if (idAbogadoOpositante != null) {
                idAbogadoOpositante.getOposicionHechaList().remove(oposicionHecha);
                idAbogadoOpositante = em.merge(idAbogadoOpositante);
            }
            EstadoOposicion idEstadoOposicion = oposicionHecha.getIdEstadoOposicion();
            if (idEstadoOposicion != null) {
                idEstadoOposicion.getOposicionHechaList().remove(oposicionHecha);
                idEstadoOposicion = em.merge(idEstadoOposicion);
            }
            Expediente idExpedienteOpositante = oposicionHecha.getIdExpedienteOpositante();
            if (idExpedienteOpositante != null) {
                idExpedienteOpositante.getOposicionHechaList().remove(oposicionHecha);
                idExpedienteOpositante = em.merge(idExpedienteOpositante);
            }
            em.remove(oposicionHecha);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<OposicionHecha> findOposicionHechaEntities() {
        return findOposicionHechaEntities(true, -1, -1);
    }

    public List<OposicionHecha> findOposicionHechaEntities(int maxResults, int firstResult) {
        return findOposicionHechaEntities(false, maxResults, firstResult);
    }

    private List<OposicionHecha> findOposicionHechaEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            cq.select(cq.from(OposicionHecha.class));
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

    public OposicionHecha findOposicionHecha(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(OposicionHecha.class, id);
        } finally {
            em.close();
        }
    }

    public int getOposicionHechaCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<OposicionHecha> rt = cq.from(OposicionHecha.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    /**
     * Retorna true si la oposicion esta vacio, caso contrario false
     * @param idOposicion
     * @return Boolean
     */
    public Boolean oposicionVacio(Integer idOposicion) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select d.idOposicionHecha.idOposicion from DocumentoOposicionHecha d where d.idOposicionHecha.idOposicion = :idOposicion "+
                                "union "+
                                "select e.idOposicionHecha.idOposicion from EventoOposicionHecha e where e.idOposicionHecha.idOposicion = :idOposicion ";
                                
                
            Query q = em.createQuery(consulta);
            
            q.setParameter("idOposicion", idOposicion);
           
             
            List<Integer> lista = q.getResultList();
           
            if(lista.size() > 0){
                return  false;
            }else{
                return true;
            }
            
        } catch(Exception e){
            System.out.println(e);
            return false;
            
        }finally {
            em.close();
        }
    }
    
}
