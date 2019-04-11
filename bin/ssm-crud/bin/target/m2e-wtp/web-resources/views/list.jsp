<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	pageContext.setAttribute("APP_PATH",request.getContextPath()); %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>

<!-- web路径问题 ：
	1、不以/开始的为相对路径，找资源，以当前资源的路径为基础
	2、绝对路径：以服务器的根路径为基准，

-->
<script src="${APP_PATH}/static/js/jquery-3.3.1.min.js" type="text/javascript"></script>
<link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
<script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<style>
#operate_row{
	margin: 10px 0 10px 0;
}	
#content_table th{
	text-align: center;
}
#pageinfo span{
	background: #337ab7;
	color: white;
	border-radius: 3px;
	font-size: 18px;
}
</style>
<body>
	<!-- 搭建显示页面 -->
	<div class="container">
		<!-- 标题栏 -->
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<!-- 按钮 -->
		<div class="row" id="operate_row">
			<div class="col-md-3 col-md-offset-9">
				<button type="button" class="btn btn-primary">新增</button>
				<button type="button" class="btn btn-danger">删除</button>
			</div>
		</div>
		<!-- 表格数据 -->
		<div class="row">
			<div class="col-md-12">
				<table id="content_table" class="table table-striped table-hover" style="text-align: center;">
					<tr>
						<th>#</th>
						<th>名字</th>
						<th>性别</th>
						<th>电子邮箱</th>
						<th>所在部门</th>
						<th>操作</th>
					</tr>
					
					<c:forEach items="${PageInfo.list}" var="emp">
						<tr>
							<td>${emp.empId }</td>
							<td>${emp.empName }</td>
							<td>${emp.gender=="M"?"男":"女" }</td>
							<td>${emp.email}</td>
							<td>${emp.department.deptName}</td>
							<td>
								<button type="button" class="btn btn-success">
									<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
									修改
								</button>
								<button type="button" class="btn btn-danger">
									<span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
									删除
								</button>							
							</td>
						</tr>					
					</c:forEach>
					

				</table>
			</div>
		</div>
		<!-- 分页信息栏 -->
		<div class="row">
			<div id="pageinfo" class="col-md-6" style="margin-top: 25px;">
				当前第<span>${PageInfo.pageNum}</span>页,总<span>${PageInfo.pages }</span>页,共<span>${PageInfo.total }</span>条记录
			</div>
			<div class="col-md-6">
				<nav aria-label="Page navigation">
				  <ul class="pagination">
				  	<li><a href="${APP_PATH}/emps?pn=1">首页</a></li>
				  	
					<c:choose>
						<c:when test="${PageInfo.hasPreviousPage}">
						    <li>
						    	<a href="${APP_PATH}/emps?pn=${PageInfo.pageNum-1}" aria-label="Previous">
						    	<span aria-hidden="true">&laquo;</span>
						      	</a>
						    </li>						
						</c:when>
						<c:otherwise>
						    <li class="disabled">
						    	<a href="#" aria-label="Previous">
						    	<span aria-hidden="true">&laquo;</span>
						      	</a>
						    </li>						
						</c:otherwise>
					</c:choose>

				    <c:forEach items="${PageInfo.navigatepageNums }" var="page_Num">
				    <c:if test="${ page_Num==PageInfo.pageNum}">
				    	<li class="active"><a href="">${page_Num}</a></li> 
				    </c:if>
				    <c:if test="${ page_Num != PageInfo.pageNum}">
				    	<li><a href="${APP_PATH}/emps?pn=${page_Num}">${page_Num}</a></li> 
				    </c:if>
				    </c:forEach>
				    
					<c:choose>
						<c:when test="${PageInfo.hasNextPage}">
						    <li>
						    	<a href="${APP_PATH}/emps?pn=${PageInfo.pageNum+1}" aria-label="Next">
						    	<span aria-hidden="true">&raquo;</span>
						      	</a>
						    </li>						
						</c:when>
						<c:otherwise>
						    <li class="disabled">
				      <a href="#" aria-label="Next">
				        <span aria-hidden="true">&raquo;</span>
				      </a>
				    </li>						
						</c:otherwise>
					</c:choose>				    

				    <li><a href="${APP_PATH}/emps?pn=${PageInfo.pages}">末页</a></li>
				  </ul>
				</nav>				
			</div>
		</div>
	</div>

</body>
</html>