<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script type="text/javascript">
function del(pid){
	//用户点击确定
	if(confirm("是否确定删除")){
		window.location="${pageContext.request.contextPath }/player_delete?pid="+pid;
	} 
}
</script>
</head>
<body>

<%-- <s:if test="null!=#request.palyers&&!#request.players.isEmpty()"> --%>
    <table width="500px" align="center" border="1px">
    <tr align="center"><th>球员名</th><th>球员性别</th><th>场上位置</th><th>所在球队</th><th>操作</th>
    </tr>
    <!-- 遍历集合 -->
    <s:iterator var="player" value="#request.players" >
     
    <tr align="center">
      <td>${player.pname}</td>
       <td><s:if test="#player.psex==0">男</s:if><s:else>女</s:else></td>
       <td><s:iterator value="#player.position" var="position">
               ${position}&nbsp;
           </s:iterator></td> 
       <td>${player.team.tname}</td>
       <!--  -->
       <td><a href="${pageContext.request.contextPath }/player_updateInit?pid=${player.pid }">修改</a> 
       |<a href="${pageContext.request.contextPath }/player_delete?pid=${player.pid }" >删除</a></td>
    
    </tr>
    
    
    </s:iterator>
    
    </table>
<%-- </s:if> --%>
<%-- <s:else>
 没有记录
</s:else> --%>
</body>
</html>