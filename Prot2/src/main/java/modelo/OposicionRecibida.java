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
@Table(name = "oposicion_recibida")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "OposicionRecibida.findAll", query = "SELECT o FROM OposicionRecibida o"),
    @NamedQuery(name = "OposicionRecibida.findByIdOposicion", query = "SELECT o FROM OposicionRecibida o WHERE o.idOposicion = :idOposicion"),
    @NamedQuery(name = "OposicionRecibida.findByAgente", query = "SELECT o FROM OposicionRecibida o WHERE o.agente = :agente"),
    @NamedQuery(name = "OposicionRecibida.findByClase", query = "SELECT o FROM OposicionRecibida o WHERE o.clase = :clase"),
    @NamedQuery(name = "OposicionRecibida.findByFechaEstado", query = "SELECT o FROM OposicionRecibida o WHERE o.fechaEstado = :fechaEstado"),
    @NamedQuery(name = "OposicionRecibida.findByMarca", query = "SELECT o FROM OposicionRecibida o WHERE o.marca = :marca"),
    @NamedQuery(name = "OposicionRecibida.findByNroExpediente", query = "SELECT o FROM OposicionRecibida o WHERE o.nroExpediente = :nroExpediente"),
    @NamedQuery(name = "OposicionRecibida.findByTitular", query = "SELECT o FROM OposicionRecibida o WHERE o.titular = :titular")})
public class OposicionRecibida implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_oposicion")
    private Integer idOposicion;
    @Column(name = "agente")
    private String agente;
    @Column(name = "clase")
    private Integer clase;
    @Column(name = "fecha_estado")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaEstado;
    @Column(name = "marca")
    private String marca;
    @Column(name = "nro_expediente")
    private Integer nroExpediente;
    @Column(name = "titular")
    private String titular;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idOposicionRecibida")
    private List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaList;
    @JoinColumn(name = "id_estado", referencedColumnName = "id_estado")
    @ManyToOne
    private EstadoOposicion idEstado;
    @JoinColumn(name = "id_expediente", referencedColumnName = "id_expediente")
    @ManyToOne
    private Expediente idExpediente;

    public OposicionRecibida() {
    }

    public OposicionRecibida(Integer idOposicion) {
        this.idOposicion = idOposicion;
    }

    public Integer getIdOposicion() {
        return idOposicion;
    }

    public void setIdOposicion(Integer idOposicion) {
        this.idOposicion = idOposicion;
    }

    public String getAgente() {
        return agente;
    }

    public void setAgente(String agente) {
        this.agente = agente;
    }

    public Integer getClase() {
        return clase;
    }

    public void setClase(Integer clase) {
        this.clase = clase;
    }

    public Date getFechaEstado() {
        return fechaEstado;
    }

    public void setFechaEstado(Date fechaEstado) {
        this.fechaEstado = fechaEstado;
    }

    public String getMarca() {
        return marca;
    }

    public void setMarca(String marca) {
        this.marca = marca;
    }

    public Integer getNroExpediente() {
        return nroExpediente;
    }

    public void setNroExpediente(Integer nroExpediente) {
        this.nroExpediente = nroExpediente;
    }

    public String getTitular() {
        return titular;
    }

    public void setTitular(String titular) {
        this.titular = titular;
    }

    @XmlTransient
    public List<HistorialEstadoOposicionRecibida> getHistorialEstadoOposicionRecibidaList() {
        return historialEstadoOposicionRecibidaList;
    }

    public void setHistorialEstadoOposicionRecibidaList(List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaList) {
        this.historialEstadoOposicionRecibidaList = historialEstadoOposicionRecibidaList;
    }

    public EstadoOposicion getIdEstado() {
        return idEstado;
    }

    public void setIdEstado(EstadoOposicion idEstado) {
        this.idEstado = idEstado;
    }

    public Expediente getIdExpediente() {
        return idExpediente;
    }

    public void setIdExpediente(Expediente idExpediente) {
        this.idExpediente = idExpediente;
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
        if (!(object instanceof OposicionRecibida)) {
            return false;
        }
        OposicionRecibida other = (OposicionRecibida) object;
        if ((this.idOposicion == null && other.idOposicion != null) || (this.idOposicion != null && !this.idOposicion.equals(other.idOposicion))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.OposicionRecibida[ idOposicion=" + idOposicion + " ]";
    }
    
}
