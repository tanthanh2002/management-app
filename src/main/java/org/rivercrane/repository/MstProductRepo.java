package org.rivercrane.repository;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.rivercrane.models.*;
import org.rivercrane.utils.CustomSqlSessionFactory;

import java.util.List;

public class MstProductRepo {
    private SqlSessionFactory sessionFactory = CustomSqlSessionFactory.getSessionFactory();
    private static MstProductRepo instance = new MstProductRepo();

    private MstProductRepo() {
    }

    public static MstProductRepo getInstance() {
        return instance;
    }

    public List<MstProduct> findAll() {
        SqlSession session = sessionFactory.openSession();
        List<MstProduct> products = session.selectList("MstProduct.findAll");
        session.close();
        return products;
    }

    public MstProduct findById(Integer id) {
        SqlSession session = sessionFactory.openSession();
        MstProduct product = session.selectOne("MstProduct.findById", id);
        session.close();
        return product;
    }

    public List<ProductDto> findByName(MstProduct product) {
        SqlSession session = sessionFactory.openSession();
        List<ProductDto> products = session.selectList("MstProduct.findByName", product);
        session.close();
        return products;
    }

    public void delete(int customerId) {
        SqlSession session = sessionFactory.openSession();
        session.delete("MstProduct.delete", customerId);
        session.commit();
        session.close();
    }

    public int getTotalPage() {
        SqlSession session = sessionFactory.openSession();
        Integer size = session.selectOne("MstProduct.getTotalRecord");
        Integer totalPage = (int) Math.ceil(size * 1.0 / 10);
        session.close();
        return totalPage;
    }

    public List<ProductDto> getByPage(Integer page) {
        SqlSession session = sessionFactory.openSession();
        List<ProductDto> products = session.selectList("MstProduct.findByNumPage", page * 10);
        session.close();
        return products;
    }

    public void update(MstProduct product) {
        SqlSession session = sessionFactory.openSession();
        session.update("MstProduct.update", product);
        session.commit();
        session.close();
    }

    public void insert(MstProduct product) {
        SqlSession session = sessionFactory.openSession();
        session.update("MstProduct.insert", product);
        session.commit();
        session.close();
    }

    public Integer getTotalRecord() {
        SqlSession session = sessionFactory.openSession();
        Integer size = session.selectOne("MstProduct.getTotalRecord");
        return size;
    }

    public void updateProductDetails(Integer id){
        SqlSession session = sessionFactory.openSession();
        session.update("MstProduct.update_product_detail", id);
        session.commit();
        session.close();
    }

    public void deteleProductDetailsById(int productId){
        SqlSession session = sessionFactory.openSession();
        session.delete("MstProduct.deleteProductDetailById", productId);
        session.commit();
        session.close();
    }

    public void insertProductDetail(ProductDetail productDetail) {
        SqlSession session = sessionFactory.openSession();
        session.insert("MstProduct.insertProductDetail", productDetail);
        session.commit();
        session.close();
    }

    public int getNewestId() {
        SqlSession session = sessionFactory.openSession();
        int newestId = session.selectOne("MstProduct.selectNewestId");
        session.close();
        return newestId;
    }

    public List<ProductDetail> getProductDetailByProductId(int id) {
        SqlSession session = sessionFactory.openSession();
        List<ProductDetail> productDetails = session.selectList("MstProduct.getProductDetailByProductId", id);
        session.close();
        return productDetails;
    }

    public List<HistoryProduct> findHistoryProductById(int productId){
        SqlSession session = sessionFactory.openSession();
        List<HistoryProduct> historyProducts = session.selectList("MstProduct.findHistoryProductById", productId);
        session.close();
        return historyProducts;
    }
}
