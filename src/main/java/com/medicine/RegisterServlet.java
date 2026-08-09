package com.medicine;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            // Check if email already exists
            PreparedStatement check = con.prepareStatement(
                    "SELECT * FROM users WHERE email=?");
            check.setString(1, email);

            ResultSet rs = check.executeQuery();

            if (rs.next()) {

                out.println("<script>");
                out.println("alert('Email already registered!');");
                out.println("location='register.jsp';");
                out.println("</script>");

            } else {

                PreparedStatement ps = con.prepareStatement(
                        "INSERT INTO users(name,email,password) VALUES(?,?,?)");

                ps.setString(1, name);
                ps.setString(2, email);
                ps.setString(3, password);

                int i = ps.executeUpdate();

                if (i > 0) {

                    out.println("<script>");
                    out.println("alert('Registration Successful! Please Login.');");
                    out.println("location='login.jsp';");
                    out.println("</script>");

                } else {

                    out.println("<script>");
                    out.println("alert('Registration Failed!');");
                    out.println("location='register.jsp';");
                    out.println("</script>");
                }
            }

            con.close();

        } catch (Exception e) {
            e.printStackTrace();

            out.println("<script>");
            out.println("alert('Something went wrong!');");
            out.println("location='register.jsp';");
            out.println("</script>");
        }
    }
}