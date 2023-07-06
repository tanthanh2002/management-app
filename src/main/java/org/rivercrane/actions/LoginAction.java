package org.rivercrane.actions;


import com.opensymphony.xwork2.ActionSupport;
import org.mindrot.jbcrypt.BCrypt;
import org.rivercrane.models.MstUsers;
import org.rivercrane.repository.MstUsersRepo;

import java.util.Optional;

public class LoginAction extends ActionSupport {




    @Override
    public String execute() throws Exception {
        Optional<MstUsers> users = Optional.ofNullable(mstUsersRepo.getUserByEmail(getEmail()));

        if(users.isPresent()){
            if(bCrypt.checkpw(getPassword(),users.get().getPassword())){
                return  SUCCESS;
            }else {
                return INPUT;
            }
        }else{
            return ERROR;
        }

    }

    private BCrypt bCrypt = new BCrypt();
    private MstUsersRepo mstUsersRepo = MstUsersRepo.getInstance();
    private String email;
    private String password;

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}