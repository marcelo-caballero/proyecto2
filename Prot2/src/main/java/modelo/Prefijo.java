
package modelo;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;

@Entity
@Table(name = "prefijo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Prefijo.findAll", query = "SELECT p FROM Prefijo p")
    , @NamedQuery(name = "Prefijo.findById", query = "SELECT p FROM Prefijo p WHERE p.id = :id")
    , @NamedQuery(name = "Prefijo.findByPrefijo", query = "SELECT p FROM Prefijo p WHERE p.prefijo = :prefijo")
    , @NamedQuery(name = "Prefijo.findByInicio", query = "SELECT p FROM Prefijo p WHERE p.inicio = :inicio")
    , @NamedQuery(name = "Prefijo.findByFin", query = "SELECT p FROM Prefijo p WHERE p.fin = :fin")
    , @NamedQuery(name = "Prefijo.findByActual", query = "SELECT p FROM Prefijo p WHERE p.actual = :actual")})
public class Prefijo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Basic(optional = false)
    @Column(name = "id")
    private int id;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 2147483647)
    @Column(name = "prefijo")
    private String prefijo;
    @Size(max = 2147483647)
    @Column(name = "inicio")
    private String inicio;
    @Size(max = 2147483647)
    @Column(name = "fin")
    private String fin;
    @Size(max = 2147483647)
    @Column(name = "actual")
    private String actual;

    public Prefijo() {
    }

    public Prefijo(String prefijo) {
        this.prefijo = prefijo;
    }

    public Prefijo(String prefijo, int id) {
        this.prefijo = prefijo;
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getPrefijo() {
        return prefijo;
    }

    public void setPrefijo(String prefijo) {
        this.prefijo = prefijo;
    }

    public String getInicio() {
        return inicio;
    }

    public void setInicio(String inicio) {
        this.inicio = inicio;
    }

    public String getFin() {
        return fin;
    }

    public void setFin(String fin) {
        this.fin = fin;
    }

    public String getActual() {
        return actual;
    }

    public void setActual(String actual) {
        this.actual = actual;
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
    
}
