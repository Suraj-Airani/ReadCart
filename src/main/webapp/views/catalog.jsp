<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.readcart.model.Product" %>
<%@ page import="com.readcart.model.Category" %>
<%
    List<Product> products = (List<Product>) request.getAttribute("products");
    List<Category> categories = (List<Category>) request.getAttribute("categories");
    String selectedCategory = (String) request.getAttribute("selectedCategory");
    String keyword = (String) request.getAttribute("keyword");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Catalog - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <h1>Book Catalog</h1>

        <div class="catalog-layout">
            <aside class="sidebar">
                <h3><img src="<%= request.getContextPath() %>/images/search.png" alt="" class="section-icon"> Search</h3>
                <form action="<%= request.getContextPath() %>/products" method="get" class="search-form">
                    <input type="text" name="keyword" placeholder="Search by title or author..." value="<%= keyword != null ? keyword : "" %>">
                    <button type="submit" class="btn btn-primary btn-full">
                        <img src="<%= request.getContextPath() %>/images/search.png" alt="" class="btn-icon"> Search
                    </button>
                </form>

                <h3><img src="<%= request.getContextPath() %>/images/filter.png" alt="" class="section-icon"> Categories</h3>
                <ul class="category-list">
                    <li>
                        <a href="<%= request.getContextPath() %>/products"
                           class="<%= (selectedCategory == null || selectedCategory.isEmpty()) ? "active" : "" %>">All</a>
                    </li>
                    <% if (categories != null) {
                        for (Category cat : categories) { %>
                        <li>
                            <a href="<%= request.getContextPath() %>/products?category=<%= cat.getCategoryId() %>"
                               class="<%= (selectedCategory != null && selectedCategory.equals(String.valueOf(cat.getCategoryId()))) ? "active" : "" %>"><%= cat.getCategoryName() %></a>
                        </li>
                    <%  }
                    } %>
                </ul>
            </aside>

            <div class="product-grid">
                <% if (products == null || products.isEmpty()) { %>
                    <p class="empty-message">No products found.</p>
                <% } else {
                    for (Product product : products) { %>
                        <div class="product-card">
                            <a href="<%= request.getContextPath() %>/product?id=<%= product.getProductId() %>">
                                <img src="<%= request.getContextPath() %>/<%= product.getImageUrl() %>" alt="<%= product.getTitle() %>" class="product-image">
                                <div class="product-info">
                                    <h3 class="product-title"><%= product.getTitle() %></h3>
                                    <p class="product-author">
                                        <img src="<%= request.getContextPath() %>/images/author.png" alt="" class="inline-icon"> <%= product.getAuthor() %>
                                    </p>
                                    <p class="product-price">&#8377; <%= product.getPrice() %></p>
                                </div>
                            </a>
                        </div>
                <%  }
                } %>
            </div>
        </div>
    </div>
</body>
</html>
