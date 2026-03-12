package models.entities;

import java.io.Serializable;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.EmbeddedId;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity(name = "CartItem")
@Table(name = "CartItem")
public class CartItem implements Serializable {

    private static final long serialVersionUID = 1L;
    @EmbeddedId
    protected CartItemId cartItemId;
    @Basic(optional = false)
    @Column(name = "quantity")
    private int quantity;
    @JoinColumn(name = "cartId", referencedColumnName = "cartId", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Cart cart;
    @JoinColumn(name = "productId", referencedColumnName = "productId", insertable = false, updatable = false)
    @ManyToOne(optional = false)
    private Product product;

    public CartItem() {
    }

    public CartItem(CartItemId cartItemId) {
        this.cartItemId = cartItemId;
    }

    public CartItem(CartItemId cartItemId, int quantity) {
        this.cartItemId = cartItemId;
        this.quantity = quantity;
    }

    public CartItem(int cartId, String productId) {
        this.cartItemId = new CartItemId(cartId, productId);
    }

    public CartItemId getCartItemId() {
        return cartItemId;
    }

    public void setCartItemId(CartItemId cartItemId) {
        this.cartItemId = cartItemId;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
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
        hash += (cartItemId != null ? cartItemId.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof CartItem)) {
            return false;
        }
        CartItem other = (CartItem) object;
        if ((this.cartItemId == null && other.cartItemId != null) || (this.cartItemId != null && !this.cartItemId.equals(other.cartItemId))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "models.entities.CartItem[ cartItemId=" + cartItemId + " ]";
    }

}
