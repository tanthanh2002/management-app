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

    private MstCustomerRepo() {
    }

    public static MstCustomerRepo getInstance() {
        return instance;
    }

    public List<MstCustomer> findAll() {
        SqlSession session = sessionFactory.openSession();
        List<MstCustomer> customers = session.selectList("MstCustomer.findAll");
        session.close();
        return customers;
    }

    public List<MstCustomer> findByNameAndEmailAndAddress(MstCustomer customer) {
        SqlSession session = sessionFactory.openSession();
        List<MstCustomer> customers = session.selectList("MstCustomer.findByNameAndEmailAndAddress", customer);
        session.close();
        return customers;
    }

    public void update(MstCustomer customer) throws Exception {
        SqlSession session = sessionFactory.openSession();
        List<MstCustomer> customers = session.selectList("MstCustomer.findByEmail",customer);

        if(customers.size() > 0){
            System.out.println("Email is exist");
            throw new Exception("Email is exist");
        }
        session.update("MstCustomer.update", customer);
        session.commit();
        session.close();
    }


    public void insert(MstCustomer customer) {
        SqlSession session = sessionFactory.openSession();
        session.update("MstCustomer.insert", customer);
        session.commit();
        session.close();
    }

    public int getTotalPage() {
        SqlSession session = sessionFactory.openSession();
        Integer size = session.selectOne("MstCustomer.getTotalRecord");
        Integer totalPage = (int) Math.ceil(size * 1.0 / 10);
        session.close();
        return totalPage;
    }

    public List<MstCustomer> getByPage(Integer page) {
        SqlSession session = sessionFactory.openSession();
        List<MstCustomer> customers = session.selectList("MstCustomer.findByNumPage", page * 10);
        session.close();
        return customers;
    }

    public Integer getTotalRecord() {
        SqlSession session = sessionFactory.openSession();
        Integer size = session.selectOne("MstCustomer.getTotalRecord");
        return size;
    }
}

