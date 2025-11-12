<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.airgo.model.User" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Booking Successful - AirGo</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<nav class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="logo">✈️ AirGo</a>
        <ul class="nav-links">
            <li><a href="index.jsp">Home</a></li>
            <li><a href="myBookings">My Bookings</a></li>
            <li><span style="color: #3b82f6;">Hello, <%= user.getUsername() %></span></li>
            <li><a href="logout" class="btn btn-danger">Logout</a></li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="success-container">
        <div class="success-icon">✓</div>
        <h2>Booking Confirmed!</h2>
        <p style="font-size: 1.1rem; color: #6b7280; margin-bottom: 2rem;">
            <%= request.getParameter("msg") != null ? request.getParameter("msg") : "Your flight has been booked successfully!" %>
        </p>

        <p style="color: #6b7280; margin-bottom: 2rem;">
            A confirmation email has been sent to your registered email address.<br/>
            You can view your booking details in the My Bookings section.
        </p>

        <div style="display: flex; gap: 1rem; justify-content: center; flex-wrap: wrap;">
            <a href="myBookings" class="btn btn-primary">View My Bookings</a>
            <a href="index.jsp" class="btn btn-secondary">Book Another Flight</a>
        </div>
    </div>
</div>
</body>
</html>
