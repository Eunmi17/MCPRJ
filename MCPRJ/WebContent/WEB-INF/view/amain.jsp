<%@page import="java.util.ArrayList"%>
<%@page import="com.emlee.DTO.informationDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.emlee.DTO.boardDTO"%>
<%@page import="com.emlee.DTO.manageDTO"%>
<%@page import="com.emlee.DTO.userDTO"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
<%@page import="com.emlee.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <!-- Favicons -->
    <link rel="apple-touch-icon" href="bootstrap/assets/img/icon.png">
    <link rel="icon" href="bootstrap/assets/img/icon.png">
    <title>
        MC
    </title>
    <!--     Fonts and icons     -->
    <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700|Roboto+Slab:400,700|Material+Icons" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <link rel="stylesheet" href="bootstrap/assets/css/material-dashboard.css?v=2.0.0">
    <!-- Documentation extras -->
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="bootstrap/assets/assets-for-demo/demo.css" rel="stylesheet" />
    <!-- iframe removal -->
<%
	String session_user_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));
    List<informationDTO> iList = (List<informationDTO>) request.getAttribute("iList");
    if(iList == null) {
    	iList = new ArrayList();
    }
    userDTO u = (userDTO) request.getAttribute("u");
    manageDTO m = (manageDTO) request.getAttribute("m");
    boardDTO b = (boardDTO) request.getAttribute("b");

	String url = "http://openapi.forest.go.kr/openapi/service/trailInfoService/getforeststoryservice?";
	String servicekey = "serviceKey=HNnmPvdDJDrKEsF3NjHy%2BNkeMnO3zSVJs9GbDxpnYAVpX7GeVtnWIiqpPIOugTK8gq0l9b7sVNBKHL%2FF39%2FClw%3D%3D";
	String allurl = url+servicekey;
	Document text = Jsoup.connect(allurl).get();
	
	Elements totalCount = text.select("totalCount");
%>

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
.sam hr{
    margin-top: 0;
    margin-bottom: 0;
}

.sam{
display: block;
  width: 100%;
  padding: 0.4375rem 0;
  font-size: 1rem;
}
</style>
<script>
window.onload = function() {
	
	var all = document.getElementById("all");
	var month = document.getElementById("month");
	var theme = document.getElementById("theme");
	var mon = document.getElementById("mon");
	var the = document.getElementById("the");
	var ex1 = document.getElementById("ex1");
	var ex2 = document.getElementById("ex2");
	var ex3 = document.getElementById("ex3");
	var info = document.getElementById("info");
	var infomation = document.getElementById("information");
	
	$(document).on("click", ".detail", function() {
		var no = $(this).attr('id');
		$.ajax({
			url : "/information.do",
			method : "post",
			data : {"no" : no},
			dataType : "json",
			success : function(data) {
				var name = "";
				var height = "";
				var addr = "";
				var reason = "";
				var image = "";
				$.each(data, function(key, value){
					name = value.name;
					height = value.height;
					addr = value.addr;
					reason = value.reason;
					image = value.image;
					console.log(name);
				});
				var content = "";
				content += "<div class='card-body' id='information' style='display: '>";
				content += "<div class='row'><div class='col-md-6' align='center'>";
				content += "<div class='form-group'><img src='"+image+"' width='80%'>";
				content += "</div></div><div class='col-md-5'><div class='form-group'>";
				content += "<label class='bmd-label-floating'>산 명</label>";
				content += "<div class='sam'>"+name+"<hr></div></div><div class='form-group'>";
				content += "<label class='bmd-label-floating'>높이</label>";
				content += "<div class='sam'>"+height+"<hr></div></div><div class='form-group'>";
				content += "<label class='bmd-label-floating'>소재지</label>";
				content += "<div class='sam'>"+addr+"<hr></div></div></div></div>";
				content += "<div class='row'><div align='center'>";
				content += "<div class='col-md-11' align='left'><div class='form-group'>";
				content += "<label class='bmd-label-floating'>선정 이유</label>";
				content += "<div class='sam'>"+reason+"<hr></div></div></div></div></div></div>";
				
				$('#information').html(content);
			}
		});
		info.style.display = "none";
		infomation.style.display = "";
	});
	
	$(document).on("click", "#all", function() {
		var content = "";
		content += "<div align='center' style='width: 100%' id='d'>";
		content += "<span class='text-success' id='all'>전체</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='month'>월별</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='theme'>테마</span></div>";
		$('#d').html(content);
		
		mon.style.display = "none";
		the.style.display = "none";
		ex1.style.display = "";
		ex2.style.display = "none";
		ex3.style.display = "none";
		info.style.display = "";
		infomation.style.display = "none";
	});
	
	$(document).on("click", "#month", function() {
		var content = "";
		content += "<div align='center' style='width: 100%' id='d'>";
		content += "<span id='all'>전체</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span class='text-success' id='month'>월별</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='theme'>테마</span></div>";
		$('#d').html(content);
		
		mon.style.display = "";
		the.style.display = "none";
		ex1.style.display = "none";
		ex2.style.display = "";
		ex3.style.display = "none";
		info.style.display = "";
		infomation.style.display = "none";
	});
	
	$(document).on("click", "#theme", function() {
		var content = "";
		content += "<div align='center' style='width: 100%' id='d'>";
		content += "<span id='all'>전체</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='month'>월별</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span class='text-success' id='theme'>테마</span></div>";
		$('#d').html(content);
		
		mon.style.display = "none";
		the.style.display = "";
		ex1.style.display = "none";
		ex2.style.display = "none";
		ex3.style.display = "";
		info.style.display = "";
		infomation.style.display = "none";
	});
	
	var page = 1;
	var countPage = 5;
	var countList = 10;
	var totalCount = 100;
	var totalPage =  20;
	
	if(totalCount % countList > 0){
		totalPage++;
	}
	if(totalPage < page){
		page = totalPage;
	}
	
	var startPage = 1;
	var endPage = 5;
	
	console.log(startPage);
	console.log(endPage);
	console.log(page);
	var content = "";
	content += "<div id='paging'>";
	content += "<nav aria-label='Page navigation example'>";
	content += "<ul class='pagination justify-content-center'>";
	for(var iCount = startPage; iCount <= endPage; iCount++){
		if(iCount == page) {
			content += "<li class='page-item'><a class='page-link'><b>("+iCount+")</b></a></li>";
		}else{
			content += "<li class='page-item'><a class='page-link' id='"+iCount+"'>"+iCount+"</a></li>";
		}
	}
	if(endPage != totalPage) {
		content += "<li class='page-item'>";
		content += "<a class='page-link' id='6' aria-label='Next'>";
		content += "<span aria-hidden='true'>&raquo;</span>";
		content += "<span class='sr-only'>Next</span></a></li>";
	}
	content += "</ul></nav></div>";
	$('#paging').html(content);
	
	$(document).on("click", ".page-link", function() {
		var num = $(this).attr('id');
		num = parseInt(num);
		console.log("num : " + num);
		$.ajax({
			url : "/infoPaging.do",
			method : "post",
			data : {"num" : num},
			dataType : "json",
			success : function(data, st, xhr) {
				console.log(data);
				console.log(st);
				console.log(xhr);
				var contents = "";
				contents += "<table class='table'><thead class=' text-primary'>";
				contents += "<th><strong>No</strong></th><th><strong>산명</strong></th>";
				contents += "<th></th></thead><tbody>";
				$.each(data, function (key, value) {
					contents += "<tr><td>"+value.no+"</td><td>"+value.name+"</td>";
					contents += "<td><img class='detail' id="+value.no+" src='bootstrap/assets/img/loupe.png'></td></tr>";
				})
				contents += "</tbody></table>";
				$('.table').html(contents);
				
				page = num;
				if(totalPage < page){
					page = totalPage;
				}
				if(page == 20) {
					startPage = 16;
				}else{
					startPage = parseInt(parseInt(page / 5) * 5) + 1;
				}
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
					console.log("?");
					var pre = parseInt(startPage-5);
					content += "<li class='page-item'>";
					content += "<a class='page-link' id="+pre+" aria-label='Previous'>";
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
					var next = parseInt(startPage+5);
					content += "<li class='page-item'>";
					content += "<a class='page-link' id="+next+" aria-label='Next'>";
					content += "<span aria-hidden='true'>&raquo;</span>";
					content += "<span class='sr-only'>Next</span></a></li>";
				}
				content += "</ul></nav></div>";
				$('#paging').html(content);
			},
			error : function(xhr, st, error) {alert(error)}
		});
	});
	
};
</script>
</head>

<body id="page-top">
    <div class="wrapper">
        <div class="sidebar" data-color="gray" data-background-color="white" data-image="bootstrap/assets/img/sidebar-1.jpg">
            <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

        Tip 2: you can also add an image using data-image tag
    -->
            <div class="logo">
                <a href="home.do" class="simple-text logo-normal">
                    Mountain Climbing
                </a>
            </div>
            <div class="sidebar-wrapper">
                <ul class="nav">
                    <li class="nav-item active ">
                        <a class="nav-link" href="/main.do">
                            <i class="material-icons">home</i>
                            <p>메인</p>
                        </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="/apiMain.do">
                            <i class="material-icons">filter_hdr</i>
                            <p>정보</p>
                        </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="/userList.do">
                            <i class="material-icons">person</i>
                            <p>회원 관리</p>
                        </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="/teamL.do">
                            <i class="material-icons">dvr</i>
                            <p>동호회 관리</p>
                        </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="/boardL.do">
                            <i class="material-icons">list</i>
                            <p>자유게시판</p>
                        </a>
                    </li>
                    <li class="nav-item ">
                        <a class="nav-link" href="/chart.do">
                            <i class="material-icons">assessment</i>
                            <p>분석</p>
                        </a>
                    </li>
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
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="card card-stats">
                                <div class="card-header card-header-warning card-header-icon">
                                    <div class="card-icon">
                                        <i class="material-icons">highlight</i>
                                    </div>
                                    <p class="card-category">Informations</p>
                                    <h3 class="card-title"><%=totalCount.text() %></h3>
                                </div>
                                <div class="card-footer">
                                    <div class="stats">
                                    	산림청에서 제공하는 산 정보 수
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="card card-stats">
                                <div class="card-header card-header-success card-header-icon">
                                    <div class="card-icon">
                                        <i class="material-icons">face</i>
                                    </div>
                                    <p class="card-category">Members</p>
                                    <h3 class="card-title"><%=u.getData() %></h3>
                                </div>
                                <div class="card-footer">
                                    <div class="stats">
                                    	회원가입한 회원 수
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="card card-stats">
                                <div class="card-header card-header-danger card-header-icon">
                                    <div class="card-icon">
                                        <i class="material-icons">bubble_chart</i>
                                    </div>
                                    <p class="card-category">Clubs</p>
                                    <h3 class="card-title"><%=m.getNum() %></h3>
                                </div>
                                <div class="card-footer">
                                    <div class="stats">
                                    	동호회 개수
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-6 col-sm-6">
                            <div class="card card-stats">
                                <div class="card-header card-header-info card-header-icon">
                                    <div class="card-icon">
                                    	<i class="material-icons">loyalty</i>
                                    </div>
                                    <p class="card-category">Posts</p>
                                    <h3 class="card-title"><%=b.getData() %></h3>
                                </div>
                                <div class="card-footer">
                                    <div class="stats">
                                    	총 게시물 수
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
						<div class="col-md-3">
							<div class="card">
								<div class="card-header card-header-primary">
									<h2 class="card-title">
										<b>100대 명산</b>
									</h2>
								</div>
								<div class="card-body">
									<div class="table-responsive" id="divTable">
										<div align="center" style="width: 100%" id='d'>
											<span class='text-success' id='all'>전체</span>
											<span>&emsp;|&emsp;</span>
											<span id='month'>월별</span>
											<span>&emsp;|&emsp;</span>
											<span id='theme'>테마</span>
										</div>
										<div align="right" style="display: none" id="mon">
											<select style="width: 80%;" name="month">
												<option>월</option>
												<%for(int i = 1; i < 13; i++) {%>
													<option value="<%=i%>"><%=i %>월</option>
												<%} %>
											</select>
										</div>
										<div align="right" style="display: none" id="the">
											<select style="width: 80%;" name="theme">
												<option>테마</option>
												<%for(int i = 1; i < 16; i++) {%>
													<option value="<%=i%>"><%=i %>산행</option>
												<%} %>
											</select>
										</div>
										<table class="table">
											<thead class=" text-primary">
												<th><strong>No</strong></th>
												<th><strong>산명</strong></th>
												<th></th>
											</thead>
											<tbody>
											<%for(informationDTO iDTO : iList) {%>
												<tr>
													<td><%=iDTO.getNo() %></td>
													<td><%=iDTO.getName() %></td>
													<td><img class="detail" id="<%=iDTO.getNo() %>" src="bootstrap/assets/img/loupe.png"></td>
												</tr>
											<%} %>
											</tbody>
										</table>
										<div id="paging">
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-9">
							<div class="card">
								<div class="card-header card-header-primary">
									<h2 class="card-title ">
										<b>설명</b>
									</h2>
								</div>
								<div class="card-body" id='info'>
									<div class="row">
									<div align="center">
										<div class="col-md-11" align="left">
											<div class="form-group" id='ex1'>
												<label class="bmd-label-floating">'100대 명산'이란,</label>
												<div class="sam">
														"100대 명산"은 "2002년 세계 산의 해"를 기념하고 산의 가치와 중요성을 새롭게 인식하기 위해
														2002년 10월 산림청에서 선정 공표하였습니다. 산림청에서 선정한 "100대 명산"은 학계, 산악계,
														언론계 등 13명의 전문가로 구성된 선정위원회가 지방자치단체를 통해 추천받은 105개 산과 산악회 및
														산악 전문지가 추천하는 산, 인터넷 사이트를 통해 선호도가 높은 산을 대상을 산의 역사, 문화성,
														접근성, 선호도, 규모, 생태계 특성 등 5개 항목에 가중치를 부여하여 심사 후 선정하였습니다. 100대
														명산에는 국립공원(16), 도립공원(17), 군립공원(11) 지역에서 44개, 백두대간에 인접한 산
														중에서 34개가 선정되었습니다. 또 대암산, 백운산, 점봉산 등 생태적 가치가 큰 산과 울창한 원시림을
														자랑하는 울릉도 성인봉, 섬 전체가 천연보호구역인 홍도 깃대봉 등도 100대 명산에 포함되어 있습니다.

														<hr>
												</div>
											</div>
											<div class="form-group" id='ex2' style="display: none">
												<label class="bmd-label-floating">계절 산행</label>
												<div class="sam">
														계절에 따른 자연의 변화, 같은 산이라도 다른 계절에 가면 또 다른 느낌이다. 산세가 수려하고 사계절
														산행지로 각광 받는 산도 있지만 특정 계절에만 찾아볼 만한 산행지도 있다. 계절에 맞는 산행지 선택은
														산도 오르고 자연의 변화도 즐기는 일석이조의 효과를 얻을 수 있다.

														<hr>
												</div>
											</div>
											<div class="form-group" id='ex3' style="display: none">
												<label class="bmd-label-floating">테마 산행</label>
												<div class="sam">
														산을 오르는 행위 그 자체만을 등산의 모든 것으로 생각하던 등산에서 이제 다양한 주제를 가지고 접근하는
														등산인이 늘어가고 있다. 우리것에 대한 관심과 애정이 등산인들 마음속에 자리잡으면서 등산행태가 변화하고
														있다. 비지땀을 흘리며 정상만을 오르기 바쁜 산행보다 테마산행은 또 다른 즐거움을 제공한다. 자연이
														이루어 놓은 아름다움, 계절에 따른 자연의 변화, 자연과 인간이 이룬 것 과의 조화... 이러한 것을
														즐기며 오르는 테마산행은 산행의 피로도 덜하고 일석이조로 산행을 즐길 수 있다.

														<hr>
												</div>
											</div>
										</div>
									</div>
									</div>
								</div>
								<div class="card-body" id='information' style="display: none">
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
<script src="bootstrap/assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
<!--  Charts Plugin, full documentation here: https://gionkunz.github.io/chartist-js/ -->
<script src="bootstrap/assets/js/plugins/chartist.min.js"></script>
<!-- Library for adding dinamically elements -->
<script src="bootstrap/assets/js/plugins/arrive.min.js" type="text/javascript"></script>
<!--  Notifications Plugin, full documentation here: http://bootstrap-notify.remabledesigns.com/    -->
<script src="bootstrap/assets/js/plugins/bootstrap-notify.js"></script>
<!-- demo init -->
<script src="/bootstrap/assets/js/plugins/demo.js"></script>

</html>
