/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author User
 */
@Entity
@Table(name = "estado_oposicion")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "EstadoOposicion.findAll", query = "SELECT e FROM EstadoOposicion e"),
    @NamedQuery(name = "EstadoOposicion.findByIdEstado", query = "SELECT e FROM EstadoOposicion e WHERE e.idEstado = :idEstado"),
    @NamedQuery(name = "EstadoOposicion.findByDescripcion", query = "SELECT e FROM EstadoOposicion e WHERE e.descripcion = :descripcion")})
public class EstadoOposicion implements Serializable {

    @Size(max = 2147483647)
    @Column(name = "tipo")
    private String tipo;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_estado")
    private Integer idEstado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idEstadoOposicion")
    private List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idEstado")
    private List<OposicionRecibida> oposicionRecibidaList;

    public EstadoOposicion() {
    }

    public EstadoOposicion(Integer idEstado) {
        this.idEstado = idEstado;
    }

    public EstadoOposicion(Integer idEstado, String descripcion) {
        this.idEstado = idEstado;
        this.descripcion = descripcion;
    }

    public Integer getIdEstado() {
        return idEstado;
    }

    public void setIdEstado(Integer idEstado) {
        this.idEstado = idEstado;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<HistorialEstadoOposicionRecibida> getHistorialEstadoOposicionRecibidaList() {
        return historialEstadoOposicionRecibidaList;
    }

    public void setHistorialEstadoOposicionRecibidaList(List<HistorialEstadoOposicionRecibida> historialEstadoOposicionRecibidaList) {
        this.historialEstadoOposicionRecibidaList = historialEstadoOposicionRecibidaList;
    }

    @XmlTransient
    public List<OposicionRecibida> getOposicionRecibidaList() {
        return oposicionRecibidaList;
    }

    public void setOposicionRecibidaList(List<OposicionRecibida> oposicionRecibidaList) {
        this.oposicionRecibidaList = oposicionRecibidaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idEstado != null ? idEstado.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EstadoOposicion)) {
            return false;
        }
        EstadoOposicion other = (EstadoOposicion) object;
        if ((this.idEstado == null && other.idEstado != null) || (this.idEstado != null && !this.idEstado.equals(other.idEstado))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.EstadoOposicion[ idEstado=" + idEstado + " ]";
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }
    
}
