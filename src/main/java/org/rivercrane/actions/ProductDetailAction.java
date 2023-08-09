package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstProduct;
import org.rivercrane.models.ProductDetail;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.services.MstProductService;

import java.io.File;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;


@Data
public class ProductDetailAction extends ActionSupport {

    public String execute() throws IOException {
        String path = "./src/main/webapp/images/";
        String fileName = RandomStringUtils.randomAlphabetic(10) + ".png";
        File fileToCreate = new File(path, fileName);

        if (image != null) {
            FileUtils.copyFile(image, fileToCreate);
        }else{
            fileName = "null";
        }
        List<String> productDetails = Arrays.asList(components.split(";"));

        MstProduct product = MstProduct.builder()
                .productId(productId)
                .productName(productName)
                .productPrice(productPrice)
                .description(description)
                .isSales(isSales)
                .isContainer(isContainer)
                .productImage("../images/"+ fileName)
                .customerId(customerId == -1 ? null : customerId)
                .build();
        System.out.println(product.toString());
        if (productId == null) {
            if (isSales.equals(-1)) {
                product.setIsSales(1);
            }
            productService.insert(product);
        } else {
            if (isSales.equals(-1)) {
                product.setIsSales(productService.getById(productId).getIsSales());
            }
            productService.update(product);

        }

        int newProductId = productService.getNewestId();
        if(productId != null){
            productService.deleteProductDetailsById(productId);
        }

        //add productdetail

        for (String item : productDetails) {
            if(item.equals("")){
                continue;
            }

            String[] info = item.split(":");
            String id = info[0];
            String qty = info[1];
            ProductDetail detail = ProductDetail.builder()
                    .productId(productId == null ? newProductId : productId)
                    .productComponent(Integer.parseInt(id))
                    .qty(Integer.parseInt(qty))
                    .build();
            productService.insertProductDetail(detail);
        }


        if(productId != null){
            productService.updateProductDetails(productId);
        }

        return SUCCESS;
    }

    private MstProductService productService = MstProductService.getInstance();
    private MstCustomerService customerService = MstCustomerService.getInstance();
    private File image;
    private Integer productId;
    private String productName;
    private Double productPrice;
    private String description;
    private Integer isSales;
    private Integer customerId;
    private String components;
    private Integer isContainer;
}
