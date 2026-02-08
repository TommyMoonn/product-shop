package models.services;

import java.util.List;

public interface Accessible<T> {
    void create(T entity);
    T update(T entity);
    void delete(String id);
    T findById(String id);
    List<T> findAll();
}
