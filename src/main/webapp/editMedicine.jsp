<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.medicine.DBConnection" %>

<%
String userName=(String)session.getAttribute("userName");

if(userName==null){
    response.sendRedirect("login.jsp");
    return;
}

int id=Integer.parseInt(request.getParameter("id"));

Connection con=DBConnection.getConnection();

PreparedStatement ps=con.prepareStatement(
"SELECT * FROM medicines WHERE id=?");

ps.setInt(1,id);

ResultSet rs=ps.executeQuery();

String medicineName="";
String dosage="";
String reminderTime="";
String startDate="";
String endDate="";

if(rs.next()){

    medicineName=rs.getString("medicine_name");
    dosage=rs.getString("dosage");

    reminderTime=rs.getString("reminder_time");
    if(reminderTime.length()>5)
        reminderTime=reminderTime.substring(0,5);

    startDate=rs.getString("start_date");
    endDate=rs.getString("end_date");
}

rs.close();
ps.close();
con.close();

%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Edit Medicine</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:"Segoe UI",sans-serif;
}

body{
background:#eef3f9;
}

/* Header */

.header{

background:#1565c0;
color:white;
padding:18px 50px;

display:flex;
justify-content:space-between;
align-items:center;

}

.header h2{

font-size:28px;

}

.nav a{

color:white;
text-decoration:none;
margin-left:25px;
font-weight:600;

}

.nav a:hover{

color:#ffeb3b;

}

/* Container */

.container{

width:600px;
margin:40px auto;

background:white;

padding:35px;

border-radius:15px;

box-shadow:0 10px 25px rgba(0,0,0,.12);

}

.container h1{

text-align:center;
color:#1565c0;
margin-bottom:30px;

}

/* Form */

.form-group{

margin-bottom:20px;

}

label{

display:block;
margin-bottom:8px;
font-weight:bold;

}

input{

width:100%;
padding:12px;
border:1px solid #ccc;
border-radius:8px;
font-size:15px;

}

input:focus{

outline:none;
border-color:#1565c0;

}

button{

width:100%;
padding:14px;

background:#1565c0;
color:white;

border:none;

border-radius:8px;

font-size:17px;

font-weight:bold;

cursor:pointer;

margin-top:15px;

}

button:hover{

background:#0d47a1;

}

.back{

margin-top:20px;
text-align:center;

}

.back a{

text-decoration:none;
color:#1565c0;
font-weight:bold;

}

.footer{

margin-top:40px;
text-align:center;
color:#777;
padding-bottom:20px;

}

</style>

</head>

<body>

<div class="header">

<h2>Medicine Reminder</h2>

<div class="nav">

<a href="DashboardServlet">Dashboard</a>

<a href="viewMedicine.jsp">Medicines</a>

<a href="TodayReminderServlet">Today's Reminder</a>

<a href="MedicineHistoryServlet">History</a>

<a href="LogoutServlet">Logout</a>

</div>

</div>

<div class="container">

<h1>Edit Medicine</h1>

<form action="UpdateMedicineServlet" method="post">

<input
type="hidden"
name="id"
value="<%=id%>">

<div class="form-group">

<label>Medicine Name</label>

<input
type="text"
name="medicine_name"
value="<%=medicineName%>"
required>

</div>

<div class="form-group">

<label>Dosage</label>

<input
type="text"
name="dosage"
value="<%=dosage%>"
required>

</div>

<div class="form-group">

<label>Reminder Time</label>

<input
type="time"
name="reminder_time"
value="<%=reminderTime%>"
required>

</div>

<div class="form-group">

<label>Start Date</label>

<input
type="date"
name="start_date"
value="<%=startDate%>"
required>

</div>

<div class="form-group">

<label>End Date</label>

<input
type="date"
name="end_date"
value="<%=endDate%>"
required>

</div>

<button type="submit">

Update Medicine

</button>

</form>

<div class="back">

<a href="viewMedicine.jsp">

Back to Medicine List

</a>

</div>

</div>

<div class="footer">

© 2026 Medicine Reminder System | AI Powered

</div>

</body>

</html>