package org.rivercrane.actions;

import com.opencsv.exceptions.CsvException;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.services.MstCustomerService;
import org.rivercrane.utils.CSVHandler;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Data
public class CustomerAction extends ActionSupport {
    public String execute() {
        page = page == null ? 1 : page;
        pages = customerService.getTotalPage();
        setPages(customerService.getTotalPage());
        setCustomers(customerService.getByPage(page));

        Integer start = (page - 1) * 10 + 1;
        Integer finish = (page - 1) * 10 + customerService.getByPage(page).size();

        Map context = ActionContext.getContext().getContextMap();
        context.put("totalRecord", customerService.getTotalRecord());
        context.put("start", start);
        context.put("finish", finish);
        return SUCCESS;
    }

    public String edit() {
        MstCustomer customer = MstCustomer.builder()
                .customerId(customerId)
                .customerName(customerName)
                .email(customerEmail)
                .address(customerAddress)
                .telNum(customerTel)
                .groupName(groupName)
                .customerCode(customerCode)
                .build();
        System.out.println(customer.toString());
        try {
            customerService.update(customer);
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(200);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
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
                    .groupName(groupName)
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

        if (!groupName.equals("ALL")){
            customers = customers.stream().filter(i -> i.getGroupName().equals(groupName)).collect(Collectors.toList());
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

        Integer start = (page - 1) * 10 + 1;
        Integer finish = (page - 1) * 10 + customers.subList(begin, end).size();

        Map context = ActionContext.getContext().getContextMap();
        context.put("totalRecord", customers.size());
        context.put("start", start);
        context.put("finish", finish);
        return SUCCESS;
    }

    public String importCustomer() throws IOException, CsvException {

        String newFileName = "import.csv"; // Đổi tên tệp
        String path = "./src/main/resources/csv/";
        File newFile = new File(path, newFileName);
        FileUtils.copyFile(fileCsv, newFile);

        List<MstCustomer> customers = csvHandler.importCustomersFromCSV(path+newFileName);
        System.out.println("kich thuoc: "+customers.size());

        for (MstCustomer i : customers) {
            try {
                i.setIsActive(1);
                if(i.getGroupName() == null){
                    i.setGroupName("GLOBAL");
                }
                customerService.insert(i);
            }catch(SQLIntegrityConstraintViolationException e){
                HttpServletResponse response = ServletActionContext.getResponse();
                response.setStatus(404);
                System.out.println(e.getMessage());
                System.out.println("failed");
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
    private String groupName;
    private String customerCode;
    private List<Integer> pages;
    private File fileCsv;
}
