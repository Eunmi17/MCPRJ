<%@page import="com.emlee.util.CmmUtil"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<!-- Favicons -->
    <link rel="apple-touch-icon" href="bootstrap/assets/img/icon.png">
    <link rel="icon" href="bootstrap/assets/img/icon.png">
    
<title>MC</title>

<!-- Bootstrap Core CSS -->
<link
	href="bootstrap/mainBootstrap/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom Fonts -->
<link
	href="bootstrap/mainBootstrap/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic"
	rel="stylesheet" type="text/css">
<link
	href="bootstrap/mainBootstrap/vendor/simple-line-icons/css/simple-line-icons.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="bootstrap/mainBootstrap/css/stylish-portfolio.css"
	rel="stylesheet">
<%String session_user_id = CmmUtil.nvl((String)session.getAttribute("session_user_id")); %>
</head>

<body id="page-top">
	
    <!-- Navigation -->
    <a class="menu-toggle rounded" href="#">
      <i class="fa fa-bars"></i>
    </a>
    <nav id="sidebar-wrapper">
      <ul class="sidebar-nav">
        <li class="sidebar-brand">
          <a class="js-scroll-trigger" href="/main.do">Mountain Climbing</a>
        </li>
        <li class="sidebar-nav-item">
          <a class="js-scroll-trigger" href="#check">유의사항</a>
        </li>
        <%if (session_user_id.equals("")) {%>
        <li class="sidebar-nav-item">
          <a class="js-scroll-trigger" href="login.do">로그인</a>
        </li>
        <li class="sidebar-nav-item">
          <a class="js-scroll-trigger" href="join.do">회원가입</a>
        </li>
        <%}else{ %>
        <li class="sidebar-nav-item">
          <a class="js-scroll-trigger" href="logout.do">로그아웃</a>
        </li>
        <%} %>
      </ul>
    </nav>

	<!-- Header -->
	<header class="masthead d-flex">
		<div class="container text-center my-auto">
			<h1 class="mb-1" style="color: whitesmoke">Mountain Climbing</h1>
			<h3 class="mb-5" style="color: whitesmoke">
				<em>산이 거기 있기에 오른다&nbsp;&nbsp;-&nbsp;&nbsp;조지 말러리</em>
			</h3>
			<a class="btn btn-primary btn-xl js-scroll-trigger" href="/main.do">MAIN</a>
		</div>
		<div class="overlay"></div>
	</header>

	<!-- check -->
	<section class="content-section" id="check">
		<div class="container">
			<div class="content-section-heading text-center">
				<h3 class="text-secondary mb-0">등산 전</h3>
				<h2 class="mb-5">알아두기</h2>
			</div>
			<div class="row no-gutters">
				<div class="col-lg-6">
					<a class="portfolio-item">
						<span class="caption">
							<span class="caption-content">
								<h3>등산에 관한 짐 휴브너의<br> 6가지 규칙<br></h3>
								<p class="mb-0">
								1.&emsp; 열정을 가지고 오른다. <br>
								2.&emsp; 결단이 없으면 영광도 없다. <br>
								3.&emsp; 막다른 길을 고려한다. <br>
								4.&emsp; 동반자에게 등을 돌리지 않는다. <br>
								5.&emsp; 가고 싶지 않은 곳은 쳐다보지도 않는다. <br>
								6.&emsp; 인명구조용 로프에는 언제나 여유가 있다.
								</p>
							</span>
						</span>
						<img class="img-fluid"
						src="bootstrap/mainBootstrap/img/1.jpg" alt="">
					</a>
				</div>
				<div class="col-lg-6">
					<a class="portfolio-item">
						<span class="caption">
							<span class="caption-content">
								<h3>등산 준비</h3>
								<p class="mb-0">
								1.&emsp; 등산 장비 : 처음 시작 할 때는 부피가 작고,
								<br>&emsp;가벼운 장비를 선택하고, 필요한 장비만 구매<br>
								2.&emsp; 산행지 자료 수집<br>
								3.&emsp; 날씨 확인<br>
								4.&emsp; 준비물 : 산행을 할 때 먹을 간식, 물 등을
								<br>&emsp;전날 체크리스트를 만들어 확인하고 챙기기
								</p>
							</span>
						</span>
						<img class="img-fluid"
						src="bootstrap/mainBootstrap/img/2.jpg" alt="">
					</a>
				</div>
				<div class="col-lg-6">
					<a class="portfolio-item">
						<span class="caption">
							<span class="caption-content">
								<h3>산행지 선택 정보</h3>
								<p class="mb-0">
								1.&emsp; 국립공원 지명산 :&emsp;산세가 화려하고,
								<br>&emsp;&emsp;볼거리도 많고, 등산코스가 잘 정비되어
								<br>&emsp;&emsp;있기 때문에 가장 안전하고 무난 <br>
								2.&emsp; 계절 산행 :&emsp; 계절 별로 찾는 것도 좋고
								<br>&emsp;&emsp;특정 계절에 볼 수 있는 산행지도 있음 <br>
								3.&emsp; 지역별 산
								</p>
							</span>
						</span>
						<img class="img-fluid"
						src="bootstrap/mainBootstrap/img/3.jpg" alt="">
					</a>
				</div>
				<div class="col-lg-6">
					<a class="portfolio-item">
						<span class="caption">
							<span class="caption-content">
								<h3>걷는 방법</h3>
								<p class="mb-0">
								1.&emsp; 평소보다 포폭을 작게<br>
								2.&emsp; 걸음은 지그재그<br>
								3.&emsp; 쉬는 시간 조절
								</p>
							</span>
						</span>
						<img class="img-fluid"
						src="bootstrap/mainBootstrap/img/4.jpg" alt="">
					</a>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<footer class="footer text-center">
		<div class="container">
			<p class="text-muted small mb-0">문의 : 관리자 (dldmsal1123@gmail.com)</p>
			<br>
			<p class="text-muted small mb-0">Copyright &copy; Your Website 2018</p>
		</div>
	</footer>

	<!-- Scroll to Top Button-->
	<a class="scroll-to-top rounded js-scroll-trigger" href="#page-top">
		<i class="fa fa-angle-up"></i>
	</a>

	<!-- Bootstrap core JavaScript -->
	<script src="bootstrap/mainBootstrap/vendor/jquery/jquery.min.js"></script>
	<script src="bootstrap/mainBootstrap/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

	<!-- Plugin JavaScript -->
	<script src="bootstrap/mainBootstrap/vendor/jquery-easing/jquery.easing.min.js"></script>

	<!-- Custom scripts for this template -->
	<script src="bootstrap/mainBootstrap/js/stylish-portfolio.min.js"></script>

</body>

</html>

