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
var keyCheck = false; //인증체크

window.onload = function() {
	
	var email_btn = document.getElementById("email_btn");
	var key_btn = document.getElementById("key_btn");
	var email = document.getElementById("resetEmail");
	var id = document.getElementById("resetId");
	
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
	
	email_btn.onclick = function() { //이메일 전송
		var user_email = document.getElementById("resetEmail");
		var email = $('#resetEmail').val();
		var id = $('#resetId').val();
		
		$.ajax({
			url : '/passwordCheck.do',
			method : 'post',
			data : {
				'user_email' : email,
				'user_id' : id
			},
			success : function(data) {
				if ($.trim(data) != "null") {
					$.ajax({
						url : '/emailEx.do',
						method : 'post',
						data : {
							'user_email' : email
						},
						success : function(data) {
							if (!$('#resetEmail').val()) {
								$('#emailc').html('<p style="color:red;">이메일를 입력해주세요.</p>');
								$('#resetEmail').focus();
							}else if ($.trim(data) != 0) {
								$('#emailc').html('<p style="color:green;">인증번호가 전송되었습니다.</p>');
								email_btn.style.display="none";
								user_email.readOnly = true;
								$('#resetKey').focus();
							}else{
								$('#emailc').html('<p style="color:red;">인증번호 전송에 실패하였습니다. 다시 시도해주세요.</p>');
							}
						}
					});
				}else{
					$('#emailc').html('<p style="color:red;">입력하신 정보가 올바르지않습니다. 다시 확인해주세요.</p>');
					$('#resetEmail').focus();
				}
			}
		});
		
	};
	
	key_btn.onclick = function(){ //인증번호 확인
		var email_key = document.getElementById("resetKey");
		var key = $('#resetKey').val();
		var user_email = document.getElementById("resetEmail");
		var email = $('#resetEmail').val();
		
		$.ajax({
			url : '/keyCheck.do',
			method : 'post',
			data : {
				'user_email' : email,
				'email_key' : key
			},
			success : function(data) {
				if (!$('#resetKey').val()) {
					$('#keyc').html('<p style="color:red;">인증번호를 입력해주세요.</p>');
						$('#resetKey').focus();
						keyCheck = false;
				}else if ($.trim(data) != null) {
					$('#keyc').html('<p style="color:green;">인증되었습니다.</p>');
						keyCheck = true;
						key_btn.style.display= "none";
						key.readOnly = true;
				}else{
					$('#keyc').html('<p style="color:red;">인증번호를 다시 확인해주세요.</p>');
					$('#resetEmail').focus();
					keyCheck = false;
				}
			}
		})
	};
}
function doSubmit(f) { //전송시 유효성 체크
	
	if (f.user_id.value == "") {
		$('#idc').html('<p style="color:red;">아이디를 입력해주세요.</p>');
		f.user_id.focus();
		return false;
	}else{
		$('#idc').html('');
	}
	if (f.password.value == "") {
		$('#np').html('<p style="color:red;">비밀번호를 입력해주세요.</p>');
		f.password.focus();
		return false;
	}else{
		$('#np').html('');
	}
	if (f.password2.value == "") {
		$('#pc').html('<p style="color:red;">비밀번호를 입력해주세요.</p>');
		f.password2.focus();
		return false;
	}else{
		$('#pc').html('');
	}
	if (keyCheck == false) {
		$('#keyc').html('<p style="color:red;">이메일 인증을 해주세요.</p>');
		f.email_key.focus();
		return false;
	}else{
		$('#keyc').html('');
	}
	if(f.password.value.length < 6 || f.password.value.length > 12){
		$('#np').html('<p style="color:red;">비밀번호가 형식에 맞지않습니다. 다시 입력해주세요.</p>');
		f.password.focus();
		return false;
	}else{
		$('#np').html('');
	}
	if(f.password.value != f.password2.value) {
		$('#np').html('<p style="color:red;">비밀번호가 일치하지않습니다. 다시 확인해주세요.</p>');
		f.password.focus();
		return false;
	}else{
		$('#np').html('');
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
    
	<!-- reset_password -->
	<section class="content-section" id="reset_password">
		<div class="container" style="width: 30%">
			<div class="content-section-heading text-center">
				<h3 class="text-secondary mb-0">Reset Password</h3>
				<h2 class="mb-5">비밀번호 변경</h2>
				<div class="card card-login mx-auto mt-5">
					<div class="card-header">Reset Password</div>
					<div class="card-body">
						<form style="color: black;" onsubmit="return doSubmit(this);" method="post" action="reset_proc.do">
							<div class="form-group" align="left">
								<label for="resetId">아이디</label>
								<input class="form-control" id="resetId" name="user_id" type="text" placeholder="ID">
								<div id="idc"></div>
							</div>
							<div class="form-group" align="left">
								<label for="resetEmail">이메일</label>
								<div class="input-group">
									<input class="form-control" id="resetEmail" name="email" type="email"
										aria-describedby="emailHelp" placeholder="Email">
									<button type="button" class="btn btn-primary" id="email_btn">
										인증번호 전송<i class="fa fa-mail-forward spaceLeft"></i>
									</button>
								</div>
								<div id="emailc"></div>
							</div>
							<div class="form-group" align="left">
								<label for="resetNumber">인증번호</label>
								<div class="input-group">
									<input class="form-control" id="resetKey" name="keynum" type="text" placeholder="number">
									<button type="button" class="btn btn-primary" id="key_btn">
										인증번호 확인<i class="fa fa-edit spaceLeft"></i>
									</button>
								</div>
								<div id="keyc"></div>
							</div>
							<div class="form-group" align="left">
								<label for="resetPw">새로운 비밀번호</label>
								<input class="form-control" id="resetPw1" name="password" type="password" placeholder="New password">
								<div id="np"></div>
								<input class="form-control" id="resetPw2" name="password2" type="password" placeholder="password Check">
								<div id="pc"></div>
							</div>
							<br>
							<input type="submit" value="Reset Password" class="btn btn-primary btn-block">
						</form>
						<div class="text-center">
							<a class="d-block small mt-3" href="login.do">Login</a> <a
								class="d-block small" href="idSearch.do">id search</a>
						</div>
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
