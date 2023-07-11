package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.mindrot.jbcrypt.BCrypt;
import org.rivercrane.models.MstUsers;
import org.rivercrane.services.MstUserService;

import java.util.List;
import java.util.stream.Collectors;

@Data
public class UserAction extends ActionSupport {

    public String execute(){
        setUsers(userService.getAll());
        setGroupRoles(userService.getGroupRole());
        return SUCCESS;
    }

    public String search(){
        name= name.isEmpty() ? "%" : "%" + name + "%";
        email= email.isEmpty() ? "%" : "%" + email + "%";
        List<MstUsers> searchedUsers = userService.getByNameAndEmail(name,email);

        if(!groupRole.isEmpty()){
            searchedUsers = searchedUsers.stream().filter(user -> user.getGroupRole().equals(groupRole)).collect(Collectors.toList());
        }

        if(!isActive.equals(-1)){
            searchedUsers = searchedUsers.stream().filter(user -> user.getIsActive().equals(isActive)).collect(Collectors.toList());
        }

        setGroupRoles(userService.getGroupRole());
        setUsers(searchedUsers);
        return SUCCESS;
    }

    public String delete(){
        userService.deleteLogical(getId());
        setGroupRoles(userService.getGroupRole());
        setUsers(userService.getAll());
        return SUCCESS;
    }

    public String changeIsActive(){
        userService.changeIsActive(id);
        setGroupRoles(userService.getGroupRole());
        setUsers(userService.getAll());
        return SUCCESS;
    }

    public String update(){
        MstUsers user = MstUsers.builder()
                .id(id)
                .name(name)
                .email(email)
                .groupRole(groupRole)
                .build();
        try{
            userService.update(user);
        }catch (Exception e){
            e.printStackTrace();
        }
        return SUCCESS;

    }

    private MstUserService userService = MstUserService.getInstance();
    private BCrypt bCrypt = new BCrypt();
    private List<MstUsers> users;
    private List<String> groupRoles;
    private Integer id;
    private String name;
    private String email;
    private String groupRole;
    private Integer isActive;
    private String password;

}
