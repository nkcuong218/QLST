package com.example.qlst.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    private String URL = "jdbc:mysql://localhost:3306/qlst?useSSL=false&characterEncoding=UTF-8";
    private String USER = "root";
    private String PASSWORD = "21082004";

    //ham dung chung cho ca dao
    public Connection getConnection() throws SQLException {
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException("SQL not found...!" , e);
        }
    }
}
