package com.airgo.servlet;

import com.airgo.dao.FlightDAO;
import com.airgo.model.Flight;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/searchFlights")
public class FlightSearchServlet extends HttpServlet {
    private FlightDAO flightDAO = new FlightDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String tripType = request.getParameter("tripType");
        String source = request.getParameter("source");
        String destination = request.getParameter("destination");
        String departDate = request.getParameter("departDate");
        String returnDate = request.getParameter("returnDate");

        if (source == null || destination == null || source.equals(destination)) {
            response.sendRedirect("index.jsp?error=Invalid search parameters");
            return;
        }

        List<Flight> outboundFlights = flightDAO.searchFlights(source, destination);
        request.setAttribute("outboundFlights", outboundFlights);
        request.setAttribute("tripType", tripType);
        request.setAttribute("source", source);
        request.setAttribute("destination", destination);
        request.setAttribute("departDate", departDate);

        if ("round-trip".equals(tripType) && returnDate != null && !returnDate.isEmpty()) {
            List<Flight> returnFlights = flightDAO.searchFlights(destination, source);
            request.setAttribute("returnFlights", returnFlights);
            request.setAttribute("returnDate", returnDate);
        }

        request.getRequestDispatcher("flights.jsp").forward(request, response);
    }
}
