package org.rivercrane.services;

import org.rivercrane.models.MstProduct;
import org.rivercrane.models.MstUsers;
import org.rivercrane.models.ProductDetail;
import org.rivercrane.models.ProductDto;
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

    public List<ProductDto> findByName(MstProduct product){
        return repo.findByName(product);
    }

    public void delete(int productId){
        repo.delete(productId);
    }

    public List<Integer> getTotalPage() {
        List<Integer> pages = new ArrayList<>();

        for(int i = 0 ; i < repo.getTotalPage() ; i++){
            pages.add(i+1);
        }

        return pages;
    }

    public Integer getTotalRecord(){
        return repo.getTotalRecord();
    }
    public List<ProductDetail> getProductDetailByProductId(int id){
        return  repo.getProductDetailByProductId(id);
    }
    public List<ProductDto> getByPage(Integer page) {
        return repo.getByPage(page-1);
    }

    public void update(MstProduct product) {
        repo.update(product);
    }

    public void insert(MstProduct product) {
        repo.insert(product);
    }

    public void insertProductDetail(ProductDetail productDetail){
        repo.insertProductDetail(productDetail);
    }

    public void updateProductDetails(Integer id){
        repo.updateProductDetails(id);
    }

    public void deleteProductDetailsById(int productId){
        repo.deteleProductDetailsById(productId);
    }

    public int getNewestId() {
        return repo.getNewestId();
    }
}
