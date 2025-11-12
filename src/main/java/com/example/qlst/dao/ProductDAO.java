package com.example.qlst.dao;

import com.example.qlst.dao.DAO;
import com.example.qlst.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO extends DAO {
    public List<Product> getProducts(String q) {
        List<Product> products = new ArrayList<Product>();
        String sql = "";
        if(q==null || q.trim().isEmpty()){
            sql = "select id, name from tblproduct";
        }
        else {
            sql = "select id, name from tblproduct where name like '%"+q+"%' ";
        }

        try (Connection connection = getConnection()) {
            PreparedStatement stmt = connection.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()){
                Product product = new Product();
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                products.add(product);
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return products;
    }

    public Product getProductsDetail(int id){
        String sql = "select * from tblproduct where id = ?";
        Product product = new Product();
        try (Connection conn = getConnection()){
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(rs.next()){
                product.setId(rs.getInt("id"));
                product.setName(rs.getString("name"));
                product.setType(rs.getString("type"));
                product.setStockQuantity(rs.getInt("stockQuantity"));
                product.setPrice(rs.getDouble("unitPrice"));
            }
        }
        catch (SQLException e){
            e.printStackTrace();
        }
        return product;
    }

    public boolean saveProduct(Product product){
        Product p = new Product();
        String sql = "Update tblproduct SET name =?, type=?, stockQuantity=?, unitPrice=? where id = ?";

        try (Connection connection = getConnection()){
            PreparedStatement stmt = connection.prepareStatement(sql);
            stmt.setString(1, product.getName());
            stmt.setString(2, product.getType());
            stmt.setInt(3, product.getStockQuantity());
            stmt.setDouble(4, product.getPrice());
            stmt.setInt(5, product.getId());

            return stmt.executeUpdate() ==1;
        }
        catch (SQLException e){
            e.printStackTrace();
            return false;
        }
    }
}
