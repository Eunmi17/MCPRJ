<%@page import="com.emlee.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%String session_user_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));%>
<style>
.navbar.navbar-transparent {
    padding-top: 30px;
    padding-left: 20px;
    padding-right: 20px;
}
</style>
<nav
	class="navbar navbar-expand-lg navbar-transparent  navbar-absolute fixed-top">
	<div class="container-fluid">
		<form class="navbar-form">
			<div class="input-group no-border" style="size: 30">
				<i class="material-icons">person</i> <span><%=session_user_name%></span>
			</div>
		</form>
		<div class="collapse navbar-collapse justify-content-end"
			id="navigation">
			<form class="navbar-form">
				<div class="input-group no-border">
					<i class="material-icons">lock</i> <a id="m" href="/logout.do">로그아웃</a>
				</div>
			</form>
		</div>
	</div>
</nav>