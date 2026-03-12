package models.entities;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlTransient;

@Entity(name = "Order")
@Table(name = "Orders")
public class Order implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "orderId")
    private Integer orderId;
    @Basic(optional = false)
    @Column(name = "orderDate")
    @Temporal(TemporalType.TIMESTAMP)
    private Date orderDate;
    @Basic(optional = false)
    @Column(name = "orderStatus")
    private int orderStatus;
    @Basic(optional = false)
    @Column(name = "customerName")
    private String customerName;
    @Basic(optional = false)
    @Column(name = "customerPhone")
    private String customerPhone;
    @Basic(optional = false)
    @Column(name = "customerAddress")
    private String customerAddress;
    @Basic(optional = false)
    @Column(name = "totalValue")
    private int totalValue;
    @JoinColumn(name = "account", referencedColumnName = "account")
    @ManyToOne(optional = false)
    private Account account;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "order")
    private Collection<OrderDetail> orderDetailsCollection;

    public Order() {
    }

    public Order(Integer orderId) {
        this.orderId = orderId;
    }

    public Order(Integer orderId, int orderStatus, String customerName, String customerPhone, String customerAddress, int totalValue) {
        this.orderId = orderId;
        this.orderStatus = orderStatus;
        this.customerName = customerName;
        this.customerPhone = customerPhone;
        this.customerAddress = customerAddress;
        this.totalValue = totalValue;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getOrderStatus() {
        return orderStatus;
    }

    public void setOrderStatus(int orderStatus) {
        this.orderStatus = orderStatus;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getCustomerAddress() {
        return customerAddress;
    }

    public void setCustomerAddress(String customerAddress) {
        this.customerAddress = customerAddress;
    }

    public int getTotalValue() {
        return totalValue;
    }

    public void setTotalValue(int totalValue) {
        this.totalValue = totalValue;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    @XmlTransient
    public Collection<OrderDetail> getOrderDetailsCollection() {
        return orderDetailsCollection;
    }

    public void setOrderDetailsCollection(Collection<OrderDetail> orderDetailsCollection) {
        this.orderDetailsCollection = orderDetailsCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderId != null ? orderId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Order)) {
            return false;
        }
        Order other = (Order) object;
        if ((this.orderId == null && other.orderId != null) || (this.orderId != null && !this.orderId.equals(other.orderId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.Orders[ orderId=" + orderId + " ]";
    }

}
