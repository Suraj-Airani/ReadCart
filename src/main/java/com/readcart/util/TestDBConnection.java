package com.readcart.util;

import java.sql.Connection;

public class TestDBConnection {

    public static void main(String[] args) {
        Connection conn = null;
        try {
            conn = DBConnection.getConnection();
            if (conn != null) {
                System.out.println("Database connected successfully!");
            } else {
                System.out.println("Failed to connect to database.");
            }
        } catch (Exception e) {
            System.out.println("Connection failed: " + e.getMessage());
            e.printStackTrace();
        } finally {
            DBConnection.closeConnection(conn);
        }
    }
}