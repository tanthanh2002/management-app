package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;


@Data
public class ProductDetailAction extends ActionSupport {

    public String execute() {
        String path = "./src/main/webapp/images/";
//        System.out.println(productId);
//        System.out.println(productName);
//        System.out.println(productPrice);
//        System.out.println(description);
        File fileToCreate = new File(path, productId.toString()+".png");
        try {
            FileUtils.copyFile(image, fileToCreate);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        if(productId == null){
            //insert

        }else {
            //update

        }
        return SUCCESS;
    }


    private File image;
    private String productId;
    private String productName;
    private Double productPrice;
    private String description;

}
