package models.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class OrderDetailId implements Serializable {

    @Basic(optional = false)
    @Column(name = "orderId")
    private Integer orderId;
    @Basic(optional = false)
    @Column(name = "productId")
    private String productId;

    public OrderDetailId() {
    }

    public OrderDetailId(Integer orderId, String productId) {
        this.orderId = orderId;
        this.productId = productId;
    }

    public Integer getOrderId() {
        return orderId;
    }

    public void setOrderId(Integer orderId) {
        this.orderId = orderId;
    }

    public String getProductId() {
        return productId;
    }

    public void setProductId(String productId) {
        this.productId = productId;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderId != null ? orderId.hashCode() : 0);
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderDetailId)) {
            return false;
        }
        OrderDetailId other = (OrderDetailId) object;
        if ((this.orderId == null && other.orderId != null) || (this.orderId != null && !this.orderId.equals(other.orderId))) {
            return false;
        }
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.OrderDetailsId[ orderId=" + orderId + ", productId=" + productId + " ]";
    }

}
