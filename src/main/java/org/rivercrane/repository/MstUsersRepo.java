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

    public MstUsers findById(int id){
        SqlSession  session = sessionFactory.openSession();
        MstUsers user = session.selectOne("MstUsers.findById",id);
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

    public List<String> getAllGroupRole(){
        SqlSession session = sessionFactory.openSession();
        List<String> groupRoles = session.selectList("MstUsers.getDisctintGroupRole");
        session.close();
        return groupRoles;
    }

    public void deleteLogical(int id){
        SqlSession session = sessionFactory.openSession();
        session.update("MstUsers.updateIsDeletedById",id);
        session.commit();
        session.close();
    }

    public void changeIsActive(int id){
        SqlSession session = sessionFactory.openSession();
        session.update("MstUsers.updateIsActiveById",id);
        session.commit();
        session.close();
    }

    public void update(MstUsers user){
        SqlSession session = sessionFactory.openSession();
        session.update("MstUsers.updateUser",user);
        session.commit();
        session.close();
    }

    public void insert(MstUsers user){
        SqlSession session = sessionFactory.openSession();
        session.update("MstUsers.insert",user);
        session.commit();
        session.close();
    }

    public void updateIpByEmail(MstUsers user){
        SqlSession session = sessionFactory.openSession();
        session.update("MstUsers.updateIpByEmail",user);
        session.commit();
        session.close();
    }

    public int getTotalPage() {
        SqlSession session = sessionFactory.openSession();
        Integer size = session.selectOne("MstUsers.getTotalPage");
        Integer totalPage = (int) Math.ceil(size *1.0 / 10);
        session.close();
        return totalPage;
    }

    public List<MstUsers> getByPage(Integer page) {
        SqlSession session = sessionFactory.openSession();
        List<MstUsers> users = session.selectList("MstUsers.findByNumPage",page*10);
        session.close();
        return users;
    }
}
