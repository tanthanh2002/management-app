package org.rivercrane.actions;

import com.opencsv.exceptions.CsvException;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.struts2.ServletActionContext;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.utils.CSVHandler;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Data
public class CustomerAction extends ActionSupport {
    public String execute() {
        page = page == null ? 1 : page;
        pages = customerService.getTotalPage();
        setPages(customerService.getTotalPage());
        setCustomers(customerService.getByPage(page));
        return SUCCESS;
    }

    public String edit() {
        MstCustomer customer = MstCustomer.builder()
                .customerId(customerId)
                .customerName(customerName)
                .email(customerEmail)
                .address(customerAddress)
                .telNum(customerTel)
                .build();
        try {
            customerService.update(customer);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(400);
        }
        return SUCCESS;
    }

    public String insert() {

        try {
            MstCustomer customer = MstCustomer.builder()
                    .customerName(customerName)
                    .email(customerEmail)
                    .address(customerAddress)
                    .telNum(customerTel)
                    .isActive(isActive)
                    .build();
            customerService.insert(customer);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(400);
        }
        return SUCCESS;
    }

    public String export() {
        List<MstCustomer> customers = customerService.getAll();

        try {
            csvHandler.exportCustomersToCSV(customers);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(200);
        } catch (IOException e) {
//            throw new RuntimeException(e);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(404);
        }
        return SUCCESS;
    }

    public String search() {

        customerName = customerName.isEmpty() ? "%" : "%" + customerName + "%";
        customerEmail = customerEmail.isEmpty() ? "%" : "%" + customerEmail + "%";
        customerAddress = customerAddress.isEmpty() ? "%" : "%" + customerAddress + "%";

        MstCustomer customer = MstCustomer.builder()
                .customerName(customerName)
                .email(customerEmail)
                .address(customerAddress)
                .isActive(isActive)
                .build();

        List<MstCustomer> customers = customerService.findByNameAndEmailAndAddress(customerName, customerEmail, customerAddress);

        if (!isActive.equals(-1)) {
            customers = customers.stream().filter(i -> i.getIsActive().equals(isActive)).collect(Collectors.toList());
        }

        page = page == null ? 1 : page;

        pages = new ArrayList<>();
        Integer totalPage = (int) Math.ceil(customers.size() * 1.0 / 10);
        for (int i = 0; i < totalPage; i++) {
            pages.add(i + 1);
        }

        Integer begin = (page - 1) * 10;
        Integer end = (page - 1) * 10 + 10 > customers.size()  ? customers.size() : (page - 1) * 10 + 10;
        setCustomers(customers.subList(begin, end));
        return SUCCESS;
    }

    public String importCustomer() throws IOException, CsvException {
        String path = "./src/main/resources/csv/" + "customer.csv";
        List<MstCustomer> customers = csvHandler.importCustomersFromCSV(path);
        for (MstCustomer i : customers) {
            try {
                customerService.insert(i);
            } catch (Exception e) {
//                e.printStackTrace();
                System.out.println("Thêm không thành công: " + i.getCustomerName());
            }
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
    private Integer isActive;
    private Integer page;
    private List<Integer> pages;


}
