<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.readcart.model.Order" %>
<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    String success = request.getParameter("success");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order History - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <h1>Order History</h1>

        <% if (success != null) { %>
            <div class="alert alert-success">
                <img src="<%= request.getContextPath() %>/images/success.png" alt="" class="alert-icon"> <%= success %>
            </div>
        <% } %>

        <% if (orders == null || orders.isEmpty()) { %>
            <p class="empty-message">No orders yet. <a href="<%= request.getContextPath() %>/products">Start shopping</a></p>
        <% } else { %>
            <table class="order-table">
                <thead>
                    <tr>
                        <th>Order ID</th>
                        <th>Date</th>
                        <th>Total Amount</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (Order order : orders) { %>
                        <tr>
                            <td>#<%= order.getOrderId() %></td>
                            <td><%= order.getCreatedAt() %></td>
                            <td>&#8377; <%= order.getTotalAmount() %></td>
                            <td><span class="status-badge status-<%= order.getStatus() %>"><%= order.getStatus() %></span></td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        <% } %>
    </div>
</body>
</html>
