package org.rivercrane.models;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class MstCustomer {
    private Integer customerId;
    private String customerName;
    private String email;
    private String telNum;
    private String address;
    private Integer isActive;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}
