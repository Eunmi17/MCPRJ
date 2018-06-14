<%@page import="com.emlee.DTO.fileDTO"%>
<%@page import="oracle.jdbc.proxy.annotation.GetProxy"%>
<%@page import="com.emlee.DTO.boardDTO"%>
<%@page import="com.emlee.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">
<meta
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"
	name="viewport" />
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<!-- Favicons -->
<link rel="apple-touch-icon" href="bootstrap/assets/img/icon.png">
<link rel="icon" href="bootstrap/assets/img/icon.png">
<title>MC</title>
<!--     Fonts and icons     -->
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<link rel="stylesheet"
	href="bootstrap/assets/css/material-dashboard.css?v=2.0.0">
<!-- Documentation extras -->
<!-- CSS Just for demo purpose, don't include it in your project -->
<link href="bootstrap/assets/assets-for-demo/demo.css" rel="stylesheet" />
<!-- iframe removal -->
<%
	String session_user_id = CmmUtil.nvl((String) session.getAttribute("session_user_id"));
	String session_user_no = CmmUtil.nvl((String) session.getAttribute("session_user_no"));
	String session_team_name = CmmUtil.nvl((String) session.getAttribute("session_team_no"));
	String check = CmmUtil.nvl((String) session.getAttribute("check"));
	String session_user_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));
%>
<!-- 나중에 팀이름으로 바꾸기 -->
<%
	boardDTO bDTO = (boardDTO) request.getAttribute("bDTO");
	if (bDTO == null){
		bDTO = new boardDTO();
	}
	fileDTO fDTO = (fileDTO) request.getAttribute("fDTO");
	if (fDTO == null) {
		fDTO = new fileDTO();
	}
%>
<script>

	window.onload = function() {
		
		<%if(session_user_no.equals(CmmUtil.nvl(bDTO.getReg_no()))) {%>
		var del = document.getElementById("del");
		del.onclick = function() {
			alert("글을 삭제하시겠습니까?");
			location.href = "/boardD.do?board_no="+<%=CmmUtil.nvl(bDTO.getBoard_no())%>;
		};
		var up = document.getElementById("up");
		up.onclick = function() {
			location.href = "/boardU.do?board_no="+<%=CmmUtil.nvl(bDTO.getBoard_no())%>;
		};
		<%}%>
		
		<%if(!session_user_id.equals("admin")){%>
		var nav1 = document.getElementById("nav1");
		var nav2 = document.getElementById("nav2");
		var nav3 = document.getElementById("nav3");
		nav1.onclick = function() {
			nav2.style.display = "";
			nav3.style.display = "";
		};
		<%}%>

		<%if(check.equals("F")){%>
			var list = document.getElementById("list");
			list.onclick = function() {
				location.href = "/boardL.do";
			};
		<%}else{%>
			var list = document.getElementById("list");
			list.onclick = function() {
				location.href = "/teamL.do";
			}
		<%}%>

	}
	function doSubmit(f) {
		if(f.title.value == "") {
			alert("제목을 입력하시기 바랍니다.");
			f.title.focus();
			return false;
		}
		if(f.content.value == "") {
			alert("내용을 입력하시기 바랍니다.");
			f.content.focus();
			return false;
		}
	}
</script>
<style>
#m:link {
	color: #6c757d;
}

#m:visited {
	color: #6c757d;
}

#m:hover {
	color: #6c757d;
	text-decoration: underline;
}
#file_input label {
	position: relative;
	padding: 12px 20px;
	margin: 0.3125rem 1px;
	font-size: .75rem;
	font-weight: 400;
	line-height: 1.42857;
	text-decoration: none;
	text-transform: uppercase;
	letter-spacing: 0;
	cursor: pointer;
	background-color: transparent;
	border: 0;
	border-radius: 0.2rem;
	outline: 0;
	-webkit-transition: background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1),
		-webkit-box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1);
	transition: background-color 0.2s cubic-bezier(0.4, 0, 0.2, 1),
		-webkit-box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1);
	transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color
		0.2s cubic-bezier(0.4, 0, 0.2, 1);
	transition: box-shadow 0.2s cubic-bezier(0.4, 0, 1, 1), background-color
		0.2s cubic-bezier(0.4, 0, 0.2, 1), -webkit-box-shadow 0.2s
		cubic-bezier(0.4, 0, 1, 1);
	will-change: box-shadow, transform;
	color: #fff;
	background-color: #d2d2d2;
	border-color: #d2d2d2;
	-webkit-box-shadow: 0 2px 2px 0 rgba(156, 39, 176, 0.14), 0 3px 1px -2px
		rgba(156, 39, 176, 0.2), 0 1px 5px 0 rgba(156, 39, 176, 0.12);
	box-shadow: 0 2px 2px 0 #ddd, 0 3px 1px -2px #ddd, 0 1px 5px 0 #ddd;
}

#file_input label:hover {
	color: #fff;
	background-color: #999;
	border-color: #999;
}

#file_input label input {
	position: absolute;
	width: 0;
	height: 0;
	overflow: hidden;
}
#non {
	background-color:transparent;border:0 solid black;
	font-size: 1.2rem;
}
#btn{
	background-color:transparent;border:0 solid black;
	color: #000;
}
</style>
</head>
<body id="page-top">
	<div class="wrapper">
		<div class="sidebar" data-color="gray" data-background-color="white"
			data-image="bootstrap/assets/img/sidebar-1.jpg">
			<!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

        Tip 2: you can also add an image using data-image tag
    -->
			<div class="logo">
				<a href="home.do" class="simple-text logo-normal"> Mountain
					Climbing </a>
			</div>
			<div class="sidebar-wrapper">
				<ul class="nav">
					<li class="nav-item"><a class="nav-link" href="/main.do">
							<i class="material-icons">home</i>
							<p>메인</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/apiMain.do"> <i class="material-icons">filter_hdr</i>
							<p>정보</p>
					</a></li>
					<%
						if (session_user_id.equals("admin")) {
					%>
					<li class="nav-item"><a class="nav-link" href="/userList.do">
							<i class="material-icons">person</i>
							<p>회원 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/teamL.do"> <i
							class="material-icons">dvr</i>
							<p>동호회 관리</p>
					</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="/boardL.do"> <i class="material-icons">list</i>
							<p>자유게시판</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/chart.do"> <i
							class="material-icons">assessment</i>
							<p>분석</p>
					</a></li>
					<%
						} else {
					%>
					<li class="nav-item "><a class="nav-link" id="nav1"> <i
							class="material-icons">person</i>
							<p>마이페이지</p>
					</a>
						<ul class="nav-item" id="nav2" style="display: none">
							<li class="nav-item" style="list-style-type: none"><a
								class="nav-link" href="/regList.do"> <i
									class="material-icons">assignment</i>
									<p>작성글</p>
							</a></li>
						</ul>
						<ul class="nav-item" id="nav3" style="display: none">
							<li class="nav-item" style="list-style-type: none"><a
								class="nav-link"
								href="/userDetail.do?user_no=<%=session_user_no%>"> <i
									class="material-icons">assignment_ind</i>
									<p>상세</p>
							</a></li>
						</ul></li>
					<%if(check.equals("F")) {%>
							<li class="nav-item active"><a class="nav-link"
								href="/boardL.do"> <i class="material-icons">list</i>
									<p>자유게시판</p>
							</a></li>
							<li class="nav-item "><a class="nav-link"
								href="/teamL.do"> <i
									class="material-icons">favorite</i>
									<p>동호회</p>
							</a></li>
						<%}else if(check.equals("T")) {%>
							<li class="nav-item"><a class="nav-link"
								href="/boardL.do"> <i class="material-icons">list</i>
									<p>자유게시판</p>
							</a></li>
							<li class="nav-item active "><a class="nav-link"
								href="/teamL.do"> <i
									class="material-icons">favorite</i>
									<p>동호회</p>
							</a></li>
						<%} %>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="main-panel">
			<!-- Navbar -->
            <jsp:include page="../top.jsp" flush="true"/>
            <!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h5 class="card-footer">
										<%if(check.equals("F")) {%>
											자유 게시판
										<%}else if(check.equals("T")){ %>
											동호회 게시판
										<%}else{ %>
											<b>check : <%=check %></b>
										<%} %>
									</h5>
									<h2 class="card-title ">
										<%if((CmmUtil.nvl(bDTO.getNotice_check())).equals("Y")) {%>
										<b style="color: red; font-size: 30px"><공지></b>&nbsp;
										<%} %>
										<b><%=CmmUtil.nvl(bDTO.getTitle())%></b>
									</h2>
								</div>
								<div class="card-body">
									<%
										if (!CmmUtil.nvl(fDTO.getFile_no()).equals("")) {
									%>
									<div class="row">
										<div class="col-md-12">
											<div class="form-group" align="right">
												<form method="post" action="/down.do">
													<input type="hidden" name="file_no" value="<%=fDTO.getFile_no()%>">
													<input type="hidden" name="ori_name" value="<%=fDTO.getOri_name()%>">
													<input type="hidden" name="file_path" value="<%=fDTO.getFile_path()%>">
													<label>
														<button id="btn">
															<%=CmmUtil.nvl(fDTO.getOri_name())%>&emsp;(<%=CmmUtil.nvl(fDTO.getFile_size())%>KB)&emsp;
															<img src="bootstrap/assets/img/down.png">
														</button>
													</label>
												</form>
											</div>
										</div>
									</div>
									<%
										}
									%>
									<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<textarea name="content" id="non" rows="15" cols="100%" readonly><%=CmmUtil.nvl(bDTO.getContent())%></textarea>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">작성자</label>
													<input type="text" readonly class="form-control" value="<%=CmmUtil.nvl(bDTO.getReg_name())%>">
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">작성일</label>
													<input type="text" readonly class="form-control" value="<%=CmmUtil.nvl(bDTO.getReg_dt())%>">
												</div>
											</div>
										</div>
										<button type="button" id="list" class="btn btn-primary pull-right">리스트로 이동</button>
										<%if(session_user_no.equals(CmmUtil.nvl(bDTO.getReg_no()))) {%>
										<button type="button" id="del" class="btn btn-primary pull-right"
											style="width: 100px">삭제</button>
										<button id="up" type="button" class="btn btn-primary pull-right"
											style="width: 100px">수정</button>
										<%} %>
										<div class="clearfix"></div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<footer class="footer ">
                <div class="container-fluid">
                    <nav class="pull-left">
						<p class="text-muted small mb-0">문의 : 관리자 (dldmsal1123@gmail.com)</p>
						<br>
						<p class="text-muted small mb-0" align="left">정보출처 : 산림청 
							(<a id="m" href="http://www.forest.go.kr" target="_blank">www.forest.go.kr</a>)</p>
					</nav>
                    <div class="copyright pull-right">
                        &copy; 2018, made with love by emlee for a better web.
                    </div>
                </div>
            </footer>
		</div>
	</div>
</body>
<!--   Core JS Files   -->
<script src="bootstrap/assets/js/core/jquery.min.js"></script>
<script src="bootstrap/assets/js/core/popper.min.js"></script>
<script src="bootstrap/assets/js/bootstrap-material-design.js"></script>
<script
	src="bootstrap/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Charts Plugin, full documentation here: https://gionkunz.github.io/chartist-js/ -->
<script src="bootstrap/assets/js/plugins/chartist.min.js"></script>
<!-- Library for adding dinamically elements -->
<script src="bootstrap/assets/js/plugins/arrive.min.js"
	type="text/javascript"></script>
<!--  Notifications Plugin, full documentation here: http://bootstrap-notify.remabledesigns.com/    -->
<script src="bootstrap/assets/js/plugins/bootstrap-notify.js"></script>
<!-- demo init -->
<script src="bootstrap/assets/js/plugins/demo.js"></script>
</body>
</html>