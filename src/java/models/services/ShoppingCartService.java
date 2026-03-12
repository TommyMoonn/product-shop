package models.services;

import exceptions.ValidationException;
import java.util.List;
import javax.persistence.EntityManager;
import models.entities.Account;
import models.entities.Cart;
import models.entities.CartItem;
import models.entities.CartItemId;
import models.entities.Product;
import utilities.JPAUtil;

public class ShoppingCartService {

    private EntityManager em;

    public ShoppingCartService() {
        this.em = JPAUtil.getEntityManager();
    }

    public Cart getOrCreate(String account) {
        Account user = em.find(Account.class, account);

        Cart cart = em.createQuery("SELECT c FROM Cart c WHERE c.account = :account", Cart.class)
                .setParameter("account", user)
                .getResultStream()
                .findFirst()
                .orElse(null);

        if (cart == null) {
            em.getTransaction().begin();

            cart = new Cart();
            cart.setAccount(user);

            em.persist(cart);

            em.getTransaction().commit();
        }

        return cart;
    }

    public void addItem(String account, String productId, int quantity) {
        if (quantity <= 0) {
            throw new ValidationException("Quantity can not be zero");
        }
        Cart cart = getOrCreate(account);

        em.getTransaction().begin();

        Product p = em.find(Product.class, productId);
        CartItemId cartItemId = new CartItemId(cart.getCartId(), productId);
        CartItem item = em.find(CartItem.class, cartItemId);

        if (item == null) {
            item = new CartItem();
            item.setCartItemId(cartItemId);
            item.setCart(cart);
            item.setProduct(p);
            item.setQuantity(quantity);

            em.persist(item);
        } else {
            item.setQuantity(item.getQuantity() + quantity);
            em.merge(item);
        }

        em.getTransaction().commit();
    }

    public void updateQuantity(String account, String productId, int quantity) {
        Cart cart = getOrCreate(account);
        em.getTransaction().begin();

        CartItem item = em.find(CartItem.class, new CartItemId(cart.getCartId(), productId));

        if (item == null) {
            throw new ValidationException("Item not found");
        }

        if (quantity <= 0) {
            em.remove(item);
        } else {
            item.setQuantity(quantity);
        }

        em.getTransaction().commit();
    }

    public void removeItem(String account, String productId) {
        Cart cart = getOrCreate(account);
        em.getTransaction().begin();

        CartItem item = em.find(CartItem.class, new CartItemId(cart.getCartId(), productId));

        if (item == null) {
            throw new ValidationException("Item not found");
        }

        em.remove(item);

        em.getTransaction().commit();
    }

    public List<CartItem> getItems(String account) {
        Account user = em.find(Account.class, account);

        return em.createQuery("SELECT ci FROM CartItem ci WHERE ci.cart.account = :account", CartItem.class)
                .setParameter("account", user)
                .getResultList();
    }

    public void clearCart(String account) {
        Cart cart = getOrCreate(account);
        em.getTransaction().begin();

        em.createQuery("DELETE FROM CartItem ci WHERE ci.cart = :cart")
                .setParameter("cart", cart)
                .executeUpdate();

        em.getTransaction().commit();
    }

    public int calculateTotal(List<CartItem> items) {
        int total = 0;
        for (CartItem item : items) {
            total += item.getSubTotal();
        }

        return total;
    }
}
