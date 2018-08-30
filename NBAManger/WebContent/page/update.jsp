<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    <%@ taglib uri="/struts-tags" prefix="s"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>



 
<form action="/SSH/player_update">
<input type="hidden" name="pid" value="${player.pid}"/>
球员姓名：<input type="text" name="pname" value="${player.pname}"/></br>
<s:radio label="性别" list="#{0:'男',1:'女' }" name="psex" value="#request.player.psex"/></br>
<s:checkboxlist label="位置" list="{'中锋','大前锋','小前锋','得分后卫','控球后卫'}" name="position" value="#request.player.position"></s:checkboxlist></br>
<s:select list="#request.teams" label="球队" name="team.tid" 
headerKey="0" headerValue="请选择" listKey="tid" 
listValue="tname" value="#request.player.team.tid"></s:select></br>
 
<input type="submit" value="修改"/>
</form>

 
 
 <!--  name="dept.deptId": 部门值传给dept的deptId字段；-->
 <!-- 日期控件的使用 -->
 
 
 


</body>
</html>