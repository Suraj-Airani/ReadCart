package com.readcart.dao;

import com.readcart.model.User;

public interface UserDAO {

    User registerUser(User user);

    User loginUser(String email, String passwordHash);

    User getUserById(int userId);

    boolean updateUser(User user);

    boolean emailExists(String email);
}
