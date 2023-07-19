package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.RandomStringUtils;
import org.rivercrane.models.MstProduct;
import org.rivercrane.services.MstProductService;

import java.io.File;
import java.io.IOException;


@Data
public class ProductDetailAction extends ActionSupport {

    public String execute() throws IOException {
        String path = "./src/main/webapp/images/";
        String fileName = RandomStringUtils.randomAlphabetic(10) + ".png";
        File fileToCreate = new File(path, fileName);

        if(image != null){
            FileUtils.copyFile(image, fileToCreate);
        }

        MstProduct product = MstProduct.builder()
                .productId(productId)
                .productName(productName)
                .productPrice(productPrice)
                .description(description)
                .isSales(isSales)
                .productImage(path + fileName)
                .build();

        if (productId == null) {
            //insert
            System.out.println("insert");
            System.out.println(product.toString());
            productService.insert(product);
        } else {
            //update
            System.out.println("update");
            System.out.println(product.toString());
            productService.update(product);
        }
        return SUCCESS;
    }

    private MstProductService productService = MstProductService.getInstance();
    private File image;
    private Integer productId;
    private String productName;
    private Double productPrice;
    private String description;
    private Integer isSales;

}
