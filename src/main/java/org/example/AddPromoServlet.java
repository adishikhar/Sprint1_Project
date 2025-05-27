package org.example;

import com.google.gson.Gson;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class AddPromoServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json"); // JSON response
        PrintWriter out = response.getWriter();

        try {
            String type = request.getParameter("promoType");
            String desc = request.getParameter("description");
            String promoCode = request.getParameter("promoCode");
            double amt = Double.parseDouble(request.getParameter("amount"));

            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(
                    "jdbc:mysql://localhost:3306/promo_catalog_db", "root", "Shikhar@123");

            // Insert product
            PreparedStatement ps = conn.prepareStatement(
                    "INSERT INTO promocode (promo_type, description,promo_Code, amount) VALUES (?, ?, ?, ?)");
            ps.setString(1, type);
            ps.setString(2, desc);
            ps.setString(3, promoCode);
            ps.setDouble(4, amt);
            ps.executeUpdate();
            ps.close();

            // now fetch all product
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT promo_type, description,promo_Code, amount FROM promocode");

            List<Promo> promos = new ArrayList<>();
            while (rs.next()) {
                promos.add(new Promo(
                        rs.getString("promo_type"),
                        rs.getString("description"),
                        rs.getString("promo_Code"),
                        rs.getDouble("amount")
                        ));
            }

            rs.close();
            stmt.close();
            conn.close();

            // Convert to JSON and send
            Gson gson = new Gson();
            String json2 = gson.toJson(promos);
            out.print(json2);

        } catch (Exception e) {
            e.printStackTrace(out);
            response.setStatus(500);
        }

    }
}