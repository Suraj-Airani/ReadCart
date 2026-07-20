package com.readcart.servlet;

import com.readcart.model.User;
import com.readcart.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/views/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");

        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPasswordHash(password);
        user.setPhone(phone);
        user.setAddress(address);

        User registered = userService.register(user);

        if (registered != null) {
            response.sendRedirect(request.getContextPath() + "/login?success=Registration+successful.+Please+login.");
        } else {
            request.setAttribute("error", "Email already exists. Please use a different email.");
            request.getRequestDispatcher("/views/register.jsp").forward(request, response);
        }
    }
}
