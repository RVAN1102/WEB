package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Category;

public interface ICategoryService {
    void insert(Category category);
    void update(Category category);
    void delete(int cateid);
    Category findById(int cateid);
    Category findByCategoryname(String name);
    List<Category> findAll();
    List<Category> searchByName(String catname);
    List<Category> findAll(int page, int pagesize);
    int count();
}