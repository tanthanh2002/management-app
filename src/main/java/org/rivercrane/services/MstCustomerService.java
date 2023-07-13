package org.rivercrane.services;

import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstUsers;
import org.rivercrane.repository.MstCustomerRepo;

import java.util.List;

public class MstCustomerService {

    private MstCustomerRepo repo = MstCustomerRepo.getInstance();
    private static MstCustomerService instance = new MstCustomerService();

    private MstCustomerService(){}

    public static MstCustomerService getInstance(){
        return instance;
    }

    public List<MstCustomer> getAll(){
        return repo.findAll();
    }

    public List<MstCustomer> findByNameAndEmailAndAddress(String name, String email, String address){
        MstCustomer customer = MstCustomer.builder()
                .customerName(name)
                .email(email)
                .address(address)
                .build();
        return repo.findByNameAndEmailAndAddress(customer);
    }

    public void update(MstCustomer customer){
        repo.update(customer);
    }

    public void insert(MstCustomer customer) {
        repo.insert(customer);
    }
}
