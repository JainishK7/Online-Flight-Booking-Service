<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.airgo.model.User" %>
<%@ page import="com.airgo.model.Booking" %>
<%@ page import="com.airgo.dao.BookingDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Create DAO instance and fetch bookings
    BookingDAO bookingDAO = new BookingDAO();
    List<Booking> bookings = bookingDAO.getBookingsByUserId(user.getUserId());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>My Bookings - AirGo</title>
    <link rel="stylesheet" href="style.css" />
    <style>
        .table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px 0;
            background: white;
            box-shadow: 0 2px 8px rgba(0,0,0,0.1);
        }
        .table thead {
            background: #1e40af;
            color: white;
        }
        .table th, .table td {
            padding: 12px 15px;
            text-align: left;
            border-bottom: 1px solid #ddd;
        }
        .table tbody tr:hover {
            background: #f3f4f6;
        }
    </style>
</head>
<body>

<header class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="logo">
            <span class="logo-icon">✈️</span>
            <span>AirGo</span>
        </a>
        <nav class="nav-links">
            <a href="index.jsp">Flights</a>
            <a href="myBookings.jsp" class="active">My Bookings</a>
            <span style="color: #38bdf8; font-weight: 700; margin-left: 14px;">
                Hello, <%= user.getFullName() %>
            </span>
            <a href="logout" class="btn btn-danger" style="margin-left: 12px;">Logout</a>
        </nav>
    </div>
</header>

<div class="container" style="margin-top: 40px; padding: 20px;">
    <h2 style="color: #1e40af; margin-bottom: 20px;">My Bookings</h2>

    <%
        if (bookings == null || bookings.isEmpty()) {
    %>
    <p style="font-size: 16px; color: #6b7280;">You currently have no bookings.</p>
    <%
    } else {
    %>
    <table class="table">
        <thead>
        <tr>
            <th>Booking Ref</th>
            <th>Flight No</th>
            <th>Passenger</th>
            <th>Travel Date</th>
            <th>Seats</th>
            <th>Total Price</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            for (Booking booking : bookings) {
                String statusColor = "CANCELLED".equals(booking.getBookingStatus()) ? "red" : "green";
        %>
        <tr>
            <td><%= booking.getBookingReference() %></td>
            <td><%= booking.getFlightNumber() != null ? booking.getFlightNumber() : "N/A" %></td>
            <td><%= booking.getPassengerName() %></td>
            <td><%= booking.getTravelDate() %></td>
            <td><%= booking.getSeatsBooked() %></td>
            <td>₹<%= String.format("%.2f", booking.getTotalPrice()) %></td>
            <td style="color: <%= statusColor %>; font-weight: 600;">
                <%= booking.getBookingStatus() %>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <% } %>
</div>

<footer class="footer">
    <div class="footer-inner">
        <div class="col">
            <div class="brand">✈️ AirGo</div>
            <p>Your trusted partner for hassle-free flight bookings.</p>
            <div class="social">🔵 🐦 📸 💼</div>
        </div>
        <div class="col">
            <h5>Quick Links</h5>
            <a href="index.jsp">Home</a>
            <a href="index.jsp">Flights</a>
            <a href="#">Contact</a>
        </div>
        <div class="col">
            <h5>Support</h5>
            <a href="#">Feedback</a>
            <a href="#">Terms & Conditions</a>
            <a href="#">Privacy Policy</a>
        </div>
    </div>
</footer>

</body>
</html>
