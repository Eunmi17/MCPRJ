<%@page import="com.emlee.DTO.userDTO"%>
<%@page import="com.emlee.DTO.manageDTO"%>
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
	String session_auth = CmmUtil.nvl((String) session.getAttribute("session_auth"));
	String session_user_name = CmmUtil.nvl((String) session.getAttribute("session_user_name"));
%>
<!-- 나중에 팀이름으로 바꾸기 -->
<%
	List<manageDTO> mList = (List<manageDTO>) request.getAttribute("mList");
	if (mList == null) {
		mList = new ArrayList();
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
				location.href="/teamL.do";
			}else{
				$.ajax({
					url : "/teamSearch.do",
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
						contents += "<th><strong>번호</strong></th>";
						contents += "<th><strong>동호회 명</strong></th>";
						contents += "<th><strong>리더</strong></th>";
						contents += "<th><strong>가입 방식</strong></th>";
						contents += "<th><strong>인원수</strong></th>";
						contents += "<th></th></thead><tbody>";
						
						$.each(data, function (key, value) {
							content += "<tr>";
								content += "<td>"+value.team_no+"</td>";
								content += "<td>"+value.team_name+"</td>";
								content += "<td>"+value.leader_name+"</td>";
								content += "<td>"+value.join_form+"</td>";
								content += "<td>"+value.num+"</td>";
								content += "<td><img onclick='doDetail("+value.team_no+");'";
								content += "scr='bootstrap/assets/img/loupe.png'></td></tr>";
						});
						
						contentss += "</tbody></table>"
						contentss += "<button type='button' class='btn btn-primary pull-right' id='create'>동호회 개설</button></div>";
						
						if(content == ""){
							content += '<div align="center" style="color:red;">"'+search+'" 에 해당하는 검색결과가 없습니다.</div>';
							$('#divTable').html(content);
						}else{
							$('#divTable').html(contents+content+contentss);
						}
					}
				});
			}
		};
		
		<%if(session_auth.equals("U")){%>		
		var join = document.getElementById("join");
		var create = document.getElementById("create");
		
		create.onclick = function() {
			location.href = "/teamC.do";
		};
		<%}else{%>
		var btn = document.getElementById("btn");
		
		btn.onclick = function() {
			alert("동호회 가입을 취소하시겠습니까?");
			location.href = "/joinD.do";
		}
		<%}%>
	};
	function doDetail(no){
		var team_no = no;
		location.href="/teamR.do?team_no="+team_no;
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
#notice {
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
						href="bootstrap/examples/user.html"> <i class="material-icons">filter_hdr</i>
							<p>정보</p>
					</a></li>
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
					<li class="nav-item "><a class="nav-link" href="/boardL.do">
							<i class="material-icons">list</i>
							<p>자유게시판</p>
					</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="/teamL.do"> <i class="material-icons">favorite</i>
							<p>동호회</p>
					</a></li>
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
			<%if(session_auth.equals("UD")) {%>
				<div align="center">
					<label style="color: red;">동호회 리더의 승인을 기다리고있습니다.</label>
					<button type="button" id="btn" class="btn btn-primary">가입 취소</button>
				</div>
			<%}else{ %>
				<p style="text-align: center; color: red;">회원님은 동호회에 가입되어있지않습니다. 동호회를 개설하시거나 가입하세요.</p>
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h2 class="card-title ">
										<b>동호회 리스트</b>
									</h2>
								</div>
								<div class="card-body">
									<div align="right">
										<form class="navbar-form">
											<div class="input-group no-border" style="width: 30%">
												<input type="text" value="" class="form-control" id="search" name="search" placeholder="동호회명 or 리더명">
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
												<th><strong>번호</strong></th>
												<th><strong>동호회 명</strong></th>
												<th><strong>리더</strong></th>
												<th><strong>가입 방식</strong></th>
												<th><strong>인원수</strong></th>
												<th></th>
											</thead>
											<tbody>
												<%for (manageDTO mDTO : mList) {%>
												<tr>
													<td><%=CmmUtil.nvl(mDTO.getTeam_no())%></td>
													<td><%=CmmUtil.nvl(mDTO.getTeam_name())%></td>
													<td><%=CmmUtil.nvl(mDTO.getLeader_name())%></td>
													<td><%=CmmUtil.nvl(mDTO.getJoin_form())%></td>
													<td><%=CmmUtil.nvl(mDTO.getNum()) %></td>
													<td><img onclick="doDetail(<%=CmmUtil.nvl(mDTO.getTeam_no()) %>);" src="bootstrap/assets/img/loupe.png"></td>
												</tr>
												<%}%>
											</tbody>
										</table>
										<button type="button" class="btn btn-primary pull-right" id="create">동호회 개설</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			<%} %>
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