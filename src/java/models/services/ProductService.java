package models.services;

import java.util.List;
import javax.persistence.EntityManager;
import models.entities.Product;
import utilities.JPAUtil;

public class ProductService implements Accessible<Product> {

    private EntityManager em;

    public ProductService() {
        this.em = JPAUtil.getEntityManager();
    }

    @Override
    public void create(Product entity) {
        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public Product update(Product entity) {
        em.getTransaction().begin();
        Product p = em.merge(entity);
        em.getTransaction().commit();
        return p;
    }

    @Override
    public void delete(String id) {
        em.getTransaction().begin();
        Product p = findById(id);
        if (p != null) {
            em.remove(p);
        }
        em.getTransaction().commit();
    }

    @Override
    public Product findById(String id) {
        return em.find(Product.class, id);
    }

    @Override
    public List<Product> findAll() {
        return em.createQuery("SELECT p FROM Product p", Product.class).getResultList();
    }

    public List<Product> findByCategory(int typeId) {
        return em.createQuery("SELECT p from Product p WHERE p.type.typeId = :typeId",
                Product.class).setParameter("typeId", typeId).getResultList();
                
    }
    
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

}
