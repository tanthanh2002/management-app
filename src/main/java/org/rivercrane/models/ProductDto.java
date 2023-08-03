package org.rivercrane.models;


import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
public class ProductDto {
    private Integer productId;
    private String productCode;
    private String productName;
    private String productImage;
    private Double productPrice;
    private Integer isSales;
    private String description;
    private Integer customerId;
    private Timestamp createdAt;
    private Timestamp updatedAt;
    private String customerName;
    private String productDetails;
    private Integer isContainer;
}
