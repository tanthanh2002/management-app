package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.rivercrane.models.HistoryProduct;
import org.rivercrane.services.MstProductService;

import java.util.List;


public class ProductHistoryAction extends ActionSupport {
    public String execute() {
        // Lấy thông tin lịch sử chỉnh sửa sản phẩm có id là productId
        historyProducts = productService.findHistoryProductById(productId);
        return SUCCESS;
    }

    public Integer getProductId() {
        return productId;
    }

    public void setProductId(Integer productId) {
        this.productId = productId;
    }

    public List<HistoryProduct> getHistoryProducts() {
        return historyProducts;
    }

    private Integer productId;
    private MstProductService productService = MstProductService.getInstance();
    private List<HistoryProduct> historyProducts;


}
