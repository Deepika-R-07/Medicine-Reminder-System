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
import jakarta.servlet.http.HttpSession;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        try {

            Connection con = DBConnection.getConnection();

            PreparedStatement ps = con.prepareStatement(
                    "SELECT * FROM users WHERE email=? AND password=?");

            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {

                HttpSession session = request.getSession();

                session.setAttribute("userId", rs.getInt("id"));
                session.setAttribute("userName", rs.getString("name"));
                session.setAttribute("userEmail", rs.getString("email"));

                response.sendRedirect("DashboardServlet");

            } else {

                out.println("<script>");
                out.println("alert('Invalid Email or Password!');");
                out.println("location='login.jsp';");
                out.println("</script>");
            }

            con.close();

        } catch (Exception e) {

            e.printStackTrace();

            out.println("<script>");
            out.println("alert('Something went wrong!');");
            out.println("location='login.jsp';");
            out.println("</script>");
        }
    }
}