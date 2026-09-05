package vn.iotstar.service;

import java.util.List;
import vn.iotstar.entity.Product;

public interface IProductService {
    void insert(Product product);
    void update(Product product);
    void delete(int productId);
    Product findById(int productId);
    List<Product> findAll();
    List<Product> findTop10Latest();
    List<Product> findAll(int page, int pageSize);
    int count();
    List<Product> findByCategoryId(int categoryId);
}
