<%@page import="com.emlee.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String msg = (String) request.getAttribute("msg"); //Object형으로 나오기 때문에 문자형으로 변환시켜주기위해 앞에 (String)을 붙여줌.
	String url = (String) request.getAttribute("url");
%>

<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>