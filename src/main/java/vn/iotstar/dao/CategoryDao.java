package vn.iotstar.dao;

import java.util.List;
import vn.iotstar.model.Category;

public interface CategoryDao {
    void insert(Category category);
    void edit(Category category);
    void delete(int id);
    Category get(int id);
    Category get(String name);
    List<Category> getAll();
    List<Category> search(String keyword);
}