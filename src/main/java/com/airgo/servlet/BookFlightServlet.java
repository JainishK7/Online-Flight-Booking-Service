package com.airgo.servlet;

import com.airgo.dao.BookingDAO;
import com.airgo.dao.FlightDAO;
import com.airgo.model.Booking;
import com.airgo.model.Flight;
import com.airgo.model.User;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;

@WebServlet("/bookFlight")
public class BookFlightServlet extends HttpServlet {
    private BookingDAO bookingDAO = new BookingDAO();
    private FlightDAO flightDAO = new FlightDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        User user = (User) session.getAttribute("user");

        if (user == null) {
            response.sendRedirect("login.jsp?error=Please login first");
            return;
        }

        int flightId = Integer.parseInt(request.getParameter("flightId"));
        String travelDate = request.getParameter("travelDate");
        String passengerName = request.getParameter("passengerName");
        String passengerEmail = request.getParameter("passengerEmail");
        String passengerPhone = request.getParameter("passengerPhone");
        int seats = Integer.parseInt(request.getParameter("seats"));

        Flight flight = flightDAO.getFlightById(flightId);
        if (flight == null || flight.getSeatsAvailable() < seats) {
            response.sendRedirect("index.jsp?error=Flight not available");
            return;
        }

        BigDecimal totalPrice = flight.getPrice().multiply(new BigDecimal(seats));

        Booking booking = new Booking();
        booking.setBookingReference(bookingDAO.generateBookingReference());
        booking.setUserId(user.getUserId());
        booking.setFlightId(flightId);
        booking.setPassengerName(passengerName);
        booking.setPassengerEmail(passengerEmail);
        booking.setPassengerPhone(passengerPhone);
        booking.setTravelDate(travelDate);
        booking.setSeatsBooked(seats);


        if (flightDAO.updateSeats(flightId, seats) && bookingDAO.createBooking(booking)) {
            response.sendRedirect("myBookings?msg=Booking confirmed! Reference: " + booking.getBookingReference());
        } else {
            response.sendRedirect("booking.jsp?flightId=" + flightId + "&travelDate=" + travelDate + "&error=Booking failed");
        }
    }
}
