<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
if(session.getAttribute("userId")==null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User Profile</title>

<style>

body{
    margin:0;
    font-family:Arial,sans-serif;
    background:#f4f7fb;
}

.container{
    width:500px;
    margin:60px auto;
    background:white;
    padding:30px;
    border-radius:12px;
    box-shadow:0 0 15px rgba(0,0,0,0.15);
}

h2{
    text-align:center;
    color:#0d6efd;
}

table{
    width:100%;
    margin-top:20px;
}

td{
    padding:12px;
    font-size:18px;
}

.label{
    font-weight:bold;
    color:#444;
}

.value{
    color:#222;
}

.btn{
    display:block;
    width:100%;
    padding:12px;
    margin-top:25px;
    background:#0d6efd;
    color:white;
    border:none;
    border-radius:8px;
    cursor:pointer;
    text-decoration:none;
    text-align:center;
    font-size:17px;
}

.btn:hover{
    background:#084db5;
}

</style>

</head>

<body>

<div class="container">

<h2>👤 User Profile</h2>

<table>

<tr>
<td class="label">User ID</td>
<td class="value">${id}</td>
</tr>

<tr>
<td class="label">Name</td>
<td class="value">${name}</td>
</tr>

<tr>
<td class="label">Email</td>
<td class="value">${email}</td>
</tr>

</table>

<a href="DashboardServlet" class="btn">⬅ Back to Dashboard</a>

</div>

</body>
</html>