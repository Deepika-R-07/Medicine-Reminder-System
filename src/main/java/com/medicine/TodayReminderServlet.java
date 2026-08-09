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

@WebServlet("/TodayReminderServlet")
public class TodayReminderServlet extends HttpServlet {

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
            "SELECT * FROM medicines " +
            "WHERE user_id=? " +
            "AND CURDATE() BETWEEN start_date AND end_date " +
            "ORDER BY reminder_time";

            PreparedStatement ps=con.prepareStatement(sql);

            ps.setInt(1,userId);

            ResultSet rs=ps.executeQuery();

            request.setAttribute("medicineList", rs);

            request.getRequestDispatcher("todayReminder.jsp")
                   .forward(request,response);

            con.close();

        }catch(Exception e){
            e.printStackTrace();
        }

    }

}