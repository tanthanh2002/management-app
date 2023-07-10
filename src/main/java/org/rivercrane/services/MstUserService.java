package org.rivercrane.services;

import org.mindrot.jbcrypt.BCrypt;
import org.rivercrane.models.MstUsers;
import org.rivercrane.repository.MstUsersRepo;

import java.util.List;
import java.util.Optional;

public class MstUserService {

    private static MstUserService instance = new MstUserService();
    private BCrypt bCrypt = new BCrypt();
    private MstUsersRepo repo = MstUsersRepo.getInstance();
    private String message;
    private MstUserService() {
    }

    public static MstUserService getInstance(){
        return instance;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Boolean login(String email, String password){
        System.out.println(email);
        Optional<MstUsers> user = Optional.ofNullable(repo.findUserByEmail(email));
        System.out.println(user.get().getEmail());
        if(user.isPresent()){
            if(bCrypt.checkpw(password,user.get().getPassword())){
                setMessage("Đăng nhập thành công!");
                return Boolean.TRUE;
            }else {
                setMessage("Mật khẩu chưa chính xác!");
                return Boolean.FALSE;
            }
        }else{
            setMessage("Email không tồn tại!");
            return Boolean.FALSE;
        }
    }

    public List<MstUsers> getAll(){
        return repo.findAll();
    }

    public List<MstUsers> getByNameAndEmail(String name, String email){
        MstUsers user = MstUsers.builder()
                .email(email)
                .name(name)
                .build();
        return repo.findByNameAndEmail(user);
    }

}