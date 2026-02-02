package service;

import java.util.List;
import models.dao.CategoryDAO;
import models.entity.Category;

public class CategoryService {

    private CategoryDAO categoryDAO = new CategoryDAO();

    public void add(Category category) {
        categoryDAO.insert(category);
    }

    public void update(Category category) {
        categoryDAO.update(category);
    }

    public void delete(String id) {
        categoryDAO.delete(id);
    }
    
    public Category getById(String id) {
        return categoryDAO.getById(id);
    }

    public List<Category> getAll() {
        return categoryDAO.getAll();
    }

}