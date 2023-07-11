package org.rivercrane.models;

import lombok.Builder;
import lombok.Data;

import java.sql.Time;
import java.sql.Timestamp;


@Builder
@Data
public class MstUsers {
    private Integer id;
    private String name;
    private String email;
    private String password;
    private String rememberToken;
    private String verifyEmail;
    private Integer isActive;
    private Integer isDelete;
    private String groupRole;
    private Timestamp lastLoginAt;
    private String lastLoginIp;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}
