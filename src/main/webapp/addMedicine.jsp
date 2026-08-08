<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String userName = (String)session.getAttribute("userName");

if(userName == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">

<title>Add Medicine | Medicine Reminder</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family:"Segoe UI",sans-serif;
}

body{
    background:#f4f7fb;
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
    box-shadow:0 10px 25px rgba(0,0,0,.15);
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
    text-align:center;
    margin-top:25px;
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

<h1>Add Medicine</h1>

<form action="AddMedicineServlet" method="post">

<div class="form-group">

<label>Medicine Name</label>

<input
type="text"
name="medicine_name"
placeholder="Enter medicine name"
required>

</div>

<div class="form-group">

<label>Dosage</label>

<input
type="text"
name="dosage"
placeholder="Example: 500 mg"
required>

</div>

<div class="form-group">

<label>Reminder Time</label>

<input
type="time"
name="reminder_time"
required>

</div>

<div class="form-group">

<label>Start Date</label>

<input
type="date"
name="start_date"
required>

</div>

<div class="form-group">

<label>End Date</label>

<input
type="date"
name="end_date"
required>

</div>

<button type="submit">

Save Medicine

</button>

</form>

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