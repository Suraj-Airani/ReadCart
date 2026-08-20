package com.readcart.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String PASSWORD = System.getenv("DB_PASSWORD");

    private DBConnection() {
    }

    public static Connection getConnection() {
        try {
            if (URL == null || USER == null || PASSWORD == null) {
                throw new IllegalStateException(
                    "Database environment variables are not configured."
                );
            }

            Class.forName("com.mysql.cj.jdbc.Driver");

            return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
            );

        } catch (ClassNotFoundException | SQLException e) {
            throw new RuntimeException(
                "Database connection failed",
                e
            );
        }
    }

    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}