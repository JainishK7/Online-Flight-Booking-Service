<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - AirGo</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="style.css">
</head>
<body>

<header class="navbar">
    <div class="navbar-container">
        <a href="index.jsp" class="logo">
            <span class="logo-icon">✈️</span>
            <span>AirGo</span>
        </a>
        <nav class="nav-links">
            <a href="login.jsp" style="color:#ff784b">Login</a>
            <a href="register.jsp">Register</a>
        </nav>
    </div>
</header>

<div class="center-content">
    <div class="auth-card">
        <div class="auth-header">
            <div class="avatar-icon">👤</div>
            <h2>Welcome Back</h2>
            <span class="muted">Login to your AirGo account</span>
        </div>

        <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger"><%= request.getParameter("error") %></div>
        <% } %>

        <form class="auth-form" method="post" action="login" autocomplete="off">
            <div class="form-group">
                <label class="form-label">Email Address</label>
                <div class="input-row">
                    <span class="input-ico">✉️</span>
                    <input type="email" class="form-control" name="email" placeholder="Enter your email" required />
                </div>
            </div>
            <div class="form-group">
                <label class="form-label">Password</label>
                <div class="input-row">
                    <span class="input-ico">🔒</span>
                    <input type="password" class="form-control" name="password" placeholder="Enter your password" required />
                </div>
            </div>
            <div class="form-group" style="margin-bottom:0;">
                <label>
                    <input type="checkbox" name="remember"/>
                    Remember me
                </label>
            </div>
            <button type="submit" class="primary-cta" style="margin-top:1rem;">
                <span style="font-size:1.2em;">🔑</span> Login
            </button>
        </form>
        <div class="links-row">
            <a href="#" class="muted" style="font-size:0.97em;">Forgot Password?</a>
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
            <a href="#">Terms & Conditions</a>
            <a href="#">Privacy Policy</a>
        </div>
    </div>
</footer>

<style>
    .center-content { display:flex; align-items:center; justify-content:center; min-height:70vh; }
    .auth-card { background:white; border-radius:22px; box-shadow:0 10px 30px rgba(0,0,0,0.10); max-width:380px; width:100%; padding:2.6rem 2.2rem 1.5rem 2.2rem;}
    .auth-header { text-align:center; margin-bottom:1.2rem;}
    .avatar-icon { font-size:3.7rem; margin-bottom:8px; opacity:.90; }
    .auth-header h2 { font-size:2.0rem; font-weight:900; letter-spacing:.02em;}
    .muted { display:block; color:#6b7280; margin-top:6px;}
    .input-row { display:flex; align-items:center; background:#f3f5f7; border-radius:8px; border:1.5px solid #e5e7eb; }
    .input-ico { font-size:1.20rem; width:2.2em;text-align:center;color:#888;}
    .input-row input { border:0; background:transparent; padding:10px; width:100%;}
    .input-row input:focus { outline:none; }
    .links-row { margin-top:1.2rem; text-align:center; }
    .auth-form .primary-cta { width:100%; margin-top:1rem;}
</style>
</body>
</html>
