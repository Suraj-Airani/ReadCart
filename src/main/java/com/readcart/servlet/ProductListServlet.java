package com.readcart.servlet;

import com.readcart.model.Category;
import com.readcart.model.Product;
import com.readcart.service.ProductService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/products")
public class ProductListServlet extends HttpServlet {

    private ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String categoryParam = request.getParameter("category");
        String keyword = request.getParameter("keyword");

        List<Product> products;

        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productService.searchProducts(keyword.trim());
        } else if (categoryParam != null && !categoryParam.trim().isEmpty()) {
            int categoryId = Integer.parseInt(categoryParam);
            products = productService.getProductsByCategory(categoryId);
        } else {
            products = productService.getAllProducts();
        }

        List<Category> categories = productService.getAllCategories();

        request.setAttribute("products", products);
        request.setAttribute("categories", categories);
        request.setAttribute("selectedCategory", categoryParam);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("/views/catalog.jsp").forward(request, response);
    }
}
