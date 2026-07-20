<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.readcart.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    String error = (String) request.getAttribute("error");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Checkout - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="form-card">
            <h1><img src="<%= request.getContextPath() %>/images/checkout.png" alt="" class="heading-icon"> Checkout</h1>

            <% if (error != null) { %>
                <div class="alert alert-error">
                    <img src="<%= request.getContextPath() %>/images/warning.png" alt="" class="alert-icon"> <%= error %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/checkout" method="post">
                <div class="form-group">
                    <label for="shippingAddress">
                        <img src="<%= request.getContextPath() %>/images/address.png" alt="" class="label-icon"> Shipping Address
                    </label>
                    <textarea id="shippingAddress" name="shippingAddress" rows="4" required
                              placeholder="Enter your full shipping address"><%= (loggedInUser != null && loggedInUser.getAddress() != null) ? loggedInUser.getAddress() : "" %></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-full">
                    <img src="<%= request.getContextPath() %>/images/check-solid.png" alt="" class="btn-icon"> Place Order
                </button>
            </form>

            <a href="<%= request.getContextPath() %>/cart" class="btn btn-secondary btn-full" style="margin-top: 12px;">
                <img src="<%= request.getContextPath() %>/images/cart.png" alt="" class="btn-icon"> Back to Cart
            </a>
        </div>
    </div>
</body>
</html>
