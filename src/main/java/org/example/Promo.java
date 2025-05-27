package org.example;

public class Promo {
    private String promoType;
    private String description;
    private String promoCode;
    private double amount;

    public Promo(String promoType, String description,String promoCode, double amount) {
        this.promoType = promoType;
        this.description = description;
        this.promoCode = promoCode;
        this.amount = amount;
    }

    //Getter
    public String getPromoType() { return promoType; }
    public String getDescription() { return description; }
    public String getPromoCode() { return promoCode; }
    public double getAmount() { return amount; }
}
