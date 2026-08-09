package com.medicine;


import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;


@WebServlet("/AddMedicineServlet")

public class AddMedicineServlet extends HttpServlet {


private static final long serialVersionUID = 1L;



protected void doPost(HttpServletRequest request,
HttpServletResponse response)
throws ServletException, IOException {



HttpSession session=request.getSession();


int userId=(int)session.getAttribute("userId");



String medicineName=request.getParameter("medicine_name");

String dosage=request.getParameter("dosage");

String reminderTime=request.getParameter("reminder_time");

String startDate=request.getParameter("start_date");

String endDate=request.getParameter("end_date");



try{


Connection con=DBConnection.getConnection();



PreparedStatement ps=con.prepareStatement(

"INSERT INTO medicines(user_id,medicine_name,dosage,reminder_time,start_date,end_date) VALUES(?,?,?,?,?,?)"

);



ps.setInt(1,userId);

ps.setString(2,medicineName);

ps.setString(3,dosage);

ps.setString(4,reminderTime);

ps.setString(5,startDate);

ps.setString(6,endDate);



ps.executeUpdate();



response.sendRedirect("viewMedicine.jsp");



}

catch(Exception e){

e.printStackTrace();

}



}


}