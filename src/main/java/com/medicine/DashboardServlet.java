package com.medicine;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/DashboardServlet")
public class DashboardServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try (Connection con = DBConnection.getConnection()) {

            int totalMedicines = 0;
            int activeMedicines = 0;
            int todayMedicines = 0;
            int takenToday = 0;
            int missedToday = 0;
            int completion = 0;

            // Total Medicines
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM medicines WHERE user_id=?")) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        totalMedicines = rs.getInt(1);
                    }
                }
            }

            // Active Medicines
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM medicines WHERE user_id=? AND CURDATE() BETWEEN start_date AND end_date")) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        activeMedicines = rs.getInt(1);
                    }
                }
            }

            // Today's Medicines
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM medicines WHERE user_id=? AND CURDATE() BETWEEN start_date AND end_date")) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        todayMedicines = rs.getInt(1);
                    }
                }
            }

            // Taken Today
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM medicine_history WHERE user_id=? AND status='Taken' AND DATE(taken_time)=CURDATE()")) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        takenToday = rs.getInt(1);
                    }
                }
            }

            // Missed Today
            try (PreparedStatement ps = con.prepareStatement(
                    "SELECT COUNT(*) FROM medicine_history WHERE user_id=? AND status='Missed' AND DATE(taken_time)=CURDATE()")) {

                ps.setInt(1, userId);

                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        missedToday = rs.getInt(1);
                    }
                }
            }

            if (todayMedicines > 0) {
                completion = (takenToday * 100) / todayMedicines;
            }

            request.setAttribute("totalMedicines", totalMedicines);
            request.setAttribute("activeMedicines", activeMedicines);
            request.setAttribute("todayMedicines", todayMedicines);
            request.setAttribute("takenToday", takenToday);
            request.setAttribute("missedToday", missedToday);
            request.setAttribute("completion", completion);

            request.getRequestDispatcher("dashboard.jsp")
                    .forward(request, response);

        } catch (Exception e) {

            e.printStackTrace();

            request.setAttribute("error", e.getMessage());

            request.getRequestDispatcher("dashboard.jsp")
                    .forward(request, response);
        }
    }
}