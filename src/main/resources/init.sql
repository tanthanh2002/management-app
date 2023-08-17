DROP DATABASE IF EXISTS mst;
CREATE DATABASE IF NOT EXISTS mst;
USE mst;

CREATE TABLE IF NOT EXISTS mst_users
(
    id             INT AUTO_INCREMENT PRIMARY KEY,
    user_code    VARCHAR(255) UNIQUE,
    name           VARCHAR(255)        NOT NULL,
    email          VARCHAR(255) UNIQUE NOT NULL,
    password       VARCHAR(255)        NOT NULL,
    remember_token VARCHAR(100),
    verify_email   VARCHAR(100),
    is_active      TINYINT CHECK ( is_active IN (1, 0) ),
    is_delete      TINYINT CHECK ( is_delete IN (1, 0)),
    group_role     VARCHAR(50)         NOT NULL,
    last_login_at  TIMESTAMP,
    last_login_ip  VARCHAR(40),
    created_at     TIMESTAMP,
    updated_at     TIMESTAMP
    );

CREATE TABLE IF NOT EXISTS mst_customer
(
    customer_id   INT PRIMARY KEY AUTO_INCREMENT,
    customer_code VARCHAR(255) UNIQUE,
    customer_name VARCHAR(255) NOT NULL,
    email         VARCHAR(255) NOT NULL,
    tel_num       VARCHAR(14)  NOT NULL,
    address       VARCHAR(255) NOT NULL,
    is_active     TINYINT      NOT NULL CHECK ( is_active IN (1, 0)) DEFAULT 1,
    created_at    TIMESTAMP,
    updated_at    TIMESTAMP,
    group_name    VARCHAR(255) NOT NULL CHECK(group_name IN ('GLOBAL','GLOCAL','DESIGN','DATA','MARKETING')) DEFAULT 'GLOBAL'
);

CREATE TABLE IF NOT EXISTS mst_product
(
    product_id      INT AUTO_INCREMENT PRIMARY KEY,
    product_code    VARCHAR(255) UNIQUE,
    product_name    VARCHAR(255) NOT NULL,
    product_image   VARCHAR(255),
    product_price   DECIMAL      NOT NULL DEFAULT 0,
    is_sales        TINYINT      NOT NULL DEFAULT 1 CHECK ( is_sales IN (1, 0)),
    is_container    TINYINT      CHECK (is_container IN (1,0)),
    description     TEXT,
    customer_id     INT,
    created_at      TIMESTAMP,
    updated_at      TIMESTAMP,
    product_details VARCHAR(255),
    type            varchar(255) CHECK ( type IN ('RAM','CPU','GPU','MOUSE','HEADPHONE','MAINBOARD','SCREEN','OTHER','CAMERA','KEYBOARD','PC') ),
    CONSTRAINT mst_product_customer_id FOREIGN KEY (customer_id) REFERENCES mst_customer (customer_id)
);

CREATE TABLE IF NOT EXISTS mst_product_detail
(
    product_id        INT NOT NULL,
    product_component INT NOT NULL,
    qty               INT CHECK ( qty > 0 ),
    CONSTRAINT mst_product_detail_product_id FOREIGN KEY (product_id) REFERENCES mst_product (product_id) ON DELETE CASCADE,
    CONSTRAINT mst_product_detail_product_component FOREIGN KEY (product_component) REFERENCES mst_product (product_id) ON DELETE CASCADE
    );

CREATE TABLE IF NOT EXISTS mst_shop
(
    shop_id    INT PRIMARY KEY AUTO_INCREMENT,
    shop_name  VARCHAR(255) NOT NULL,
    created_at TIMESTAMP,
    updated_at TIMESTAMP
);

CREATE TABLE IF NOT EXISTS mst_order
(
    order_id       INT PRIMARY KEY AUTO_INCREMENT,
    order_shop     INT      NOT NULL,
    customer_id    INT      NOT NULL,
    total_price    INT      NOT NULL,
    payment_method TINYINT CHECK ( payment_method BETWEEN 1 AND 3),
    ship_charge    INT,
    tax            INT,
    order_date     DATETIME NOT NULL,
    shipment_date  DATETIME,
    cancel_date    DATETIME,
    order_status   TINYINT  NOT NULL,
    note_customer  VARCHAR(255),
    error_code_api VARCHAR(20),
    created_at     TIMESTAMP,
    updated_at     TIMESTAMP,
    CONSTRAINT mst_order_customer_id FOREIGN KEY (customer_id) REFERENCES mst_customer (customer_id),
    CONSTRAINT mst_order_order_shop FOREIGN KEY (order_shop) REFERENCES mst_shop (shop_id)
    );

CREATE TABLE IF NOT EXISTS mst_order_detail
(
    order_id    INT         NOT NULL,
    detail_line INT         NOT NULL,
    product_id  VARCHAR(50) NOT NULL,
    price_buy   INT         NOT NULL,
    quantity    INT         NOT NULL,
    shop_id     INT         NOT NULL, -- VARCHAR -> INT
    receiver_id INT         NOT NULL,
    created_at  TIMESTAMP,
    updated_at  TIMESTAMP,
    PRIMARY KEY (order_id, detail_line),
    CONSTRAINT mst_order_detail_order_id FOREIGN KEY (order_id) REFERENCES mst_order (order_id),
    CONSTRAINT mst_order_detail_shop_id FOREIGN KEY (shop_id) REFERENCES mst_shop (shop_id),
    CONSTRAINT mst_order_detail_receiver_id FOREIGN KEY (receiver_id) REFERENCES mst_customer (customer_id)
    );


CREATE TABLE IF NOT EXISTS audit_history_product
(
    id              int auto_increment primary key,
    user_id         int,
    customer_id     int,
    old_customer_name varchar(255),
    new_customer_name varchar(255),
    product_id      int,
    product_name    varchar(255),
    action_name     varchar(255)    check ( action_name in ('insert','update','delete')),
    happened_at     TIMESTAMP
    );


-- trigger update
CREATE TRIGGER update_mst_product
    BEFORE UPDATE
    ON mst_product
    FOR EACH ROW
BEGIN
    SET NEW.updated_at = CONVERT_TZ(NOW(), '+00:00', '+07:00');
END;


DELIMITER //
CREATE PROCEDURE update_productdetails(p_id INT)
BEGIN
    DECLARE revisedProductId INT;
    DECLARE product_detail VARCHAR(255);
    DECLARE done INT DEFAULT 0;

    DECLARE cur CURSOR FOR SELECT DISTINCT mpd.product_id
                           FROM mst_product_detail mpd
                           WHERE mpd.product_component = p_id;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
OPEN cur;
label:
    LOOP
        FETCH cur INTO revisedProductId;

SELECT GROUP_CONCAT(p.product_name SEPARATOR ', ')
INTO product_detail
FROM mst_product_detail d
         join mst_product p on d.product_component = p.product_id
WHERE d.product_id = revisedProductId;

UPDATE mst_product
SET product_details = product_detail
WHERE product_id = revisedProductId;

IF done = 1 THEN
            LEAVE label;
END IF;
END LOOP;
CLOSE cur;
END;
DELIMITER ;

CREATE TRIGGER create_mst_product
    BEFORE INSERT
    ON mst_product
    FOR EACH ROW
BEGIN
    DECLARE id int;
    select product_id into id from mst_product order by product_id desc limit 1;
    SET id = CASE WHEN id is null THEN 0 ELSE id END;
SET NEW.product_code = CONCAT('PRODUCT_',
            CONCAT(
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26))
            ), DATE_FORMAT(NOW(), '%H%i%s'),id
        ),
        NEW.created_at = CONVERT_TZ(NOW(), '+00:00', '+07:00');
END;
CREATE TRIGGER update_mst_product_detail
    AFTER UPDATE
    ON mst_product_detail
    FOR EACH ROW
BEGIN
    DECLARE product_detail VARCHAR(255);
    IF !(NEW.product_component <=> OLD.product_component) THEN
    SELECT GROUP_CONCAT(p.product_name SEPARATOR ', ')
    INTO product_detail
    FROM mst_product_detail d
             join mst_product p on d.product_component = p.product_id
    WHERE d.product_id = NEW.product_id;

    UPDATE mst_product
    SET product_details = product_detail
    WHERE product_id = NEW.product_id;
END IF;
END;

CREATE TRIGGER insert_mst_product_detail
    AFTER INSERT
    ON mst_product_detail
    FOR EACH ROW
BEGIN
    DECLARE product_detail VARCHAR(255);

    SELECT GROUP_CONCAT(p.product_name SEPARATOR ', ')
    INTO product_detail
    FROM mst_product_detail d
             join mst_product p on d.product_component = p.product_id
    WHERE d.product_id = NEW.product_id;

    UPDATE mst_product
    SET product_details = product_detail
    WHERE product_id = NEW.product_id;
END;

CREATE TRIGGER delete_mst_product_detail
    AFTER DELETE
    ON mst_product_detail
    FOR EACH ROW
BEGIN
    DECLARE product_detail VARCHAR(255);

    SELECT GROUP_CONCAT(p.product_name SEPARATOR ', ')
    INTO product_detail
    FROM mst_product_detail d
             join mst_product p on d.product_component = p.product_id
    WHERE d.product_id = OLD.product_id;

    UPDATE mst_product
    SET product_details = product_detail
    WHERE product_id = OLD.product_id;
END;


CREATE TRIGGER update_mst_users
    BEFORE UPDATE
    ON mst_users
    FOR EACH ROW
    SET NEW.updated_at = CONVERT_TZ(NOW(), '+00:00', '+07:00');

CREATE TRIGGER create_mst_users
    BEFORE INSERT
    ON mst_users
    FOR EACH ROW
BEGIN
    DECLARE id int;
    select id into id from mst_users order by id desc limit 1;
    SET id = CASE WHEN id is null THEN 0 ELSE id END;
SET NEW.user_code = CONCAT('USR_',
            CONCAT(
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26))
            ), DATE_FORMAT(NOW(), '%H%i%s'),id
        ),
        NEW.created_at = CONVERT_TZ(NOW(), '+00:00', '+07:00');
END;
CREATE TRIGGER update_mst_customer
    BEFORE UPDATE
    ON mst_customer
    FOR EACH ROW
    SET NEW.updated_at = CONVERT_TZ(NOW(), '+00:00', '+07:00');

CREATE TRIGGER create_mst_customer
    BEFORE INSERT
    ON mst_customer
    FOR EACH ROW
BEGIN
    DECLARE id int;
    select customer_id into id from mst_customer order by customer_id desc limit 1;
    SET id = CASE WHEN id is null THEN 0 ELSE id END;
SET NEW.customer_code = CASE WHEN NEW.customer_code IS NULL THEN CONCAT('CUS_',
            CONCAT(
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26)),
                CHAR(FLOOR(65 + RAND() * 26))
            ), DATE_FORMAT(NOW(), '%H%i%s'),id
        ) ELSE NEW.customer_code END ,
        NEW.created_at = CONVERT_TZ(NOW(), '+00:00', '+07:00');
END;


-- audit
CREATE TRIGGER audit_update_product
    AFTER UPDATE ON mst_product
    FOR EACH ROW
BEGIN
    DECLARE  old_customer varchar(255);
    DECLARE  new_customer varchar(255);

    select customer_name into old_customer from mst_customer where  customer_id = OLD.customer_id;
    select customer_name into new_customer from mst_customer where  customer_id = NEW.customer_id;

    IF !(NEW.customer_id <=> OLD.customer_id) THEN
        INSERT audit_history_product(CUSTOMER_ID, PRODUCT_ID, PRODUCT_NAME, old_customer_name, new_customer_name, ACTION_NAME, HAPPENED_AT)
            VALUES (NEW.customer_id, NEW.product_id, NEW.product_name, old_customer, new_customer, 'update', CONVERT_TZ(NOW(), '+00:00', '+07:00'));
END IF;

END;

# CREATE TRIGGER audit_insert_product
    # AFTER INSERT ON mst_product
# FOR EACH ROW
# BEGIN
#     INSERT audit_history_product(CUSTOMER_ID, PRODUCT_ID, ACTION_NAME, HAPPENED_AT)
#             VALUES (NEW.customer_id, NEW.product_id, 'insert', CONVERT_TZ(NOW(), '+00:00', '+07:00'));
# END;

CREATE TRIGGER audit_delete_product
    AFTER DELETE ON mst_product
    FOR EACH ROW
BEGIN
    INSERT audit_history_product(PRODUCT_ID, PRODUCT_NAME, ACTION_NAME, HAPPENED_AT)
        VALUES (OLD.product_id, OLD.product_name, 'delete', CONVERT_TZ(NOW(), '+00:00', '+07:00'));
END;

-- INSERT DEFAULT DATA
INSERT INTO mst_shop(shop_id, shop_name)
VALUES (3, 'Rakuten');
INSERT INTO mst_shop(shop_id, shop_name)
VALUES (1, 'Amazon');
INSERT INTO mst_shop(shop_id, shop_name)
VALUES (2, 'Yahoo');


INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (1, 'Nguyen Van A', 'a.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Admin', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (2, 'Nguyen Van B', 'b.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Admin', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (3, 'Nguyen Van C', 'c.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Editor', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (4, 'Nguyen Van D', 'd.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Reviewer', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (5, 'Nguyen Van E', 'e.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Reviewer', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (6, 'Nguyen Van F', 'f.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Reviewer', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (7, 'Nguyen Van G', 'g.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Editor', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (8, 'Nguyen Van H', 'h.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Editor', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (9, 'Nguyen Van I', 'i.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Editor', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (10, 'Nguyen Van J', 'j.nguyen@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Editor', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (11, 'Duong Tan Thanh', 'admin@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Admin', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (12, 'Duong Tan Thanh', 'editor@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Editor', null, null, null, null);
INSERT INTO mst_users(id, name, email, password, remember_token, verify_email, is_active, is_delete, group_role,
                      last_login_at, last_login_ip, created_at, updated_at)
VALUES (13, 'Duong Tan Thanh', 'reviewer@gmail.com', '$2a$12$OGp.7Sv8zMHa5TNJ6aXAg.rTQgYaMsiCbnBYOmwOkY2hqkltmnDEG', null,
        null, 1, 0, 'Reviewer', null, null, null, null);

INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at)
VALUES ('Nguyen Van A', 'a.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null);
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at)
VALUES ('Nguyen Van B', 'b.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null);
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at,group_name)
VALUES ('Nguyen Van C', 'C.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null,'DESIGN');
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at,group_name)
VALUES ('Nguyen Van D', 'd.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null,'GLOCAL');
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at,group_name)
VALUES ('Nguyen Van E', 'e.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null,'DATA');
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at)
VALUES ('Nguyen Van F', 'f.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null);
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at,group_name)
VALUES ('Nguyen Van G', 'g.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null,'DATA');
INSERT INTO mst_customer(customer_name, email, tel_num, address, is_active, created_at, updated_at,group_name)
VALUES ('Nguyen Van H', 'h.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM', 1,
        null, null,'MARKETING');
INSERT INTO mst_customer(customer_name, email, tel_num, address)
VALUES ('Nguyen Van I', 'i.nguyen@gmail.com', '012342424', '394 Ung Văn Khiêm, Phường 25, Quận Bình Thạnh, TP.HCM');


INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Ram Gygabyte', null, '8GB DDR4', null, null, 10000,0,'RAM');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Ram Asus', null, '8GB DDR5', null, null, 20000,0,'RAM');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Màn hình Edra', null, '24Inch - IPS 98% SRGB', null, null, 30000,0,'SCREEN');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Chuột logitech g102', null, 'Có dây, RGB', null, null, 40000,0,'MOUSE');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Chuột Dareu', null, 'Không dây', null, null, 50000,0,'MOUSE');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Arm màn hình monitor motion t7', null, '17 inch đến 24 inch', null, null, 60000,0,'OTHER');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Bàn phím EK87', null, 'Blue switch', null, null, 70000,0,'KEYBOARD');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Canon M10', null, 'Màu trắng', null, null, 80000,1,'CAMERA');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Len kit canon', null, '15-45mm', null, null, 90000,0,'OTHER');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Case PC 01', null, 'Màu trắng', null, null, 100000,1,'OTHER');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Case PC 02', null, 'Màu đen', null, null, 100000,1,'OTHER');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('VGA Asus RTX 3060', null, '12GB GDDR6', null, null, 100000,0,'GPU');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('VGA Asus RTX 4080', null, '12GB GDDR6', null, null, 100000,0,'GPU');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Mainboard Asus Z11PA-D8C', null, 'Z11PA-D8', null, null, 100000,0,'MAINBOARD');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('CPU Intel Core I7 12700KF', null, 'LGA1700, Turbo 5.00 GHz, 12C/20T, 25MB', null, null, 100000,0,'CPU');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('Headphone sony', null, 'true wireless', null, null, 100000,0,'HEADPHONE');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('PC 01', null, 'PC gaming', null, null, 100000,1,'PC');
INSERT INTO mst_product(product_name, product_image, description, created_at, updated_at, product_price,is_container,type)
VALUES ('PC 02', null, 'PC văn phòng', null, null, 100000,1,'PC');


INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 1, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 2, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 3, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 4, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 5, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 6, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 12, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (17, 16, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (8, 9, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (18, 6, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (18, 7, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (18, 8, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (18, 9, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (18, 11, 1);
INSERT INTO mst_product_detail(product_id, product_component, qty)
VALUES (18, 1, 2);

UPDATE mst_product
SET customer_id = 3
WHERE product_id = 17;

UPDATE mst_product
SET customer_id = 4
WHERE product_id = 18;

UPDATE mst_product
SET customer_id = 1
WHERE product_id = 8;

UPDATE mst_product
SET customer_id = 1
WHERE product_id = 4;

UPDATE mst_product
SET customer_id = 1
WHERE product_id = 11;

UPDATE mst_users
SET is_delete = 0
WHERE TRUE;
UPDATE mst_product
SET is_sales = 1
WHERE TRUE;


