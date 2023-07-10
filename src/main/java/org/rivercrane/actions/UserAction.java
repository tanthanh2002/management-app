package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.rivercrane.models.MstUsers;
import org.rivercrane.services.MstUserService;

import java.util.List;

@Data
public class UserAction extends ActionSupport {

    public String execute(){
        setUsers(userService.getAll());
        return SUCCESS;
    }

    public String search(){
        setUsers(userService.getByNameAndEmail("A","a"));
        return SUCCESS;
    }

    public String delete(){
        return SUCCESS;
    }

    private MstUserService userService = MstUserService.getInstance();
    private List<MstUsers> users;
    private String name;
    private String email;

}
