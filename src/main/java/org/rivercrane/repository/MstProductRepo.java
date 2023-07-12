package org.rivercrane.repository;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.rivercrane.models.MstProduct;
import org.rivercrane.utils.CustomSqlSessionFactory;

import java.util.List;

public class MstProductRepo {
    private SqlSessionFactory sessionFactory = CustomSqlSessionFactory.getSessionFactory();
    private static MstProductRepo instance = new MstProductRepo();
    private MstProductRepo(){}

    public static MstProductRepo getInstance(){
        return instance;
    }

    public List<MstProduct> findAll(){
        SqlSession session = sessionFactory.openSession();
        List<MstProduct> products = session.selectList("MstProduct.findAll");
        session.close();
        return products;
    }
}
