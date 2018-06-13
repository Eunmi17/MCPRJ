<%@page import="com.emlee.DTO.userDTO"%>
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
<%
	List<boardDTO> bList = (List<boardDTO>) request.getAttribute("bList");
	if (bList == null) {
		bList = new ArrayList();
	}
	boardDTO cDTO = (boardDTO)request.getAttribute("cDTO");
	int count = Integer.parseInt(cDTO.getData());
	System.out.println("count : " + count);
%>
<script>

	window.onload = function() {
		
		<%if (!session_user_id.equals("admin")) {%>
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
			var contents = "";
			var search = $('#search').val();
			var num = 1;
			
			if(search == "") {
				location.href="/regList.do?user_no"+<%=session_user_no%>;
			}else{
				$.ajax({
					url : "/regSearch.do",
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
						contents += "<th><strong>게시판</strong></th>";
						contents += "<th><strong>제목</strong></th>";
						contents += "<th><strong>작성자</strong></th>";
						contents += "<th><strong>작성일</strong></th>";
						contents += "<th><strong>조회수</strong></th></thead><tbody>";
						
						$.each(data, function (key, value) {
							content += "<tr>";
							if(value.team_no == 0) {
								content += "<td>자유</td>";
							}else{
								content += "<td>동호회</td>";
							}
							if(value.file_check == "Y") {
								content += "<td onclick='doDetail("+value.board_no+","+value.team_no+");'>";
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
					url : "/regSearchNum.do",
					method : "post",
					data : {'search' : search},
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
						if(startPage != 1) {
							content += "<li class='page-item'>";
							content += "<a class='page-links' id="+startPage-10+" value='"+search+"' aria-label='Previous'>";
							content += "<span aria-hidden='true'>&laquo;</span>";
							content += "<span class='sr-only'>Previous</span></a></li>";
						}
						for(var iCount = startPage; iCount <= endPage; iCount++){
							if(iCount == page) {
								content += "<li class='page-item'><a class='page-links'><b>("+iCount+")</b></a></li>";
							}else{
								content += "<li class='page-item'><a class='page-links' id='"+iCount+"' value='"+search+"'>"+iCount+"</a></li>";
							}
						}
						if(endPage != totalPage) {
							content += "<li class='page-item'>";
							content += "<a class='page-links' id="+startPage+10+" value='"+search+"' aria-label='Next'>";
							content += "<span aria-hidden='true'>&raquo;</span>";
							content += "<span class='sr-only'>Next</span></a></li>";
						}
						content += "</ul></nav></div>";
						if(totalCount != 0){
							$('#paging').html(content);
						}else{
							$('#paging').html('');
						}
					},
					error : function(error) {alert("num : " + error)}
				});
			}
		};
		
		$(document).on("click", ".page-links", function() {
			var num = $(this).attr('id');
			var search = $(this).attr('value');
			console.log("num : " + num);
			console.log("search : " + search);
			$.ajax({
				url : "/regSearchPaging.do",
				method : "post",
				data : {"search" : search, "num" : num},
				dataType : "json",
				success : function(data, st, xhr) {
					console.log(data);
					var contents = "";
					var content = "";
					var contentss = "";
					
					contents += "<div class='table-responsive' id='divTable'>";
					contents += "<table class='table'>";
					contents += "<thead class='text-primary'>";
					contents += "<th><strong>게시판</strong></th>";
					contents += "<th><strong>제목</strong></th>";
					contents += "<th><strong>작성자</strong></th>";
					contents += "<th><strong>작성일</strong></th>";
					contents += "<th><strong>조회수</strong></th></thead><tbody>";
					
					$.each(data, function (key, value) {
						content += "<tr>";
						if(value.team_no == 0) {
							content += "<td>자유</td>";
						}else{
							content += "<td>동호회</td>";
						}
						if(value.file_check == "Y") {
							content += "<td onclick='doDetail("+value.board_no+","+value.team_no+");'>";
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
					$('#divTable').html(contents+content+contentss);
					
					countPage = 10;
					countList = 10;
					page = num;
					if(totalPage < page){
						page = totalPage;
					}
					
					startPage =  parseInt(((page - 1) / 10)) * 10 + 1;
					endPage = startPage + countPage - 1;
					
					if(endPage > totalPage) {
						endPage = totalPage;
					}
					console.log(startPage);
					console.log(endPage);
					console.log(page);
					content = "";
					content += "<div id='paging'>";
					content += "<nav aria-label='Page navigation example'>";
					content += "<ul class='pagination justify-content-center'>";
					if(startPage != 1) {
						content += "<li class='page-item'>";
						content += "<a class='page-links' id="+startPage-10+" value='"+search+"' aria-label='Previous'>";
						content += "<span aria-hidden='true'>&laquo;</span>";
						content += "<span class='sr-only'>Previous</span></a></li>";
					}
					for(var iCount = startPage; iCount <= endPage; iCount++){
						if(iCount == page) {
							content += "<li class='page-item'><a class='page-links'><b>("+iCount+")</b></a></li>";
						}else{
							content += "<li class='page-item'><a class='page-links' id='"+iCount+"' value='"+search+"'>"+iCount+"</a></li>";
						}
					}
					if(endPage != totalPage) {
						content += "<li class='page-item'>";
						content += "<a class='page-links' id="+startPage+10+" value='"+search+"' aria-label='Next'>";
						content += "<span aria-hidden='true'>&raquo;</span>";
						content += "<span class='sr-only'>Next</span></a></li>";
					}
					content += "</ul></nav></div>";
					if(totalCount != 0){
						$('#paging').html(content);
					}else{
						$('#paging').html('');
					}
				},
				error : function(xhr, st, error) {alert(error)}
			});
		});
		
		var page = 1;
		var countPage = 10;
		var countList = 10;
		var totalCount = <%=count%>;
		var totalPage =  parseInt(totalCount / countList);
		
		if(totalCount % countList > 0){
			totalPage++;
		}
		if(totalPage < page){
			page = totalPage;
		}
		
		var startPage = ((page - 1) / 10) * 10 + 1;
		var endPage = startPage + countPage - 1;
		
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
		if(startPage != 1) {
			content += "<li class='page-item'>";
			content += "<a class='page-link' id="+startPage-10+" aria-label='Previous'>";
			content += "<span aria-hidden='true'>&laquo;</span>";
			content += "<span class='sr-only'>Previous</span></a></li>";
		}
		for(var iCount = startPage; iCount <= endPage; iCount++){
			if(iCount == page) {
				content += "<li class='page-item'><a class='page-link'><b>("+iCount+")</b></a></li>";
			}else{
				content += "<li class='page-item'><a class='page-link' id='"+iCount+"'>"+iCount+"</a></li>";
			}
		}
		if(endPage != totalPage) {
			content += "<li class='page-item'>";
			content += "<a class='page-link' id="+startPage+10+" aria-label='Next'>";
			content += "<span aria-hidden='true'>&raquo;</span>";
			content += "<span class='sr-only'>Next</span></a></li>";
		}
		content += "</ul></nav></div>";
		if(totalCount != 0){
			$('#paging').html(content);
		}else{
			$('#paging').html('');
		}
		
		$(document).on("click", ".page-link", function() {
			var num = $(this).attr('id');
			num = parseInt(num);
			console.log("num : " + num);
			$.ajax({
				url : "/regPaging.do",
				method : "post",
				data : {"num" : num},
				dataType : "json",
				success : function(data, st, xhr) {
					console.log(data);
					console.log(st);
					console.log(xhr);
					var contents = "";
					var content = "";
					var contentss = "";
					
					contents += "<div class='table-responsive' id='divTable'>";
					contents += "<table class='table'>";
					contents += "<thead class='text-primary'>";
					contents += "<th><strong>게시판</strong></th>";
					contents += "<th><strong>제목</strong></th>";
					contents += "<th><strong>작성자</strong></th>";
					contents += "<th><strong>작성일</strong></th>";
					contents += "<th><strong>조회수</strong></th></thead><tbody>";
					
					$.each(data, function (key, value) {
						content += "<tr>";
						if(value.team_no == 0) {
							content += "<td>자유</td>";
						}else{
							content += "<td>동호회</td>";
						}
						if(value.file_check == "Y") {
							content += "<td onclick='doDetail("+value.board_no+","+value.team_no+");'>";
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
					$('#divTable').html(contents+content+contentss);
					
					page = num;
					if(totalPage < page){
						page = totalPage;
					}
					
					startPage =  parseInt(((page - 1) / 10)) * 10 + 1;
					endPage = startPage + countPage - 1
					
					if(endPage > totalPage) {
						endPage = totalPage;
					}
					console.log(startPage);
					console.log(endPage);
					console.log(page);
					content = "";
					content += "<div id='paging'>";
					content += "<nav aria-label='Page navigation example'>";
					content += "<ul class='pagination justify-content-center'>";
					if(startPage != 1) {
						content += "<li class='page-item'>";
						content += "<a class='page-link' id="+startPage-10+" aria-label='Previous'>";
						content += "<span aria-hidden='true'>&laquo;</span>";
						content += "<span class='sr-only'>Previous</span></a></li>";
					}
					for(var iCount = startPage; iCount <= endPage; iCount++){
						if(iCount == page) {
							content += "<li class='page-item'><a class='page-link'><b>("+iCount+")</b></a></li>";
						}else{
							content += "<li class='page-item'><a class='page-link' id='"+iCount+"'>"+iCount+"</a></li>";
						}
					}
					if(endPage != totalPage) {
						content += "<li class='page-item'>";
						content += "<a class='page-link' id="+startPage+10+" aria-label='Next'>";
						content += "<span aria-hidden='true'>&raquo;</span>";
						content += "<span class='sr-only'>Next</span></a></li>";
					}
					content += "</ul></nav></div>";
					if(totalCount != 0){
						$('#paging').html(content);
					}else{
						$('#paging').html('');
					}
				},
				error : function(xhr, st, error) {alert(error)}
			});
		});
		
	}
	function doDetail(board, team){
		var board_no = board;
		var team_no = team;
		location.href="/boardR.do?board_no="+board_no+"&team_no="+team_no;
	};
</script>
<style>
#notice {
	font-size: 15px;
	color: red;
}
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
.page-links{
    list-style: none;
    border: 0;
    border-radius: 30px !important;
    transition: all .3s;
    padding: 0px 11px;
    margin: 0 3px;
    min-width: 30px;
    height: 30px;
    line-height: 30px;
    color: #999999;
    font-weight: 400;
    font-size: 12px;
    text-transform: uppercase;
    background: transparent;
    text-align: center;
}
.page-links:not([href]):not([tabindex]){
	color: #999999
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
					<li class="nav-item"><a class="nav-link" id="nav1"> <i
							class="material-icons">person</i>
							<p>마이페이지</p>
					</a>
						<ul class="nav-item" id="nav2">
							<li class="nav-item active " style="list-style-type: none"><a
								class="nav-link" href="/regList.do"> <i
									class="material-icons">assignment</i>
									<p>작성글</p>
							</a></li>
						</ul>
						<ul class="nav-item" id="nav3">
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
					<li class="nav-item "><a class="nav-link" href="/teamL.do">
							<i class="material-icons">favorite</i>
							<p>동호회</p>
					</a></li>
				</ul>
			</div>
		</div>
		<div class="main-panel">
		<!-- Navbar -->
            <jsp:include page="top.jsp" flush="true"/>
			<!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-12">
							<div class="card">
								<div class="card-header card-header-primary">
									<h2 class="card-title ">
										<b>작성한 글 확인</b>
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
												<th><strong>게시판</strong></th>
												<th><strong>제목</strong></th>
												<th><strong>작성자</strong></th>
												<th><strong>작성일</strong></th>
												<th><strong>조회수</strong></th>
											</thead>
											<tbody>
												<%
													for (boardDTO bDTO : bList) {
												%>
												<tr>
													<%if(bDTO.getTeam_no().equals("0")) {%>
													<td>자유</td>
													<%}else{ %>
													<td>동호회</td>
													<%} %>
													<%if (CmmUtil.nvl(bDTO.getFile_check()).equals("Y")) {%>
													<td onclick="doDetail(<%=bDTO.getBoard_no()%>, <%=bDTO.getTeam_no()%>);"><%=bDTO.getTitle()%>&emsp;&emsp;
														<img width="18" src="bootstrap/assets/img/file.png"></td>
													<%} else {%>
													<td onclick="doDetail(<%=bDTO.getBoard_no()%>);"><%=bDTO.getTitle()%></td>
													<%}%>
													<td><%=bDTO.getReg_name()%></td>
													<td><%=bDTO.getReg_dt()%></td>
													<td><%=bDTO.getCnt()%></td>
												</tr>
												<%
													}
												%>
											</tbody>
										</table>
									</div>
									<div id="paging">
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
</body>
</html>