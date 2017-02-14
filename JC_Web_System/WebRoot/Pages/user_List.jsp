<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%@ page import ="com.bean.SysUsers"%>
<%@ page import ="java.util.*"%>
<% SysUsers currentUser=(SysUsers)session.getAttribute("currentUser"); %>
<% List<SysUsers> usersList=(List<SysUsers>)session.getAttribute("usersList"); %>
    

<!DOCTYPE html>
<html lang="zh-cn">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
<meta name="renderer" content="webkit">
<title></title>
<link rel="stylesheet" href="<%=basePath%>/Pages/common/css/pintuer.css">
<link rel="stylesheet" href="<%=basePath%>/Pages/common/css/admin.css">
<script src="<%=basePath%>/Pages/common/js/jquery.js"></script>
<script src="<%=basePath%>/Pages/common/js/pintuer.js"></script>
</head>
<body>
<form name="userList" action="userList.action" method="post">
  <div class="panel admin-panel">
    <div class="panel-head">
    <strong class="icon-reorder"> 
    <a href="userList.action">刷新用户列表</a>
    
    </strong> 
    </div>
    <div class="padding border-bottom">
      <ul class="search" style="padding-left:10px;">
        <li style="float:left;"> <a class="button border-main icon-plus-square-o" 
        	href="userList!gotoAddUser.action"> 添加用户</a> </li>
        <div style="float:right;">
         	 用户类型
          <select id="s_userType" name="s_userType" class="input"  style="width:100px; line-height:17px;display:inline-block">
            <option value="-1">不限</option>
            <option value="0">管理员</option>
            <option value="1">普通用户</option>
          </select>
          
          <input type="text" id="i_userName" placeholder="输入姓名查询" name="keywords" class="input" style="width:150px; line-height:17px;display:inline-block" />
          <a class="button border-main icon-search" onclick="changesearch()" > 
          	搜索</a></li>
          </div>
      </ul>
    </div>
    <table class="table table-hover text-center">
      <tr>
        <th>请选择</th>
        <th>登录名</th>
        <th>姓名</th>
        <th>手机号</th>
        <th>电子邮箱</th>
        <th>用户类型</th>
        <th>操作</th>
      </tr>
     <%for(SysUsers user:usersList){ %>
        <tr>
          <td style="text-align:left; padding-left:20px;">
          <input type="checkbox" name="id[]"/>
          <%=user.getUserId()%>
          </td>
          <td><%=user.getUserLoginName() %></td>
          <td><font color="#00CC99"><%=user.getUserName()%></font></td>
          <td><%=user.getUserPhoneNum()%></td>
          <td><%=user.getUserEmail()%></td>
          <td><%=user.getUserType()==0?"管理员":"用户"%></td>
          <td><div class="button-group" > 
          <a class="button border-main" id="user_edit" >
          <span class="icon-edit"></span>
        	  修改</a>
          <a class="button border-red" onclick="return del()">
          <span class="icon-trash-o"></span> 
         	 删除</a> </div></td>
        </tr>
   		<%} %>
        
      <tr>
        <td style="text-align:left; padding:19px 0;padding-left:20px;"><input type="checkbox" id="checkall"/>
         	 全选 </td>
        <td colspan="7" style="text-align:left;padding-left:20px;">
        <a href="javascript:void(0)" class="button border-red icon-trash-o" style="padding:5px 15px;" onclick="DelSelect()">批量删除</a> 
        
         </td>
      </tr>
      <tr>
        <td colspan="8"><div class="pagelist"> <a href="">上一页</a> <span class="current">1</span><a href="">2</a><a href="">3</a><a href="">下一页</a><a href="">尾页</a> </div></td>
      </tr>
    </table>
  </div>
</form>
<script type="text/javascript">

//搜索
function changesearch(){	
	
	var  IuserName=document.getElementById("i_userName").value;
	var  SuserType=document.getElementById("s_userType");
	var index=SuserType.selectedIndex; 
	var s_value=SuserType.options[index].value;
	window.location.href="userList!searchUserByT_N.action?userType="+s_value+"&userName="+IuserName; 
}

//单个编辑
$(function(){
 $("[id=user_edit]").click(function(){
 	var userId = $(this).parent().parent().parent().find("td:eq(0)").text();
    
    //alert(userType);
    window.location.href = "userList!gotoEditUser.action?userId="
    	+userId; 
});

});


//单个删除
function del(){
	if(confirm("您确定要删除吗?")){
		
	}
}


//全选
$("#checkall").click(function(){ 
  $("input[name='id[]']").each(function(){
	  if (this.checked) {
		  this.checked = false;
	  }
	  else {
		  this.checked = true;
	  }
  });
})

//批量删除
function DelSelect(){
	var Checkbox=false;
	 $("input[name='id[]']").each(function(){
	  if (this.checked==true) {		
		Checkbox=true;	
	  }
	});
	if (Checkbox){
		var t=confirm("您确认要删除选中的内容吗？");
		if (t==false) return false;		
		$("#listform").submit();		
	}
	else{
		alert("请选择您要删除的内容!");
		return false;
	}
}
</script>
</body>
</html>