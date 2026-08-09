package com.medicine;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {

    private static final String HOST = "mysql-119ef5b4-aadhaar-awareness-system.d.aivencloud.com";
    private static final String PORT = "21735";
    private static final String DATABASE = "medicine_reminder";
    private static final String USER = "avnadmin";
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    private static final String URL =
            "jdbc:mysql://" + HOST + ":" + PORT + "/" + DATABASE
            + "?useSSL=true&requireSSL=true";

    public static Connection getConnection() {

        Connection con = null;

        try {

            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(
                    URL,
                    USER,
                    PASSWORD
            );

            System.out.println("Aiven Database Connected Successfully!");

        } catch (Exception e) {

            e.printStackTrace();

        }

        return con;
    }
}