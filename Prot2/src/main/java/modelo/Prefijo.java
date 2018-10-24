
package modelo;

import java.io.Serializable;
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
 * @author Pathy
 */
@Entity
@Table(name = "prefijo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prefijo.findAll", query = "SELECT p FROM Prefijo p")
    , @NamedQuery(name = "Prefijo.findByPrefijo", query = "SELECT p FROM Prefijo p WHERE p.prefijo = :prefijo")
    , @NamedQuery(name = "Prefijo.findByInicio", query = "SELECT p FROM Prefijo p WHERE p.inicio = :inicio")
    , @NamedQuery(name = "Prefijo.findByFin", query = "SELECT p FROM Prefijo p WHERE p.fin = :fin")
    , @NamedQuery(name = "Prefijo.findByFecha", query = "SELECT p FROM Prefijo p WHERE p.fecha = :fecha")})
public class Prefijo implements Serializable {

    @Basic(optional = false)
    @Column(name = "id")
    private int id;

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "prefijo")
    private String prefijo;
    @Column(name = "inicio")
    private Integer inicio;
    @Column(name = "fin")
    private Integer fin;
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;

    public Prefijo() {
    }

    public Prefijo(String prefijo) {
        this.prefijo = prefijo;
    }

    public String getPrefijo() {
        return prefijo;
    }

    public void setPrefijo(String prefijo) {
        this.prefijo = prefijo;
    }

    public Integer getInicio() {
        return inicio;
    }

    public void setInicio(Integer inicio) {
        this.inicio = inicio;
    }

    public Integer getFin() {
        return fin;
    }

    public void setFin(Integer fin) {
        this.fin = fin;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (prefijo != null ? prefijo.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Prefijo)) {
            return false;
        }
        Prefijo other = (Prefijo) object;
        if ((this.prefijo == null && other.prefijo != null) || (this.prefijo != null && !this.prefijo.equals(other.prefijo))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.Prefijo[ prefijo=" + prefijo + " ]";
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }
    
}
