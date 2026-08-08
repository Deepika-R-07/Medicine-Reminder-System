package com.medicine;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/UpdateMedicineServlet")
public class UpdateMedicineServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        String medicineName = request.getParameter("medicine_name");
        String dosage = request.getParameter("dosage");
        String reminderTime = request.getParameter("reminder_time");
        String startDate = request.getParameter("start_date");
        String endDate = request.getParameter("end_date");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                "UPDATE medicines SET medicine_name=?, dosage=?, reminder_time=?, start_date=?, end_date=? WHERE id=?");

            ps.setString(1, medicineName);
            ps.setString(2, dosage);
            ps.setString(3, reminderTime);
            ps.setString(4, startDate);
            ps.setString(5, endDate);
            ps.setInt(6, id);

            int result = ps.executeUpdate();

            ps.close();
            con.close();

            if(result > 0){
                response.sendRedirect("viewMedicine.jsp");
            }else{
                response.getWriter().println("Medicine update failed.");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error : " + e.getMessage());
        }
    }
}