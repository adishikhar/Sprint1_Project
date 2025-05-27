

package org.example;

public class Product {
    private String productName;
    private String sku;
    private String category;
    private String size;
    private String color;
    private double price;
    private int inventory;

    public Product(String productName, String sku, String category, String size, String color, double price, int inventory) {
        this.productName = productName;
        this.sku = sku;
        this.category = category;
        this.size = size;
        this.color = color;
        this.price = price;
        this.inventory = inventory;
    }

    // Getters
    public String getProductName() { return productName; }
    public String getSku() { return sku; }
    public String getCategory() { return category; }
    public String getSize() { return size; }
    public String getColor() { return color; }
    public double getPrice() { return price; }
    public int getInventory() { return inventory; }
}