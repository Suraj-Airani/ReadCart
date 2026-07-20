package com.readcart.dao;

import com.readcart.model.Product;
import java.util.List;

public interface ProductDAO {

    List<Product> getAllProducts();

    Product getProductById(int productId);

    List<Product> getProductsByCategory(int categoryId);

    List<Product> searchProducts(String keyword);

    boolean updateStock(int productId, int newStock);
}
