package com.readcart.dao;

import com.readcart.model.Order;
import com.readcart.model.OrderItem;
import java.util.List;

public interface OrderDAO {

    int placeOrder(Order order, List<OrderItem> items);

    List<Order> getOrdersByUserId(int userId);

    List<OrderItem> getOrderItems(int orderId);
}
