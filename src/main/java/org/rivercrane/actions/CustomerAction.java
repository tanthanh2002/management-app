package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.struts2.ServletActionContext;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.utils.CSVHandler;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@Data
public class CustomerAction extends ActionSupport {
    public String execute(){
        setCustomers(customerService.getAll());
        return SUCCESS;
    }

    public String edit(){
        System.out.println(customerId+customerName);
        MstCustomer customer = MstCustomer.builder()
                .customerId(customerId)
                .customerName(customerName)
                .email(customerEmail)
                .address(customerAddress)
                .telNum(customerTel)
                .build();
        try {
            customerService.update(customer);
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return SUCCESS;
    }

    public String export(){
        List<MstCustomer> customers = customerService.getAll();

        try {
            csvHandler.exportCustomersToCSV(customers);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(400);
        } catch (IOException e) {
//            throw new RuntimeException(e);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(404);
        }
        return SUCCESS;
    }

    private MstCustomerService customerService = MstCustomerService.getInstance();
    private CSVHandler csvHandler = CSVHandler.getInstance();
    private List<MstCustomer> customers;
    private Integer customerId;
    private String customerName;
    private String customerAddress;
    private String customerTel;
    private String customerEmail;


}
