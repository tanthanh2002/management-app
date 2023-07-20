package org.rivercrane.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;

import java.util.Map;

public class LoginInterceptor implements Interceptor {
    @Override
    public void destroy() {

    }

    @Override
    public void init() {

    }

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        Map session = ActionContext.getContext().getSession();
        String loggedUser = (String) session.get("loggedUser");

        if(loggedUser == null){
            if(actionInvocation.getInvocationContext().getName().equals("login")){
                return actionInvocation.invoke();
            }
            return "index";
        }else {
            if(actionInvocation.getInvocationContext().getName().equals("login")){
                return "success";
            }
            if(actionInvocation.getInvocationContext().getName().equals("index")){
                return "verified";
            }
            return  actionInvocation.invoke();
        }
    }
}
