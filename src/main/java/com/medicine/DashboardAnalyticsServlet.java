package com.medicine;

import java.io.IOException;
import java.sql.*;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/DashboardAnalyticsServlet")
public class DashboardAnalyticsServlet extends HttpServlet {

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

            Statement st;

            ResultSet rs;

            int totalMedicines=0;
            int todayMedicines=0;
            int takenToday=0;
            int missedToday=0;
            int activeMedicines=0;

            // Total Medicines
            PreparedStatement ps1=con.prepareStatement(
            "SELECT COUNT(*) FROM medicines WHERE user_id=?");
            ps1.setInt(1,userId);
            rs=ps1.executeQuery();
            if(rs.next())
                totalMedicines=rs.getInt(1);

            // Today's Medicines
            PreparedStatement ps2=con.prepareStatement(
            "SELECT COUNT(*) FROM medicines WHERE user_id=? AND CURDATE() BETWEEN start_date AND end_date");
            ps2.setInt(1,userId);
            rs=ps2.executeQuery();
            if(rs.next())
                todayMedicines=rs.getInt(1);

            // Taken Today
            PreparedStatement ps3=con.prepareStatement(
            "SELECT COUNT(*) FROM medicine_history WHERE user_id=? AND status='Taken' AND DATE(taken_time)=CURDATE()");
            ps3.setInt(1,userId);
            rs=ps3.executeQuery();
            if(rs.next())
                takenToday=rs.getInt(1);

            // Missed Today
            PreparedStatement ps4=con.prepareStatement(
            "SELECT COUNT(*) FROM medicine_history WHERE user_id=? AND status='Missed' AND DATE(taken_time)=CURDATE()");
            ps4.setInt(1,userId);
            rs=ps4.executeQuery();
            if(rs.next())
                missedToday=rs.getInt(1);

            // Active Medicines
            PreparedStatement ps5=con.prepareStatement(
            "SELECT COUNT(*) FROM medicines WHERE user_id=? AND end_date>=CURDATE()");
            ps5.setInt(1,userId);
            rs=ps5.executeQuery();
            if(rs.next())
                activeMedicines=rs.getInt(1);

            int completion=0;

            if(todayMedicines!=0)
                completion=(takenToday*100)/todayMedicines;

            request.setAttribute("totalMedicines",totalMedicines);
            request.setAttribute("todayMedicines",todayMedicines);
            request.setAttribute("takenToday",takenToday);
            request.setAttribute("missedToday",missedToday);
            request.setAttribute("activeMedicines",activeMedicines);
            request.setAttribute("completion",completion);

            request.getRequestDispatcher("dashboard.jsp")
                   .forward(request,response);

            con.close();

        }
        catch(Exception e){
            e.printStackTrace();
        }

    }

}