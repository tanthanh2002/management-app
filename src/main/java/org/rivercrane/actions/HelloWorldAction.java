package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.rivercrane.models.MstShop;
import org.rivercrane.utils.CustomSqlSessionFactory;

import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class HelloWorldAction extends ActionSupport {

    private String name="123";

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String execute(){
        this.name = "123455";
        SqlSession session = CustomSqlSessionFactory.openSession();
        List<MstShop> shops = session.selectList("MstShop.selectAll");
        for (MstShop i:shops) {
            if(i != null) {
                System.out.println(i.getShopName());
            }
        }
        return SUCCESS;
    }
}
