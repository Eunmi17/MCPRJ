<%@page import="com.emlee.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String url = (String) request.getAttribute("url");
%>

<script>
	location.href="<%=url%>";
</script>