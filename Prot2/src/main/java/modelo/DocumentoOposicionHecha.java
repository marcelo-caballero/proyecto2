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
import javax.persistence.Lob;
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
@Table(name = "documento_oposicion_hecha")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "DocumentoOposicionHecha.findAll", query = "SELECT d FROM DocumentoOposicionHecha d"),
    @NamedQuery(name = "DocumentoOposicionHecha.findByIdDocumento", query = "SELECT d FROM DocumentoOposicionHecha d WHERE d.idDocumento = :idDocumento"),
    @NamedQuery(name = "DocumentoOposicionHecha.findByNombre", query = "SELECT d FROM DocumentoOposicionHecha d WHERE d.nombre = :nombre"),
    @NamedQuery(name = "DocumentoOposicionHecha.findByDescripcion", query = "SELECT d FROM DocumentoOposicionHecha d WHERE d.descripcion = :descripcion"),
    @NamedQuery(name = "DocumentoOposicionHecha.findByFecha", query = "SELECT d FROM DocumentoOposicionHecha d WHERE d.fecha = :fecha"),
    @NamedQuery(name = "DocumentoOposicionHecha.findByFolioDesde", query = "SELECT d FROM DocumentoOposicionHecha d WHERE d.folioDesde = :folioDesde"),
    @NamedQuery(name = "DocumentoOposicionHecha.findByFolioHasta", query = "SELECT d FROM DocumentoOposicionHecha d WHERE d.folioHasta = :folioHasta")})
public class DocumentoOposicionHecha implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_documento")
    private Integer idDocumento;
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
    @Column(name = "folio_desde")
    private int folioDesde;
    @Basic(optional = false)
    @Column(name = "folio_hasta")
    private int folioHasta;
    @Basic(optional = false)
    @Lob
    @Column(name = "documento")
    private byte[] documento;
    @JoinColumn(name = "id_oposicion_hecha", referencedColumnName = "id_oposicion")
    @ManyToOne(optional = false)
    private OposicionHecha idOposicionHecha;
    @JoinColumn(name = "id_tipo_documento_oposicion_hecha", referencedColumnName = "id_tipo_documento")
    @ManyToOne(optional = false)
    private TipoDocumentoOposicionHecha idTipoDocumentoOposicionHecha;

    public DocumentoOposicionHecha() {
    }

    public DocumentoOposicionHecha(Integer idDocumento) {
        this.idDocumento = idDocumento;
    }

    public DocumentoOposicionHecha(Integer idDocumento, String nombre, String descripcion, Date fecha, int folioDesde, int folioHasta, byte[] documento) {
        this.idDocumento = idDocumento;
        this.nombre = nombre;
        this.descripcion = descripcion;
        this.fecha = fecha;
        this.folioDesde = folioDesde;
        this.folioHasta = folioHasta;
        this.documento = documento;
    }

    public Integer getIdDocumento() {
        return idDocumento;
    }

    public void setIdDocumento(Integer idDocumento) {
        this.idDocumento = idDocumento;
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

    public int getFolioDesde() {
        return folioDesde;
    }

    public void setFolioDesde(int folioDesde) {
        this.folioDesde = folioDesde;
    }

    public int getFolioHasta() {
        return folioHasta;
    }

    public void setFolioHasta(int folioHasta) {
        this.folioHasta = folioHasta;
    }

    public byte[] getDocumento() {
        return documento;
    }

    public void setDocumento(byte[] documento) {
        this.documento = documento;
    }

    public OposicionHecha getIdOposicionHecha() {
        return idOposicionHecha;
    }

    public void setIdOposicionHecha(OposicionHecha idOposicionHecha) {
        this.idOposicionHecha = idOposicionHecha;
    }

    public TipoDocumentoOposicionHecha getIdTipoDocumentoOposicionHecha() {
        return idTipoDocumentoOposicionHecha;
    }

    public void setIdTipoDocumentoOposicionHecha(TipoDocumentoOposicionHecha idTipoDocumentoOposicionHecha) {
        this.idTipoDocumentoOposicionHecha = idTipoDocumentoOposicionHecha;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idDocumento != null ? idDocumento.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof DocumentoOposicionHecha)) {
            return false;
        }
        DocumentoOposicionHecha other = (DocumentoOposicionHecha) object;
        if ((this.idDocumento == null && other.idDocumento != null) || (this.idDocumento != null && !this.idDocumento.equals(other.idDocumento))) {
            return false;
        }
        return true;
    }

     public String getStringFecha(){
        String fecha = new SimpleDateFormat("dd/MM/yyyy").format(this.fecha);
        return fecha;  
    }
     
    @Override
    public String toString() {
        return "modelo.DocumentoOposicionHecha[ idDocumento=" + idDocumento + " ]";
    }
    
   
}
