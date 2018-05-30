<%@page import="javax.script.ScriptEngineManager"%>
<%@page import="javax.script.ScriptEngine"%>
<%@page import="org.jsoup.nodes.Element"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="com.emlee.util.TextUtil"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
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
	String session_user_name = CmmUtil.nvl((String) session.getAttribute("session_user_name"));
	String check = CmmUtil.nvl((String) session.getAttribute("check"));
	String url = "http://openapi.forest.go.kr/openapi/service/trailInfoService/getforeststoryservice?pageNo=";
	String pageNo = (String)request.getAttribute("no");
	String servicekey = "&serviceKey=HNnmPvdDJDrKEsF3NjHy%2BNkeMnO3zSVJs9GbDxpnYAVpX7GeVtnWIiqpPIOugTK8gq0l9b7sVNBKHL%2FF39%2FClw%3D%3D";
	String allurl = url + pageNo + servicekey;
	Document text = Jsoup.connect(allurl).get();

	Elements mntnid = text.select("mntnid");
	Elements mntnnm = text.select("mntnnm");
	Elements item = text.select("items > item");
	Elements mntninfohght = text.select("mntninfohght");

	int s = 0;
	String[] addr = new String[10];

	for (Element add : item) {
		Elements mntninfopoflc = add.getElementsByTag("mntninfopoflc");
		addr[s] = mntninfopoflc.get(0).text().trim();
		s++;
		if (s > 10) {
			break;
		}
	}

	String[] id = mntnid.text().split(" ");
	String[] name = mntnnm.text().split(" ");
	String[] h = mntninfohght.text().split(" ");
%>
<%
	int pages = Integer.parseInt(pageNo);
	int countList = 10;
	int countPage = 10;
	int totalCount = 1592;
	int totalPage = 160;
	
	int startPage = ((pages -1) / 10) * 10 + 1;
	int endPage = startPage + countPage - 1;
	
	if (endPage > totalPage) {
		endPage = totalPage;
	}
%>
<script>

	window.onload = function() {
		<%if(!session_user_id.equals("admin")){%>
			var nav1 = document.getElementById("nav1");
			var nav2 = document.getElementById("nav2");
			var nav3 = document.getElementById("nav3");
			nav1.onclick = function() {
				nav2.style.display = "";
				nav3.style.display = "";
			};
		<%}%>
		
		var s = document.getElementById("search");
		s.onclick = function(){
			$('#search').val('');
		};
		
		var sbtn = document.getElementById("sbtn");
		sbtn.onclick = function() {
			console.log("검색 클릭");
			
			if(nm = ""){
				location.href="/apiMain.do";
			}else{
				var nm = $('#search').val();
				console.log("검색값 : " + nm);
				location.href="/apiSearch.do?nm="+nm;
			}
		}
		
		
		
		<%if(startPage != 1){%>
			var back = document.getElementById("back");
			back.onclick = function() {
				<%
					startPage = ((pages -1) / 10) * 10 + 1;
					endPage = startPage + countPage - 1;
				
					if (endPage > totalPage) {
					endPage = totalPage;
					}
				%>
				
				var content = "";
				
				content = "<div id='paging'>";
				content = "<nav aria-label='Page navigation example'>";
				content = "<ul class='pagination justify-content-center'>";
				<%if(startPage != 1) {%>
					content = "<li class='page-item'>";
					content = "<a class='page-link' id='back' aria-label='Previous'>";
					content = "<span aria-hidden='true'>&laquo;</span>";
					content = "<span class='sr-only'>Previous</span>";
					content = "</a></li>";
				<%} %>
				<%for (int iCount = startPage; iCount <= endPage; iCount++) {
					if(iCount == pages) {%>
						content = "<li class='page-item'><a class='page-link'><b>(<%=iCount%>)</b></a></li>";
					<%}else{ %>
						content = "<li class='page-item'><a class='page-link' href='/apiMain.do?no=<%=iCount%>'><%=iCount%></a></li>";
					<%} }%>
					<%if(endPage != 160) {%>
						content = "<li class='page-item'>";
						content = "<a class='page-link' id='next' aria-label='Next'>";
						content = "<span aria-hidden='true'>&raquo;</span>";
						content = "<span class='sr-only'>Next</span></a></li>";
					<%} %>
				content = "</ul></nav></div>";
				
				$('#paging').html(content);
			};
		<%}%>
		<%if(endPage != 160) {%>
			var next = document.getElementById("next");
			next.onclick = function() {
				<%
					startPage = ((pages -1) / 10) * 10 + 1;
					endPage = startPage + countPage - 1;
				
					if (endPage > totalPage) {
					endPage = totalPage;
					}
				%>
				
				var content = "";
				
				content = "<div id='paging'>";
				content = "<nav aria-label='Page navigation example'>";
				content = "<ul class='pagination justify-content-center'>";
				<%if(startPage != 1) {%>
					content = "<li class='page-item'>";
					content = "<a class='page-link' id='back' aria-label='Previous'>";
					content = "<span aria-hidden='true'>&laquo;</span>";
					content = "<span class='sr-only'>Previous</span>";
					content = "</a></li>";
				<%} %>
				<%for (int iCount = startPage; iCount <= endPage; iCount++) {
					if(iCount == pages) {%>
						content = "<li class='page-item'><a class='page-link'><b>(";
						content = <%=iCount%>;
						content = ")</b></a></li>";
					<%}else{ %>
						content = "<li class='page-item'><a class='page-link' href='/apiMain.do?no=";
						content = <%=iCount%>;
						content = "'>";
						content = <%=iCount%>;
						content = "</a></li>";
					<%} }%>
					<%if(endPage != 160) {%>
						content = "<li class='page-item'>";
						content = "<a class='page-link' id='next' aria-label='Next'>";
						content = "<span aria-hidden='true'>&raquo;</span>";
						content = "<span class='sr-only'>Next</span></a></li>";
					<%} %>
				content = "</ul></nav></div>";
				
				$('#paging').html(content);
			};
		<%}%>
	}
	
	function doDetail(n, h){
		var nm = n;
		var hght = h
		location.href="/api.do?nm="+nm+"&hght="+hght;
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
					<li class="nav-item active"><a class="nav-link"
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
							<p>게시판 관리</p>
					</a></li>
					<li class="nav-item"><a class="nav-link"
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
							<li class="nav-item"><a class="nav-link"
								href="/boardL.do"> <i class="material-icons">list</i>
									<p>자유게시판</p>
							</a></li>
							<li class="nav-item"><a class="nav-link"
								href="/teamL.do"> <i
									class="material-icons">favorite</i>
									<p>동호회</p>
							</a></li>
					<%
						}
					%>
				</ul>
			</div>
		</div>
		<div class="main-panel">
			<!-- Navbar -->
			<nav
				class="navbar navbar-expand-lg navbar-transparent  navbar-absolute fixed-top">
				<div class="container-fluid">
					<div class="collapse navbar-collapse justify-content-end"
						id="navigation">
						<div class="row">
							<div class="row">
								<i class="material-icons">person</i>
								<p><%=session_user_name%></p>
							</div>
							&emsp;&emsp;&emsp;&emsp; <a id="m" href="/logout.do">로그아웃</a>
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
										<b>Mountain List</b>
									</h2>
								</div>
								<div class="card-body">
									<div align="right">
										<form class="navbar-form">
											<div class="input-group no-border" style="width: 30%">
												<input type="text" value="" class="form-control" id="search"
													name="search" placeholder="산명  Search...">
												<button type="button"
													class="btn btn-white btn-round btn-just-icon" id="sbtn">
													<i class="material-icons">search</i>
													<div class="ripple-container"></div>
												</button>
											</div>
										</form>
									</div>
									<div class="table-responsive" id="divTable">
										<table class="table">
											<thead class=" text-primary">
												<th><strong>산코드</strong></th>
												<th><strong>산명</strong></th>
												<th><strong>소재지</strong></th>
												<th><strong>높이</strong></th>
												<th></th>
											</thead>
											<tbody>
												<%
													for (int i = 0; i < id.length; i++) {
												%>
												<tr>
													<td><%=id[i]%></td>
													<td><%=name[i]%></td>
													<td><%=addr[i]%></td>
													<td><%=h[i]%> M</td>
													<td><img onclick="doDetail('<%=name[i]%>', '<%=h[i]%>');" src="bootstrap/assets/img/loupe.png"></td>
												</tr>
												<%}%>
											</tbody>
										</table>
									</div>
									<div id="paging">
										<nav aria-label="Page navigation example">
											<ul class="pagination justify-content-center">
												<%if(startPage != 1) {%>
												<li class="page-item">
													<a class="page-link" id="back" aria-label="Previous">
														<span aria-hidden="true">&laquo;</span>
														<span class="sr-only">Previous</span>
													</a>
												</li>
												<%} %>
												<%for (int iCount = startPage; iCount <= endPage; iCount++) {
													if(iCount == pages) {%>
														<li class="page-item"><a class="page-link"><b>(<%=iCount%>)</b></a></li>
													<%}else{ %>
														<li class="page-item"><a class="page-link" href="/apiMain.do?no=<%=iCount%>"><%=iCount%></a></li>
													<%} }%>
												<%if(endPage != 160) {%>
												<li class="page-item">
													<a class="page-link" id="next" aria-label="Next">
														<span aria-hidden="true">&raquo;</span>
														<span class="sr-only">Next</span>
													</a>
												</li>
												<%} %>
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
						<p class="text-muted small mb-0">문의 : 관리자
							(dldmsal1123@gmail.com)</p>
						<br>
						<p class="text-muted small mb-0" align="left">
							정보출처 : 산림청 (<a id="m" href="http://www.forest.go.kr"
								target="_blank">www.forest.go.kr</a>)
						</p>
					</nav>
					<div class="copyright pull-right">&copy; 2018, made with love
						by emlee for a better web.</div>
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