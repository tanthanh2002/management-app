package org.rivercrane.repository;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.rivercrane.models.MstUsers;
import org.rivercrane.utils.CustomSqlSessionFactory;

public class MstUsersRepo {

    private SqlSessionFactory sessionFactory = CustomSqlSessionFactory.getSessionFactory();
    private static MstUsersRepo instance = new MstUsersRepo();
    private MstUsersRepo(){}

    public static MstUsersRepo getInstance(){
        return instance;
    }

    public MstUsers getUserByEmail(String email){
        SqlSession  session = sessionFactory.openSession();
        MstUsers user = session.selectOne("MstUsers.findByEmail",email);
        return user;
    }
}
