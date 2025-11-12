package com.airgo.dao;

import com.airgo.model.Booking;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    /**
     * Get database connection
     */
    private Connection getConnection() throws SQLException {
        // Update with your database credentials
        return DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/AirGoDB",
                "root",
                "yourpassword"
        );
    }

    /**
     * Generate a unique booking reference
     */
    public String generateBookingReference() {
        return "AG" + System.currentTimeMillis() + (int)(Math.random() * 1000);
    }

    /**
     * Get all bookings for a specific user with flight details
     */
    public List<Booking> getBookingsByUserId(int userId) {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.bookingId, b.bookingReference, b.userId, b.flightId, " +
                "b.passengerName, b.passengerEmail, b.passengerPhone, " +
                "b.travelDate, b.seatsBooked, b.totalPrice, b.bookingStatus, " +
                "f.flightNumber " +
                "FROM Bookings b " +
                "JOIN Flights f ON b.flightId = f.flightId " +
                "WHERE b.userId = ? " +
                "ORDER BY b.bookingDate DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Booking booking = new Booking();
                    booking.setBookingId(rs.getInt("bookingId"));
                    booking.setBookingReference(rs.getString("bookingReference"));
                    booking.setUserId(rs.getInt("userId"));
                    booking.setFlightId(rs.getInt("flightId"));
                    booking.setPassengerName(rs.getString("passengerName"));
                    booking.setPassengerEmail(rs.getString("passengerEmail"));
                    booking.setPassengerPhone(rs.getString("passengerPhone"));
                    booking.setTravelDate(rs.getString("travelDate"));
                    booking.setSeatsBooked(rs.getInt("seatsBooked"));

                    // Handle BigDecimal to double conversion
                    booking.setTotalPrice(rs.getBigDecimal("totalPrice").doubleValue());

                    booking.setBookingStatus(rs.getString("bookingStatus"));
                    booking.setFlightNumber(rs.getString("flightNumber"));
                    bookings.add(booking);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }

    /**
     * Create a new booking
     */
    public boolean createBooking(Booking booking) {
        String sql = "INSERT INTO Bookings (bookingReference, userId, flightId, passengerName, " +
                "passengerEmail, passengerPhone, travelDate, seatsBooked, totalPrice, " +
                "bookingStatus, bookingDate) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW())";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, booking.getBookingReference());
            pstmt.setInt(2, booking.getUserId());
            pstmt.setInt(3, booking.getFlightId());
            pstmt.setString(4, booking.getPassengerName());
            pstmt.setString(5, booking.getPassengerEmail());
            pstmt.setString(6, booking.getPassengerPhone());
            pstmt.setString(7, booking.getTravelDate());
            pstmt.setInt(8, booking.getSeatsBooked());
            pstmt.setDouble(9, booking.getTotalPrice());
            pstmt.setString(10, booking.getBookingStatus());

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get a single booking by reference
     */
    public Booking getBookingByReference(String bookingReference) {
        String sql = "SELECT b.*, f.flightNumber " +
                "FROM Bookings b " +
                "JOIN Flights f ON b.flightId = f.flightId " +
                "WHERE b.bookingReference = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, bookingReference);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("bookingId"));
                booking.setBookingReference(rs.getString("bookingReference"));
                booking.setUserId(rs.getInt("userId"));
                booking.setFlightId(rs.getInt("flightId"));
                booking.setPassengerName(rs.getString("passengerName"));
                booking.setPassengerEmail(rs.getString("passengerEmail"));
                booking.setPassengerPhone(rs.getString("passengerPhone"));
                booking.setTravelDate(rs.getString("travelDate"));
                booking.setSeatsBooked(rs.getInt("seatsBooked"));
                booking.setTotalPrice(rs.getBigDecimal("totalPrice").doubleValue());
                booking.setBookingStatus(rs.getString("bookingStatus"));
                booking.setFlightNumber(rs.getString("flightNumber"));
                return booking;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    /**
     * Cancel a booking by reference
     */
    public boolean cancelBooking(int userId, int bookingId) {
        String sql = "UPDATE Bookings SET bookingStatus = 'CANCELLED' " +
                "WHERE userId = ? AND bookingId = ?";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            pstmt.setInt(2, bookingId);
            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Get all bookings (for admin)
     */
    public List<Booking> getAllBookings() {
        List<Booking> bookings = new ArrayList<>();
        String sql = "SELECT b.*, f.flightNumber " +
                "FROM Bookings b " +
                "JOIN Flights f ON b.flightId = f.flightId " +
                "ORDER BY b.bookingDate DESC";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Booking booking = new Booking();
                booking.setBookingId(rs.getInt("bookingId"));
                booking.setBookingReference(rs.getString("bookingReference"));
                booking.setUserId(rs.getInt("userId"));
                booking.setFlightId(rs.getInt("flightId"));
                booking.setPassengerName(rs.getString("passengerName"));
                booking.setPassengerEmail(rs.getString("passengerEmail"));
                booking.setPassengerPhone(rs.getString("passengerPhone"));
                booking.setTravelDate(rs.getString("travelDate"));
                booking.setSeatsBooked(rs.getInt("seatsBooked"));
                booking.setTotalPrice(rs.getBigDecimal("totalPrice").doubleValue());
                booking.setBookingStatus(rs.getString("bookingStatus"));
                booking.setFlightNumber(rs.getString("flightNumber"));
                bookings.add(booking);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookings;
    }
}
