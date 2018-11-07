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
@Table(name = "evento_oposicion_hecha")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "EventoOposicionHecha.findAll", query = "SELECT e FROM EventoOposicionHecha e"),
    @NamedQuery(name = "EventoOposicionHecha.findByIdEvento", query = "SELECT e FROM EventoOposicionHecha e WHERE e.idEvento = :idEvento"),
    @NamedQuery(name = "EventoOposicionHecha.findByNombre", query = "SELECT e FROM EventoOposicionHecha e WHERE e.nombre = :nombre"),
    @NamedQuery(name = "EventoOposicionHecha.findByDescripcion", query = "SELECT e FROM EventoOposicionHecha e WHERE e.descripcion = :descripcion"),
    @NamedQuery(name = "EventoOposicionHecha.findByFecha", query = "SELECT e FROM EventoOposicionHecha e WHERE e.fecha = :fecha"),
    @NamedQuery(name = "EventoOposicionHecha.findByPrioridad", query = "SELECT e FROM EventoOposicionHecha e WHERE e.prioridad = :prioridad")})
public class EventoOposicionHecha implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_evento")
    private Integer idEvento;
    @Basic(optional = false)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @Column(name = "descripcion")
    private String descripcion;
    @Basic(optional = false)
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @Basic(optional = false)
    @Column(name = "prioridad")
    private String prioridad;
    @JoinColumn(name = "id_oposicion_hecha", referencedColumnName = "id_oposicion")
    @ManyToOne(optional = false)
    private OposicionHecha idOposicionHecha;

    public EventoOposicionHecha() {
    }

    public EventoOposicionHecha(Integer idEvento) {
        this.idEvento = idEvento;
    }

    public EventoOposicionHecha(Integer idEvento, String nombre, String descripcion, Date fecha, String prioridad) {
        this.idEvento = idEvento;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.prioridad = prioridad;
    }

    public Integer getIdEvento() {
        return idEvento;
    }

    public void setIdEvento(Integer idEvento) {
        this.idEvento = idEvento;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getPrioridad() {
        return prioridad;
    }

    public void setPrioridad(String prioridad) {
        this.prioridad = prioridad;
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
        hash += (idEvento != null ? idEvento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof EventoOposicionHecha)) {
            return false;
        }
        EventoOposicionHecha other = (EventoOposicionHecha) object;
        if ((this.idEvento == null && other.idEvento != null) || (this.idEvento != null && !this.idEvento.equals(other.idEvento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.EventoOposicionHecha[ idEvento=" + idEvento + " ]";
    }
    
    public String getStringFecha(){
        String fecha = new SimpleDateFormat("dd-MM-yyyy").format(this.fecha);
        return fecha;  
    }
    
    public String getStringHora(){
        String hora = new SimpleDateFormat("HH").format(this.fecha);
        return hora;  
    }
    
    public String getStringMinuto(){
        String minuto = new SimpleDateFormat("mm").format(this.fecha);
        return minuto;  
    }
}
