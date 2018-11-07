/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.Date;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author User
 */
@Entity
@Table(name = "oposicion_hecha")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OposicionHecha.findAll", query = "SELECT o FROM OposicionHecha o"),
    @NamedQuery(name = "OposicionHecha.findByIdOposicion", query = "SELECT o FROM OposicionHecha o WHERE o.idOposicion = :idOposicion"),
    @NamedQuery(name = "OposicionHecha.findByDenominacionOpositado", query = "SELECT o FROM OposicionHecha o WHERE o.denominacionOpositado = :denominacionOpositado"),
    @NamedQuery(name = "OposicionHecha.findByTitularOpositado", query = "SELECT o FROM OposicionHecha o WHERE o.titularOpositado = :titularOpositado"),
    @NamedQuery(name = "OposicionHecha.findByClaseOpositado", query = "SELECT o FROM OposicionHecha o WHERE o.claseOpositado = :claseOpositado"),
    @NamedQuery(name = "OposicionHecha.findByNroExpedienteOpositado", query = "SELECT o FROM OposicionHecha o WHERE o.nroExpedienteOpositado = :nroExpedienteOpositado"),
    @NamedQuery(name = "OposicionHecha.findByAgenteOpositado", query = "SELECT o FROM OposicionHecha o WHERE o.agenteOpositado = :agenteOpositado"),
    @NamedQuery(name = "OposicionHecha.findByFecha", query = "SELECT o FROM OposicionHecha o WHERE o.fecha = :fecha")})
public class OposicionHecha implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_oposicion")
    private Integer idOposicion;
    @Basic(optional = false)
    @Column(name = "denominacion_opositado")
    private String denominacionOpositado;
    @Basic(optional = false)
    @Column(name = "titular_opositado")
    private String titularOpositado;
    @Basic(optional = false)
    @Column(name = "clase_opositado")
    private int claseOpositado;
    @Basic(optional = false)
    @Column(name = "nro_expediente_opositado")
    private int nroExpedienteOpositado;
    @Basic(optional = false)
    @Column(name = "agente_opositado")
    private String agenteOpositado;
    @Basic(optional = false)
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOposicionHecha")
    private List<EventoOposicionHecha> eventoOposicionHechaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOposicionHecha")
    private List<HistorialEstadoOposicionHecha> historialEstadoOposicionHechaList;
    @JoinColumn(name = "id_abogado_opositante", referencedColumnName = "id_abogado")
    @ManyToOne(optional = false)
    private Abogado idAbogadoOpositante;
    @JoinColumn(name = "id_estado_oposicion", referencedColumnName = "id_estado")
    @ManyToOne(optional = false)
    private EstadoOposicion idEstadoOposicion;
    @JoinColumn(name = "id_expediente_opositante", referencedColumnName = "id_expediente")
    @ManyToOne(optional = false)
    private Expediente idExpedienteOpositante;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOposicionHecha")
    private List<DocumentoOposicionHecha> documentoOposicionHechaList;

    public OposicionHecha() {
    }

    public OposicionHecha(Integer idOposicion) {
        this.idOposicion = idOposicion;
    }

    public OposicionHecha(Integer idOposicion, String denominacionOpositado, String titularOpositado, int claseOpositado, int nroExpedienteOpositado, String agenteOpositado, Date fecha) {
        this.idOposicion = idOposicion;
        this.denominacionOpositado = denominacionOpositado;
        this.titularOpositado = titularOpositado;
        this.claseOpositado = claseOpositado;
        this.nroExpedienteOpositado = nroExpedienteOpositado;
        this.agenteOpositado = agenteOpositado;
        this.fecha = fecha;
    }

    public Integer getIdOposicion() {
        return idOposicion;
    }

    public void setIdOposicion(Integer idOposicion) {
        this.idOposicion = idOposicion;
    }

    public String getDenominacionOpositado() {
        return denominacionOpositado;
    }

    public void setDenominacionOpositado(String denominacionOpositado) {
        this.denominacionOpositado = denominacionOpositado;
    }

    public String getTitularOpositado() {
        return titularOpositado;
    }

    public void setTitularOpositado(String titularOpositado) {
        this.titularOpositado = titularOpositado;
    }

    public int getClaseOpositado() {
        return claseOpositado;
    }

    public void setClaseOpositado(int claseOpositado) {
        this.claseOpositado = claseOpositado;
    }

    public int getNroExpedienteOpositado() {
        return nroExpedienteOpositado;
    }

    public void setNroExpedienteOpositado(int nroExpedienteOpositado) {
        this.nroExpedienteOpositado = nroExpedienteOpositado;
    }

    public String getAgenteOpositado() {
        return agenteOpositado;
    }

    public void setAgenteOpositado(String agenteOpositado) {
        this.agenteOpositado = agenteOpositado;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @XmlTransient
    public List<EventoOposicionHecha> getEventoOposicionHechaList() {
        return eventoOposicionHechaList;
    }

    public void setEventoOposicionHechaList(List<EventoOposicionHecha> eventoOposicionHechaList) {
        this.eventoOposicionHechaList = eventoOposicionHechaList;
    }

    @XmlTransient
    public List<HistorialEstadoOposicionHecha> getHistorialEstadoOposicionHechaList() {
        return historialEstadoOposicionHechaList;
    }

    public void setHistorialEstadoOposicionHechaList(List<HistorialEstadoOposicionHecha> historialEstadoOposicionHechaList) {
        this.historialEstadoOposicionHechaList = historialEstadoOposicionHechaList;
    }

    public Abogado getIdAbogadoOpositante() {
        return idAbogadoOpositante;
    }

    public void setIdAbogadoOpositante(Abogado idAbogadoOpositante) {
        this.idAbogadoOpositante = idAbogadoOpositante;
    }

    public EstadoOposicion getIdEstadoOposicion() {
        return idEstadoOposicion;
    }

    public void setIdEstadoOposicion(EstadoOposicion idEstadoOposicion) {
        this.idEstadoOposicion = idEstadoOposicion;
    }

    public Expediente getIdExpedienteOpositante() {
        return idExpedienteOpositante;
    }

    public void setIdExpedienteOpositante(Expediente idExpedienteOpositante) {
        this.idExpedienteOpositante = idExpedienteOpositante;
    }

    @XmlTransient
    public List<DocumentoOposicionHecha> getDocumentoOposicionHechaList() {
        return documentoOposicionHechaList;
    }

    public void setDocumentoOposicionHechaList(List<DocumentoOposicionHecha> documentoOposicionHechaList) {
        this.documentoOposicionHechaList = documentoOposicionHechaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idOposicion != null ? idOposicion.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OposicionHecha)) {
            return false;
        }
        OposicionHecha other = (OposicionHecha) object;
        if ((this.idOposicion == null && other.idOposicion != null) || (this.idOposicion != null && !this.idOposicion.equals(other.idOposicion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.OposicionHecha[ idOposicion=" + idOposicion + " ]";
    }
    
}
