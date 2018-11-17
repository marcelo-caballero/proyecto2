/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package modelo;

import java.io.Serializable;
import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author User
 */
@Entity
@Table(name = "factura_cabecera")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "FacturaCabecera.findAll", query = "SELECT f FROM FacturaCabecera f"),
    @NamedQuery(name = "FacturaCabecera.findByIdFactura", query = "SELECT f FROM FacturaCabecera f WHERE f.idFactura = :idFactura"),
    @NamedQuery(name = "FacturaCabecera.findByFecha", query = "SELECT f FROM FacturaCabecera f WHERE f.fecha = :fecha"),
    @NamedQuery(name = "FacturaCabecera.findByCondicionVenta", query = "SELECT f FROM FacturaCabecera f WHERE f.condicionVenta = :condicionVenta"),
    @NamedQuery(name = "FacturaCabecera.findByFormaPago", query = "SELECT f FROM FacturaCabecera f WHERE f.formaPago = :formaPago"),
    @NamedQuery(name = "FacturaCabecera.findByBanco", query = "SELECT f FROM FacturaCabecera f WHERE f.banco = :banco"),
    @NamedQuery(name = "FacturaCabecera.findByNumeroCheque", query = "SELECT f FROM FacturaCabecera f WHERE f.numeroCheque = :numeroCheque"),
    @NamedQuery(name = "FacturaCabecera.findByNumeroCuenta", query = "SELECT f FROM FacturaCabecera f WHERE f.numeroCuenta = :numeroCuenta"),
    @NamedQuery(name = "FacturaCabecera.findByEstado", query = "SELECT f FROM FacturaCabecera f WHERE f.estado = :estado"),
    @NamedQuery(name = "FacturaCabecera.findByNumeroFactura", query = "SELECT f FROM FacturaCabecera f WHERE f.numeroFactura = :numeroFactura")})
public class FacturaCabecera implements Serializable {

  
    @Column(name = "numero_transaccion_transferencia_bancaria")
    private BigInteger numeroTransaccionTransferenciaBancaria;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id_factura")
    private Integer idFactura;
    @Basic(optional = false)
    @Column(name = "fecha")
    @Temporal(TemporalType.TIMESTAMP)
    private Date fecha;
    @Basic(optional = false)
    @Column(name = "condicion_venta")
    private String condicionVenta;
    @Basic(optional = false)
    @Column(name = "forma_pago")
    private String formaPago;
    @Basic(optional = false)
    @Column(name = "banco")
    private String banco;
    @Column(name = "numero_cheque")
    private String numeroCheque;
    @Column(name = "numero_cuenta")
    private String numeroCuenta;
    @Basic(optional = false)
    @Column(name = "estado")
    private String estado;
    @Basic(optional = false)
    @Column(name = "numero_factura")
    private BigInteger numeroFactura;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "idFactura")
    private List<FacturaDetalle> facturaDetalleList;
    @JoinColumn(name = "id_cliente", referencedColumnName = "id_cliente")
    @ManyToOne(optional = false)
    private Cliente idCliente;

    public FacturaCabecera() {
    }

    public FacturaCabecera(Integer idFactura) {
        this.idFactura = idFactura;
    }

    public FacturaCabecera(Integer idFactura, Date fecha, String condicionVenta, String formaPago, String banco, String estado, BigInteger numeroFactura) {
        this.idFactura = idFactura;
        this.fecha = fecha;
        this.condicionVenta = condicionVenta;
        this.formaPago = formaPago;
        this.banco = banco;
        this.estado = estado;
        this.numeroFactura = numeroFactura;
    }

    public Integer getIdFactura() {
        return idFactura;
    }

    public void setIdFactura(Integer idFactura) {
        this.idFactura = idFactura;
    }

    public Date getFecha() {
        return fecha;
    }

    public void setFecha(Date fecha) {
        this.fecha = fecha;
    }

    public String getCondicionVenta() {
        return condicionVenta;
    }

    public void setCondicionVenta(String condicionVenta) {
        this.condicionVenta = condicionVenta;
    }

    public String getFormaPago() {
        return formaPago;
    }

    public void setFormaPago(String formaPago) {
        this.formaPago = formaPago;
    }

    public String getBanco() {
        return banco;
    }

    public void setBanco(String banco) {
        this.banco = banco;
    }

    public String getNumeroCheque() {
        return numeroCheque;
    }

    public void setNumeroCheque(String numeroCheque) {
        this.numeroCheque = numeroCheque;
    }

    public String getNumeroCuenta() {
        return numeroCuenta;
    }

    public void setNumeroCuenta(String numeroCuenta) {
        this.numeroCuenta = numeroCuenta;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }

    public BigInteger getNumeroFactura() {
        return numeroFactura;
    }

    public void setNumeroFactura(BigInteger numeroFactura) {
        this.numeroFactura = numeroFactura;
    }

    @XmlTransient
    public List<FacturaDetalle> getFacturaDetalleList() {
        return facturaDetalleList;
    }

    public void setFacturaDetalleList(List<FacturaDetalle> facturaDetalleList) {
        this.facturaDetalleList = facturaDetalleList;
    }

    public Cliente getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(Cliente idCliente) {
        this.idCliente = idCliente;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (idFactura != null ? idFactura.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof FacturaCabecera)) {
            return false;
        }
        FacturaCabecera other = (FacturaCabecera) object;
        if ((this.idFactura == null && other.idFactura != null) || (this.idFactura != null && !this.idFactura.equals(other.idFactura))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "modelo.FacturaCabecera[ idFactura=" + idFactura + " ]";
    }
    
     public String getStringFecha(){
        String fecha = new SimpleDateFormat("dd/MM/yyyy").format(this.fecha);
        return fecha;  
    }
     
    public String getNumeroFormaPago(){
        if(numeroCheque != null) return numeroCheque;
        return numeroCuenta;
    }

    public BigInteger getNumeroTransaccionTransferenciaBancaria() {
        return numeroTransaccionTransferenciaBancaria;
    }

    public void setNumeroTransaccionTransferenciaBancaria(BigInteger numeroTransaccionTransferenciaBancaria) {
        this.numeroTransaccionTransferenciaBancaria = numeroTransaccionTransferenciaBancaria;
    }
}
