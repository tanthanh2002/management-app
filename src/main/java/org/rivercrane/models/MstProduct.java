package org.rivercrane.models;

import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Builder
@Data
public class MstProduct {
    private Integer productId;
    private String productName;
    private String productImage;
    private Double productPrice;
    private Integer isSales;
    private String description;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}