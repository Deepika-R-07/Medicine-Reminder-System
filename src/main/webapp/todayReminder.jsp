<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<%@ page import="com.medicine.DBConnection"%>

<%
Integer userId=(Integer)session.getAttribute("userId");

if(userId==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Today's Reminder</title>

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

.container{
width:90%;
margin:40px auto;
background:white;
padding:30px;
border-radius:12px;
box-shadow:0 5px 15px rgba(0,0,0,.15);
}

h1{
text-align:center;
color:#1565c0;
margin-bottom:25px;
}

table{
width:100%;
border-collapse:collapse;
}

th{
background:#1565c0;
color:white;
padding:14px;
}

td{
padding:14px;
text-align:center;
border-bottom:1px solid #ddd;
}

tr:hover{
background:#f7f7f7;
}

.takeBtn{

padding:8px 15px;
background:#28a745;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
font-weight:bold;
margin-right:5px;

}

.takeBtn:hover{

background:#218838;

}

.missBtn{

padding:8px 15px;
background:#dc3545;
color:white;
border:none;
border-radius:5px;
cursor:pointer;
font-weight:bold;

}

.missBtn:hover{

background:#c82333;

}

.back{

display:inline-block;
margin-top:25px;
padding:12px 22px;
background:#1565c0;
color:white;
text-decoration:none;
border-radius:6px;
font-weight:bold;

}

.back:hover{

background:#0d47a1;

}

</style>

</head>

<body>

<div class="container">

<h1>Today's Medicine Reminder</h1>

<table>

<tr>

<th>Medicine</th>
<th>Dosage</th>
<th>Reminder Time</th>
<th>Action</th>

</tr>

<%

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

con=DBConnection.getConnection();

String sql=

"SELECT * FROM medicines " +
"WHERE user_id=? " +
"AND CURDATE() BETWEEN start_date AND end_date " +
"ORDER BY reminder_time";

ps=con.prepareStatement(sql);

ps.setInt(1,userId);

rs=ps.executeQuery();

boolean found=false;

while(rs.next()){

found=true;

%>

<tr>

<td>

<%=rs.getString("medicine_name")%>

</td>

<td>

<%=rs.getString("dosage")%>

</td>

<td>

<%=rs.getTime("reminder_time")%>

</td>

<td>

<form action="MedicineStatusServlet" method="post">

<input type="hidden"
name="medicineId"
value="<%=rs.getInt("id")%>">

<button
type="submit"
name="status"
value="Taken"
class="takeBtn">

Take Medicine

</button>

<button
type="submit"
name="status"
value="Missed"
class="missBtn">

Miss Dose

</button>

</form>

</td>

</tr>

<%

}

if(!found){

%>

<tr>

<td colspan="4">

No medicines scheduled for today.

</td>

</tr>

<%

}

}catch(Exception e){

%>

<tr>

<td colspan="4">

<%=e.getMessage()%>

</td>

</tr>

<%

}finally{

try{
if(rs!=null)rs.close();
}catch(Exception e){}

try{
if(ps!=null)ps.close();
}catch(Exception e){}

try{
if(con!=null)con.close();
}catch(Exception e){}

}

%>

</table>

<a href="DashboardServlet" class="back">

Back to Dashboard

</a>

</div>

</body>

</html>