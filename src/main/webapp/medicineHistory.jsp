<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>
<%@ page import="com.medicine.DBConnection" %>

<%
Integer userId = (Integer) session.getAttribute("userId");

if(userId == null){
    response.sendRedirect("login.jsp");
    return;
}
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Medicine History</title>

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
    padding:15px;
}

td{
    padding:15px;
    text-align:center;
    border-bottom:1px solid #ddd;
}

tr:hover{
    background:#f5f5f5;
}

.taken{
    color:green;
    font-weight:bold;
}

.missed{
    color:red;
    font-weight:bold;
}

.btn{
    display:inline-block;
    margin-top:25px;
    padding:12px 25px;
    background:#1565c0;
    color:white;
    text-decoration:none;
    border-radius:6px;
    font-weight:bold;
}

.btn:hover{
    background:#0d47a1;
}

</style>

</head>

<body>

<div class="container">

<h1>Medicine History</h1>

<table>

<tr>
    <th>Medicine Name</th>
    <th>Status</th>
    <th>Date & Time</th>
</tr>

<%

Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try{

    con = DBConnection.getConnection();

    String sql =
        "SELECT m.medicine_name, h.status, h.taken_time " +
        "FROM medicine_history h " +
        "INNER JOIN medicines m ON h.medicine_id = m.id " +
        "WHERE h.user_id = ? " +
        "ORDER BY h.taken_time DESC";

    ps = con.prepareStatement(sql);
    ps.setInt(1, userId);

    rs = ps.executeQuery();

    boolean found = false;

    while(rs.next()){

        found = true;

        String status = rs.getString("status");

%>

<tr>

    <td><%= rs.getString("medicine_name") %></td>

    <td>

        <% if("Taken".equalsIgnoreCase(status)){ %>

            <span class="taken">Taken</span>

        <% } else { %>

            <span class="missed">Missed</span>

        <% } %>

    </td>

    <td><%= rs.getTimestamp("taken_time") %></td>

</tr>

<%

    }

    if(!found){

%>

<tr>

<td colspan="3">

No medicine history found.

</td>

</tr>

<%

    }

}catch(Exception e){

%>

<tr>

<td colspan="3">

<%= e.getMessage() %>

</td>

</tr>

<%

}finally{

    try{
        if(rs!=null)
            rs.close();
    }catch(Exception ex){}

    try{
        if(ps!=null)
            ps.close();
    }catch(Exception ex){}

    try{
        if(con!=null)
            con.close();
    }catch(Exception ex){}
}

%>

</table>

<br>

<a href="DashboardServlet" class="btn">
Back to Dashboard
</a>

</div>

</body>
</html>