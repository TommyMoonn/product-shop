package service;

import java.util.List;
import models.dao.CategoryDAO;
import models.entity.Category;

public class CategoryService {

    private CategoryDAO categoryDAO = new CategoryDAO();

    public boolean add(Category category) {
        return categoryDAO.insert(category) > 0;
    }

    public boolean update(Category category) {
        return categoryDAO.update(category) > 0;
    }

    public boolean delete(String id) {
        return categoryDAO.delete(id) > 0;
    }
    
    public Category getById(String id) {
        return categoryDAO.getById(id);
    }

    public List<Category> getAll() {
        return categoryDAO.getAll();
    }

}