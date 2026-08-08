package com.medicine;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/DeleteMedicineServlet")
public class DeleteMedicineServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        int id = Integer.parseInt(request.getParameter("id"));

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "DELETE FROM medicines WHERE id=?");

            ps.setInt(1, id);

            ps.executeUpdate();

            ps.close();
            con.close();

            response.sendRedirect("viewMedicine.jsp");

        } catch (Exception e) {

            e.printStackTrace();

            response.getWriter().println("Error : " + e.getMessage());
        }
    }
}