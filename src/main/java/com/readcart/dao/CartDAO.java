package com.readcart.dao;

import com.readcart.model.CartItem;
import java.util.List;

public interface CartDAO {

    boolean addToCart(CartItem cartItem);

    List<CartItem> getCartByUserId(int userId);

    boolean updateQuantity(int cartItemId, int quantity);

    boolean removeFromCart(int cartItemId);

    boolean clearCart(int userId);
}
