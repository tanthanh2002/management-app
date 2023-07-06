DROP DATABASE mst;
CREATE DATABASE IF NOT EXISTS mst;
USE  mst;
CREATE TABLE IF NOT EXISTS mst_users
(
    id                              INT                             AUTO_INCREMENT PRIMARY KEY,
    name                            VARCHAR(255)                    NOT NULL,
    email                           VARCHAR(255)                    UNIQUE NOT NULL,
    password                        VARCHAR(255)                    NOT NULL,
    remember_token                  VARCHAR(100)                    ,
    verify_email                    VARCHAR(100)                    ,
    is_active                       TINYINT                         CHECK ( is_active IN (1,0) ),
    is_delete                       TINYINT                         CHECK ( is_delete IN (1,0)),
    group_role                      VARCHAR(50)                     NOT NULL ,
    last_login_at                   TIMESTAMP                       ,
    last_login_ip                   VARCHAR(40)                     ,
    created_at                      TIMESTAMP                       ,
    updated_at                      TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mst_product
(
    product_id                      VARCHAR(20)                     PRIMARY KEY,
    product_name                    VARCHAR(255)                    NOT NULL,
    product_image                   VARCHAR(255)                    ,
    product_price                   DECIMAL                         NOT NULL DEFAULT 0,
    is_sales                        TINYINT                         NOT NULL DEFAULT 1 CHECK ( is_sales IN (1,0)),
    description                     TEXT                            ,
    created_at                      TIMESTAMP                       ,
    updated_at                      TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mst_shop
(
    shop_id                         INT                             PRIMARY KEY AUTO_INCREMENT,
    shop_name                       VARCHAR(255)                    NOT NULL,
    created_at                      TIMESTAMP                       ,
    updated_at                      TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mst_customer
(
    custimer_id                     INT                             PRIMARY KEY AUTO_INCREMENT,
    customer_name                   VARCHAR(255)                    NOT NULL,
    email                           VARCHAR(255)                    NOT NULL,
    tel_num                         VARCHAR(14)                     NOT NULL,
    address                         VARCHAR(255)                    NOT NULL,
    is_active                       TINYINT                         ,
    created_at                      TIMESTAMP                       ,
    updated_at                      TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mst_order
(
    order_id                        INT                             PRIMARY KEY AUTO_INCREMENT,
    order_shop                      INT                             NOT NULL ,
    customer_id                     INT                             NOT NULL ,
    total_price                     INT                             NOT NULL ,
    payment_method                  TINYINT                         CHECK ( payment_method BETWEEN 1 AND 3),
    ship_charge                     INT                             ,
    tax                             INT                             ,
    order_date                      DATETIME                        NOT NULL ,
    shipment_date                   DATETIME                        ,
    cancel_date                     DATETIME                        ,
    order_status                    TINYINT                         NOT NULL ,
    note_customer                   VARCHAR(255)                    ,
    error_code_api                  VARCHAR(20)                     ,
    created_at                      TIMESTAMP                       ,
    updated_at                      TIMESTAMP                       ,
    CONSTRAINT mst_order_customer_id FOREIGN KEY (customer_id) REFERENCES mst_customer(custimer_id),
    CONSTRAINT mst_order_order_shop FOREIGN KEY (order_shop) REFERENCES mst_shop(shop_id)
);

CREATE TABLE IF NOT EXISTS mst_order_detail
(
    order_id                        INT                             NOT NULL ,
    detail_line                     INT                             NOT NULL ,
    product_id                      VARCHAR(50)                     NOT NULL ,
    price_buy                       INT                             NOT NULL ,
    quantity                        INT                             NOT NULL ,
    shop_id                         INT                             NOT NULL , -- VARCHAR -> INT
    receiver_id                     INT                             NOT NULL ,
    created_at                      TIMESTAMP                       ,
    updated_at                      TIMESTAMP                       ,
    PRIMARY KEY (order_id,detail_line),
    CONSTRAINT mst_order_detail_order_id  FOREIGN KEY (order_id) REFERENCES mst_order(order_id),
    CONSTRAINT mst_order_detail_shop_id   FOREIGN KEY (shop_id) REFERENCES mst_shop(shop_id),
    CONSTRAINT mst_order_detail_receiver_id FOREIGN KEY (receiver_id) REFERENCES mst_customer(custimer_id)
);

-- INSERT DEFAULT DATA
INSERT INTO mst_shop(shop_id, shop_name) VALUES (3,'Rakuten');
INSERT INTO mst_shop(shop_id, shop_name) VALUES (1,'Amazon');
INSERT INTO mst_shop(shop_id, shop_name) VALUES (2,'Yahoo');


INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(1,'Nguyen Van A','a.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Admin',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(2,'Nguyen Van B','b.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Admin',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(3,'Nguyen Van C','c.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Editor',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(4,'Nguyen Van D','d.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Reviewer',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(5,'Nguyen Van E','e.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Reviewer',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(6,'Nguyen Van F','f.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Reviewer',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(7,'Nguyen Van G','g.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Editor',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(8,'Nguyen Van H','h.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Editor',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(9,'Nguyen Van I','i.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Editor',null,null,null,null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role, last_login_at, last_login_ip, created_at, updated_at)
VALUES(10,'Nguyen Van J','j.nguyen@gmail.com','$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG',null,null,1,0,'Editor',null,null,null,null);

