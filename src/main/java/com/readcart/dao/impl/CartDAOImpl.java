package com.readcart.dao.impl;

import com.readcart.dao.CartDAO;
import com.readcart.model.CartItem;
import com.readcart.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAOImpl implements CartDAO {

    @Override
    public boolean addToCart(CartItem cartItem) {
        String sql = "INSERT INTO cart_items (user_id, product_id, quantity) VALUES (?, ?, ?) "
                   + "ON DUPLICATE KEY UPDATE quantity = quantity + VALUES(quantity)";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartItem.getUserId());
            ps.setInt(2, cartItem.getProductId());
            ps.setInt(3, cartItem.getQuantity());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error adding to cart.", e);
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public List<CartItem> getCartByUserId(int userId) {
        String sql = "SELECT * FROM cart_items WHERE user_id = ?";
        List<CartItem> items = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapCartItem(rs));
            }
            return items;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching cart.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean updateQuantity(int cartItemId, int quantity) {
        String sql = "UPDATE cart_items SET quantity = ? WHERE cart_item_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setInt(2, cartItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error updating cart quantity.", e);
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean removeFromCart(int cartItemId) {
        String sql = "DELETE FROM cart_items WHERE cart_item_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, cartItemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error removing from cart.", e);
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM cart_items WHERE user_id = ?";
        Connection conn = null;
        PreparedStatement ps = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException("Error clearing cart.", e);
        } finally {
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    private CartItem mapCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setCartItemId(rs.getInt("cart_item_id"));
        item.setUserId(rs.getInt("user_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setAddedAt(rs.getTimestamp("added_at"));
        return item;
    }
}
