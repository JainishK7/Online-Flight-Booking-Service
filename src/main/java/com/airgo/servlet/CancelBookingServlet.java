package com.airgo.servlet;

import com.airgo.dao.BookingDAO;
import com.airgo.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/cancelBooking")
public class CancelBookingServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        int bookingId = Integer.parseInt(request.getParameter("bookingId"));

        if (bookingDAO.cancelBooking(bookingId, user.getUserId())) {
            response.sendRedirect("myBookings?msg=Booking cancelled successfully");
        } else {
            response.sendRedirect("myBookings?error=Cancellation failed");
        }
    }
}
