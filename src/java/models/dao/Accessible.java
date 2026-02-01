package models.dao;

import java.util.List;

public interface Accessible<T> {
    int insert(T obj);
    int update(T obj);
    int delete(String id);
    T getById(String id);
    List<T> getAll();
}
