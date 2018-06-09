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
										<select>
											<%for(int i = 1; i < 13; i++) {%>
												<option><%=i %>월</option>
											<%} %>
										</select>
										<select>
											<%for(int i = 1; i < 8; i++) {%>
												<option><%=i %>산행</option>
											<%} %>
										</select>
										<table class="table">
											<thead class=" text-primary">
												<th><strong>No</strong></th>
												<th><strong>산명</strong></th>
											</thead>
											<tbody>
											<%for(int i = 1; i < 11; i++) {%>
												<tr>
													<td><%=i %></td>
													<td>산명</td>
												</tr>
											<%} %>
											</tbody>
										</table>
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
								<div class="card-body">
									<div class="row">
										<div class="col-md-6" align="center">
											<div class="form-group">
												<img src="http://www.forest.go.kr/newkfsweb/cmm/fms/getImage.do?fileSn=1&atchFileId=FILE_000000000424055" width="80%">
											</div>
										</div>
										<div class="col-md-5">
											<div class="form-group">
												<label class="bmd-label-floating">산 명</label>
												<div class="sam">산 이름<hr>
												</div>
											</div>
											<div class="form-group">
												<label class="bmd-label-floating">높이</label>
												<div class="sam">1000m<hr>
												</div>
											</div>
											<div class="form-group">
												<label class="bmd-label-floating">소재지</label>
												<div class="sam">한국 어딘가<hr>
												</div>
											</div>
										</div>
									</div>
									<div class="row">
									<div align="center">
										<div class="col-md-11" align="left">
											<div class="form-group">
												<label class="bmd-label-floating">선정 이유</label>
												<div class="sam">
													"강원도에서 진달래가 가장 많이 피는 산으로 알려져 있고, 참나무 중심의 울창한 산림과 부드러운 산줄기 등
													우리나라 산의 전형적인 모습을 갖추고 있으며, 홍천강의 발원지 및 소양강의 수원(水源)을 이루고 있는 점
													등을 고려하여 선정 암봉이 솟아있는 정상에서 소양호를 조망할 수 있고, 야생화가 많이 서식하여
													자연학습관찰에도 좋은 여건을 갖추고 있음. '98년 강원도에서 자연휴양림으로 지정"

													<hr>
												</div>
											</div>
										</div>
									</div>
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
