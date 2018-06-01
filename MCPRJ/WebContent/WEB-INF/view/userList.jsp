<%@page import="com.emlee.util.CmmUtil"%>
<%@page import="com.emlee.DTO.userDTO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
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
	String session_user_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));
	userDTO cDTO = (userDTO)request.getAttribute("cDTO");
	int count = Integer.parseInt(cDTO.getData());

	List<userDTO> uList = (List<userDTO>)request.getAttribute("uList");
	if(uList == null){
		uList = new ArrayList();
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
				location.href="/userList.do";
			}else{
				$.ajax({
					url : "/userSearch.do",
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
						contents += "<th><strong>이름</strong></th>";
						contents += "<th><strong>ID</strong></th>";
						contents += "<th><strong>동호회</strong></th>";
						contents += "<th><strong>권한</strong></th>";
						contents += "<th></th></thead><tbody>";
						
						$.each(data, function (key, value) {
							content += "<tr>";
								content += "<td>"+value.user_no+"</td>";
								content += "<td>"+value.user_name+"</td>";
								content += "<td>"+value.user_id+"</td>";
								content += "<td>"+value.team_no+"</td>";
								content += "<td>"+value.auth+"</td>";
								content += "<td><img onclick='doDetail("+value.user_no+");'";
								content += "src='bootstrap/assets/img/loupe.png'></td></tr>";
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
			}
		};
		
		//페이징 시작
		
		var page = 1;
		var countPage = 10;
		var countList = 10;
		var totalCount = <%=count%>;
		var totalPage = totalCount / countList;
		
		if(totalCount % countList > 0){
			totalPage++;
		}
		if(totalPage < page){
			page += totalPage;
		}
		
		var startPage = ((page - 1) / 10) * 10 + 1;
		var endPage = startPage + countPage - 1
		
		if(endPage > totalPage) {
			endPage = totalPage;
		}
		
		var content = "";
		content="<div id='paging'>";
		content="<nav aria-label='Page navigation example'>";
		content="<ul class='pagination justify-content-center'>";
		for(var iCount = startPage; iCount <= endPage; iCount++){
			if(iCount == page) {
				content = "<li class='page-item'><a class='page-link'><b>("+iCount+")</b></a></li>";
			}else{
				content = "<li class='page-item'><a class='page-link'>"+iCount+"</a></li>";
			}
		}
		content = "</ul></nav></div>";
		$('#paging').html(content);
		
		//페이징 끝
	}
	function doDetail(no){
		var user_no = no;
		location.href="/userDetail.do?user_no="+user_no;
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
					<li class="nav-item active"><a class="nav-link"
						href="/userList.do"> <i class="material-icons">person</i>
							<p>회원 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/teamL.do"> <i
							class="material-icons">dvr</i>
							<p>동호회 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/boardL.do"> <i
							class="material-icons">list</i>
							<p>자유게시판</p>
					</a></li>
					<li class="nav-item "><a class="nav-link"
						href="/chart.do"> <i
							class="material-icons">assessment</i>
							<p>분석</p>
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
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h2 class="card-title ">
										<b>User List</b>
									</h2>
								</div>
								<div class="card-body">
									<div align="right">
										<form class="navbar-form">
											<div class="input-group no-border" style="width: 30%">
												<input type="text" value="" class="form-control" id="search" name="search" placeholder="name or ID Search...">
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
												<th><strong>이름</strong></th>
												<th><strong>ID</strong></th>
												<th><strong>동호회</strong></th>
												<th><strong>권한</strong></th>
												<th></th>
											</thead>
											<tbody>
												<%for (userDTO uDTO : uList) {%>
												<tr>
													<td><%=uDTO.getUser_no() %></td>
													<td><%=uDTO.getUser_name() %></td>
													<td><%=uDTO.getUser_id() %></td>
													<td><%=uDTO.getTeam_no() %></td>
													<td><%=uDTO.getAuth() %></td>
													<td><img onclick="doDetail(<%=uDTO.getUser_no() %>);" src="bootstrap/assets/img/loupe.png"></td>
												</tr>
												<%} %>
											</tbody>
										</table>
									</div>
									<div id="paging">
										<nav aria-label="Page navigation example">
											<ul class="pagination justify-content-center">
												<li class='page-item'><a class='page-link'><b>1</b></a></li>
											</ul>
										</nav>
									</div>
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

</html>
