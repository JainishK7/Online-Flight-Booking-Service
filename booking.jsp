<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.airgo.model.User" %>
<%@ page import="com.airgo.model.Flight" %>
<%@ page import="com.airgo.dao.FlightDAO" %>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp?error=Please login first");
        return;
    }

    String flightIdParam = request.getParameter("flightId");
    String travelDate = request.getParameter("travelDate");
    if (flightIdParam == null || travelDate == null) {
        response.sendRedirect("index.jsp?error=Missing flight details");
        return;
    }

    int flightId = Integer.parseInt(flightIdParam);
    FlightDAO flightDAO = new FlightDAO();
    Flight flight = flightDAO.getFlightById(flightId);
    if (flight == null) {
        response.sendRedirect("index.jsp?error=Flight not found");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Flight Booking - AirGo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="logo"><span class="logo-icon">✈️</span><span>AirGo</span></a>
        <nav class="nav-links">
            <a href="index.jsp">Flights</a>
            <a href="myBookings">My Bookings</a>
            <span style="color:#3b82f6;">Hello, <%= user.getUsername() %></span>
            <a href="logout" class="btn btn-danger">Logout</a>
        </nav>
    </div>
</header>

<section class="container" style="margin-top:2rem;">
    <!-- Gradient flight banner -->
    <div class="booking-banner">
        <div class="banner-left">
            <div class="banner-route">
                <span><%= flight.getSource() %></span>
                <span class="arrow">→</span>
                <span><%= flight.getDestination() %></span>
            </div>
            <div class="banner-meta">
                <span><%= flight.getDepartureTime() %></span>
                <span>•</span>
                <span><%= flight.getDuration() %></span>
                <span>•</span>
                <span><%= flight.getArrivalTime() %></span>
            </div>
            <div class="banner-sub">
                <%= flight.getAirline() %> - <%= flight.getFlightNumber() %> | <%= travelDate %>
            </div>
        </div>
        <div class="banner-right">
            <div class="pp">per person</div>
            <div class="banner-price">₹<%= String.format("%.0f", flight.getPrice()) %></div>
        </div>
    </div>

    <div class="booking-layout">
        <!-- Traveler details card -->
        <div class="booking-card">
            <h3 class="card-title"><span class="ico">👥</span> Traveler Details</h3>

            <form method="post" action="bookFlight" onsubmit="return validateBookingForm()" id="bookingForm">
                <input type="hidden" name="flightId" value="<%= flight.getFlightId() %>">
                <input type="hidden" name="travelDate" value="<%= travelDate %>">

                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Passenger Name</label>
                        <input class="form-control" type="text" name="passengerName" value="<%= user.getFullName() %>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Phone</label>
                        <input class="form-control" type="tel" name="passengerPhone" value="<%= user.getPhone() %>" required>
                    </div>
                </div>

                <div class="grid-2">
                    <div class="form-group">
                        <label class="form-label">Email</label>
                        <input class="form-control" type="email" name="passengerEmail" value="<%= user.getEmail() %>" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label">Seats</label>
                        <input class="form-control" type="number" name="seats" id="seats" min="1" max="<%= flight.getSeatsAvailable() %>" value="1" required>
                        <small class="muted">Available: <%= flight.getSeatsAvailable() %></small>
                    </div>
                </div>

                <div class="extras">
                    <h4 class="extras-title">Enhance Your Journey</h4>
                    <label class="check-row">
                        <input type="checkbox" id="meal"> <span>Pre-book Meal</span> <span class="extra-amt">+₹500</span>
                    </label>
                    <label class="check-row">
                        <input type="checkbox" id="baggage"> <span>Extra Baggage (15kg)</span> <span class="extra-amt">+₹1000</span>
                    </label>
                    <label class="check-row">
                        <input type="checkbox" id="insurance"> <span>Travel Insurance</span> <span class="extra-amt">+₹199</span>
                    </label>
                    <label class="check-row">
                        <input type="checkbox" id="seatSel"> <span>Seat Selection</span> <span class="extra-amt">+₹300</span>
                    </label>
                </div>

                <button type="submit" class="primary-cta">Proceed to Payment</button>
            </form>
        </div>

        <!-- Fare breakdown card -->
        <aside class="fare-card">
            <h3 class="card-title"><span class="ico">🏷️</span> Fare Breakdown</h3>
            <ul class="fare-list">
                <li><span>Base Fare (1 Adult)</span><span>₹<%= String.format("%.0f", flight.getPrice()) %></span></li>
                <li><span>Taxes & Fees</span><span>₹1014</span></li>
                <li><span>Meal</span><span>₹500</span></li>
                <li><span>Extra Baggage</span><span>₹1000</span></li>
                <li><span>Travel Insurance</span><span>₹199</span></li>
                <li><span>Seat Selection</span><span>₹300</span></li>
            </ul>
            <div class="fare-total">
                <div>Total Amount</div>
                <div id="totalAmount">₹<%= String.format("%.0f", flight.getPrice()) %></div>
            </div>

            <div class="guarantees">
                <div class="pill pill-green">✔ Free cancellation within 24 hours</div>
                <div class="pill pill-blue">🔒 Secure payment gateway</div>
            </div>
        </aside>
    </div>
</section>

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
            <a href="#">Terms & Conditions</a>
            <a href="#">Privacy Policy</a>
        </div>
    </div>
</footer>

<script>
    (function(){
        var base = <%= (long)Math.round(flight.getPrice()) %>;
        var meal = document.getElementById('meal');
        var bag = document.getElementById('baggage');
        var ins = document.getElementById('insurance');
        var seat = document.getElementById('seatSel');
        var seats = document.getElementById('seats');
        var out = document.getElementById('totalAmount');

        function recalc(){
            var extras = 0;
            if(meal.checked) extras += 500;
            if(bag.checked) extras += 1000;
            if(ins.checked) extras += 199;
            if(seat.checked) extras += 300;
            var n = parseInt(seats.value || '1', 10);
            var total = (base + extras) * (isNaN(n)?1:n);
            out.textContent = '₹' + total.toFixed(0);
        }
        [meal, bag, ins, seat, seats].forEach(function(el){
            if (el) el.addEventListener('change', recalc);
        });
        recalc();
    })();

    function validateBookingForm() {
        var name = document.querySelector('input[name="passengerName"]').value.trim();
        var email = document.querySelector('input[name="passengerEmail"]').value.trim();
        var phone = document.querySelector('input[name="passengerPhone"]').value.trim();
        var seats = parseInt(document.getElementById('seats').value || '1', 10);

        if (name.length < 3) { alert('Enter a valid passenger name'); return false; }
        if (!email.includes('@')) { alert('Enter a valid email'); return false; }
        if (phone.length < 10) { alert('Enter a valid phone number'); return false; }
        if (seats < 1 || seats > <%= flight.getSeatsAvailable() %>) { alert('Invalid seats count'); return false; }
        return true;
    }
</script>

</body>
</html>
