package models.services;

import java.util.List;
import javax.persistence.EntityManager;
import models.entities.Category;
import utilities.JPAUtil;

public class CategoryService implements Accessible<Category> {

    private EntityManager em;
    
    public CategoryService() {
        this.em = JPAUtil.getEntityManager();
    }

    @Override
    public void create(Category entity) {
        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public Category update(Category entity) {
        em.getTransaction().begin();
        Category c = em.merge(entity);
        em.getTransaction().commit();
        return c;
    }

    @Override
    public void delete(String id) {
        em.getTransaction().begin();
        Category c = findById(id);
        em.remove(c);
        em.getTransaction().commit();
    }

    @Override
    public Category findById(String typeId) {
        Integer id = Integer.parseInt(typeId);
        return em.find(Category.class, id);
    }

    @Override
    public List<Category> findAll() {
        return em.createQuery("SELECT c FROM Category c", Category.class).getResultList();
    }

}
