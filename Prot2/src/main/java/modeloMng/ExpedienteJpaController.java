/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modeloMng;

import java.io.Serializable;
import java.math.BigDecimal;
import javax.persistence.Query;
import javax.persistence.EntityNotFoundException;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import modelo.Abogado;
import modelo.Clase;
import modelo.Cliente;
import modelo.EstadoMarca;
import modelo.Marca;
import modelo.TipoExpediente;
import modelo.Documento;
import java.util.ArrayList;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.criteria.CriteriaBuilder;
import modelo.Evento;
import modelo.Expediente;
import modelo.Expediente_;
import modelo.Historial;
import modelo.HistorialEstadoMarca;
import modelo.OposicionHecha;
import modelo.OposicionRecibida;
import modeloMng.exceptions.IllegalOrphanException;
import modeloMng.exceptions.NonexistentEntityException;

/**
 *
 * @author User
 */
public class ExpedienteJpaController implements Serializable {

    public ExpedienteJpaController() {
        this.emf = Persistence.createEntityManagerFactory("com.mycompany_Prot2_war_1.0-SNAPSHOTPU"); 
    }
    private EntityManagerFactory emf = null;

    public EntityManager getEntityManager() {
        return emf.createEntityManager();
    }

    public void create(Expediente expediente) {
        if (expediente.getDocumentoList() == null) {
            expediente.setDocumentoList(new ArrayList<Documento>());
        }
        if (expediente.getEventoList() == null) {
            expediente.setEventoList(new ArrayList<Evento>());
        }
        if (expediente.getHistorialEstadoMarcaList() == null) {
            expediente.setHistorialEstadoMarcaList(new ArrayList<HistorialEstadoMarca>());
        }
        if (expediente.getOposicionRecibidaList() == null) {
            expediente.setOposicionRecibidaList(new ArrayList<OposicionRecibida>());
        }
        if (expediente.getOposicionHechaList() == null) {
            expediente.setOposicionHechaList(new ArrayList<OposicionHecha>());
        }
        if (expediente.getHistorialList() == null) {
            expediente.setHistorialList(new ArrayList<Historial>());
        }
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Abogado idAbogado = expediente.getIdAbogado();
            if (idAbogado != null) {
                idAbogado = em.getReference(idAbogado.getClass(), idAbogado.getIdAbogado());
                expediente.setIdAbogado(idAbogado);
            }
            Clase nroClase = expediente.getNroClase();
            if (nroClase != null) {
                nroClase = em.getReference(nroClase.getClass(), nroClase.getNroClase());
                expediente.setNroClase(nroClase);
            }
            Cliente idCliente = expediente.getIdCliente();
            if (idCliente != null) {
                idCliente = em.getReference(idCliente.getClass(), idCliente.getIdCliente());
                expediente.setIdCliente(idCliente);
            }
            EstadoMarca idEstado = expediente.getIdEstado();
            if (idEstado != null) {
                idEstado = em.getReference(idEstado.getClass(), idEstado.getIdEstado());
                expediente.setIdEstado(idEstado);
            }
            Marca idMarca = expediente.getIdMarca();
            if (idMarca != null) {
                idMarca = em.getReference(idMarca.getClass(), idMarca.getIdMarca());
                expediente.setIdMarca(idMarca);
            }
            TipoExpediente tipoExpediente = expediente.getTipoExpediente();
            if (tipoExpediente != null) {
                tipoExpediente = em.getReference(tipoExpediente.getClass(), tipoExpediente.getIdTipoExpediente());
                expediente.setTipoExpediente(tipoExpediente);
            }
            List<Documento> attachedDocumentoList = new ArrayList<Documento>();
            for (Documento documentoListDocumentoToAttach : expediente.getDocumentoList()) {
                documentoListDocumentoToAttach = em.getReference(documentoListDocumentoToAttach.getClass(), documentoListDocumentoToAttach.getIdDocumento());
                attachedDocumentoList.add(documentoListDocumentoToAttach);
            }
            expediente.setDocumentoList(attachedDocumentoList);
            List<Evento> attachedEventoList = new ArrayList<Evento>();
            for (Evento eventoListEventoToAttach : expediente.getEventoList()) {
                eventoListEventoToAttach = em.getReference(eventoListEventoToAttach.getClass(), eventoListEventoToAttach.getIdEvento());
                attachedEventoList.add(eventoListEventoToAttach);
            }
            expediente.setEventoList(attachedEventoList);
            List<HistorialEstadoMarca> attachedHistorialEstadoMarcaList = new ArrayList<HistorialEstadoMarca>();
            for (HistorialEstadoMarca historialEstadoMarcaListHistorialEstadoMarcaToAttach : expediente.getHistorialEstadoMarcaList()) {
                historialEstadoMarcaListHistorialEstadoMarcaToAttach = em.getReference(historialEstadoMarcaListHistorialEstadoMarcaToAttach.getClass(), historialEstadoMarcaListHistorialEstadoMarcaToAttach.getIdHistorial());
                attachedHistorialEstadoMarcaList.add(historialEstadoMarcaListHistorialEstadoMarcaToAttach);
            }
            expediente.setHistorialEstadoMarcaList(attachedHistorialEstadoMarcaList);
            List<OposicionRecibida> attachedOposicionRecibidaList = new ArrayList<OposicionRecibida>();
            for (OposicionRecibida oposicionRecibidaListOposicionRecibidaToAttach : expediente.getOposicionRecibidaList()) {
                oposicionRecibidaListOposicionRecibidaToAttach = em.getReference(oposicionRecibidaListOposicionRecibidaToAttach.getClass(), oposicionRecibidaListOposicionRecibidaToAttach.getIdOposicion());
                attachedOposicionRecibidaList.add(oposicionRecibidaListOposicionRecibidaToAttach);
            }
            expediente.setOposicionRecibidaList(attachedOposicionRecibidaList);
            List<OposicionHecha> attachedOposicionHechaList = new ArrayList<OposicionHecha>();
            for (OposicionHecha oposicionHechaListOposicionHechaToAttach : expediente.getOposicionHechaList()) {
                oposicionHechaListOposicionHechaToAttach = em.getReference(oposicionHechaListOposicionHechaToAttach.getClass(), oposicionHechaListOposicionHechaToAttach.getIdOposicion());
                attachedOposicionHechaList.add(oposicionHechaListOposicionHechaToAttach);
            }
            expediente.setOposicionHechaList(attachedOposicionHechaList);
            List<Historial> attachedHistorialList = new ArrayList<Historial>();
            for (Historial historialListHistorialToAttach : expediente.getHistorialList()) {
                historialListHistorialToAttach = em.getReference(historialListHistorialToAttach.getClass(), historialListHistorialToAttach.getIdHistorial());
                attachedHistorialList.add(historialListHistorialToAttach);
            }
            expediente.setHistorialList(attachedHistorialList);
            em.persist(expediente);
            if (idAbogado != null) {
                idAbogado.getExpedienteList().add(expediente);
                idAbogado = em.merge(idAbogado);
            }
            if (nroClase != null) {
                nroClase.getExpedienteList().add(expediente);
                nroClase = em.merge(nroClase);
            }
            if (idCliente != null) {
                idCliente.getExpedienteList().add(expediente);
                idCliente = em.merge(idCliente);
            }
            if (idEstado != null) {
                idEstado.getExpedienteList().add(expediente);
                idEstado = em.merge(idEstado);
            }
            if (idMarca != null) {
                idMarca.getExpedienteList().add(expediente);
                idMarca = em.merge(idMarca);
            }
            if (tipoExpediente != null) {
                tipoExpediente.getExpedienteList().add(expediente);
                tipoExpediente = em.merge(tipoExpediente);
            }
            for (Documento documentoListDocumento : expediente.getDocumentoList()) {
                Expediente oldIdExpedienteOfDocumentoListDocumento = documentoListDocumento.getIdExpediente();
                documentoListDocumento.setIdExpediente(expediente);
                documentoListDocumento = em.merge(documentoListDocumento);
                if (oldIdExpedienteOfDocumentoListDocumento != null) {
                    oldIdExpedienteOfDocumentoListDocumento.getDocumentoList().remove(documentoListDocumento);
                    oldIdExpedienteOfDocumentoListDocumento = em.merge(oldIdExpedienteOfDocumentoListDocumento);
                }
            }
            for (Evento eventoListEvento : expediente.getEventoList()) {
                Expediente oldIdExpedienteOfEventoListEvento = eventoListEvento.getIdExpediente();
                eventoListEvento.setIdExpediente(expediente);
                eventoListEvento = em.merge(eventoListEvento);
                if (oldIdExpedienteOfEventoListEvento != null) {
                    oldIdExpedienteOfEventoListEvento.getEventoList().remove(eventoListEvento);
                    oldIdExpedienteOfEventoListEvento = em.merge(oldIdExpedienteOfEventoListEvento);
                }
            }
            for (HistorialEstadoMarca historialEstadoMarcaListHistorialEstadoMarca : expediente.getHistorialEstadoMarcaList()) {
                Expediente oldIdExpedienteOfHistorialEstadoMarcaListHistorialEstadoMarca = historialEstadoMarcaListHistorialEstadoMarca.getIdExpediente();
                historialEstadoMarcaListHistorialEstadoMarca.setIdExpediente(expediente);
                historialEstadoMarcaListHistorialEstadoMarca = em.merge(historialEstadoMarcaListHistorialEstadoMarca);
                if (oldIdExpedienteOfHistorialEstadoMarcaListHistorialEstadoMarca != null) {
                    oldIdExpedienteOfHistorialEstadoMarcaListHistorialEstadoMarca.getHistorialEstadoMarcaList().remove(historialEstadoMarcaListHistorialEstadoMarca);
                    oldIdExpedienteOfHistorialEstadoMarcaListHistorialEstadoMarca = em.merge(oldIdExpedienteOfHistorialEstadoMarcaListHistorialEstadoMarca);
                }
            }
            for (OposicionRecibida oposicionRecibidaListOposicionRecibida : expediente.getOposicionRecibidaList()) {
                Expediente oldIdExpedienteOfOposicionRecibidaListOposicionRecibida = oposicionRecibidaListOposicionRecibida.getIdExpediente();
                oposicionRecibidaListOposicionRecibida.setIdExpediente(expediente);
                oposicionRecibidaListOposicionRecibida = em.merge(oposicionRecibidaListOposicionRecibida);
                if (oldIdExpedienteOfOposicionRecibidaListOposicionRecibida != null) {
                    oldIdExpedienteOfOposicionRecibidaListOposicionRecibida.getOposicionRecibidaList().remove(oposicionRecibidaListOposicionRecibida);
                    oldIdExpedienteOfOposicionRecibidaListOposicionRecibida = em.merge(oldIdExpedienteOfOposicionRecibidaListOposicionRecibida);
                }
            }
            for (OposicionHecha oposicionHechaListOposicionHecha : expediente.getOposicionHechaList()) {
                Expediente oldIdExpedienteOpositanteOfOposicionHechaListOposicionHecha = oposicionHechaListOposicionHecha.getIdExpedienteOpositante();
                oposicionHechaListOposicionHecha.setIdExpedienteOpositante(expediente);
                oposicionHechaListOposicionHecha = em.merge(oposicionHechaListOposicionHecha);
                if (oldIdExpedienteOpositanteOfOposicionHechaListOposicionHecha != null) {
                    oldIdExpedienteOpositanteOfOposicionHechaListOposicionHecha.getOposicionHechaList().remove(oposicionHechaListOposicionHecha);
                    oldIdExpedienteOpositanteOfOposicionHechaListOposicionHecha = em.merge(oldIdExpedienteOpositanteOfOposicionHechaListOposicionHecha);
                }
            }
            for (Historial historialListHistorial : expediente.getHistorialList()) {
                Expediente oldIdExpedienteOfHistorialListHistorial = historialListHistorial.getIdExpediente();
                historialListHistorial.setIdExpediente(expediente);
                historialListHistorial = em.merge(historialListHistorial);
                if (oldIdExpedienteOfHistorialListHistorial != null) {
                    oldIdExpedienteOfHistorialListHistorial.getHistorialList().remove(historialListHistorial);
                    oldIdExpedienteOfHistorialListHistorial = em.merge(oldIdExpedienteOfHistorialListHistorial);
                }
            }
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public void edit(Expediente expediente) throws IllegalOrphanException, NonexistentEntityException, Exception {
        EntityManager em = null;
        try {
            em = getEntityManager();
            em.getTransaction().begin();
            Expediente persistentExpediente = em.find(Expediente.class, expediente.getIdExpediente());
            Abogado idAbogadoOld = persistentExpediente.getIdAbogado();
            Abogado idAbogadoNew = expediente.getIdAbogado();
            Clase nroClaseOld = persistentExpediente.getNroClase();
            Clase nroClaseNew = expediente.getNroClase();
            Cliente idClienteOld = persistentExpediente.getIdCliente();
            Cliente idClienteNew = expediente.getIdCliente();
            EstadoMarca idEstadoOld = persistentExpediente.getIdEstado();
            EstadoMarca idEstadoNew = expediente.getIdEstado();
            Marca idMarcaOld = persistentExpediente.getIdMarca();
            Marca idMarcaNew = expediente.getIdMarca();
            TipoExpediente tipoExpedienteOld = persistentExpediente.getTipoExpediente();
            TipoExpediente tipoExpedienteNew = expediente.getTipoExpediente();
            List<Documento> documentoListOld = persistentExpediente.getDocumentoList();
            List<Documento> documentoListNew = expediente.getDocumentoList();
            List<Evento> eventoListOld = persistentExpediente.getEventoList();
            List<Evento> eventoListNew = expediente.getEventoList();
            List<HistorialEstadoMarca> historialEstadoMarcaListOld = persistentExpediente.getHistorialEstadoMarcaList();
            List<HistorialEstadoMarca> historialEstadoMarcaListNew = expediente.getHistorialEstadoMarcaList();
            List<OposicionRecibida> oposicionRecibidaListOld = persistentExpediente.getOposicionRecibidaList();
            List<OposicionRecibida> oposicionRecibidaListNew = expediente.getOposicionRecibidaList();
            List<OposicionHecha> oposicionHechaListOld = persistentExpediente.getOposicionHechaList();
            List<OposicionHecha> oposicionHechaListNew = expediente.getOposicionHechaList();
            List<Historial> historialListOld = persistentExpediente.getHistorialList();
            List<Historial> historialListNew = expediente.getHistorialList();
            List<String> illegalOrphanMessages = null;
            for (Documento documentoListOldDocumento : documentoListOld) {
                if (!documentoListNew.contains(documentoListOldDocumento)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Documento " + documentoListOldDocumento + " since its idExpediente field is not nullable.");
                }
            }
            for (Evento eventoListOldEvento : eventoListOld) {
                if (!eventoListNew.contains(eventoListOldEvento)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Evento " + eventoListOldEvento + " since its idExpediente field is not nullable.");
                }
            }
            for (HistorialEstadoMarca historialEstadoMarcaListOldHistorialEstadoMarca : historialEstadoMarcaListOld) {
                if (!historialEstadoMarcaListNew.contains(historialEstadoMarcaListOldHistorialEstadoMarca)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain HistorialEstadoMarca " + historialEstadoMarcaListOldHistorialEstadoMarca + " since its idExpediente field is not nullable.");
                }
            }
            for (OposicionRecibida oposicionRecibidaListOldOposicionRecibida : oposicionRecibidaListOld) {
                if (!oposicionRecibidaListNew.contains(oposicionRecibidaListOldOposicionRecibida)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain OposicionRecibida " + oposicionRecibidaListOldOposicionRecibida + " since its idExpediente field is not nullable.");
                }
            }
            for (OposicionHecha oposicionHechaListOldOposicionHecha : oposicionHechaListOld) {
                if (!oposicionHechaListNew.contains(oposicionHechaListOldOposicionHecha)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain OposicionHecha " + oposicionHechaListOldOposicionHecha + " since its idExpedienteOpositante field is not nullable.");
                }
            }
            for (Historial historialListOldHistorial : historialListOld) {
                if (!historialListNew.contains(historialListOldHistorial)) {
                    if (illegalOrphanMessages == null) {
                        illegalOrphanMessages = new ArrayList<String>();
                    }
                    illegalOrphanMessages.add("You must retain Historial " + historialListOldHistorial + " since its idExpediente field is not nullable.");
                }
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            if (idAbogadoNew != null) {
                idAbogadoNew = em.getReference(idAbogadoNew.getClass(), idAbogadoNew.getIdAbogado());
                expediente.setIdAbogado(idAbogadoNew);
            }
            if (nroClaseNew != null) {
                nroClaseNew = em.getReference(nroClaseNew.getClass(), nroClaseNew.getNroClase());
                expediente.setNroClase(nroClaseNew);
            }
            if (idClienteNew != null) {
                idClienteNew = em.getReference(idClienteNew.getClass(), idClienteNew.getIdCliente());
                expediente.setIdCliente(idClienteNew);
            }
            if (idEstadoNew != null) {
                idEstadoNew = em.getReference(idEstadoNew.getClass(), idEstadoNew.getIdEstado());
                expediente.setIdEstado(idEstadoNew);
            }
            if (idMarcaNew != null) {
                idMarcaNew = em.getReference(idMarcaNew.getClass(), idMarcaNew.getIdMarca());
                expediente.setIdMarca(idMarcaNew);
            }
            if (tipoExpedienteNew != null) {
                tipoExpedienteNew = em.getReference(tipoExpedienteNew.getClass(), tipoExpedienteNew.getIdTipoExpediente());
                expediente.setTipoExpediente(tipoExpedienteNew);
            }
            List<Documento> attachedDocumentoListNew = new ArrayList<Documento>();
            for (Documento documentoListNewDocumentoToAttach : documentoListNew) {
                documentoListNewDocumentoToAttach = em.getReference(documentoListNewDocumentoToAttach.getClass(), documentoListNewDocumentoToAttach.getIdDocumento());
                attachedDocumentoListNew.add(documentoListNewDocumentoToAttach);
            }
            documentoListNew = attachedDocumentoListNew;
            expediente.setDocumentoList(documentoListNew);
            List<Evento> attachedEventoListNew = new ArrayList<Evento>();
            for (Evento eventoListNewEventoToAttach : eventoListNew) {
                eventoListNewEventoToAttach = em.getReference(eventoListNewEventoToAttach.getClass(), eventoListNewEventoToAttach.getIdEvento());
                attachedEventoListNew.add(eventoListNewEventoToAttach);
            }
            eventoListNew = attachedEventoListNew;
            expediente.setEventoList(eventoListNew);
            List<HistorialEstadoMarca> attachedHistorialEstadoMarcaListNew = new ArrayList<HistorialEstadoMarca>();
            for (HistorialEstadoMarca historialEstadoMarcaListNewHistorialEstadoMarcaToAttach : historialEstadoMarcaListNew) {
                historialEstadoMarcaListNewHistorialEstadoMarcaToAttach = em.getReference(historialEstadoMarcaListNewHistorialEstadoMarcaToAttach.getClass(), historialEstadoMarcaListNewHistorialEstadoMarcaToAttach.getIdHistorial());
                attachedHistorialEstadoMarcaListNew.add(historialEstadoMarcaListNewHistorialEstadoMarcaToAttach);
            }
            historialEstadoMarcaListNew = attachedHistorialEstadoMarcaListNew;
            expediente.setHistorialEstadoMarcaList(historialEstadoMarcaListNew);
            List<OposicionRecibida> attachedOposicionRecibidaListNew = new ArrayList<OposicionRecibida>();
            for (OposicionRecibida oposicionRecibidaListNewOposicionRecibidaToAttach : oposicionRecibidaListNew) {
                oposicionRecibidaListNewOposicionRecibidaToAttach = em.getReference(oposicionRecibidaListNewOposicionRecibidaToAttach.getClass(), oposicionRecibidaListNewOposicionRecibidaToAttach.getIdOposicion());
                attachedOposicionRecibidaListNew.add(oposicionRecibidaListNewOposicionRecibidaToAttach);
            }
            oposicionRecibidaListNew = attachedOposicionRecibidaListNew;
            expediente.setOposicionRecibidaList(oposicionRecibidaListNew);
            List<OposicionHecha> attachedOposicionHechaListNew = new ArrayList<OposicionHecha>();
            for (OposicionHecha oposicionHechaListNewOposicionHechaToAttach : oposicionHechaListNew) {
                oposicionHechaListNewOposicionHechaToAttach = em.getReference(oposicionHechaListNewOposicionHechaToAttach.getClass(), oposicionHechaListNewOposicionHechaToAttach.getIdOposicion());
                attachedOposicionHechaListNew.add(oposicionHechaListNewOposicionHechaToAttach);
            }
            oposicionHechaListNew = attachedOposicionHechaListNew;
            expediente.setOposicionHechaList(oposicionHechaListNew);
            List<Historial> attachedHistorialListNew = new ArrayList<Historial>();
            for (Historial historialListNewHistorialToAttach : historialListNew) {
                historialListNewHistorialToAttach = em.getReference(historialListNewHistorialToAttach.getClass(), historialListNewHistorialToAttach.getIdHistorial());
                attachedHistorialListNew.add(historialListNewHistorialToAttach);
            }
            historialListNew = attachedHistorialListNew;
            expediente.setHistorialList(historialListNew);
            expediente = em.merge(expediente);
            if (idAbogadoOld != null && !idAbogadoOld.equals(idAbogadoNew)) {
                idAbogadoOld.getExpedienteList().remove(expediente);
                idAbogadoOld = em.merge(idAbogadoOld);
            }
            if (idAbogadoNew != null && !idAbogadoNew.equals(idAbogadoOld)) {
                idAbogadoNew.getExpedienteList().add(expediente);
                idAbogadoNew = em.merge(idAbogadoNew);
            }
            if (nroClaseOld != null && !nroClaseOld.equals(nroClaseNew)) {
                nroClaseOld.getExpedienteList().remove(expediente);
                nroClaseOld = em.merge(nroClaseOld);
            }
            if (nroClaseNew != null && !nroClaseNew.equals(nroClaseOld)) {
                nroClaseNew.getExpedienteList().add(expediente);
                nroClaseNew = em.merge(nroClaseNew);
            }
            if (idClienteOld != null && !idClienteOld.equals(idClienteNew)) {
                idClienteOld.getExpedienteList().remove(expediente);
                idClienteOld = em.merge(idClienteOld);
            }
            if (idClienteNew != null && !idClienteNew.equals(idClienteOld)) {
                idClienteNew.getExpedienteList().add(expediente);
                idClienteNew = em.merge(idClienteNew);
            }
            if (idEstadoOld != null && !idEstadoOld.equals(idEstadoNew)) {
                idEstadoOld.getExpedienteList().remove(expediente);
                idEstadoOld = em.merge(idEstadoOld);
            }
            if (idEstadoNew != null && !idEstadoNew.equals(idEstadoOld)) {
                idEstadoNew.getExpedienteList().add(expediente);
                idEstadoNew = em.merge(idEstadoNew);
            }
            if (idMarcaOld != null && !idMarcaOld.equals(idMarcaNew)) {
                idMarcaOld.getExpedienteList().remove(expediente);
                idMarcaOld = em.merge(idMarcaOld);
            }
            if (idMarcaNew != null && !idMarcaNew.equals(idMarcaOld)) {
                idMarcaNew.getExpedienteList().add(expediente);
                idMarcaNew = em.merge(idMarcaNew);
            }
            if (tipoExpedienteOld != null && !tipoExpedienteOld.equals(tipoExpedienteNew)) {
                tipoExpedienteOld.getExpedienteList().remove(expediente);
                tipoExpedienteOld = em.merge(tipoExpedienteOld);
            }
            if (tipoExpedienteNew != null && !tipoExpedienteNew.equals(tipoExpedienteOld)) {
                tipoExpedienteNew.getExpedienteList().add(expediente);
                tipoExpedienteNew = em.merge(tipoExpedienteNew);
            }
            for (Documento documentoListNewDocumento : documentoListNew) {
                if (!documentoListOld.contains(documentoListNewDocumento)) {
                    Expediente oldIdExpedienteOfDocumentoListNewDocumento = documentoListNewDocumento.getIdExpediente();
                    documentoListNewDocumento.setIdExpediente(expediente);
                    documentoListNewDocumento = em.merge(documentoListNewDocumento);
                    if (oldIdExpedienteOfDocumentoListNewDocumento != null && !oldIdExpedienteOfDocumentoListNewDocumento.equals(expediente)) {
                        oldIdExpedienteOfDocumentoListNewDocumento.getDocumentoList().remove(documentoListNewDocumento);
                        oldIdExpedienteOfDocumentoListNewDocumento = em.merge(oldIdExpedienteOfDocumentoListNewDocumento);
                    }
                }
            }
            for (Evento eventoListNewEvento : eventoListNew) {
                if (!eventoListOld.contains(eventoListNewEvento)) {
                    Expediente oldIdExpedienteOfEventoListNewEvento = eventoListNewEvento.getIdExpediente();
                    eventoListNewEvento.setIdExpediente(expediente);
                    eventoListNewEvento = em.merge(eventoListNewEvento);
                    if (oldIdExpedienteOfEventoListNewEvento != null && !oldIdExpedienteOfEventoListNewEvento.equals(expediente)) {
                        oldIdExpedienteOfEventoListNewEvento.getEventoList().remove(eventoListNewEvento);
                        oldIdExpedienteOfEventoListNewEvento = em.merge(oldIdExpedienteOfEventoListNewEvento);
                    }
                }
            }
            for (HistorialEstadoMarca historialEstadoMarcaListNewHistorialEstadoMarca : historialEstadoMarcaListNew) {
                if (!historialEstadoMarcaListOld.contains(historialEstadoMarcaListNewHistorialEstadoMarca)) {
                    Expediente oldIdExpedienteOfHistorialEstadoMarcaListNewHistorialEstadoMarca = historialEstadoMarcaListNewHistorialEstadoMarca.getIdExpediente();
                    historialEstadoMarcaListNewHistorialEstadoMarca.setIdExpediente(expediente);
                    historialEstadoMarcaListNewHistorialEstadoMarca = em.merge(historialEstadoMarcaListNewHistorialEstadoMarca);
                    if (oldIdExpedienteOfHistorialEstadoMarcaListNewHistorialEstadoMarca != null && !oldIdExpedienteOfHistorialEstadoMarcaListNewHistorialEstadoMarca.equals(expediente)) {
                        oldIdExpedienteOfHistorialEstadoMarcaListNewHistorialEstadoMarca.getHistorialEstadoMarcaList().remove(historialEstadoMarcaListNewHistorialEstadoMarca);
                        oldIdExpedienteOfHistorialEstadoMarcaListNewHistorialEstadoMarca = em.merge(oldIdExpedienteOfHistorialEstadoMarcaListNewHistorialEstadoMarca);
                    }
                }
            }
            for (OposicionRecibida oposicionRecibidaListNewOposicionRecibida : oposicionRecibidaListNew) {
                if (!oposicionRecibidaListOld.contains(oposicionRecibidaListNewOposicionRecibida)) {
                    Expediente oldIdExpedienteOfOposicionRecibidaListNewOposicionRecibida = oposicionRecibidaListNewOposicionRecibida.getIdExpediente();
                    oposicionRecibidaListNewOposicionRecibida.setIdExpediente(expediente);
                    oposicionRecibidaListNewOposicionRecibida = em.merge(oposicionRecibidaListNewOposicionRecibida);
                    if (oldIdExpedienteOfOposicionRecibidaListNewOposicionRecibida != null && !oldIdExpedienteOfOposicionRecibidaListNewOposicionRecibida.equals(expediente)) {
                        oldIdExpedienteOfOposicionRecibidaListNewOposicionRecibida.getOposicionRecibidaList().remove(oposicionRecibidaListNewOposicionRecibida);
                        oldIdExpedienteOfOposicionRecibidaListNewOposicionRecibida = em.merge(oldIdExpedienteOfOposicionRecibidaListNewOposicionRecibida);
                    }
                }
            }
            for (OposicionHecha oposicionHechaListNewOposicionHecha : oposicionHechaListNew) {
                if (!oposicionHechaListOld.contains(oposicionHechaListNewOposicionHecha)) {
                    Expediente oldIdExpedienteOpositanteOfOposicionHechaListNewOposicionHecha = oposicionHechaListNewOposicionHecha.getIdExpedienteOpositante();
                    oposicionHechaListNewOposicionHecha.setIdExpedienteOpositante(expediente);
                    oposicionHechaListNewOposicionHecha = em.merge(oposicionHechaListNewOposicionHecha);
                    if (oldIdExpedienteOpositanteOfOposicionHechaListNewOposicionHecha != null && !oldIdExpedienteOpositanteOfOposicionHechaListNewOposicionHecha.equals(expediente)) {
                        oldIdExpedienteOpositanteOfOposicionHechaListNewOposicionHecha.getOposicionHechaList().remove(oposicionHechaListNewOposicionHecha);
                        oldIdExpedienteOpositanteOfOposicionHechaListNewOposicionHecha = em.merge(oldIdExpedienteOpositanteOfOposicionHechaListNewOposicionHecha);
                    }
                }
            }
            for (Historial historialListNewHistorial : historialListNew) {
                if (!historialListOld.contains(historialListNewHistorial)) {
                    Expediente oldIdExpedienteOfHistorialListNewHistorial = historialListNewHistorial.getIdExpediente();
                    historialListNewHistorial.setIdExpediente(expediente);
                    historialListNewHistorial = em.merge(historialListNewHistorial);
                    if (oldIdExpedienteOfHistorialListNewHistorial != null && !oldIdExpedienteOfHistorialListNewHistorial.equals(expediente)) {
                        oldIdExpedienteOfHistorialListNewHistorial.getHistorialList().remove(historialListNewHistorial);
                        oldIdExpedienteOfHistorialListNewHistorial = em.merge(oldIdExpedienteOfHistorialListNewHistorial);
                    }
                }
            }
            em.getTransaction().commit();
        } catch (Exception ex) {
            String msg = ex.getLocalizedMessage();
            if (msg == null || msg.length() == 0) {
                Integer id = expediente.getIdExpediente();
                if (findExpediente(id) == null) {
                    throw new NonexistentEntityException("The expediente with id " + id + " no longer exists.");
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
            Expediente expediente;
            try {
                expediente = em.getReference(Expediente.class, id);
                expediente.getIdExpediente();
            } catch (EntityNotFoundException enfe) {
                throw new NonexistentEntityException("The expediente with id " + id + " no longer exists.", enfe);
            }
            List<String> illegalOrphanMessages = null;
            List<Documento> documentoListOrphanCheck = expediente.getDocumentoList();
            for (Documento documentoListOrphanCheckDocumento : documentoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Expediente (" + expediente + ") cannot be destroyed since the Documento " + documentoListOrphanCheckDocumento + " in its documentoList field has a non-nullable idExpediente field.");
            }
            List<Evento> eventoListOrphanCheck = expediente.getEventoList();
            for (Evento eventoListOrphanCheckEvento : eventoListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Expediente (" + expediente + ") cannot be destroyed since the Evento " + eventoListOrphanCheckEvento + " in its eventoList field has a non-nullable idExpediente field.");
            }
            List<HistorialEstadoMarca> historialEstadoMarcaListOrphanCheck = expediente.getHistorialEstadoMarcaList();
            for (HistorialEstadoMarca historialEstadoMarcaListOrphanCheckHistorialEstadoMarca : historialEstadoMarcaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Expediente (" + expediente + ") cannot be destroyed since the HistorialEstadoMarca " + historialEstadoMarcaListOrphanCheckHistorialEstadoMarca + " in its historialEstadoMarcaList field has a non-nullable idExpediente field.");
            }
            List<OposicionRecibida> oposicionRecibidaListOrphanCheck = expediente.getOposicionRecibidaList();
            for (OposicionRecibida oposicionRecibidaListOrphanCheckOposicionRecibida : oposicionRecibidaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Expediente (" + expediente + ") cannot be destroyed since the OposicionRecibida " + oposicionRecibidaListOrphanCheckOposicionRecibida + " in its oposicionRecibidaList field has a non-nullable idExpediente field.");
            }
            List<OposicionHecha> oposicionHechaListOrphanCheck = expediente.getOposicionHechaList();
            for (OposicionHecha oposicionHechaListOrphanCheckOposicionHecha : oposicionHechaListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Expediente (" + expediente + ") cannot be destroyed since the OposicionHecha " + oposicionHechaListOrphanCheckOposicionHecha + " in its oposicionHechaList field has a non-nullable idExpedienteOpositante field.");
            }
            List<Historial> historialListOrphanCheck = expediente.getHistorialList();
            for (Historial historialListOrphanCheckHistorial : historialListOrphanCheck) {
                if (illegalOrphanMessages == null) {
                    illegalOrphanMessages = new ArrayList<String>();
                }
                illegalOrphanMessages.add("This Expediente (" + expediente + ") cannot be destroyed since the Historial " + historialListOrphanCheckHistorial + " in its historialList field has a non-nullable idExpediente field.");
            }
            if (illegalOrphanMessages != null) {
                throw new IllegalOrphanException(illegalOrphanMessages);
            }
            Abogado idAbogado = expediente.getIdAbogado();
            if (idAbogado != null) {
                idAbogado.getExpedienteList().remove(expediente);
                idAbogado = em.merge(idAbogado);
            }
            Clase nroClase = expediente.getNroClase();
            if (nroClase != null) {
                nroClase.getExpedienteList().remove(expediente);
                nroClase = em.merge(nroClase);
            }
            Cliente idCliente = expediente.getIdCliente();
            if (idCliente != null) {
                idCliente.getExpedienteList().remove(expediente);
                idCliente = em.merge(idCliente);
            }
            EstadoMarca idEstado = expediente.getIdEstado();
            if (idEstado != null) {
                idEstado.getExpedienteList().remove(expediente);
                idEstado = em.merge(idEstado);
            }
            Marca idMarca = expediente.getIdMarca();
            if (idMarca != null) {
                idMarca.getExpedienteList().remove(expediente);
                idMarca = em.merge(idMarca);
            }
            TipoExpediente tipoExpediente = expediente.getTipoExpediente();
            if (tipoExpediente != null) {
                tipoExpediente.getExpedienteList().remove(expediente);
                tipoExpediente = em.merge(tipoExpediente);
            }
            em.remove(expediente);
            em.getTransaction().commit();
        } finally {
            if (em != null) {
                em.close();
            }
        }
    }

    public List<Expediente> findExpedienteEntities() {
        return findExpedienteEntities(true, -1, -1);
    }

    public List<Expediente> findExpedienteEntities(int maxResults, int firstResult) {
        return findExpedienteEntities(false, maxResults, firstResult);
    }

    private List<Expediente> findExpedienteEntities(boolean all, int maxResults, int firstResult) {
        EntityManager em = getEntityManager();
        try {
            CriteriaBuilder cb = em.getCriteriaBuilder();
            CriteriaQuery cq = cb.createQuery();
            cq.select(cq.from(Expediente.class));
            cq.orderBy(cb.asc(cq.from(Expediente.class).get(Expediente_.nroExpediente)));
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

    public Expediente findExpediente(Integer id) {
        EntityManager em = getEntityManager();
        try {
            return em.find(Expediente.class, id);
        } finally {
            em.close();
        }
    }

    public int getExpedienteCount() {
        EntityManager em = getEntityManager();
        try {
            CriteriaQuery cq = em.getCriteriaBuilder().createQuery();
            Root<Expediente> rt = cq.from(Expediente.class);
            cq.select(em.getCriteriaBuilder().count(rt));
            Query q = em.createQuery(cq);
            return ((Long) q.getSingleResult()).intValue();
        } finally {
            em.close();
        }
    }
    
    /*Responde si existe una duplicacion del numero de expediente  
    
      Si idExpediente es nulo:(GUARDAR)
        Considera si el numero del expediente esta o no duplicado
    
      Si idExpediente no es nulo:(EDITAR)
        Considera si el número esta o no duplicado 
        pero sin considerar el numero del expediente identificado por idExpediente
    */
    public Boolean existeNumeroExpDuplicado(BigDecimal nroExpediente, Integer idExpediente) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(e) from Expediente e "+
                                "where e.nroExpediente = :nroExpediente";
                    
            if(idExpediente != null){
                consulta+= " and e.idExpediente != :idExpediente"; 
            }
            Query q = em.createQuery(consulta);
            
            q.setParameter("nroExpediente", nroExpediente);
           
            
            if(idExpediente != null){
                 q.setParameter("idExpediente", idExpediente);
            }
             
            Integer cant = ((Long) q.getSingleResult()).intValue();
            System.out.println(cant+ " cantidad");
            
            if(cant>0){
                return  true;
            }else{
                return false;
            }
            
        } catch(Exception e){
            System.out.println(e);
            return null;
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Responde si el nuevo registro viola la restriccion unica de clase, marca y titular
     * @param nroClase
     * @param idMarca
     * @param idCliente
     * @return Boolean
     */
    public Boolean violaRestriccionUnicaClaseMarcaCliente(Integer nroClase, Integer idMarca, Integer idCliente) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select count(e) from Expediente e "+
                                "where e.nroClase.nroClase = :nroClase and e.idMarca.idMarca = :idMarca "+
                                "and e.idCliente.idCliente = :idCliente";
                
            Query q = em.createQuery(consulta);
            
            q.setParameter("nroClase", nroClase);
            q.setParameter("idMarca", idMarca);
            q.setParameter("idCliente", idCliente);
           
             
            Integer cant = ((Long) q.getSingleResult()).intValue();
           
            if(cant>0){
                return  true;
            }else{
                return false;
            }
            
        } catch(Exception e){
            
            return false;
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna true si el expediente esta vacio, caso contrario false
     * @param idExp
     * @return Boolean
     */
    public Boolean expedienteVacio(Integer idExp) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select d.idExpediente.idExpediente from Documento d where d.idExpediente.idExpediente = :idExp "+
                                "union "+
                                "select e.idExpediente.idExpediente from Evento e where e.idExpediente.idExpediente = :idExp "+
                                "union "+
                                "select r.idExpediente.idExpediente from OposicionRecibida r where r.idExpediente.idExpediente = :idExp ";
                
            Query q = em.createQuery(consulta);
            
            q.setParameter("idExp", idExp);
           
             
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
        
    /**
     * Retorna true si el expediente tiene asociada oposiciones hechas por el estudio juridico
     * @param idExp
     * @return Boolean
     */
    public Boolean expedienteConOposicionesHechas(Integer idExp) {
       
       EntityManager em = getEntityManager();
       
        try {
            String consulta =   "select o.idExpedienteOpositante.idExpediente from OposicionHecha o where o.idExpedienteOpositante.idExpediente = :idExp ";
                
            Query q = em.createQuery(consulta);
            
            q.setParameter("idExp", idExp);
           
             
            List<Integer> lista = q.getResultList();
           
            if(lista.size() > 0){
                return  true;
            }else{
                return false;
            }
            
        } catch(Exception e){
            System.out.println(e);
            return true;
            
        }finally {
            em.close();
        }
    }
    
    /**
     * Retorna la lista de expedientes de un cliente
     * @param idCliente
     * @return 
     */
    public List<Expediente> getListaExpedienteCliente(Integer idCliente) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from Expediente e where e.idCliente.idCliente = :idCliente";
            Query q = em.createQuery(consulta); 
            q.setParameter("idCliente", idCliente);
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
    
     /**
     * Retorna la lista de expedientes de un abogado
     * @param idAbogado
     * @return 
     */
    public List<Expediente> getListaExpedienteAbogado(Integer idAbogado) {
        EntityManager em = getEntityManager();
        
        try {
           
            String consulta = "select e from Expediente e where e.idAbogado.idAbogado = :idAbogado";
            Query q = em.createQuery(consulta); 
            q.setParameter("idAbogado", idAbogado);
            return q.getResultList();
            
        }finally {
            em.close();
        }
    }
}
