package com.action;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.bean.PageBean;
import com.bean.SysUsers;
import com.opensymphony.xwork2.ActionSupport;
import com.service.IUserService;

public class UserAction extends ActionSupport {
	/*@Override
	public String execute() throws Exception {
		System.out.println("点击登录执行该方法");
		return "SUCCESS";
	}*/
	
	
	private static final long serialVersionUID = 1L;

	protected IUserService userService;     //该对象采用 Spring 依赖注入
	
	public int pageCurrent; // 第几页     
	//public PageBean<SysUsers> pageBean; // 包含分布信息的bean ,实例化泛型类为SysUsers类
	
	@Override
	public String execute() throws Exception {
		// System.out.println("点击登录执行该方法excute");
		return "";

	}

	public String login(){
		HttpServletRequest request=ServletActionContext.getRequest();
		String username=request.getParameter("username");
		String password=request.getParameter("password");
		
		Integer userId = userService.validLogin(username, password);
		if (userId != null) {
			SysUsers user=userService.getUserByID(userId);
			request.getSession().setAttribute("currentUser", user);
			this.pageCurrent=1;
			//String s=this.pager();
			PageBean pageBean = userService.queryForPage(this.pageCurrent);
			
			request.getSession().setAttribute("pageBean", pageBean);
			 
			return "LoginSuccess";
		} else {
			return "LoginFail";
		}
	}
	
	public String logOut(){
		
		HttpServletRequest request=ServletActionContext.getRequest();
		request.getSession().removeAttribute("currentUser");
		//System.out.print("移除session完成");
		request.getSession().removeAttribute("usersList");
		return "LogOut";
	}
	
	
	//Spring依赖注入的对象必须有get、set方法。方法命名规则：get+变量名。为了便于记忆，变量名第一个字母可以大写。
    public void setUserService(IUserService userLoginService)    
    {
        this.userService = userLoginService;
    }
    public IUserService getUserService()
    {
        return userService;
    }

	public String pager(){  
	    //分页的pageBean,参数pageSize表示每页显示记录数,page为当前页         
	    //this.pageBean = userService.queryForPage( pageCurrent);        
	    return "userList";  
	} 
	
	
}
