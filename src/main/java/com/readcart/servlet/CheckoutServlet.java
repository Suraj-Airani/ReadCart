package com.readcart.servlet;

import com.readcart.model.User;
import com.readcart.service.OrderService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    private OrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User user = (User) session.getAttribute("loggedInUser");
        String shippingAddress = request.getParameter("shippingAddress");

        int orderId = orderService.checkout(user.getUserId(), shippingAddress);

        if (orderId > 0) {
            response.sendRedirect(request.getContextPath() + "/orders?success=Order+placed+successfully.+Order+ID:+" + orderId);
        } else {
            request.setAttribute("error", "Checkout failed. Your cart may be empty.");
            request.getRequestDispatcher("/views/checkout.jsp").forward(request, response);
        }
    }
}
