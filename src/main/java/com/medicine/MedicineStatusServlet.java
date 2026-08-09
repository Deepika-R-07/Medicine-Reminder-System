
package com.medicine;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/MedicineStatusServlet")
public class MedicineStatusServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        int medicineId = Integer.parseInt(request.getParameter("medicineId"));

        String status = request.getParameter("status");

        try {

            Connection con = DBConnection.getConnection();

            String sql =
                    "INSERT INTO medicine_history "
                  + "(medicine_id,user_id,status,taken_time) "
                  + "VALUES(?,?,?,NOW())";

            PreparedStatement ps = con.prepareStatement(sql);

            ps.setInt(1, medicineId);
            ps.setInt(2, userId);
            ps.setString(3, status);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("TodayReminderServlet");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println("Error : " + e.getMessage());
        }

    }
}