package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.rivercrane.models.MstUsers;
import org.rivercrane.services.MstUserService;

import java.util.List;


@Data
public class SearchUserAction extends ActionSupport {
    public String execute(){
        name= name.isEmpty() ? "%" : "%" + name + "%";
        email= email.isEmpty() ? "%" : "%" + email + "%";
        List<MstUsers> searchedUsers = userService.getByNameAndEmail(name,email);
        setUsers(searchedUsers);
        return SUCCESS;
    }

    private MstUserService userService = MstUserService.getInstance();

    private List<MstUsers> users;
    private String name;
    private String email;
    private String groupRole;
    private Integer isActive;
}
