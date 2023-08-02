package org.rivercrane.actions;


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstProduct;
import org.rivercrane.models.ProductDetail;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.services.MstProductService;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
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
        setProduct(productService.getById(productId));
        setProductDetails(productService.getProductDetailByProductId(productId));

        return SUCCESS;
    }

    public String search(){
        productName = productName.isEmpty() ? "%" : "%" + productName + "%";
        isSales = isSales == -1 ? 3 : (isSales == 1 ? 0 : 1);
        MstProduct product = MstProduct.builder()
                .productName(productName)
                .isSales(isSales)
                .build();

        List<MstProduct> products = productService.findByNameAndIsSales(product);

        if (priceFrom != null){
            products=products.stream().filter(p -> p.getProductPrice() >= priceFrom).collect(Collectors.toList());
        }

        if (priceTo != null){
            products=products.stream().filter(p -> p.getProductPrice() <= priceTo).collect(Collectors.toList());
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
    private List<MstProduct> products;
    private MstProduct product;
    private Integer productId;
    private String productName;
    private Integer isSales;
    private Integer priceFrom;
    private Integer priceTo;
    private Integer page;
    private List<Integer> pages;
    private List<MstCustomer> customers = MstCustomerService.getInstance().getAll();
    private List<MstProduct> components = productService.getAll();
    private List<ProductDetail> productDetails;


}
