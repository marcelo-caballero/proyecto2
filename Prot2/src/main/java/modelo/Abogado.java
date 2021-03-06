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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
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
 * @author Acer
 */
@Entity
@Table(name = "abogado")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Abogado.findAll", query = "SELECT a FROM Abogado a"),
    @NamedQuery(name = "Abogado.findByIdAbogado", query = "SELECT a FROM Abogado a WHERE a.idAbogado = :idAbogado"),
    @NamedQuery(name = "Abogado.findByNombre", query = "SELECT a FROM Abogado a WHERE a.nombre = :nombre"),
    @NamedQuery(name = "Abogado.findByApellido", query = "SELECT a FROM Abogado a WHERE a.apellido = :apellido"),
    @NamedQuery(name = "Abogado.findByDireccion", query = "SELECT a FROM Abogado a WHERE a.direccion = :direccion"),
    @NamedQuery(name = "Abogado.findByTelefono", query = "SELECT a FROM Abogado a WHERE a.telefono = :telefono"),
    @NamedQuery(name = "Abogado.findByCi", query = "SELECT a FROM Abogado a WHERE a.ci = :ci"),
    @NamedQuery(name = "Abogado.findByRegistroProfesional", query = "SELECT a FROM Abogado a WHERE a.registroProfesional = :registroProfesional")})
public class Abogado implements Serializable {

    // @Pattern(regexp="[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?", message="Invalid email")//if the field contains email address consider using this annotation to enforce field validation
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "email")
    private String email;

    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "estado")
    private String estado;

    @Basic(optional = false)
    @NotNull
    @Column(name = "ci")
    private long ci;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_abogado")
    private Integer idAbogado;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "nombre")
    private String nombre;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "apellido")
    private String apellido;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "direccion")
    private String direccion;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "telefono")
    private String telefono;
    @Basic(optional = false)
    @Size(min = 1, max = 2147483647)
    @Column(name = "registro_profesional")
    private String registroProfesional;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idAbogado")
    private List<Expediente> expedienteList;
    @JoinColumn(name = "id_usuario", referencedColumnName = "id_usuario")
    @ManyToOne(optional = false)
    private Usuario idUsuario;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idAbogadoOpositante")
    private List<OposicionHecha> oposicionHechaList;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idAbogado")
    private List<Historial> historialList;

    public Abogado() {
    }

    public Abogado(Integer idAbogado) {
        this.idAbogado = idAbogado;
    }

    public Abogado(Integer idAbogado, String nombre, String apellido, String direccion, String telefono, String registroProfesional) {
        this.idAbogado = idAbogado;
        this.nombre = nombre;
        this.apellido = apellido;
        this.direccion = direccion;
        this.telefono = telefono;
        this.registroProfesional = registroProfesional;
    }

    public Integer getIdAbogado() {
        return idAbogado;
    }

    public void setIdAbogado(Integer idAbogado) {
        this.idAbogado = idAbogado;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }


    public String getRegistroProfesional() {
        if(this.registroProfesional == null){
            return "";
        }
        return registroProfesional;
    }

    public void setRegistroProfesional(String registroProfesional) {
        this.registroProfesional = registroProfesional;
    }

    @XmlTransient
    public List<Expediente> getExpedienteList() {
        return expedienteList;
    }

    public void setExpedienteList(List<Expediente> expedienteList) {
        this.expedienteList = expedienteList;
    }

    public Usuario getIdUsuario() {
        return idUsuario;
    }

    public void setIdUsuario(Usuario idUsuario) {
        this.idUsuario = idUsuario;
    }

    @XmlTransient
    public List<OposicionHecha> getOposicionHechaList() {
        return oposicionHechaList;
    }

    public void setOposicionHechaList(List<OposicionHecha> oposicionHechaList) {
        this.oposicionHechaList = oposicionHechaList;
    }
    
    @XmlTransient
    public List<Historial> getHistorialList() {
        return historialList;
    }

    public void setHistorialList(List<Historial> historialList) {
        this.historialList = historialList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idAbogado != null ? idAbogado.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Abogado)) {
            return false;
        }
        Abogado other = (Abogado) object;
        if ((this.idAbogado == null && other.idAbogado != null) || (this.idAbogado != null && !this.idAbogado.equals(other.idAbogado))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Abogado[ idAbogado=" + idAbogado + " ]";
    }
    
    public String getNombreApellido(){
        return this.nombre + " "+ this.apellido;
    }

    public long getCi() {
        return ci;
    }

    public void setCi(long ci) {
        this.ci = ci;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}
