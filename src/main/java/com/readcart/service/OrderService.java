package com.readcart.service;

import com.readcart.dao.CartDAO;
import com.readcart.dao.OrderDAO;
import com.readcart.dao.ProductDAO;
import com.readcart.dao.impl.CartDAOImpl;
import com.readcart.dao.impl.OrderDAOImpl;
import com.readcart.dao.impl.ProductDAOImpl;
import com.readcart.model.CartItem;
import com.readcart.model.Order;
import com.readcart.model.OrderItem;
import com.readcart.model.Product;

import java.util.ArrayList;
import java.util.List;

public class OrderService {

    private OrderDAO orderDAO = new OrderDAOImpl();
    private CartDAO cartDAO = new CartDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    public int checkout(int userId, String shippingAddress) {
        List<CartItem> cartItems = cartDAO.getCartByUserId(userId);
        if (cartItems == null || cartItems.isEmpty()) {
            return -1;
        }

        double totalAmount = 0;
        List<OrderItem> orderItems = new ArrayList<>();

        for (CartItem cartItem : cartItems) {
            Product product = productDAO.getProductById(cartItem.getProductId());
            if (product == null) {
                return -1;
            }

            double priceAtPurchase = product.getPrice();
            totalAmount += priceAtPurchase * cartItem.getQuantity();

            OrderItem orderItem = new OrderItem();
            orderItem.setProductId(cartItem.getProductId());
            orderItem.setQuantity(cartItem.getQuantity());
            orderItem.setPriceAtPurchase(priceAtPurchase);
            orderItems.add(orderItem);
        }

        Order order = new Order();
        order.setUserId(userId);
        order.setTotalAmount(totalAmount);
        order.setShippingAddress(shippingAddress);
        order.setStatus("PENDING");

        int orderId = orderDAO.placeOrder(order, orderItems);

        if (orderId > 0) {
            cartDAO.clearCart(userId);
        }

        return orderId;
    }

    public List<Order> getOrderHistory(int userId) {
        return orderDAO.getOrdersByUserId(userId);
    }

    public List<OrderItem> getOrderDetails(int orderId) {
        return orderDAO.getOrderItems(orderId);
    }
}
