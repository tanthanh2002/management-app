package org.rivercrane.models;

import java.sql.Timestamp;

public class MstShop {
    private Integer shopId;
    private String shopName;
    private Timestamp createdAt;
    private Timestamp updatedAt;

    public MstShop() {
    }

    public MstShop(Integer shopId, String shopName, Timestamp createdAt, Timestamp updatedAt) {
        this.shopId = shopId;
        this.shopName = shopName;
        this.createdAt = createdAt;
        this.updatedAt = updatedAt;
    }

    public Integer getShopId() {
        return shopId;
    }

    public void setShopId(Integer shopId) {
        this.shopId = shopId;
    }

    public String getShopName() {
        return shopName;
    }

    public void setShopName(String shopName) {
        this.shopName = shopName;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public Timestamp getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(Timestamp updatedAt) {
        this.updatedAt = updatedAt;
    }
}
