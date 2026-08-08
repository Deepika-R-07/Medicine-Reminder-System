<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>

<%
String userName=(String)session.getAttribute("userName");

if(userName==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>AI Health Assistant</title>

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

/* Main Container */

.container{
    width:75%;
    margin:40px auto;
}

.card{
    background:white;
    border-radius:15px;
    padding:35px;
    box-shadow:0 10px 25px rgba(0,0,0,.12);
}

.card h1{
    color:#1565c0;
    margin-bottom:10px;
}

.card p{
    color:#666;
    margin-bottom:25px;
    line-height:24px;
}

textarea{

    width:100%;
    height:180px;
    resize:none;
    border:1px solid #ccc;
    border-radius:10px;
    padding:15px;
    font-size:16px;

}

textarea:focus{

    outline:none;
    border-color:#1565c0;

}

button{

    width:100%;
    margin-top:20px;
    padding:15px;
    background:#1565c0;
    color:white;
    border:none;
    border-radius:10px;
    font-size:18px;
    font-weight:bold;
    cursor:pointer;

}

button:hover{

    background:#0d47a1;

}

/* AI Response */

.response{

    margin-top:30px;
    background:#f8f9fa;
    border-left:6px solid #1565c0;
    border-radius:10px;
    padding:20px;

}

.response h3{

    color:#1565c0;
    margin-bottom:15px;

}

.response p{

    color:#333;
    line-height:28px;
    white-space:pre-wrap;

}

.footer{

    text-align:center;
    margin:40px;
    color:#777;

}

</style>

</head>

<body>

<div class="header">

<h2>Medicine Reminder</h2>

<div class="nav">

<a href="DashboardServlet">Dashboard</a>

<a href="addMedicine.jsp">Add Medicine</a>

<a href="viewMedicine.jsp">Medicines</a>

<a href="TodayReminderServlet">Today's Reminder</a>

<a href="MedicineHistoryServlet">History</a>

<a href="LogoutServlet">Logout</a>

</div>

</div>

<div class="container">

<div class="card">

<h1>AI Health Assistant</h1>

<p>

Ask questions about medicines, dosage, side effects,
healthy habits, nutrition, exercise, first aid,
or general health guidance.

</p>

<form action="AIAssistantServlet" method="post">

<textarea

name="question"

placeholder="Example:
Can I take Paracetamol after food?
What are the side effects of Vitamin C tablets?
How much water should I drink daily?"

required>

</textarea>

<button type="submit">

Ask AI

</button>

</form>

<%

String answer=(String)request.getAttribute("answer");

if(answer!=null){

%>

<div class="response">

<h3>AI Response</h3>

<p>

<%=answer%>

</p>

</div>

<%

}

%>

</div>

</div>

<div class="footer">

© 2026 Medicine Reminder System | AI Powered using Groq

</div>

</body>

</html>