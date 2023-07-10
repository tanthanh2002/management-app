package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.services.MstCustomerService;

import java.util.List;

@Data
public class CustomerAction extends ActionSupport {
    public String execute(){
        setCustomers(customerService.getAll());
        return SUCCESS;
    }

    private MstCustomerService customerService = MstCustomerService.getInstance();
    private List<MstCustomer> customers;

}
