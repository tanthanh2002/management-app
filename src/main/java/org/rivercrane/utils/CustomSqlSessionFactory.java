package org.rivercrane.utils;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

public class CustomSqlSessionFactory {
    private static SqlSessionFactory sessionFactory = getSessionFactory();

    public static SqlSessionFactory getSessionFactory() {
        if (sessionFactory == null) {
            InputStream stream;
            try {
                stream = Resources.getResourceAsStream("mybatis-config.xml");
                sessionFactory = new SqlSessionFactoryBuilder().build(stream);
            } catch (IOException e) {
                throw new RuntimeException(e.getCause());
            }
        }
        return sessionFactory;
    }

    public static SqlSession openSession() {
        return sessionFactory.openSession();
    }
}
