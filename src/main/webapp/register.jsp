<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - AirGo</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="css/style.css">
</head>
<body>

<header class="navbar">
  <div class="navbar-container">
    <a href="index.jsp" class="logo">
      <span class="logo-icon">✈️</span>
      <span>AirGo</span>
    </a>
  </div>
</header>

<div class="center-content">
  <div class="auth-card">
    <div class="auth-header">
      <div class="avatar-icon">🧑‍💼</div>
      <h2>Create Account</h2>
      <span class="muted">Sign up for seamless flight booking</span>
    </div>

    <% if (request.getParameter("error") != null) { %>
    <div class="alert alert-danger"><%= request.getParameter("error") %></div>
    <% } %>

    <form class="auth-form" method="post" action="register" autocomplete="off" onsubmit="return validateRegistration()">
      <div class="form-group">
        <label class="form-label">Full Name *</label>
        <input type="text" class="form-control" name="fullName" placeholder="Your full name" required />
      </div>
      <div class="form-group">
        <label class="form-label">Username *</label>
        <input type="text" class="form-control" name="username" placeholder="e.g., jainish_k" required />
      </div>
      <div class="form-group">
        <label class="form-label">Email Address *</label>
        <input type="email" class="form-control" name="email" placeholder="you@example.com" required />
      </div>
      <div class="form-group">
        <label class="form-label">Mobile Number *</label>
        <input type="tel" class="form-control" name="phone" placeholder="10-digit mobile" required />
      </div>
      <div class="form-group">
        <label class="form-label">Password *</label>
        <input type="password" class="form-control" name="password" placeholder="Create a password" required />
        <span class="muted">Must be 8+ characters with uppercase, lowercase, number & special character</span>
      </div>
      <div class="form-group">
        <label class="form-label">Confirm Password *</label>
        <input type="password" class="form-control" name="confirmPassword" placeholder="Confirm your password" required />
      </div>
      <div class="form-group">
        <label class="form-label">Date of Birth *</label>
        <input type="date" class="form-control" name="dob" required />
      </div>
      <div class="form-group">
        <label class="form-label">Gender *</label>
        <select class="form-control" name="gender" required>
          <option value="">Select Gender</option>
          <option>Male</option>
          <option>Female</option>
          <option>Other</option>
        </select>
      </div>
      <div class="form-group" style="margin:12px 0;">
        <label>
          <input type="checkbox" name="terms" required />
          I agree to the <a href="#">Terms & Conditions</a>
        </label>
      </div>
      <button type="submit" class="primary-cta" style="margin-top:0.8rem;">
        <span style="font-size:1.2em;">👥</span> Create Account
      </button>
      <div class="links-row" style="margin-top:1.2rem;">
        Already have an account? <a href="login.jsp" style="color:#2563eb;">Login here</a>
      </div>
    </form>
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

<script>
  // Minimal form validation for registration
  function validateRegistration() {
    var form = document.forms[0];
    var phone = form.phone.value.trim();
    var pwd = form.password.value;
    var cpwd = form.confirmPassword.value;
    var email = form.email.value.trim();
    var dob = form.dob.value;
    var gender = form.gender.value;
    var name = form.fullName.value.trim();
    var user = form.username.value.trim();

    var errors = [];
    if (name.length < 3) errors.push("Enter your valid name.");
    if (user.length < 3) errors.push("Username is required.");
    if (!/^\d{10}$/.test(phone)) errors.push("Mobile must be 10 digits.");
    if (!dob) errors.push("Date of Birth is required.");
    if (!gender) errors.push("Select gender.");
    if (!/^[^@]+@[^@]+\.[^@]+$/.test(email)) errors.push("Enter a valid email address.");
    if (pwd.length < 8) errors.push("Password must be at least 8 characters.");
    if (pwd !== cpwd) errors.push("Passwords do not match.");
    if (!form.terms.checked) errors.push("You must accept Terms & Conditions.");
    if (errors.length) {
      alert("Please Enter Valid Data:\n\n" + errors.map(function(e, i){ return (i+1)+'. '+e; }).join('\n'));
      return false;
    }
    return true;
  }
</script>
<style>
  .center-content { display:flex; align-items:center; justify-content:center; min-height:70vh; }
  .auth-card { background:white; border-radius:22px; box-shadow:0 10px 30px rgba(0,0,0,0.10); max-width:420px; width:100%; padding:2.6rem 2.2rem 1.5rem 2.2rem;}
  .auth-header { text-align:center; margin-bottom:1.2rem;}
  .avatar-icon { font-size:3.7rem; margin-bottom:8px; opacity:.90; }
  .auth-header h2 { font-size:2.0rem; font-weight:900; letter-spacing:.02em;}
  .muted { display:block; color:#6b7280; margin-top:6px;}
  .links-row { margin-top:1.2rem; text-align:center; }
  .auth-form .primary-cta { width:100%; margin-top:1rem;}
</style>
</body>
</html>
