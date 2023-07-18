package org.rivercrane.services;

import org.mindrot.jbcrypt.BCrypt;
import org.rivercrane.models.MstUsers;
import org.rivercrane.repository.MstUsersRepo;

import java.util.ArrayList;
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
        Optional<MstUsers> user = Optional.ofNullable(repo.findUserByEmail(email));
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

    public MstUsers getById(int id){
        return repo.findById(id);
    }

    public List<String> getGroupRole(){
        return  repo.getAllGroupRole();
    }

    public void deleteLogical(int id){
        repo.deleteLogical(id);
    }

    public void changeIsActive(int id){
        repo.changeIsActive(id);
    }

    public void update(MstUsers user){
        repo.update(user);
    }

    public void insert(MstUsers user){
        repo.insert(user);
    }

    public List<Integer> getTotalPage() {
        List<Integer> pages = new ArrayList<>();

        for(int i = 0 ; i <= repo.getTotalPage() ; i++){
            pages.add(i+1);
        }

        return pages;
    }

    public List<MstUsers> getByPage(Integer page) {
        return repo.getByPage(page-1);
    }
}