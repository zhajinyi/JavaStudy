<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%	pageContext.setAttribute("APP_PATH",request.getContextPath()); %>

	<meta charset="UTF-8">
	<link href="${APP_PATH}/Static/bootstrap/css/bootstrap.min.css" rel="stylesheet">
 	<script src="${APP_PATH}/Static/jquery-3.4.0.js"></script>
 	<script src="${APP_PATH}/Static/bootstrap/js/bootstrap.js"></script>
 	<!--React 的核心库-->
	<script src="${APP_PATH}/Static/reactJS/react.development.js"></script>
	<!--提供与 DOM 相关的功能-->
	<script src="${APP_PATH}/Static/reactJS/react-dom.development.js"></script>
	<!--Babel 可以将 ES6 代码转为 ES5 代码，这样我们就能在目前不支持 ES6 浏览器上执行 React 代码。
		Babel 内嵌了对 JSX 的支持。通过将 Babel 和 babel-sublime 包（package）一同使用可以让源码的语法渲染上升到一个全新的水平。-->
	<script src="${APP_PATH}/Static/reactJS/babel.min.js"></script>
