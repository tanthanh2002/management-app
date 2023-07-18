package org.rivercrane.services;

import org.rivercrane.models.MstProduct;
import org.rivercrane.models.MstUsers;
import org.rivercrane.repository.MstProductRepo;

import java.util.ArrayList;
import java.util.List;

public class MstProductService {

    private MstProductRepo repo = MstProductRepo.getInstance();
    private static MstProductService instane = new MstProductService();
    private MstProductService(){}
    public static MstProductService getInstance(){
        return instane;
    }


    public List<MstProduct> getAll() {
        return repo.findAll();
    }

    public MstProduct getById(Integer id){
        return repo.findById(id);
    }

    public List<MstProduct> findByNameAndIsSales(MstProduct product){
        return repo.findByNameAndIsSales(product);
    }

    public void delete(int productId){
        repo.delete(productId);
    }

    public List<Integer> getTotalPage() {
        List<Integer> pages = new ArrayList<>();

        for(int i = 0 ; i <= repo.getTotalPage() ; i++){
            pages.add(i+1);
        }

        return pages;
    }

    public List<MstProduct> getByPage(Integer page) {
        return repo.getByPage(page-1);
    }

    public void update(MstProduct product) {
        repo.update(product);
    }

    public void insert(MstProduct product) {
        repo.insert(product);
    }
}
