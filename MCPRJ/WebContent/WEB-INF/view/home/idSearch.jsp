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
	
	var email = document.getElementById("searchEmail");
	
	email.onkeydown = function(event){ //email 한글 no
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

	if (f.user_name.value == "") {
		$('#name').html('<p style="color:red;">이름을 입력해주세요.</p>');
		f.user_name.focus();
		return false;
	}
	if (f.email.value == "") {
		$('#email').html('<p style="color:red;">이메일를 입력해주세요.</p>');
		f.email.focus();
		return false;
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
    
	<!-- id_search -->
	<section class="content-section bg-primary text-white text-center" id="id_search">
		<div class="container" style="width: 30%">
			<div class="content-section-heading text-center">
				<h3 class="mb-0">id_search</h3>
				<h2 class="mb-5">아이디 찾기</h2>
			</div>
			<div class="card card-login mx-auto mt-5">
				<div class="card-header" align="center" style="color: black;">ID Search</div>
				<div class="card-body">
					<form style="color: black;" onsubmit="return doSubmit(this);" method="post" action="idSearch_Proc.do">
						<div class="form-group" align="left">
							<label for="searchName">이름</label>
							<input class="form-control" id="searchName" name="user_name" type="text"
								placeholder="user name">
							<div id="name"></div>
						</div>
						<div class="form-group" align="left">
							<label for="searchEmail">이메일</label>
							<div class="input-group">
								<input class="form-control" id="searchEmail" name="email" type="email"
									aria-describedby="emailHelp" placeholder="Email">
							</div>
							<div id="email"></div>
						</div>
						<br>
						<input type="submit" value="Search" class="btn btn-primary btn-block">
					</form>
					<div class="text-center">
						<a class="d-block small mt-3" href="login.do">Login</a>
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
