package com.readcart.dao.impl;

import com.readcart.dao.CategoryDAO;
import com.readcart.model.Category;
import com.readcart.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDAOImpl implements CategoryDAO {

    @Override
    public List<Category> getAllCategories() {
        String sql = "SELECT * FROM categories";
        List<Category> categories = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();

            while (rs.next()) {
                categories.add(mapCategory(rs));
            }
            return categories;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching all categories.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public Category getCategoryById(int categoryId) {
        String sql = "SELECT * FROM categories WHERE category_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, categoryId);
            rs = ps.executeQuery();

            if (rs.next()) {
                return mapCategory(rs);
            }
            return null;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching category by ID.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    private Category mapCategory(ResultSet rs) throws SQLException {
        Category category = new Category();
        category.setCategoryId(rs.getInt("category_id"));
        category.setCategoryName(rs.getString("category_name"));
        return category;
    }
}
