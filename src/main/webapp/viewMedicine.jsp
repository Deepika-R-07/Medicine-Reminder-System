<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.medicine.DBConnection" %>

<%
String userName=(String)session.getAttribute("userName");
Integer userId=(Integer)session.getAttribute("userId");

if(userName==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>View Medicines</title>

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

width:95%;
margin:40px auto;

background:white;

padding:30px;

border-radius:15px;

box-shadow:0 10px 25px rgba(0,0,0,.12);

}

.container h1{

text-align:center;
margin-bottom:25px;
color:#1565c0;

}

/* Search */

.search{

margin-bottom:25px;
text-align:right;

}

.search input{

padding:10px;
width:280px;
border:1px solid #ccc;
border-radius:6px;

}

/* Table */

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

background:#f5f5f5;

}

/* Buttons */

.edit{

background:#28a745;
color:white;

padding:8px 15px;

text-decoration:none;

border-radius:5px;

margin-right:8px;

}

.edit:hover{

background:#1f8b38;

}

.delete{

background:#dc3545;
color:white;

padding:8px 15px;

text-decoration:none;

border-radius:5px;

}

.delete:hover{

background:#b52a37;

}

.back{

margin-top:25px;
text-align:center;

}

.back a{

background:#1565c0;
color:white;

padding:12px 25px;

text-decoration:none;

border-radius:6px;

}

.back a:hover{

background:#0d47a1;

}

.footer{

margin-top:40px;
text-align:center;
color:#777;
padding-bottom:20px;

}

</style>

<script>

function searchMedicine(){

var input=document.getElementById("search").value.toUpperCase();

var table=document.getElementById("medicineTable");

var tr=table.getElementsByTagName("tr");

for(var i=1;i<tr.length;i++){

var td=tr[i].getElementsByTagName("td")[0];

if(td){

var txt=td.textContent||td.innerText;

if(txt.toUpperCase().indexOf(input)>-1){

tr[i].style.display="";

}else{

tr[i].style.display="none";

}

}

}

}

</script>

</head>

<body>

<div class="header">

<h2>Medicine Reminder</h2>

<div class="nav">

<a href="DashboardServlet">Dashboard</a>

<a href="addMedicine.jsp">Add Medicine</a>

<a href="TodayReminderServlet">Today's Reminder</a>

<a href="MedicineHistoryServlet">History</a>

<a href="LogoutServlet">Logout</a>

</div>

</div>

<div class="container">

<h1>Your Medicines</h1>

<div class="search">

<input

type="text"

id="search"

placeholder="Search Medicine..."

onkeyup="searchMedicine()">

</div>

<table id="medicineTable">

<tr>

<th>Medicine</th>

<th>Dosage</th>

<th>Reminder</th>

<th>Start Date</th>

<th>End Date</th>

<th>Action</th>

</tr>

<%

Connection con=null;
PreparedStatement ps=null;
ResultSet rs=null;

try{

con=DBConnection.getConnection();

ps=con.prepareStatement(

"SELECT * FROM medicines WHERE user_id=? ORDER BY reminder_time");

ps.setInt(1,userId);

rs=ps.executeQuery();

boolean found=false;

while(rs.next()){

found=true;

%>

<tr>

<td><%=rs.getString("medicine_name")%></td>

<td><%=rs.getString("dosage")%></td>

<td><%=rs.getString("reminder_time")%></td>

<td><%=rs.getDate("start_date")%></td>

<td><%=rs.getDate("end_date")%></td>

<td>

<a

class="edit"

href="editMedicine.jsp?id=<%=rs.getInt("id")%>">

Edit

</a>

<a

class="delete"

href="DeleteMedicineServlet?id=<%=rs.getInt("id")%>"

onclick="return confirm('Delete this medicine?');">

Delete

</a>

</td>

</tr>

<%

}

if(!found){

%>

<tr>

<td colspan="6">

No medicines found.

</td>

</tr>

<%

}

}catch(Exception e){

%>

<tr>

<td colspan="6">

<%=e.getMessage()%>

</td>

</tr>

<%

}finally{

try{
if(rs!=null)rs.close();
}catch(Exception ex){}

try{
if(ps!=null)ps.close();
}catch(Exception ex){}

try{
if(con!=null)con.close();
}catch(Exception ex){}

}

%>

</table>

<div class="back">

<a href="DashboardServlet">

Back to Dashboard

</a>

</div>

</div>

<div class="footer">

© 2026 Medicine Reminder System | AI Powered

</div>

</body>

</html>