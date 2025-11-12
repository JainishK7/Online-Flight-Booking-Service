package com.airgo.servlet;

import com.airgo.dao.BookingDAO;
import com.airgo.model.Booking;
import com.airgo.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/myBookings")
public class MyBookingsServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        List<Booking> bookings = bookingDAO.getBookingsByUserId(user.getUserId());
        request.setAttribute("bookings", bookings);
        request.getRequestDispatcher("myBookings.jsp").forward(request, response);
    }
}
