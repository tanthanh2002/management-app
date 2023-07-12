package org.rivercrane.repository;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.rivercrane.models.MstCustomer;
import org.rivercrane.models.MstUsers;
import org.rivercrane.utils.CustomSqlSessionFactory;

import java.util.List;

public class MstCustomerRepo {
    private SqlSessionFactory sessionFactory = CustomSqlSessionFactory.getSessionFactory();
    private static MstCustomerRepo instance = new MstCustomerRepo();
    private MstCustomerRepo(){}

    public static MstCustomerRepo getInstance(){
        return instance;
    }

    public List<MstCustomer> findAll(){
        SqlSession  session = sessionFactory.openSession();
        List<MstCustomer> customers = session.selectList("MstCustomer.findAll");
        session.close();
        return customers;
    }

    public void update(MstCustomer customer){
        SqlSession session = sessionFactory.openSession();
        session.update("MstCustomer.update",customer);
        session.commit();
        session.close();
    }


    public void insert(MstCustomer customer) {
        SqlSession session = sessionFactory.openSession();
        session.update("MstCustomer.insert",customer);
        session.commit();
        session.close();
    }
}

