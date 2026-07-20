package com.readcart.dao.impl;

import com.readcart.dao.ProductDAO;
import com.readcart.model.Product;
import com.readcart.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAOImpl implements ProductDAO {

    @Override
    public List<Product> getAllProducts() {
        String sql = "SELECT * FROM products";
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
            return products;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all products.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public Product getProductById(int productId) {
        String sql = "SELECT * FROM products WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return mapProduct(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching product by ID.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public List<Product> getProductsByCategory(int categoryId) {
        String sql = "SELECT * FROM products WHERE category_id = ?";
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
            return products;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching products by category.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public List<Product> searchProducts(String keyword) {
        String sql = "SELECT * FROM products WHERE title LIKE ? OR author LIKE ?";
        List<Product> products = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            String pattern = "%" + keyword + "%";
            ps.setString(1, pattern);
            ps.setString(2, pattern);
            rs = ps.executeQuery();

            while (rs.next()) {
                products.add(mapProduct(rs));
            }
            return products;
        } catch (SQLException e) {
            throw new RuntimeException("Error searching products.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean updateStock(int productId, int newStock) {
        String sql = "UPDATE products SET stock = ? WHERE product_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, newStock);
            ps.setInt(2, productId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating stock.", e);
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    private Product mapProduct(ResultSet rs) throws SQLException {
        Product product = new Product();
        product.setProductId(rs.getInt("product_id"));
        product.setTitle(rs.getString("title"));
        product.setAuthor(rs.getString("author"));
        product.setCategoryId(rs.getInt("category_id"));
        product.setPrice(rs.getDouble("price"));
        product.setStock(rs.getInt("stock"));
        product.setDescription(rs.getString("description"));
        product.setImageUrl(rs.getString("image_url"));
        product.setCreatedAt(rs.getTimestamp("created_at"));
        return product;
    }
}
