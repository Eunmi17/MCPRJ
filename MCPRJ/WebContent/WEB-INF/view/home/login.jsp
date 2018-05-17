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
	
<script>
window.onload = function() {
	var id = document.getElementById("loginId");
	
	id.onkeydown = function(event){ //아이디 한글 no
		event = event || window.event;

        var keyID = (event.which) ? event.which : event.keyCode;

        //48~57: 숫자키 / 96~105: 숫자 키패드
        if ((keyID >= 48 && keyID <= 57) || (keyID >= 96 && keyID <= 105)
              || (keyID == 8) || (keyID == 46) || (keyID == 110) || (keyID == 190) //8->backspace, 46->delete, 110,190->.
              || (keyID >= 65 && keyID <= 90) && //65~90 영소문자, 
              (keyID != 16) && (keyID != 20) && (keyID != 21)) { //16->shift, 20->capslock, 21->한/영
              
           return true;
        } else {
           return false;
        }
	};
}
function doSubmit(f) { //전송시 유효성 체크
	if (f.user_id.value == "") {
		$('#id').html('<p style="color:red;">아이디를 입력해주세요.</p>');
		f.user_id.focus();
		return false;
	}else{
		$('#id').html('');
	}
	if(f.password.value == "") {
		$('#pw').html('<p style="color:red;">비밀번호를 입력해주세요.</p>');
		f.password.focus();
		return false;
	}else{
		$('#pw').html('');
	}
}
</script>
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
          <a class="js-scroll-trigger" href="home.do">홈</a>
        </li>
        <li class="sidebar-nav-item">
          <a class="js-scroll-trigger" href="join.do">회원가입</a>
        </li>
      </ul>
    </nav>

<!-- login -->
	<section class="content-section bg-light" id="login">
		<div class="container" style="width: 30%">
			<div class="content-section-heading text-center">
				<h3 class="text-secondary mb-0">Login</h3>
				<h2 class="mb-5">로그인</h2>
			</div>
			<div class="card card-login mx-auto mt-5">
				<div class="card-header" align="center">Login</div>
				<div class="card-body">
					<form method="post" action="login_proc.do" onsubmit="return doSubmit(this);">
						<div class="form-group">
							<label for="loginId">아이디</label>
							<input class="form-control" id="loginId" name="user_id" type="text" placeholder="ID">
							<div id="id"></div>
						</div>
						<div class="form-group">
							<label for="loginPassword">비밀번호</label>
							<input class="form-control" id="loginPassword" name="password" type="password" placeholder="Password">
							<div id="pw"></div>
						</div>
						<br>
						<input class="btn btn-primary btn-block" type="submit" value="Login">
					</form>
					<div class="text-center">
						<a class="d-block small mt-3" href="idSearch.do">id search</a>
						<a class="d-block small" href="passwordReset.do">password reset</a>
					</div>
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