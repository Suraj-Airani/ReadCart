package com.readcart.service;

import com.readcart.dao.CartDAO;
import com.readcart.dao.ProductDAO;
import com.readcart.dao.impl.CartDAOImpl;
import com.readcart.dao.impl.ProductDAOImpl;
import com.readcart.model.CartItem;
import com.readcart.model.Product;

import java.util.List;

public class CartService {

    private CartDAO cartDAO = new CartDAOImpl();
    private ProductDAO productDAO = new ProductDAOImpl();

    public boolean addToCart(int userId, int productId, int quantity) {
        Product product = productDAO.getProductById(productId);
        if (product == null || product.getStock() < quantity) {
            return false;
        }
        CartItem cartItem = new CartItem();
        cartItem.setUserId(userId);
        cartItem.setProductId(productId);
        cartItem.setQuantity(quantity);
        return cartDAO.addToCart(cartItem);
    }

    public List<CartItem> getCart(int userId) {
        return cartDAO.getCartByUserId(userId);
    }

    public double getCartTotal(int userId) {
        List<CartItem> items = cartDAO.getCartByUserId(userId);
        double total = 0;
        for (CartItem item : items) {
            Product product = productDAO.getProductById(item.getProductId());
            if (product != null) {
                total += product.getPrice() * item.getQuantity();
            }
        }
        return total;
    }

    public boolean updateQuantity(int cartItemId, int quantity) {
        if (quantity <= 0) {
            return false;
        }
        return cartDAO.updateQuantity(cartItemId, quantity);
    }

    public boolean removeFromCart(int cartItemId) {
        return cartDAO.removeFromCart(cartItemId);
    }

    public boolean clearCart(int userId) {
        return cartDAO.clearCart(userId);
    }
}
