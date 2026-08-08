<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Medicine Reminder | Login</title>

<style>

*{
margin:0;
padding:0;
box-sizing:border-box;
font-family:"Segoe UI",sans-serif;
}

body{
height:100vh;
display:flex;
justify-content:center;
align-items:center;
background:linear-gradient(135deg,#0f172a,#1d4ed8,#3b82f6);
}

.container{
width:900px;
height:550px;
display:flex;
background:white;
border-radius:18px;
overflow:hidden;
box-shadow:0 20px 40px rgba(0,0,0,.25);
}

.left{
width:50%;
background:#2563eb;
color:white;
display:flex;
justify-content:center;
align-items:center;
flex-direction:column;
padding:40px;
text-align:center;
}

.left h1{
font-size:36px;
margin-bottom:20px;
}

.left p{
font-size:17px;
line-height:28px;
}

.right{
width:50%;
display:flex;
justify-content:center;
align-items:center;
padding:40px;
}

form{
width:100%;
}

h2{
text-align:center;
margin-bottom:30px;
color:#1e3a8a;
}

.input-group{
margin-bottom:20px;
}

label{
font-weight:600;
display:block;
margin-bottom:8px;
}

input{
width:100%;
padding:14px;
border:1px solid #ccc;
border-radius:8px;
font-size:15px;
}

input:focus{
outline:none;
border-color:#2563eb;
}

button{
width:100%;
padding:15px;
border:none;
background:#2563eb;
color:white;
font-size:17px;
border-radius:8px;
cursor:pointer;
transition:.3s;
}

button:hover{
background:#1d4ed8;
}

.bottom{
text-align:center;
margin-top:20px;
}

.bottom a{
text-decoration:none;
color:#2563eb;
font-weight:bold;
}

</style>

</head>

<body>

<div class="container">

<div class="left">

<h1>Welcome Back</h1>

<p>
Login to access your medicine schedule,
manage reminders, and stay healthy every day.
</p>

</div>

<div class="right">

<form action="LoginServlet" method="post">

<h2>Sign In</h2>

<div class="input-group">

<label>Email</label>

<input
type="email"
name="email"
placeholder="Enter your email"
required>

</div>

<div class="input-group">

<label>Password</label>

<input
type="password"
name="password"
placeholder="Enter your password"
required>

</div>

<button type="submit">

Login

</button>

<div class="bottom">

Don't have an account?

<a href="register.jsp">

Register

</a>

</div>

</form>

</div>

</div>

</body>
</html>