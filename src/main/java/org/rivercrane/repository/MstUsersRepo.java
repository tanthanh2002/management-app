package org.rivercrane.repository;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.rivercrane.models.MstUsers;
import org.rivercrane.utils.CustomSqlSessionFactory;

import java.util.List;

public class MstUsersRepo {

    private SqlSessionFactory sessionFactory = CustomSqlSessionFactory.getSessionFactory();
    private static MstUsersRepo instance = new MstUsersRepo();
    private MstUsersRepo(){}

    public static MstUsersRepo getInstance(){
        return instance;
    }

    public MstUsers findUserByEmail(String email){
        SqlSession  session = sessionFactory.openSession();
        MstUsers user = session.selectOne("MstUsers.findByEmail",email);
        session.close();
        return user;
    }

    public List<MstUsers> findAll(){
        SqlSession session = sessionFactory.openSession();
        List<MstUsers> users = session.selectList("MstUsers.findAll");
        session.close();
        return users;
    }

    public List<MstUsers> findByNameAndEmail(MstUsers user){
        SqlSession session = sessionFactory.openSession();
        List<MstUsers> users = session.selectList("MstUsers.findByNameAndEmail",user);
        session.close();
        return users;
    }

}
