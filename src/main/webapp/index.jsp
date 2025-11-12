<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.airgo.model.User" %>
<%
    // Auto-login as Jainish Kakkad only on first visit or when not logged in
    User user = (User) session.getAttribute("user");
    if (user == null) {
        user = new User();
        user.setUserId(1);
        user.setUsername("jainishk");
        user.setFullName("Jainish Kakkad");
        user.setEmail("jainish.kakkad@email.com");
        session.setAttribute("user", user);
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>AirGo - Book Your Flight</title>
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="css/style.css" />
</head>
<body>
<header class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="logo">
            <span class="logo-icon">✈️</span>
            <span>AirGo</span>
        </a>
        <nav class="nav-links">
            <a href="index.jsp" class="active">Flights</a>
            <% if (user != null) { %>
            <a href="myBookings.jsp" class="btn btn-primary">My Bookings</a>
            <span style="color:#38bdf8;font-weight:700;margin-left:14px;">
                    Hello, <%= user.getFullName() %>
                </span>
            <a href="logout.jsp" class="btn btn-danger" style="margin-left:12px;">Logout</a>
            <% } else { %>
            <a href="login.jsp">Login</a>
            <a href="register.jsp">Register</a>
            <% } %>
        </nav>
    </div>
</header>

<div class="hero">
    <div class="hero-overlay">
        <h1>Book Your Flight With Ease</h1>
        <p>Find the best deals on flights to your favorite destinations. Travel smart with AirGo.</p>
        <a href="#destinations" class="primary-btn">Explore Destinations</a>
    </div>
</div>

<div class="search-card-wrap">
    <section class="search-card">
        <div class="search-head">
            <span class="search-icon">🔎</span>
            <h2>Find Your Perfect Flight</h2>
        </div>
        <form method="post" action="searchFlights">
            <div class="form-grid">
                <div class="form-group">
                    <label class="form-label">Trip Type</label>
                    <select class="form-control" name="tripType" required>
                        <option value="round-trip">Round Trip</option>
                        <option value="one-way">One Way</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">From</label>
                    <select class="form-control" name="source" required>
                        <option>Departure City</option>
                        <option>Mumbai</option>
                        <option>Pune</option>
                        <option>Delhi</option>
                        <option>Bangalore</option>
                        <option>Ahmedabad</option>
                        <option>Hyderabad</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">To</label>
                    <select class="form-control" name="destination" required>
                        <option>Arrival City</option>
                        <option>Mumbai</option>
                        <option>Pune</option>
                        <option>Delhi</option>
                        <option>Bangalore</option>
                        <option>Ahmedabad</option>
                        <option>Hyderabad</option>
                    </select>
                </div>
                <div class="form-group">
                    <label class="form-label">Departure Date</label>
                    <input class="form-control" type="date" name="departDate" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Return Date</label>
                    <input class="form-control" type="date" name="returnDate">
                </div>
                <div class="form-group">
                    <label class="form-label">Passengers</label>
                    <input class="form-control" type="number" min="1" max="9" name="passengers" value="1" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Class</label>
                    <select class="form-control" name="class" required>
                        <option>Economy</option>
                        <option>Business</option>
                        <option>First</option>
                    </select>
                </div>
                <div class="form-submit">
                    <button class="search-btn" type="submit">🔎 Search Flights</button>
                </div>
            </div>
        </form>
    </section>
</div>

<div class="features-block">
    <h2>Why Choose AirGo?</h2>
    <div class="features-grid">
        <div class="feature-card">
            <div class="feat-ico">💸</div>
            <h3>Best Price Guarantee</h3>
            <p>We offer the lowest fares for your journeys, every time.</p>
        </div>
        <div class="feature-card">
            <div class="feat-ico">⏱️</div>
            <h3>Instant Booking</h3>
            <p>Book flights instantly and receive e-tickets right in your inbox.</p>
        </div>
        <div class="feature-card">
            <div class="feat-ico">☎️</div>
            <h3>24/7 Support</h3>
            <p>Get support at any time from our enthusiastic team of travel experts.</p>
        </div>
        <div class="feature-card">
            <div class="feat-ico">🛡️</div>
            <h3>Flexible Booking</h3>
            <p>Easy cancellations and changes with full transparency—no hidden fees.</p>
        </div>
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
