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
}
