<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.readcart.model.Product" %>
<%
    Product product = (Product) request.getAttribute("product");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><%= product.getTitle() %> - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="product-detail">
            <div class="product-detail-image">
                <img src="<%= request.getContextPath() %>/<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>">
            </div>
            <div class="product-detail-info">
                <h1><%= product.getTitle() %></h1>
                <p class="product-author">
                    <img src="<%= request.getContextPath() %>/images/author.png" alt="" class="inline-icon"> by <%= product.getAuthor() %>
                </p>
                <p class="product-price">&#8377; <%= product.getPrice() %></p>
                <p class="product-stock">
                    <% if (product.getStock() > 0) { %>
                        <span class="in-stock">
                            <img src="<%= request.getContextPath() %>/images/check-solid.png" alt="" class="inline-icon"> In Stock (<%= product.getStock() %> available)
                        </span>
                    <% } else { %>
                        <span class="out-of-stock">
                            <img src="<%= request.getContextPath() %>/images/close.png" alt="" class="inline-icon"> Out of Stock
                        </span>
                    <% } %>
                </p>
                <p class="product-description"><%= product.getDescription() %></p>

                <% if (product.getStock() > 0) { %>
                    <form action="<%= request.getContextPath() %>/cart" method="post" class="add-to-cart-form">
                        <input type="hidden" name="action" value="add">
                        <input type="hidden" name="productId" value="<%= product.getProductId() %>">
                        <div class="form-group">
                            <label for="quantity">Quantity</label>
                            <input type="number" id="quantity" name="quantity" value="1" min="1" max="<%= product.getStock() %>">
                        </div>
                        <button type="submit" class="btn btn-primary">
                            <img src="<%= request.getContextPath() %>/images/add-to-cart.png" alt="" class="btn-icon"> Add to Cart
                        </button>
                    </form>
                <% } %>

                <a href="<%= request.getContextPath() %>/products" class="btn btn-secondary">Back to Catalog</a>
            </div>
        </div>
    </div>
</body>
</html>
