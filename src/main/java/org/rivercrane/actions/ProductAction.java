package org.rivercrane.actions;


import com.opencsv.exceptions.CsvException;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstProduct;
import org.rivercrane.models.ProductDetail;
import org.rivercrane.models.ProductDto;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.services.MstProductService;
import org.rivercrane.utils.CSVHandler;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

@Data
public class ProductAction extends ActionSupport {
    public String execute(){
        page = page == null ? 1 : page;


        pages = productService.getTotalPage();
        setPages(productService.getTotalPage());
        setProducts(productService.getByPage(page));

        Integer start = (page - 1) * 10 + 1;
        Integer finish = (page - 1) * 10 + productService.getByPage(page).size();

        Map context = ActionContext.getContext().getContextMap();
        context.put("totalRecord", productService.getTotalRecord());
        context.put("start", start);
        context.put("finish", finish);
        return SUCCESS;
    }

    public String showDetail(){
        if(productId == null)
            return SUCCESS;
        setProduct(productService.getById(productId));
        setProductDetails(productService.getProductDetailByProductId(productId));

        return SUCCESS;
    }

    public String importProduct() throws IOException, CsvException {

        String newFileName = "importProduct.csv"; // Đổi tên tệp
        String path = "./src/main/resources/csv/";
        File newFile = new File(path, newFileName);
        FileUtils.copyFile(fileCsv, newFile);

        List<MstProduct> products = csvHandler.importProductFromCSV(path+newFileName);
        System.out.println("kich thuoc: "+products.size());

        for (MstProduct i : products) {
            productService.insert(i);
        }

        return SUCCESS;
    }

    public String search(){
        productName = productName.isEmpty() ? "%" : "%" + productName + "%";
        MstProduct product = MstProduct.builder()
                .productName(productName)
                .customerId(customerId)
                .build();

        List<ProductDto> products = productService.findByName(product);

        if (priceFrom != null){
            products=products.stream().filter(p -> p.getProductPrice() >= priceFrom).collect(Collectors.toList());
        }

        if (priceTo != null){
            products=products.stream().filter(p -> p.getProductPrice() <= priceTo).collect(Collectors.toList());
        }

        if(!customerId.equals(-1)){
            products=products.stream().filter(p -> Objects.equals(p.getCustomerId(), customerId)).collect(Collectors.toList());
        }

        if(!type.equals("ALL")){
            products=products.stream().filter(p -> Objects.equals(p.getType(), type)).collect(Collectors.toList());
        }

        page = page == null ? 1 : page;

        pages = new ArrayList<>();
        Integer totalPage = (int) Math.ceil(products.size() * 1.0 / 10);
        for (int i = 0; i < totalPage; i++) {
            pages.add(i + 1);
        }

        Integer begin = (page - 1) * 10;
        Integer end = (page - 1) * 10 + 10 > products.size()  ? products.size() : (page - 1) * 10 + 10;
        setProducts(products.subList(begin, end));

        Integer start = (page - 1) * 10 + 1;
        Integer finish = (page - 1) * 10 + products.subList(begin, end).size();

        Map context = ActionContext.getContext().getContextMap();
        context.put("totalRecord", products.size());
        context.put("start", start);
        context.put("finish", finish);

        return SUCCESS;
    }

    public String delete(){
        System.out.println(productId);
        productService.delete(productId);
        return SUCCESS;
    }

    private MstProductService productService = MstProductService.getInstance();
    private List<ProductDto> products;
    private MstProduct product;
    private Integer productId;
    private String productName;
    private Integer isSales;
    private Integer priceFrom;
    private Integer priceTo;
    private String type;
    private Integer customerId;
    private Integer page;
    private List<Integer> pages;
    private List<MstCustomer> customers = MstCustomerService.getInstance().getAll();
    private List<MstProduct> components = productService.getAll();
    private List<ProductDetail> productDetails;
    private File fileCsv;
    private CSVHandler csvHandler = CSVHandler.getInstance();


}
