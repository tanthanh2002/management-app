package org.rivercrane.models;


import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@Builder
public class HistoryProduct {
    private Integer id;
    private Integer userId;
    private Integer customerId;
    private String oldCustomerName;
    private String newCustomerName;
    private Integer productId;
    private String productName;
    private String actionName;
    private Timestamp happenedAt;
}
