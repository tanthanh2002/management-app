package org.rivercrane.repository;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstProduct;
import org.rivercrane.models.MstUsers;
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

    public List<MstProduct> findByNameAndIsSales(MstProduct product) {
        SqlSession session = sessionFactory.openSession();
        List<MstProduct> products = session.selectList("MstProduct.findByNameAndIsSales", product);
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
        Integer size = session.selectOne("MstProduct.getTotalPage");
        Integer totalPage = (int) Math.ceil(size * 1.0 / 10);
        session.close();
        return totalPage;
    }

    public List<MstProduct> getByPage(Integer page) {
        SqlSession session = sessionFactory.openSession();
        List<MstProduct> products = session.selectList("MstProduct.findByNumPage", page * 10);
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
}
