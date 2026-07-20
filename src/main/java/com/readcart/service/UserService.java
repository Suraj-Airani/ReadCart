package com.readcart.service;

import com.readcart.dao.UserDAO;
import com.readcart.dao.impl.UserDAOImpl;
import com.readcart.model.User;

public class UserService {

    private UserDAO userDAO = new UserDAOImpl();

    public User register(User user) {
        if (userDAO.emailExists(user.getEmail())) {
            return null;
        }
        return userDAO.registerUser(user);
    }

    public User login(String email, String password) {
        return userDAO.loginUser(email, password);
    }

    public User getUserById(int userId) {
        return userDAO.getUserById(userId);
    }

    public boolean updateProfile(User user) {
        return userDAO.updateUser(user);
    }
}
