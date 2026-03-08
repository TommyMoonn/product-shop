package models.services;

import exceptions.ValidationException;
import java.util.Date;
import java.util.List;
import javax.persistence.EntityManager;
import javax.persistence.TypedQuery;
import models.entities.Product;
import utilities.JPAUtil;

public class ProductService implements Accessible<Product> {

    private EntityManager em;

    public ProductService() {
        this.em = JPAUtil.getEntityManager();
    }

    @Override
    public void create(Product entity) {
        entity.setPostedDate(new Date());
        //create operation specific check
        if (findById(entity.getProductId()) != null) {
            throw new ValidationException("Product already exists.");
        }
        //general business rule validations
        validate(entity);

        em.getTransaction().begin();
        em.persist(entity);
        em.getTransaction().commit();
    }

    @Override
    public Product update(Product entity) {
        //update operation specific check
        if (findById(entity.getProductId()) == null) {
            throw new ValidationException("Product does not exist.");
        }
        //general business rule validations
        validate(entity);

        em.getTransaction().begin();
        Product p = em.merge(entity);
        em.getTransaction().commit();
        return p;
    }

    @Override
    public void delete(String id) {
        Product p = findById(id);
        if (p == null) {
            throw new ValidationException("Product does not exist.");
        }

        em.getTransaction().begin();
        em.remove(p);
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

    public List<Product> filter(String keyword, Integer typeId, Integer minPrice, Integer maxPrice, Boolean discounted, String sort) {
        String s = "SELECT p FROM Product p WHERE 1=1";

        if (keyword != null && !keyword.isEmpty()) {
            s += " AND LOWER(p.productName) LIKE LOWER(:keyword)";
        }

        if (typeId != null) {
            s += " AND p.type.typeId = :typeId";
        }

        if (minPrice != null) {
            s += " AND p.price >= :minPrice";
        }

        if (maxPrice != null) {
            s += " AND p.price <= :maxPrice";
        }

        if (discounted != null && discounted) {
            s += " AND p.discount > 0";
        }

        if ("asc".equals(sort)) {
            s += " ORDER BY p.price, p.productName ASC";
        } else if ("desc".equals(sort)) {
            s += " ORDER BY p.price, p.productName DESC";
        } else {
            s += " ORDER BY p.productName";
        }

        TypedQuery<Product> query = em.createQuery(s, Product.class);

        if (keyword != null && !keyword.isEmpty()) {
            keyword = keyword.trim().toLowerCase();
            query.setParameter("keyword", "%" + keyword + "%");
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

    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    private void validate(Product p) {
        if (p == null) {
            throw new ValidationException("Product cannot be null.");
        }
        if (p.getProductId() == null || p.getProductId().length() > 10 || !p.getProductId().matches("[A-Z0-9_-]{3,20}")) {
            throw new ValidationException("Product Id must be 3–10 characters, uppercase letters, numbers, _ or -");
        }
        if (p.getProductName() == null || p.getProductName().length() < 2) {
            throw new ValidationException("Product name is too short.");
        }
        if (p.getType() == null || p.getType().getTypeId() <= 0) {
            throw new ValidationException("This category does not exist.");
        }
        if (p.getUnit() == null || !p.getUnit().matches("[\\p{L} ]+")) {
            throw new ValidationException("Unit must contain only letters or spaces.");
        }
        if (p.getPrice() < 0) {
            throw new ValidationException("Price cannot be negative.");
        }
        if (p.getDiscount() < 0 || p.getDiscount() > 100) {
            throw new ValidationException("Discount must be between 0 to 100.");
        }
        String imageFile = p.getProductImage();
        if (imageFile == null || imageFile.isEmpty()) {
            imageFile = "default.png";
        } else if (!imageFile.matches("^[a-zA-Z0-9_-]+\\.(jpg|jpeg|png)$")) {
            throw new ValidationException("Invalid image file");
        }
        p.setProductImage("/images/sanPham/" + imageFile);
    }

}
