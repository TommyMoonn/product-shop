package service;

import java.util.List;
import models.dao.ProductDAO;
import models.entity.Product;

public class ProductService {

    private ProductDAO productDAO = new ProductDAO();

    public void add(Product product) {
        productDAO.insert(product);
    }

    public void update(Product product) {
        productDAO.update(product);
    }

    public void delete(String id) {
        productDAO.delete(id);
    }

    public List<Product> getAll() {
        return productDAO.getAll();
    }

    public List<Product> getAllByCategory(int categoryId) {
        return productDAO.listByCategory(categoryId);
    }
}
