<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
String userName=(String)session.getAttribute("userName");

if(userName==null){
    response.sendRedirect("login.jsp");
    return;
}

int totalMedicines=request.getAttribute("totalMedicines")==null?0:(Integer)request.getAttribute("totalMedicines");
int todayMedicines=request.getAttribute("todayMedicines")==null?0:(Integer)request.getAttribute("todayMedicines");
int takenToday=request.getAttribute("takenToday")==null?0:(Integer)request.getAttribute("takenToday");
int missedToday=request.getAttribute("missedToday")==null?0:(Integer)request.getAttribute("missedToday");
int activeMedicines=request.getAttribute("activeMedicines")==null?0:(Integer)request.getAttribute("activeMedicines");
int completion=request.getAttribute("completion")==null?0:(Integer)request.getAttribute("completion");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Medicine Reminder Dashboard</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:Segoe UI,sans-serif;
}

body{
background:#f4f7fb;
}

.navbar{
height:70px;
background:#1565c0;
display:flex;
justify-content:space-between;
align-items:center;
padding:0 60px;
color:white;
}

.logo{
font-size:28px;
font-weight:bold;
}

.menu a{
color:white;
text-decoration:none;
margin-left:25px;
font-weight:bold;
}

.hero{
width:90%;
margin:30px auto;
background:linear-gradient(135deg,#1976d2,#42a5f5);
padding:40px;
border-radius:15px;
color:white;
}

.analytics{
width:90%;
margin:30px auto;
display:grid;
grid-template-columns:repeat(auto-fit,minmax(220px,1fr));
gap:20px;
}

.stat{
background:white;
padding:25px;
border-radius:15px;
text-align:center;
box-shadow:0 5px 15px rgba(0,0,0,.15);
}

.stat h2{
color:#1565c0;
font-size:18px;
margin-bottom:10px;
}

.stat h1{
font-size:35px;
color:#222;
}

.progress{
width:100%;
height:18px;
background:#ddd;
border-radius:20px;
overflow:hidden;
margin-top:15px;
}

.bar{
height:100%;
background:#4caf50;
}

.cards{
width:90%;
margin:30px auto;
display:grid;
grid-template-columns:repeat(auto-fit,minmax(280px,1fr));
gap:25px;
}

.card{
background:white;
padding:30px;
border-radius:15px;
text-align:center;
box-shadow:0 8px 20px rgba(0,0,0,.12);
}

.card h2{
color:#1565c0;
margin-bottom:15px;
}

.card p{
line-height:25px;
color:#555;
min-height:80px;
}

.btn{
display:inline-block;
margin-top:20px;
padding:12px 24px;
background:#1565c0;
color:white;
text-decoration:none;
border-radius:6px;
font-weight:bold;
}

.btn:hover{
background:#0d47a1;
}

.footer{
margin:40px;
text-align:center;
color:#666;
}

</style>

</head>

<body>

<div class="navbar">

<div class="logo">
Medicine Reminder
</div>

<div class="menu">

<a href="DashboardServlet">Home</a>

<a href="addMedicine.jsp">Add Medicine</a>

<a href="viewMedicine.jsp">Medicines</a>

<a href="aiAssistant.jsp">AI Assistant</a>

<a href="LogoutServlet">Logout</a>

</div>

</div>

<div class="hero">

<h1>Welcome, <%=userName%></h1>

<p>
Manage medicines, reminders and AI health assistance.
</p>

</div>

<div class="analytics">

<div class="stat">
<h2>Total Medicines</h2>
<h1><%=totalMedicines%></h1>
</div>

<div class="stat">
<h2>Today's Medicines</h2>
<h1><%=todayMedicines%></h1>
</div>

<div class="stat">
<h2>Taken Today</h2>
<h1><%=takenToday%></h1>
</div>

<div class="stat">
<h2>Missed Today</h2>
<h1><%=missedToday%></h1>
</div>

<div class="stat">
<h2>Active Medicines</h2>
<h1><%=activeMedicines%></h1>
</div>

<div class="stat">

<h2>Today's Progress</h2>

<h1><%=completion%>%</h1>

<div class="progress">

<div class="bar" style="width:<%=completion%>%"></div>

</div>

</div>

</div>

<div class="cards">

<div class="card">

<h2>Add Medicine</h2>

<p>Add medicine details with dosage and reminder time.</p>

<a href="addMedicine.jsp" class="btn">Open</a>

</div>

<div class="card">

<h2>View Medicines</h2>

<p>View, edit and delete medicines.</p>

<a href="viewMedicine.jsp" class="btn">Open</a>

</div>

<div class="card">

<h2>Today's Reminder</h2>

<p>View today's reminders and mark Taken or Missed.</p>

<a href="TodayReminderServlet" class="btn">Open</a>

</div>

<div class="card">

<h2>Medicine History</h2>

<p>View complete medicine history.</p>

<a href="MedicineHistoryServlet" class="btn">Open</a>

</div>

<div class="card">

<h2>Profile</h2>

<p>View your account details.</p>

<a href="UserProfileServlet" class="btn">Open</a>

</div>

<div class="card">

<h2>AI Assistant</h2>

<p>Ask medicine related questions using Gemini AI.</p>

<a href="aiAssistant.jsp" class="btn">Open</a>

</div>

</div>

<div class="footer">

© 2026 Medicine Reminder System

</div>

</body>

</html>