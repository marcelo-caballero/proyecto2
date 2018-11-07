/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.text.SimpleDateFormat;
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
@Table(name = "historial_estado_oposicion_hecha")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "HistorialEstadoOposicionHecha.findAll", query = "SELECT h FROM HistorialEstadoOposicionHecha h"),
    @NamedQuery(name = "HistorialEstadoOposicionHecha.findByIdHistorial", query = "SELECT h FROM HistorialEstadoOposicionHecha h WHERE h.idHistorial = :idHistorial"),
    @NamedQuery(name = "HistorialEstadoOposicionHecha.findByFecha", query = "SELECT h FROM HistorialEstadoOposicionHecha h WHERE h.fecha = :fecha"),
    @NamedQuery(name = "HistorialEstadoOposicionHecha.findByFechaRegistro", query = "SELECT h FROM HistorialEstadoOposicionHecha h WHERE h.fechaRegistro = :fechaRegistro")})
public class HistorialEstadoOposicionHecha implements Serializable {

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
    @Basic(optional = false)
    @Column(name = "fecha_registro")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaRegistro;
    @JoinColumn(name = "id_estado_oposicion", referencedColumnName = "id_estado")
    @ManyToOne(optional = false)
    private EstadoOposicion idEstadoOposicion;
    @JoinColumn(name = "id_oposicion_hecha", referencedColumnName = "id_oposicion")
    @ManyToOne(optional = false)
    private OposicionHecha idOposicionHecha;

    public HistorialEstadoOposicionHecha() {
    }

    public HistorialEstadoOposicionHecha(Integer idHistorial) {
        this.idHistorial = idHistorial;
    }

    public HistorialEstadoOposicionHecha(Integer idHistorial, Date fecha, Date fechaRegistro) {
        this.idHistorial = idHistorial;
        this.fecha = fecha;
        this.fechaRegistro = fechaRegistro;
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

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }

    public EstadoOposicion getIdEstadoOposicion() {
        return idEstadoOposicion;
    }

    public void setIdEstadoOposicion(EstadoOposicion idEstadoOposicion) {
        this.idEstadoOposicion = idEstadoOposicion;
    }

    public OposicionHecha getIdOposicionHecha() {
        return idOposicionHecha;
    }

    public void setIdOposicionHecha(OposicionHecha idOposicionHecha) {
        this.idOposicionHecha = idOposicionHecha;
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
        if (!(object instanceof HistorialEstadoOposicionHecha)) {
            return false;
        }
        HistorialEstadoOposicionHecha other = (HistorialEstadoOposicionHecha) object;
        if ((this.idHistorial == null && other.idHistorial != null) || (this.idHistorial != null && !this.idHistorial.equals(other.idHistorial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.HistorialEstadoOposicionHecha[ idHistorial=" + idHistorial + " ]";
    }
    
     public String getStringFecha(){
        String fecha = new SimpleDateFormat("dd/MM/yyyy").format(this.fecha);
        return fecha;  
    }
}
