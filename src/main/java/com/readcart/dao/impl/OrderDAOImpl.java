package com.readcart.dao.impl;

import com.readcart.dao.OrderDAO;
import com.readcart.model.Order;
import com.readcart.model.OrderItem;
import com.readcart.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int placeOrder(Order order, List<OrderItem> items) {
        String orderSql = "INSERT INTO orders (user_id, total_amount, shipping_address, status) VALUES (?, ?, ?, ?)";
        String itemSql = "INSERT INTO order_items (order_id, product_id, quantity, price_at_purchase) VALUES (?, ?, ?, ?)";
        Connection conn = null;
        PreparedStatement orderPs = null;
        PreparedStatement itemPs = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            conn.setAutoCommit(false);

            orderPs = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS);
            orderPs.setInt(1, order.getUserId());
            orderPs.setDouble(2, order.getTotalAmount());
            orderPs.setString(3, order.getShippingAddress());
            orderPs.setString(4, order.getStatus());
            orderPs.executeUpdate();

            rs = orderPs.getGeneratedKeys();
            int orderId = 0;
            if (rs.next()) {
                orderId = rs.getInt(1);
            }

            itemPs = conn.prepareStatement(itemSql);
            for (OrderItem item : items) {
                itemPs.setInt(1, orderId);
                itemPs.setInt(2, item.getProductId());
                itemPs.setInt(3, item.getQuantity());
                itemPs.setDouble(4, item.getPriceAtPurchase());
                itemPs.addBatch();
            }
            itemPs.executeBatch();

            conn.commit();
            return orderId;
        } catch (SQLException e) {
            if (conn != null) {
                try { conn.rollback(); } catch (SQLException ignored) {}
            }
            throw new RuntimeException("Error placing order.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (itemPs != null) itemPs.close(); } catch (SQLException ignored) {}
            try { if (orderPs != null) orderPs.close(); } catch (SQLException ignored) {}
            try { if (conn != null) conn.setAutoCommit(true); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT * FROM orders WHERE user_id = ? ORDER BY created_at DESC";
        List<Order> orders = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, userId);
            rs = ps.executeQuery();

            while (rs.next()) {
                orders.add(mapOrder(rs));
            }
            return orders;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching orders.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    @Override
    public List<OrderItem> getOrderItems(int orderId) {
        String sql = "SELECT * FROM order_items WHERE order_id = ?";
        List<OrderItem> items = new ArrayList<>();
        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            ps = conn.prepareStatement(sql);
            ps.setInt(1, orderId);
            rs = ps.executeQuery();

            while (rs.next()) {
                items.add(mapOrderItem(rs));
            }
            return items;
        } catch (SQLException e) {
            throw new RuntimeException("Error fetching order items.", e);
        } finally {
            try { if (rs != null) rs.close(); } catch (SQLException ignored) {}
            try { if (ps != null) ps.close(); } catch (SQLException ignored) {}
            DBConnection.closeConnection(conn);
        }
    }

    private Order mapOrder(ResultSet rs) throws SQLException {
        Order order = new Order();
        order.setOrderId(rs.getInt("order_id"));
        order.setUserId(rs.getInt("user_id"));
        order.setTotalAmount(rs.getDouble("total_amount"));
        order.setShippingAddress(rs.getString("shipping_address"));
        order.setStatus(rs.getString("status"));
        order.setCreatedAt(rs.getTimestamp("created_at"));
        return order;
    }

    private OrderItem mapOrderItem(ResultSet rs) throws SQLException {
        OrderItem item = new OrderItem();
        item.setOrderItemId(rs.getInt("order_item_id"));
        item.setOrderId(rs.getInt("order_id"));
        item.setProductId(rs.getInt("product_id"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPriceAtPurchase(rs.getDouble("price_at_purchase"));
        return item;
    }
}
