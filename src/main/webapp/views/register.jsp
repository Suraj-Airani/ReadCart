<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="form-card">
            <h1>Register</h1>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert alert-error">
                    <img src="<%= request.getContextPath() %>/images/warning.png" alt="" class="alert-icon"> <%= error %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/register" method="post">
                <div class="form-group">
                    <label for="name">
                        <img src="<%= request.getContextPath() %>/images/user.png" alt="" class="label-icon"> Full Name
                    </label>
                    <input type="text" id="name" name="name" required placeholder="Enter your full name">
                </div>
                <div class="form-group">
                    <label for="email">
                        <img src="<%= request.getContextPath() %>/images/mail.png" alt="" class="label-icon"> Email
                    </label>
                    <input type="email" id="email" name="email" required placeholder="Enter your email">
                </div>
                <div class="form-group">
                    <label for="password">
                        <img src="<%= request.getContextPath() %>/images/lock-solid.png" alt="" class="label-icon"> Password
                    </label>
                    <input type="password" id="password" name="password" required placeholder="Create a password">
                </div>
                <div class="form-group">
                    <label for="phone">
                        <img src="<%= request.getContextPath() %>/images/phone.png" alt="" class="label-icon"> Phone
                    </label>
                    <input type="text" id="phone" name="phone" placeholder="Enter your phone number">
                </div>
                <div class="form-group">
                    <label for="address">
                        <img src="<%= request.getContextPath() %>/images/address.png" alt="" class="label-icon"> Address
                    </label>
                    <textarea id="address" name="address" rows="3" placeholder="Enter your address"></textarea>
                </div>
                <button type="submit" class="btn btn-primary btn-full">Register</button>
            </form>

            <p class="form-footer">
                Already have an account? <a href="<%= request.getContextPath() %>/login">Login here</a>
            </p>
        </div>
    </div>
</body>
</html>
