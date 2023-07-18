package org.rivercrane.actions;


import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.SessionAware;
import org.mindrot.jbcrypt.BCrypt;
import org.rivercrane.models.MstUsers;
import org.rivercrane.repository.MstUsersRepo;
import org.rivercrane.services.MstUserService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.Map;
import java.util.Optional;


@Data
public class LoginAction extends ActionSupport {

    @Override
    public String execute() throws Exception {

        System.out.println(MstUsers.builder().email(email).password(password).build().toString());
        try{
            if(userService.login(email,password)){
                HttpServletResponse response = ServletActionContext.getResponse();
                response.setStatus(200);
                System.out.println("login successfully");
                Map session = ActionContext.getContext().getSession();
                session.put("loggedUser",email);
                return SUCCESS;
            }else{
                addActionError(userService.getMessage());
                HttpServletResponse response = ServletActionContext.getResponse();
                response.setStatus(400);
                return INPUT;
            }
        }catch (Exception e){
            e.printStackTrace();
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(400);
            return INPUT;
        }

    }

    public String logout(){
        Map session = ActionContext.getContext().getSession();
        session.clear();
        return SUCCESS;
    }

    private MstUserService userService = MstUserService.getInstance();
    private String email;
    private String password;

}
