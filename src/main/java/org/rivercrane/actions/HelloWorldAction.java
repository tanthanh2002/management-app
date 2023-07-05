package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.rivercrane.models.MstShop;
import org.rivercrane.utils.CustomSqlSessionFactory;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

public class HelloWorldAction extends ActionSupport implements ServletRequestAware {

    public String execute(){
        try{
            if(getUsername().equals("admin") && getPassword().equals("admin123")){
                return SUCCESS;
            }else {
                return INPUT;
            }
        }catch (Exception e){
            e.printStackTrace();
            System.out.println(e.getMessage());
            return INPUT;
        }

    }

    private String name;
    private HttpServletRequest request;
    private String username;
    private String password;

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public void setServletRequest(HttpServletRequest httpServletRequest) {
        this.request = httpServletRequest;
    }

}
