<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Medicine Reminder | Register</title>

<style>

*{
    margin:0;
    padding:0;
    box-sizing:border-box;
    font-family: "Segoe UI", Tahoma, Geneva, Verdana, sans-serif;
}

body{
    height:100vh;
    display:flex;
    justify-content:center;
    align-items:center;
    background:linear-gradient(135deg,#0f172a,#1e3a8a,#3b82f6);
}

.container{
    width:900px;
    height:550px;
    background:white;
    border-radius:18px;
    overflow:hidden;
    display:flex;
    box-shadow:0 20px 45px rgba(0,0,0,.25);
}

.left{
    width:50%;
    background:linear-gradient(135deg,#2563eb,#1d4ed8);
    color:white;
    display:flex;
    flex-direction:column;
    justify-content:center;
    align-items:center;
    padding:40px;
    text-align:center;
}

.left h1{
    font-size:34px;
    margin-bottom:20px;
}

.left p{
    font-size:17px;
    line-height:28px;
    opacity:.9;
}

.right{
    width:50%;
    padding:45px;
    display:flex;
    flex-direction:column;
    justify-content:center;
}

.right h2{
    color:#1e3a8a;
    margin-bottom:30px;
    font-size:30px;
}

.inputBox{
    margin-bottom:22px;
}

.inputBox label{
    display:block;
    margin-bottom:8px;
    color:#555;
    font-weight:600;
}

.inputBox input{
    width:100%;
    padding:14px;
    border:1px solid #ccc;
    border-radius:10px;
    font-size:15px;
    transition:.3s;
}

.inputBox input:focus{
    outline:none;
    border-color:#2563eb;
    box-shadow:0 0 8px rgba(37,99,235,.3);
}

button{
    width:100%;
    padding:15px;
    border:none;
    border-radius:10px;
    background:#2563eb;
    color:white;
    font-size:17px;
    cursor:pointer;
    transition:.3s;
}

button:hover{
    background:#1d4ed8;
    transform:translateY(-2px);
}

.bottom{
    margin-top:20px;
    text-align:center;
}

.bottom a{
    color:#2563eb;
    text-decoration:none;
    font-weight:600;
}

.bottom a:hover{
    text-decoration:underline;
}

</style>

</head>

<body>

<div class="container">

<div class="left">

<h1>Medicine Reminder</h1>

<p>
Never miss your medication again.
Create your account and manage medicine schedules,
dosage, reminders, and notifications from one secure platform.
</p>

</div>

<div class="right">

<h2>Create Account</h2>

<form action="RegisterServlet" method="post">

<div class="inputBox">
<label>Full Name</label>
<input type="text" name="name" placeholder="Enter your full name" required>
</div>

<div class="inputBox">
<label>Email Address</label>
<input type="email" name="email" placeholder="Enter your email" required>
</div>

<div class="inputBox">
<label>Password</label>
<input type="password" name="password" placeholder="Create a password" required>
</div>

<button type="submit">
Create Account
</button>

</form>

<div class="bottom">
Already have an account?
<a href="login.jsp">Login</a>
</div>

</div>

</div>

</body>
</html>