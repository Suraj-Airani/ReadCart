<%@ page import="com.readcart.model.User" %>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
%>
<nav class="navbar">
    <div class="nav-container">
        <a href="<%= request.getContextPath() %>/products" class="nav-brand">
            <img src="<%= request.getContextPath() %>/images/logo.png" alt="ReadCart" class="nav-logo">
        </a>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/products">
                <img src="<%= request.getContextPath() %>/images/list.png" alt="" class="nav-icon"> Catalog
            </a>
            <% if (loggedInUser != null) { %>
                <a href="<%= request.getContextPath() %>/cart">
                    <img src="<%= request.getContextPath() %>/images/cart.png" alt="" class="nav-icon"> Cart
                </a>
                <a href="<%= request.getContextPath() %>/orders">
                    <img src="<%= request.getContextPath() %>/images/checkout.png" alt="" class="nav-icon"> Orders
                </a>
                <span class="nav-user">
                    <img src="<%= request.getContextPath() %>/images/user.png" alt="" class="nav-icon"> Hi, <%= loggedInUser.getName() %>
                </span>
                <a href="<%= request.getContextPath() %>/logout">
                    <img src="<%= request.getContextPath() %>/images/sign-out.png" alt="" class="nav-icon"> Logout
                </a>
            <% } else { %>
                <a href="<%= request.getContextPath() %>/login">
                    <img src="<%= request.getContextPath() %>/images/sign-in.png" alt="" class="nav-icon"> Login
                </a>
                <a href="<%= request.getContextPath() %>/register">
                    <img src="<%= request.getContextPath() %>/images/user.png" alt="" class="nav-icon"> Register
                </a>
            <% } %>
        </div>
    </div>
</nav>