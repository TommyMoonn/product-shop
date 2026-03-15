package models.services;

import exceptions.ValidationException;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import models.entities.Account;
import models.entities.Cart;
import models.entities.CartItem;
import models.entities.Order;
import models.entities.OrderDetail;
import models.entities.OrderDetailId;
import models.entities.Product;
import utilities.JPAUtil;

public class OrderService {

    private EntityManager em;
    private final ShoppingCartService shoppingCartService = new ShoppingCartService();

    public OrderService() {
        this.em = JPAUtil.getEntityManager();
    }

    public void checkout(String account, String customerName, String phone, String address) {
        em.getTransaction().begin();

        Account user = em.find(Account.class, account);
        Cart cart = em.createQuery("SELECT c FROM Cart c WHERE c.account = :account", Cart.class)
                .setParameter("account", user)
                .getSingleResult();
        List<CartItem> items = em.createQuery("SELECT ci FROM CartItem ci WHERE ci.cart = :cart", CartItem.class)
                .setParameter("cart", cart)
                .getResultList();

        if (items.isEmpty()) {
            throw new ValidationException("Shopping cart is empty");
        }

        Order order = new Order();
        order.setAccount(user);
        order.setCustomerName(customerName);
        order.setCustomerPhone(phone);
        order.setCustomerAddress(address);
        order.setOrderDate(new Date());
        order.setOrderStatus(0);
        int total = shoppingCartService.calculateTotal(items);
        order.setTotalValue(total);

        em.persist(order);
        em.flush();

        for (CartItem item : items) {
            Product p = item.getProduct();

            OrderDetail detail = new OrderDetail();
            OrderDetailId detailId = new OrderDetailId(order.getOrderId(), p.getProductId());

            detail.setOrderDetailsId(detailId);
            detail.setOrder(order);
            detail.setProduct(p);
            detail.setPrice(p.getPrice());
            detail.setQuantity(item.getQuantity());
            detail.setDiscount(p.getDiscount());

            em.persist(detail);
        }

        em.createQuery("DELETE FROM CartItem ci WHERE ci.cart = :cart")
                .setParameter("cart", cart)
                .executeUpdate();

        em.getTransaction().commit();
    }

    public void checkoutSingleProduct(String account, String productId, String customerName, String phone, String address, int quantity) {

        em.getTransaction().begin();

        Account user = em.find(Account.class, account);
        Product p = em.find(Product.class, productId);

        Order order = new Order();
        order.setAccount(user);
        order.setCustomerName(customerName);
        order.setCustomerPhone(phone);
        order.setCustomerAddress(address);
        order.setOrderDate(new Date());
        order.setOrderStatus(0);

        int finalPrice = p.getPrice() * (100 - p.getDiscount()) / 100;
        int total = finalPrice * quantity;

        order.setTotalValue(total);

        em.persist(order);
        em.flush();

        OrderDetail detail = new OrderDetail();
        OrderDetailId id = new OrderDetailId(order.getOrderId(), p.getProductId());

        detail.setOrderDetailsId(id);
        detail.setOrder(order);
        detail.setProduct(p);
        detail.setPrice(p.getPrice());
        detail.setQuantity(quantity);
        detail.setDiscount(p.getDiscount());

        em.persist(detail);

        em.getTransaction().commit();
    }

    public void updateOrderStatus(int orderId, int status) {
        em.getTransaction().begin();

        Order order = em.find(Order.class, orderId);
        order.setOrderStatus(status);

        em.getTransaction().commit();
    }

    public Order getOrder(int orderId) {
        return em.find(Order.class, orderId);
    }

    public List<Order> getOrders(String account) {
        Account user = em.find(Account.class, account);

        return em.createQuery("SELECT o FROM Order o WHERE o.account = :account ORDER BY o.orderDate DESC", Order.class)
                .setParameter("account", user)
                .getResultList();
    }

    public List<Order> getRecentOrders(int limit) {
        return em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class)
                .setMaxResults(limit)
                .getResultList();
    }

    public List<Order> getAllOrders() {
        return em.createQuery("SELECT o FROM Order o ORDER BY o.orderDate DESC", Order.class)
                .getResultList();
    }

    public List<OrderDetail> getOrderDetail(int orderId) {
        Order order = em.find(Order.class, orderId);

        return em.createQuery("SELECT od FROM OrderDetail od WHERE od.order = :order", OrderDetail.class)
                .setParameter("order", order)
                .getResultList();
    }

    public Long getOrderCount() {
        return em.createQuery("SELECT COUNT(o) FROM Order o", Long.class).getSingleResult();
    }

    public Long getOrderCountToday() {
        LocalDate today = LocalDate.now();

        Date start = java.sql.Timestamp.valueOf(today.atStartOfDay());
        Date end = java.sql.Timestamp.valueOf(today.plusDays(1).atStartOfDay());

        return em.createQuery(
                "SELECT COUNT(o) FROM Order o WHERE o.orderDate >= :start AND o.orderDate < :end",
                Long.class)
                .setParameter("start", start)
                .setParameter("end", end)
                .getSingleResult();
    }

    public Long getTotalRevenue() {
        return em.createQuery("SELECT SUM(o.totalValue) FROM Order o", Long.class).getSingleResult();
    }

    public List<Object[]> getTopSellingProducts(int limit) {
        return em.createQuery(
                "SELECT od.product, SUM(od.quantity * od.price) "
                + "FROM OrderDetail od "
                + "GROUP BY od.product "
                + "ORDER BY SUM(od.quantity * od.price) DESC",
                Object[].class
        )
                .setMaxResults(limit)
                .getResultList();
    }

    public List<Order> getOrdersByStatus(Integer status) {
        String s = "SELECT o FROM Order o";

        if (status != null) {
            s += " WHERE o.orderStatus = :status";
        }
        s += " ORDER BY o.orderDate DESC";

        TypedQuery<Order> query = em.createQuery(s, Order.class);

        if (status != null) {
            query.setParameter("status", status);
        }

        return query.getResultList();
    }
}
