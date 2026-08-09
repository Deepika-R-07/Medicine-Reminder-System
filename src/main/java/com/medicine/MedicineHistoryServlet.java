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

@WebServlet("/MedicineHistoryServlet")
public class MedicineHistoryServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session==null || session.getAttribute("userId")==null){
            response.sendRedirect("login.jsp");
            return;
        }

        int userId=(Integer)session.getAttribute("userId");

        try{

            Connection con=DBConnection.getConnection();

            String sql=
            "SELECT m.medicine_name,h.status,h.taken_time " +
            "FROM medicine_history h " +
            "JOIN medicines m ON h.medicine_id=m.id " +
            "WHERE h.user_id=? " +
            "ORDER BY h.taken_time DESC";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            request.setAttribute("history", rs);

            request.getRequestDispatcher("medicineHistory.jsp")
                   .forward(request,response);

            con.close();

        }catch(Exception e){
            e.printStackTrace();
        }

    }

}
