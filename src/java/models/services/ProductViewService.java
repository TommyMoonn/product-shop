package models.services;

import exceptions.ValidationException;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import models.entities.Account;
import models.entities.Product;
import models.entities.ProductView;
import utilities.JPAUtil;

public class ProductViewService {

    private EntityManager em;

    public ProductViewService() {
        this.em = JPAUtil.getEntityManager();
    }

    public void recordView(Account account, String productId) {
        ProductView view = new ProductView();
        view.setViewDate(new Date());

        em.getTransaction().begin();

        Account user = em.find(Account.class, account.getAccount());
        Product product = em.find(Product.class, productId);
        view.setAccount(user);
        view.setProduct(product);

        em.persist(view);
        em.getTransaction().commit();
    }

    public ProductView findById(int id) {
        return em.find(ProductView.class, id);
    }

    public List<ProductView> findViewedProducts(Account account) {
        return em.createQuery(
                "SELECT pv FROM ProductView pv WHERE pv.account = :account ORDER BY pv.viewDate DESC",
                ProductView.class)
                .setParameter("account", account)
                .setMaxResults(20)
                .getResultList();
    }

    public void removeView(int id) {
        ProductView view = findById(id);
        
        if (view == null) {
            throw new ValidationException("Product view does not exist");
        }

        em.getTransaction().begin();
        em.remove(view);
        em.getTransaction().commit();
    }

    public void clearHistory(Account account) {
        em.getTransaction().begin();
        em.createQuery("DELETE FROM ProductView pv WHERE pv.account = :account")
                .setParameter("account", account)
                .executeUpdate();
        em.getTransaction().commit();
    }

    public List<ProductView> filter(Account account, Integer typeId, Integer minPrice, Integer maxPrice, Boolean discounted, String sort) {
        String s = "SELECT pv FROM ProductView pv WHERE 1=1";

        if (account != null) {
            s += " AND pv.account = :account";
        }
        
        if (typeId != null) {
            s += " AND pv.product.type.typeId = :typeId";
        }

        if (minPrice != null) {
            s += " AND pv.product.price > :minPrice";
        }

        if (maxPrice != null) {
            s += " AND pv.product.price < :maxPrice";
        }

        if (discounted != null && discounted) {
            s += " AND pv.product.discount > 0";
        }

        if (sort != null) {
            switch (sort) {
                case "newest":
                    s += " ORDER BY pv.viewDate DESC, pv.product.productName ASC";
                    break;
                case "oldest":
                    s += " ORDER BY pv.viewDate ASC, pv.product.productName ASC";
                    break;
                case "priceAsc":
                    s += " ORDER BY pv.product.price ASC, pv.product.productName ASC";
                    break;
                case "priceDesc":
                    s += " ORDER BY pv.product.price DESC, pv.product.productName ASC";
                    break;
            }
        } else {
            s += " ORDER BY pv.viewDate DESC, pv.product.productName ASC";
        }
        
        TypedQuery<ProductView> query = em.createQuery(s, ProductView.class);
        
        if (account != null) {
            query.setParameter("account", account);
        }
        
        if (typeId != null) {
            query.setParameter("typeId", typeId);
        }

        if (minPrice != null) {
            query.setParameter("minPrice", minPrice);
        }

        if (maxPrice != null) {
            query.setParameter("maxPrice", maxPrice);
        }
        
        return query.getResultList();
    }
}
