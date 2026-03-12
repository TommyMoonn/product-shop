package models.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "OrderDetail")
@Table(name = "OrderDetails")
public class OrderDetail implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected OrderDetailId orderDetailsId;
    @Basic(optional = false)
    @Column(name = "price")
    private int price;
    @Basic(optional = false)
    @Column(name = "quantity")
    private int quantity;
    @Basic(optional = false)
    @Column(name = "discount")
    private int discount;
    @JoinColumn(name = "orderId", referencedColumnName = "orderId", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Order order;
    @JoinColumn(name = "productId", referencedColumnName = "productId", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Product product;

    public OrderDetail() {
    }

    public OrderDetail(OrderDetailId orderDetailsId) {
        this.orderDetailsId = orderDetailsId;
    }

    public OrderDetail(OrderDetailId orderDetailsId, int price, int quantity, int discount) {
        this.orderDetailsId = orderDetailsId;
        this.price = price;
        this.quantity = quantity;
        this.discount = discount;
    }

    public OrderDetail(Integer orderId, String productId) {
        this.orderDetailsId = new OrderDetailId(orderId, productId);
    }

    public OrderDetailId getOrderDetailsId() {
        return orderDetailsId;
    }

    public void setOrderDetailsId(OrderDetailId orderDetailsId) {
        this.orderDetailsId = orderDetailsId;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public int getDiscount() {
        return discount;
    }

    public void setDiscount(int discount) {
        this.discount = discount;
    }

    public Order getOrder() {
        return order;
    }

    public void setOrder(Order order) {
        this.order = order;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (orderDetailsId != null ? orderDetailsId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof OrderDetail)) {
            return false;
        }
        OrderDetail other = (OrderDetail) object;
        if ((this.orderDetailsId == null && other.orderDetailsId != null) || (this.orderDetailsId != null && !this.orderDetailsId.equals(other.orderDetailsId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.OrderDetails[ orderDetailsId=" + orderDetailsId + " ]";
    }

}
