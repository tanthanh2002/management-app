package org.rivercrane.services;

import org.rivercrane.models.MstCustomer;
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

    public void update(MstCustomer customer){
        repo.update(customer);
    }

}
