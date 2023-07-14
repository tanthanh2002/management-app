package org.rivercrane.services;

import org.rivercrane.models.MstProduct;
import org.rivercrane.repository.MstProductRepo;

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

    public List<MstProduct> findByNameAndIsSales(MstProduct product){
        return repo.findByNameAndIsSales(product);
    }

    public void delete(int productId){
        repo.delete(productId);
    }
}
