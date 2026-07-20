<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.readcart.model.CartItem" %>
<%
    List<CartItem> cartItems = (List<CartItem>) request.getAttribute("cartItems");
    Double cartTotal = (Double) request.getAttribute("cartTotal");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cart - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <h1><img src="<%= request.getContextPath() %>/images/cart.png" alt="" class="heading-icon"> Shopping Cart</h1>

        <% if (cartItems == null || cartItems.isEmpty()) { %>
            <p class="empty-message">Your cart is empty. <a href="<%= request.getContextPath() %>/products">Browse products</a></p>
        <% } else { %>
            <table class="cart-table">
                <thead>
                    <tr>
                        <th>Product ID</th>
                        <th>Quantity</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (CartItem item : cartItems) { %>
                        <tr>
                            <td><%= item.getProductId() %></td>
                            <td>
                                <form action="<%= request.getContextPath() %>/cart" method="post" class="inline-form">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                    <input type="number" name="quantity" value="<%= item.getQuantity() %>" min="1" class="qty-input">
                                    <button type="submit" class="btn btn-small">Update</button>
                                </form>
                            </td>
                            <td>
                                <form action="<%= request.getContextPath() %>/cart" method="post" class="inline-form">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="cartItemId" value="<%= item.getCartItemId() %>">
                                    <button type="submit" class="btn btn-danger btn-small">
                                        <img src="<%= request.getContextPath() %>/images/trash.png" alt="" class="btn-icon"> Remove
                                    </button>
                                </form>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>

            <div class="cart-summary">
                <p class="cart-total">Total: &#8377; <%= cartTotal %></p>
                <a href="<%= request.getContextPath() %>/checkout" class="btn btn-primary">
                    <img src="<%= request.getContextPath() %>/images/checkout.png" alt="" class="btn-icon"> Proceed to Checkout
                </a>
            </div>
        <% } %>
    </div>
</body>
</html>
