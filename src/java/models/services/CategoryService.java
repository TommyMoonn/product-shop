package models.services;

import exceptions.ValidationException;
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
        validate(entity);

        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public Category update(Category entity) {
        validate(entity);

        em.getTransaction().begin();
        Category c = em.merge(entity);
        em.getTransaction().commit();
        return c;
    }

    @Override
    public void delete(String id) {
        Category c = findById(id);

        if (c == null) {
            throw new ValidationException("Category does not exist.");
        }

        Long count = em.createQuery(
                "SELECT COUNT(p) FROM Product p WHERE p.type = :category",
                Long.class)
                .setParameter("category", c)
                .getSingleResult();

        if (count > 0) {
            throw new ValidationException("Cannot delete category because it is used by existing products.");
        }

        em.getTransaction().begin();
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

    //helper class to enforce business rules on server-side
    private void validate(Category c) {
        if (c == null) {
            throw new ValidationException("Category cannot be null.");
        }
        if (c.getCategoryName() == null || !c.getCategoryName().matches("[\\p{L} ]+")) {
            throw new ValidationException("Category name must only contain letters and spaces.");
        }
    }

}
