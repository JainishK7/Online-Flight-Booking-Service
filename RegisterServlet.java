package com.airgo.servlet;

import com.airgo.dao.UserDAO;
import com.airgo.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");

        if (userDAO.emailExists(email)) {
            response.sendRedirect("register.jsp?error=Email already registered");
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setPassword(password);
        user.setEmail(email);
        user.setFullName(fullName);
        user.setPhone(phone);

        if (userDAO.registerUser(user)) {
            response.sendRedirect("login.jsp?msg=Registration successful! Please login.");
        } else {
            response.sendRedirect("register.jsp?error=Registration failed");
        }
    }
}
