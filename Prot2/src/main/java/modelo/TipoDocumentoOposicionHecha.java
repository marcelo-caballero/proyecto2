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
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author User
 */
@Entity
@Table(name = "tipo_documento_oposicion_hecha")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "TipoDocumentoOposicionHecha.findAll", query = "SELECT t FROM TipoDocumentoOposicionHecha t"),
    @NamedQuery(name = "TipoDocumentoOposicionHecha.findByIdTipoDocumento", query = "SELECT t FROM TipoDocumentoOposicionHecha t WHERE t.idTipoDocumento = :idTipoDocumento"),
    @NamedQuery(name = "TipoDocumentoOposicionHecha.findByDescripcion", query = "SELECT t FROM TipoDocumentoOposicionHecha t WHERE t.descripcion = :descripcion")})
public class TipoDocumentoOposicionHecha implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_tipo_documento")
    private Integer idTipoDocumento;
    @Basic(optional = false)
    @Column(name = "descripcion")
    private String descripcion;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idTipoDocumentoOposicionHecha")
    private List<DocumentoOposicionHecha> documentoOposicionHechaList;

    public TipoDocumentoOposicionHecha() {
    }

    public TipoDocumentoOposicionHecha(Integer idTipoDocumento) {
        this.idTipoDocumento = idTipoDocumento;
    }

    public TipoDocumentoOposicionHecha(Integer idTipoDocumento, String descripcion) {
        this.idTipoDocumento = idTipoDocumento;
        this.descripcion = descripcion;
    }

    public Integer getIdTipoDocumento() {
        return idTipoDocumento;
    }

    public void setIdTipoDocumento(Integer idTipoDocumento) {
        this.idTipoDocumento = idTipoDocumento;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    @XmlTransient
    public List<DocumentoOposicionHecha> getDocumentoOposicionHechaList() {
        return documentoOposicionHechaList;
    }

    public void setDocumentoOposicionHechaList(List<DocumentoOposicionHecha> documentoOposicionHechaList) {
        this.documentoOposicionHechaList = documentoOposicionHechaList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idTipoDocumento != null ? idTipoDocumento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof TipoDocumentoOposicionHecha)) {
            return false;
        }
        TipoDocumentoOposicionHecha other = (TipoDocumentoOposicionHecha) object;
        if ((this.idTipoDocumento == null && other.idTipoDocumento != null) || (this.idTipoDocumento != null && !this.idTipoDocumento.equals(other.idTipoDocumento))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.TipoDocumentoOposicionHecha[ idTipoDocumento=" + idTipoDocumento + " ]";
    }
    
}
