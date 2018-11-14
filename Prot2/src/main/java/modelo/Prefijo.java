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
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

/**
 *
 * @author User
 */
@Entity
@Table(name = "prefijo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prefijo.findAll", query = "SELECT p FROM Prefijo p"),
    @NamedQuery(name = "Prefijo.findById", query = "SELECT p FROM Prefijo p WHERE p.id = :id"),
    @NamedQuery(name = "Prefijo.findByPrefijo", query = "SELECT p FROM Prefijo p WHERE p.prefijo = :prefijo"),
    @NamedQuery(name = "Prefijo.findByFechaValidoHasta", query = "SELECT p FROM Prefijo p WHERE p.fechaValidoHasta = :fechaValidoHasta"),
    @NamedQuery(name = "Prefijo.findByInicio", query = "SELECT p FROM Prefijo p WHERE p.inicio = :inicio"),
    @NamedQuery(name = "Prefijo.findByFin", query = "SELECT p FROM Prefijo p WHERE p.fin = :fin"),
    @NamedQuery(name = "Prefijo.findByRuc", query = "SELECT p FROM Prefijo p WHERE p.ruc = :ruc"),
    @NamedQuery(name = "Prefijo.findByTimbrado", query = "SELECT p FROM Prefijo p WHERE p.timbrado = :timbrado")})
public class Prefijo implements Serializable {

    

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Column(name = "id")
    private Integer id;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 255)
    @Column(name = "prefijo")
    private String prefijo;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fecha_valido_hasta")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fechaValidoHasta;
    @Basic(optional = false)
    @NotNull
    @Column(name = "inicio")
    private int inicio;
    @Basic(optional = false)
    @NotNull
    @Column(name = "fin")
    private int fin;
    @Basic(optional = false)
    @NotNull
    @Column(name = "proximo")
    private int proximo;
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "ruc")
    private String ruc;
    @Basic(optional = false)
    @NotNull
    @Column(name = "timbrado")
    private int timbrado;

    public Prefijo() {
    }

    public Prefijo(Integer id) {
        this.id = id;
    }

    public Prefijo(Integer id, String prefijo, Date fechaValidoHasta, int inicio, int fin, int proximo, String ruc, int timbrado) {
        this.id = id;
        this.prefijo = prefijo;
        this.fechaValidoHasta = fechaValidoHasta;
        this.inicio = inicio;
        this.fin = fin;
        this.proximo = proximo;
        this.ruc = ruc;
        this.timbrado = timbrado;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getPrefijo() {
        return prefijo;
    }

    public void setPrefijo(String prefijo) {
        this.prefijo = prefijo;
    }

    public Date getFechaValidoHasta() {
        return fechaValidoHasta;
    }

    public void setFechaValidoHasta(Date fechaValidoHasta) {
        this.fechaValidoHasta = fechaValidoHasta;
    }

    public int getInicio() {
        return inicio;
    }

    public void setInicio(int inicio) {
        this.inicio = inicio;
    }

    public int getFin() {
        return fin;
    }

    public void setFin(int fin) {
        this.fin = fin;
    }

    

    public String getRuc() {
        return ruc;
    }

    public void setRuc(String ruc) {
        this.ruc = ruc;
    }

    public int getTimbrado() {
        return timbrado;
    }

    public void setTimbrado(int timbrado) {
        this.timbrado = timbrado;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prefijo)) {
            return false;
        }
        Prefijo other = (Prefijo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Prefijo[ id=" + id + " ]";
    }
    
    public String getStringFecha(){
        String fecha = new SimpleDateFormat("dd/MM/yyyy").format(fechaValidoHasta);
        return fecha; 
    }

    public int getProximo() {
        return proximo;
    }

    public void setProximo(int proximo) {
        this.proximo = proximo;
    }
}
