package com.readcart.service;

import com.readcart.dao.CategoryDAO;
import com.readcart.dao.ProductDAO;
import com.readcart.dao.impl.CategoryDAOImpl;
import com.readcart.dao.impl.ProductDAOImpl;
import com.readcart.model.Category;
import com.readcart.model.Product;

import java.util.ArrayList;
import java.util.List;

public class ProductService {

    private ProductDAO productDAO = new ProductDAOImpl();
    private CategoryDAO categoryDAO = new CategoryDAOImpl();

    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    public Product getProductById(int productId) {
        return productDAO.getProductById(productId);
    }

    public List<Product> getProductsByCategory(int categoryId) {
        return productDAO.getProductsByCategory(categoryId);
    }

    public List<Product> searchProducts(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return new ArrayList<>();
        }
        return productDAO.searchProducts(keyword.trim());
    }

    public List<Category> getAllCategories() {
        return categoryDAO.getAllCategories();
    }
}
