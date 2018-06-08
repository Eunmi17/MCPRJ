<%@page import="java.util.ArrayList"%>
<%@page import="com.emlee.DTO.boardDTO"%>
<%@page import="java.util.List"%>
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
	String session_auth = CmmUtil.nvl((String)session.getAttribute("session_auth"));
	String check = CmmUtil.nvl((String)session.getAttribute("check"));
	String session_user_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));
%>
<%
	List<boardDTO> bList = (List<boardDTO>)request.getAttribute("bList");
	if(bList == null) {
		bList = new ArrayList();
	}
	String tName = CmmUtil.nvl((String) request.getAttribute("tName"));
	String team_no = "";
	if(check.equals("T")){
		team_no = session_team_name;
	}else{
		team_no = "0";
	}
%>
<script>

	window.onload = function() {
		var s = document.getElementById("search");
		s.onclick = function(){
			$('#search').val('');
		};
		
		var sbtn = document.getElementById("sbtn");
		sbtn.onclick = function() {
			var contents = "";
			var search = $('#search').val();
			
			if(search == "") {
				<%if(check.equals("F")){%>
					location.href="/boardL.do";
				<%}else{%>
					location.href="/teamL.do"
				<%}%>
			}else{
				$.ajax({
					url : "/boardSearch.do",
					method : "post",
					data : {'search' : search},
					datatype : "json",
					success : function(data) {
						var contents = "";
						var content = "";
						var contentss = "";
						
						contents += "<div class='table-responsive' id='divTable'>";
						contents += "<table class='table'>";
						contents += "<thead class='text-primary'>";
						contents += "<th><strong>글 번호</strong></th>";
						contents += "<th><strong>제목</strong></th>";
						contents += "<th><strong>작성자</strong></th>";
						contents += "<th><strong>작성일</strong></th>";
						contents += "<th><strong>조회수</strong></th></thead><tbody>";
						
						$.each(data, function (key, value) {
							content += "<tr>";
							if(value.notice_check == "N") {
								content += "<td>"+value.board_no+"</td>";
							}else{
								content += "<td><b id='notice'>공지</b></td>";
							}
							if(value.file_check == "Y") {
								content += "<td onclick='doDetail("+value.board_no+");'>";
								content += value.title+"&emsp;&emsp;";
								content += "<img width='18' src='bootstrap/assets/img/file.png'></td>";
							}else{
								content += "<td onclick='doDetail("+value.board_no+")';>";
								content += value.title+"</td>";
							}
							content += "<td>"+value.reg_name+"</td>";
							content += "<td>"+value.reg_dt+"</td>";
							content += "<td>"+value.cnt+"</td></tr>";
						});
						
						contentss += "</tbody></table></div>";
						
						if(content == ""){
							content += '<div align="center" style="color:red;">"'+search+'" 에 해당하는 검색결과가 없습니다.</div>';
							$('#divTable').html(content);
						}else{
							$('#divTable').html(contents+content+contentss);
						}
					}
				});
				
				$.ajax({
					url : "/boardSearchNum.do",
					method : "post",
					data : {'search' : search},
					dataType : "int",
					success : function(data) {
						console.log(data);
						var page = 1;
						var countPage = 10;
						var countList = 10;
						var totalCount = data;
						var totalPage =  parseInt(totalCount / countList);
						if(totalCount % countList > 0){
							totalPage++;
						}
						if(totalPage < page){
							page = totalPage;
						}
						
						var startPage = ((page - 1) / 10) * 10 + 1;
						var endPage = startPage + countPage - 1
						
						if(endPage > totalPage) {
							endPage = totalPage;
						}
						console.log(startPage);
						console.log(endPage);
						console.log(page);
						var content = "";
						content += "<div id='paging'>";
						content += "<nav aria-label='Page navigation example'>";
						content += "<ul class='pagination justify-content-center'>";
						for(var iCount = startPage; iCount <= endPage; iCount++){
							if(iCount == page) {
								content += "<li class='page-item'><a class='page-links'><b>("+iCount+")</b></a></li>";
							}else{
								content += "<li class='page-item'><a class='page-links' id='"+iCount+"' value='"+search+"'>"+iCount+"</a></li>";
							}
						}
						content += "</ul></nav></div>";
						$('#paging').html(content);
					},
					error : function(error) {alert("num : "  + error)}
				});
				
			}
		};
		
		$(document).on("click", ".page-links", function() {
			var num = $(this).attr('id');
			var search = $();
		})
		
		var list = document.getElementById("list");
		list.onclick = function() {
			location.href = "/boardC.do";
		};
		
		<%if(!session_user_id.equals("admin")){%>
		var nav1 = document.getElementById("nav1");
		var nav2 = document.getElementById("nav2");
		var nav3 = document.getElementById("nav3");
		nav1.onclick = function() {
			nav2.style.display = "";
			nav3.style.display = "";
		};
		<%}%>
	};
	function doDetail(no){
		var board_no = no;
		location.href="/boardR.do?board_no="+board_no;
	};
	<%if(check.equals("T")){%>
	function doDet(no){
		var team_no = no;
		location.href="/teamR.do?team_no="+team_no;
	};
		<%if(session_auth.equals("UU")){%>
		function doTeamDelete(no){
			var team_no = no;
			alert("동호회에 탈퇴하시겠습니까?");
			location.href="/joinD.do?team_no="+team_no;
		};
		<%}else if(session_auth.equals("UA")){%>
		function doTeamUserList(no) {
			var team_no = no;
			location.href="/teamUL.do?team_no="+team_no;
		};
		<%}%>
	<%}%>
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
#notice{
    font-size: 15px;
    color: red;
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
				<a href="home.do" class="simple-text logo-normal"> Mountain Climbing </a>
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
					<%if(session_user_id.equals("admin")) {%>
					<li class="nav-item"><a class="nav-link"
						href="/userList.do"> <i class="material-icons">person</i>
							<p>회원 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/teamL.do"> <i
							class="material-icons">dvr</i>
							<p>동호회 관리</p>
					</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="/boardL.do"> <i
							class="material-icons">list</i>
							<p>자유게시판</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/chart.do"> <i
							class="material-icons">assessment</i>
							<p>분석</p>
					</a></li>
					<%}else{ %>
					<li class="nav-item "><a class="nav-link" id="nav1">
							<i class="material-icons">person</i>
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
								class="nav-link" href="/userDetail.do?user_no=<%=session_user_no%>"> <i
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
					<%} %>
				</ul>
			</div>
		</div>
		<div class="main-panel">
			<!-- Navbar -->
            <nav class="navbar navbar-expand-lg navbar-transparent  navbar-absolute fixed-top">
                <div class="container-fluid">
                    <div class="collapse navbar-collapse justify-content-end" id="navigation">
						<div class="row">
							<div class="row">
								<i class="material-icons">person</i>
								<p><%=session_user_name%></p>
							</div>
							&emsp;&emsp;&emsp;&emsp;
							<a id="m" href="/logout.do">로그아웃</a>
						</div>
                    </div>
                </div>
            </nav>
            <!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h5 align="right">
									<%if(check.equals("T")) {%>
										<%if(session_auth.equals("UA")) {%>
											<b onclick="doTeamUserList(<%=session_team_name%>);">동호회원 관리</b>
										<%}else if(session_auth.equals("UU")){ %>
											<b onclick="doTeamDelete(<%=session_team_name%>);">동호회 탈퇴</b>
										<%}else{ %>
											<b>session_auth : <%=session_auth %></b>
										<%} %>
									<%} %>
									</h5>
									<h2 class="card-title ">
										<%if(check.equals("F")) {%>
										<b>자유 게시판</b>
									<%}else if(check.equals("T")){ %>
										<b onclick="doDet(<%=session_team_name%>);"><%=tName %></b>
									<%}else{ %>
										<b>check : <%=check %></b>
									<%} %>
									</h2>
								</div>
								<div class="card-body">
									<div align="right">
										<form class="navbar-form">
											<div class="input-group no-border" style="width: 30%">
												<input type="text" value="" class="form-control" id="search" name="search" placeholder="제목 or 내용 Search...">
												<button type="button" class="btn btn-white btn-round btn-just-icon" id="sbtn">
													<i class="material-icons">search</i>
													<div class="ripple-container"></div>
												</button>
											</div>
										</form>
									</div>
									<div class="table-responsive" id="divTable">
										<table class="table">
											<thead class=" text-primary">
												<th><strong>글 번호</strong></th>
												<th><strong>제목</strong></th>
												<th><strong>작성자</strong></th>
												<th><strong>작성일</strong></th>
												<th><strong>조회수</strong></th>
											</thead>
											<tbody>
												<%for (boardDTO bDTO : bList) {%>
												<tr>
													<%if (CmmUtil.nvl(bDTO.getNotice_check()).equals("N")) {%>
													<td><%=bDTO.getBoard_no()%></td>
													<%} else {%>
													<td><b id="notice">공지</b></td>
													<%}%>
													<%if (CmmUtil.nvl(bDTO.getFile_check()).equals("Y")) {%>
													<td onclick="doDetail(<%=bDTO.getBoard_no()%>);"><%=bDTO.getTitle()%>&emsp;&emsp;<img
														width="18" src="bootstrap/assets/img/file.png"></td>
													<%} else {%>
													<td onclick="doDetail(<%=bDTO.getBoard_no()%>);"><%=bDTO.getTitle()%>
													</td>
													<%}%>
													<td><%=bDTO.getReg_name()%></td>
													<td><%=bDTO.getReg_dt()%></td>
													<td><%=bDTO.getCnt()%></td>
												</tr>
												<%}%>
											</tbody>
										</table>
									</div>
									<button type="button" id="list" class="btn btn-primary pull-right">글 등록</button>
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