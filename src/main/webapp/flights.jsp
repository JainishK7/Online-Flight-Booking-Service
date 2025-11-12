<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.airgo.model.User" %>
<%
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>AirGo - Search Flights</title>
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>

<header class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="logo"><span class="logo-icon">✈️</span>AirGo</a>
        <nav class="nav-links">
            <a href="index.jsp">Flights</a>
            <% if(user != null) { %>
            <a href="myBookings.jsp" class="btn btn-primary">My Bookings</a>
            <span style="color: #38bdf8; font-weight: 700; margin-left: 14px;">
                    Hello, <%= user.getFullName() %>
                </span>
            <a href="logout" class="btn btn-danger" style="margin-left: 12px;">Logout</a>
            <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
            <% } %>
        </nav>
    </div>
</header>

<div class="container" style="margin-top: 36px;">
    <div class="route-summary">
        <h2>
            <%= request.getAttribute("source") %> &rarr; <%= request.getAttribute("destination") %>
        </h2>
        <p><strong>Departure:</strong> <%= request.getAttribute("departDate") %></p>
    </div>

    <div style="display: flex; gap: 32px; flex-wrap: wrap;">
        <!-- Available Flights -->
        <div style="flex: 1; min-width: 350px;">
            <h2 class="section-title">Available Flights</h2>
            <%
                for(int i=1; i<=5; i++) {
            %>
            <div class="flight-item">
                <div class="flight-left">
                    <div class="flight-logo"></div>
                    <div>
                        <div class="airline-name">AirGo Airlines</div>
                        <div class="flight-no">AG1<%= i %></div>
                    </div>
                </div>
                <div class="flight-center">
                    <div class="timeblock">
                        <div class="city-name"><%= request.getAttribute("source") %></div>
                        <div class="time">09:0<%= i %> AM</div>
                        <div class="date"><%= request.getAttribute("departDate") %></div>
                    </div>
                    <div class="plane-icon">→</div>
                    <div class="timeblock">
                        <div class="city-name"><%= request.getAttribute("destination") %></div>
                        <div class="time">11:1<%= i %> AM</div>
                        <div class="date"><%= request.getAttribute("departDate") %></div>
                    </div>
                </div>
                <div class="flight-right">
                    <div class="price">₹3999</div>
                    <div class="per">per traveller</div>
                    <form action="bookFlight" method="post">
                        <input type="hidden" name="flightId" value="AG1<%= i %>">
                        <input type="hidden" name="travelDate" value="<%= request.getAttribute("departDate") %>">
                        <button type="submit" class="book-btn">Book</button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>

        <!-- Return Flights (only if round-trip and return date exists) -->
        <%
            String tripType = (String)request.getAttribute("tripType");
            String returnDate = (String)request.getAttribute("returnDate");
            if ("round-trip".equals(tripType) && returnDate != null && !returnDate.isEmpty()) {
        %>
        <div style="flex: 1; min-width: 350px;">
            <h2 class="section-title">Return Flights</h2>
            <%
                for(int i=1; i<=5; i++) {
            %>
            <div class="flight-item">
                <div class="flight-left">
                    <div class="flight-logo"></div>
                    <div>
                        <div class="airline-name">AirGo Airlines</div>
                        <div class="flight-no">AG2<%= i %></div>
                    </div>
                </div>
                <div class="flight-center">
                    <div class="timeblock">
                        <div class="city-name"><%= request.getAttribute("destination") %></div>
                        <div class="time">12:0<%= i %> PM</div>
                        <div class="date"><%= returnDate %></div>
                    </div>
                    <div class="plane-icon">→</div>
                    <div class="timeblock">
                        <div class="city-name"><%= request.getAttribute("source") %></div>
                        <div class="time">14:1<%= i %> PM</div>
                        <div class="date"><%= returnDate %></div>
                    </div>
                </div>
                <div class="flight-right">
                    <div class="price">₹3999</div>
                    <div class="per">per traveller</div>
                    <form action="bookFlight" method="post">
                        <input type="hidden" name="flightId" value="AG2<%= i %>">
                        <input type="hidden" name="travelDate" value="<%= returnDate %>">
                        <button type="submit" class="book-btn">Book</button>
                    </form>
                </div>
            </div>
            <% } %>
        </div>
        <% } %>
    </div>
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
            <a href="#">Contact Us</a>
        </div>
        <div class="col">
            <h5>Support</h5>
            <a href="#">Feedback</a>
            <a href="#">Terms &amp; Conditions</a>
            <a href="#">Privacy Policy</a>
        </div>
    </div>
</footer>

</body>
</html>
