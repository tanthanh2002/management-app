package org.rivercrane.actions;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import lombok.Data;
import org.apache.struts2.ServletActionContext;
import org.mindrot.jbcrypt.BCrypt;
import org.rivercrane.models.MstUsers;
import org.rivercrane.services.MstUserService;

import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

@Data
public class UserAction extends ActionSupport {

    public String execute() {
        page = page == null ? 1 : page;
        pages = userService.getTotalPage();
        List<MstUsers> users = userService.getByPage(page);

        Integer start = (page - 1) * 10 + 1;
        Integer finish = (page - 1) * 10 + users.size();

        Map context = ActionContext.getContext().getContextMap();
        context.put("totalRecord", userService.getTotalRecord());
        context.put("start", start);
        context.put("finish", finish);

        setUsers(users);
        setGroupRoles(userService.getGroupRole());
        return SUCCESS;
    }

    public String search() {
        name = name.isEmpty() ? "%" : "%" + name + "%";
        email = email.isEmpty() ? "%" : "%" + email + "%";
        page = page == null ? 1 : page;
        pages = new ArrayList<>();

        List<MstUsers> users = userService.getByNameAndEmail(name, email);

        if (!groupRole.isEmpty()) {
            users = users.stream().filter(user -> user.getGroupRole().equals(groupRole)).collect(Collectors.toList());
        }

        if (!isActive.equals(-1)) {
            users = users.stream().filter(user -> user.getIsActive().equals(isActive)).collect(Collectors.toList());
        }

        Integer totalPage = (int) Math.ceil(users.size() * 1.0 / 10);
        for (int i = 0; i < totalPage; i++) {
            pages.add(i + 1);
        }

        Integer begin = (page - 1) * 10;
        Integer end = (page - 1) * 10 + 10 > users.size() ? users.size() : (page - 1) * 10 + 10;
        setUsers(users.subList(begin, end));
        setGroupRoles(userService.getGroupRole());

        Integer start;
        Integer finish;

        start = (page - 1) * 10 + 1;
        finish = (page - 1) * 10 + users.subList(begin, end).size();

        Map context = ActionContext.getContext().getContextMap();
        context.put("totalRecord", users.size());
        context.put("start", start);
        context.put("finish", finish);

        return SUCCESS;
    }

    public String delete() {
        userService.deleteLogical(getId());
        setGroupRoles(userService.getGroupRole());
        setUsers(userService.getAll());
        return SUCCESS;
    }

    public String changeIsActive() {
        userService.changeIsActive(id);
        setGroupRoles(userService.getGroupRole());
        setUsers(userService.getAll());
        return SUCCESS;
    }

    public String update() {
        MstUsers user = MstUsers.builder()
                .id(id)
                .name(name)
                .email(email)
                .password(bCrypt.hashpw(password, BCrypt.gensalt()))
                .groupRole(groupRole)
                .build();
        try {
            if (user.getId() == null) {
                userService.insert(user);
                System.out.println("insert");
            } else {
                userService.update(user);
                System.out.println("update");
            }
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(200);
        } catch (Exception e) {
            HttpServletResponse response = ServletActionContext.getResponse();
            response.setStatus(400);
            ActionContext.getContext().getSession().put("errorMessage", "Email đã tồn tại!");
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
    private Integer page;
    private List<Integer> pages;

}
