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
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author User
 */
@Entity
@Table(name = "historial_estado_marca")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "HistorialEstadoMarca.findAll", query = "SELECT h FROM HistorialEstadoMarca h"),
    @NamedQuery(name = "HistorialEstadoMarca.findByIdHistorial", query = "SELECT h FROM HistorialEstadoMarca h WHERE h.idHistorial = :idHistorial"),
    @NamedQuery(name = "HistorialEstadoMarca.findByFecha", query = "SELECT h FROM HistorialEstadoMarca h WHERE h.fecha = :fecha")})
public class HistorialEstadoMarca implements Serializable {

    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_registro")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaRegistro;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_historial")
    private Integer idHistorial;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @JoinColumn(name = "id_estado_marca", referencedColumnName = "id_estado")
    @ManyToOne(optional = false)
    private EstadoMarca idEstadoMarca;
    @JoinColumn(name = "id_expediente", referencedColumnName = "id_expediente")
    @ManyToOne(optional = false)
    private Expediente idExpediente;

    public HistorialEstadoMarca() {
    }

    public HistorialEstadoMarca(Integer idHistorial) {
        this.idHistorial = idHistorial;
    }

    public HistorialEstadoMarca(Integer idHistorial, Date fecha) {
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

    public EstadoMarca getIdEstadoMarca() {
        return idEstadoMarca;
    }

    public void setIdEstadoMarca(EstadoMarca idEstadoMarca) {
        this.idEstadoMarca = idEstadoMarca;
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
        hash += (idHistorial != null ? idHistorial.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof HistorialEstadoMarca)) {
            return false;
        }
        HistorialEstadoMarca other = (HistorialEstadoMarca) object;
        if ((this.idHistorial == null && other.idHistorial != null) || (this.idHistorial != null && !this.idHistorial.equals(other.idHistorial))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.HistorialEstadoMarca[ idHistorial=" + idHistorial + " ]";
    }
    
    public String getStringFecha(){
        String fecha = new SimpleDateFormat("dd/MM/yyyy").format(this.fecha);
        return fecha;  
    }

    public Date getFechaRegistro() {
        return fechaRegistro;
    }

    public void setFechaRegistro(Date fechaRegistro) {
        this.fechaRegistro = fechaRegistro;
    }
}
