package com.airgo.dao;

import com.airgo.model.Flight;
import com.airgo.util.DBConnectionUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class FlightDAO {

    public List<Flight> searchFlights(String source, String destination) {
        List<Flight> flights = new ArrayList<>();
        String sql = "SELECT * FROM Flights WHERE source = ? AND destination = ? AND seatsAvailable > 0";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, source);
            stmt.setString(2, destination);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                flights.add(mapFlight(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return flights;
    }

    public Flight getFlightById(int flightId) {
        String sql = "SELECT * FROM Flights WHERE flightId = ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, flightId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return mapFlight(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<String> getAllCities() {
        List<String> cities = new ArrayList<>();
        String sql = "SELECT DISTINCT source FROM Flights UNION SELECT DISTINCT destination FROM Flights";
        try (Connection conn = DBConnectionUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            while (rs.next()) {
                cities.add(rs.getString(1));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cities;
    }

    public boolean updateSeats(int flightId, int seatsBooked) {
        String sql = "UPDATE Flights SET seatsAvailable = seatsAvailable - ? WHERE flightId = ? AND seatsAvailable >= ?";
        try (Connection conn = DBConnectionUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, seatsBooked);
            stmt.setInt(2, flightId);
            stmt.setInt(3, seatsBooked);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private Flight mapFlight(ResultSet rs) throws SQLException {
        Flight flight = new Flight();
        flight.setFlightId(rs.getInt("flightId"));
        flight.setFlightNumber(rs.getString("flightNumber"));
        flight.setAirline(rs.getString("airline"));
        flight.setSource(rs.getString("source"));
        flight.setDestination(rs.getString("destination"));
        flight.setDepartureTime(rs.getString("departureTime"));
        flight.setArrivalTime(rs.getString("arrivalTime"));
        flight.setDuration(rs.getString("duration"));
        flight.setPrice(rs.getBigDecimal("price"));
        flight.setSeatsAvailable(rs.getInt("seatsAvailable"));
        flight.setTotalSeats(rs.getInt("totalSeats"));
        return flight;
    }
}
