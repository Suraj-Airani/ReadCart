<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - ReadCart</title>
    <link rel="icon" type="image/png" href="<%= request.getContextPath() %>/images/favicon.png">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <jsp:include page="navbar.jsp" />

    <div class="container">
        <div class="form-card">
            <h1>Login</h1>

            <% String error = (String) request.getAttribute("error"); %>
            <% if (error != null) { %>
                <div class="alert alert-error">
                    <img src="<%= request.getContextPath() %>/images/warning.png" alt="" class="alert-icon"> <%= error %>
                </div>
            <% } %>

            <% String success = request.getParameter("success"); %>
            <% if (success != null) { %>
                <div class="alert alert-success">
                    <img src="<%= request.getContextPath() %>/images/check-solid.png" alt="" class="alert-icon"> <%= success %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/login" method="post">
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
                    <input type="password" id="password" name="password" required placeholder="Enter your password">
                </div>
                <button type="submit" class="btn btn-primary btn-full">
                    <img src="<%= request.getContextPath() %>/images/sign-in.png" alt="" class="btn-icon"> Login
                </button>
            </form>

            <p class="form-footer">
                Don't have an account? <a href="<%= request.getContextPath() %>/register">Register here</a>
            </p>
        </div>
    </div>
</body>
</html>
