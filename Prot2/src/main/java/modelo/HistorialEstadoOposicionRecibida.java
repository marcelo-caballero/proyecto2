/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author User
 */
@Entity
@Table(name = "historial_estado_oposicion_recibida")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "HistorialEstadoOposicionRecibida.findAll", query = "SELECT h FROM HistorialEstadoOposicionRecibida h"),
    @NamedQuery(name = "HistorialEstadoOposicionRecibida.findByIdHistorial", query = "SELECT h FROM HistorialEstadoOposicionRecibida h WHERE h.idHistorial = :idHistorial"),
    @NamedQuery(name = "HistorialEstadoOposicionRecibida.findByFecha", query = "SELECT h FROM HistorialEstadoOposicionRecibida h WHERE h.fecha = :fecha")})
public class HistorialEstadoOposicionRecibida implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_historial")
    private Integer idHistorial;
    @Basic(optional = false)
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @JoinColumn(name = "id_estado_oposicion", referencedColumnName = "id_estado")
    @ManyToOne(optional = false)
    private EstadoOposicion idEstadoOposicion;
    @JoinColumn(name = "id_oposicion_recibida", referencedColumnName = "id_oposicion")
    @ManyToOne(optional = false)
    private OposicionRecibida idOposicionRecibida;

    public HistorialEstadoOposicionRecibida() {
    }

    public HistorialEstadoOposicionRecibida(Integer idHistorial) {
        this.idHistorial = idHistorial;
    }

    public HistorialEstadoOposicionRecibida(Integer idHistorial, Date fecha) {
        this.idHistorial = idHistorial;
        this.fecha = fecha;
    }

    public Integer getIdHistorial() {
        return idHistorial;
    }

    public void setIdHistorial(Integer idHistorial) {
        this.idHistorial = idHistorial;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public EstadoOposicion getIdEstadoOposicion() {
        return idEstadoOposicion;
    }

    public void setIdEstadoOposicion(EstadoOposicion idEstadoOposicion) {
        this.idEstadoOposicion = idEstadoOposicion;
    }

    public OposicionRecibida getIdOposicionRecibida() {
        return idOposicionRecibida;
    }

    public void setIdOposicionRecibida(OposicionRecibida idOposicionRecibida) {
        this.idOposicionRecibida = idOposicionRecibida;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idHistorial != null ? idHistorial.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof HistorialEstadoOposicionRecibida)) {
            return false;
        }
        HistorialEstadoOposicionRecibida other = (HistorialEstadoOposicionRecibida) object;
        if ((this.idHistorial == null && other.idHistorial != null) || (this.idHistorial != null && !this.idHistorial.equals(other.idHistorial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.HistorialEstadoOposicionRecibida[ idHistorial=" + idHistorial + " ]";
    }
    
}
