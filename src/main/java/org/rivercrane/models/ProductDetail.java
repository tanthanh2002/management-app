package org.rivercrane.models;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ProductDetail {
    private Integer productId;
    private Integer productComponent;
    private Integer qty;
}
