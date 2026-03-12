package models.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Embeddable;

@Embeddable
public class CartItemId implements Serializable {

    @Basic(optional = false)
    @Column(name = "cartId")
    private int cartId;
    @Basic(optional = false)
    @Column(name = "productId")
    private String productId;

    public CartItemId() {
    }

    public CartItemId(int cartId, String productId) {
        this.cartId = cartId;
        this.productId = productId;
    }

    public int getCartId() {
        return cartId;
    }

    public void setCartId(int cartId) {
        this.cartId = cartId;
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
        hash += (int) cartId;
        hash += (productId != null ? productId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CartItemId)) {
            return false;
        }
        CartItemId other = (CartItemId) object;
        if (this.cartId != other.cartId) {
            return false;
        }
        if ((this.productId == null && other.productId != null) || (this.productId != null && !this.productId.equals(other.productId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.CartItemsId[ cartId=" + cartId + ", productId=" + productId + " ]";
    }

}
