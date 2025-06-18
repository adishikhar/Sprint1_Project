
package org.example;

import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class AddProductServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json"); // JSON response
        PrintWriter out = response.getWriter();

        try {
            String name = request.getParameter("productName");
            String sku = request.getParameter("sku");
            String category = request.getParameter("category");
            String size = request.getParameter("size");
            String color = request.getParameter("color");
            double price = Double.parseDouble(request.getParameter("price"));
            int inventory = Integer.parseInt(request.getParameter("inventory"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/catalog_db", "root", "Shikhar@123");

            // Insert product
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO product (product_name, sku, category, size, color, price, inventory_count) VALUES (?, ?, ?, ?, ?, ?, ?)");
            ps.setString(1, name);
            ps.setString(2, sku);
            ps.setString(3, category);
            ps.setString(4, size);
            ps.setString(5, color);
            ps.setDouble(6, price);
            ps.setInt(7, inventory);
            ps.executeUpdate();
            ps.close();

            // Now fetch all products
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT product_name, sku, category, size, color, price, inventory_count FROM product");

            List<Product> products = new ArrayList<>();
            while (rs.next()) {
                products.add(new Product(
                        rs.getString("product_name"),
                        rs.getString("sku"),
                        rs.getString("category"),
                        rs.getString("size"),
                        rs.getString("color"),
                        rs.getDouble("price"),
                        rs.getInt("inventory_count")
                ));
            }

            rs.close();
            stmt.close();
            conn.close();

            // Convert to JSON and send
            Gson gson = new Gson();
            String json1 = gson.toJson(products);
            out.print(json1);

        } catch (Exception e) {
            e.printStackTrace(out);
            response.setStatus(500);
        }
    }
}