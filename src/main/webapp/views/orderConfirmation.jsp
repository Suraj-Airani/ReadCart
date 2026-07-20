<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String orderId = (String) request.getAttribute("orderId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Order Confirmed - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="confirmation-card">
            <img src="<%= request.getContextPath() %>/images/success.png" alt="Success" class="confirmation-icon">
            <h1>Order Placed Successfully!</h1>
            <p>Your order ID is: <strong>#<%= orderId %></strong></p>
            <p>Thank you for shopping with ReadCart.</p>
            <div class="confirmation-links">
                <a href="<%= request.getContextPath() %>/orders" class="btn btn-primary">View Order History</a>
                <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">Continue Shopping</a>
            </div>
        </div>
    </div>
</body>
</html>
