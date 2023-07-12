package org.rivercrane.actions;


import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstProduct;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.services.MstProductService;

import java.util.List;

@Data
public class ProductAction extends ActionSupport {
    public String execute(){
        setProducts(productService.getAll());
        return SUCCESS;
    }

    private MstProductService productService = MstProductService.getInstance();
    private List<MstProduct> products;
}
