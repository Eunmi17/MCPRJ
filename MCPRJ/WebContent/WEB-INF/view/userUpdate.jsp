<%@page import="java.util.Locale"%>
<%@page import="java.util.GregorianCalendar"%>
<%@page import="java.util.Calendar"%>
<%@page import="com.emlee.DTO.userDTO"%>
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
	String session_user_name = CmmUtil.nvl((String)session.getAttribute("session_user_name"));
%>
<!-- 나중에 팀이름으로 바꾸기 -->

<%
	Calendar calendar = new GregorianCalendar(Locale.KOREA);
	int y = calendar.get(Calendar.YEAR);

	userDTO uDTO = (userDTO) request.getAttribute("uDTO");
	if (uDTO == null)
		uDTO = new userDTO();

	String[] local = CmmUtil.nvl(uDTO.getAddr1()).split(" ");
	String n = CmmUtil.nvl(uDTO.getDay()).substring(0, 4);
	int nas = Integer.parseInt(n);
	int na = y - nas + 1;
%>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script>
window.onload = function() {
	var post_btn = document.getElementById("post_btn"); //주소찾기 버튼.
	var nav1 = document.getElementById("nav1");
	var nav2 = document.getElementById("nav2");
	var nav3 = document.getElementById("nav3");
	nav1.onclick = function() {
		nav2.style.display = "";
		nav3.style.display = "";
	};
	var reset = document.getElementById("reset");
	
	reset.onclick = function(){
		var user_no = <%=session_user_no%>
		location.href="/userDetail.do?user_no="+user_no;
	}
	
	post_btn.onclick = function(){ //주소찾기
		new daum.Postcode({
			oncomplete : function(data) {
				var fullAddr = '';
				var extraAddr = '';
				if (data.userSelectedType === 'R') {
				fullAddr = data.roadAddress;

            	} else {
               		fullAddr = data.jibunAddress;
            	}
            	if (data.userSelectedType === 'R') {
               		if (data.bname !== '') {
                  		extraAddr += data.bname;
              		}
               		if (data.buildingName !== '') {
                  		extraAddr += (extraAddr !== '' ? ', '
                        	+ data.buildingName
                        	: data.buildingName);
               		}
               		fullAddr += (extraAddr !== '' ? ' ('
                     	+ extraAddr
                     	+ ')'
                     	: '');
            	}
            	document.getElementById('post').value = data.zonecode;
	            document.getElementById('addr1').value = fullAddr;
            	document.getElementById('addr2').focus();
         	}
      	}).open();
	};
}

function doSubmit(f) { //전송시 유효성 체크
	
	if(f.day.value == "") {
		$('#dayc').html('<p style="color:red;">생년월일를 입력해주세요.</p>');
		f.day.focus();
		return false;
	}else{
		$('#dayc').html('');
	}
	if(f.gender.checked == false) {
		$('#genderc').html('<p style="color:red;">성별을 선택해주세요.</p>');
		f.gender.focus();
		return false;
	}else{
		$('#genderc').html('');
	}
	if(f.addr1.value == "") {
		$('#addr').html('<p style="color:red;">주소를 입력해주세요.</p>');
		f.addr2.focus();
		return false;
	}else{
		$('#addr').html('');
	}
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
.non{
    background-size: 0, 100%, 100%, 100%;
    border: 0;
   	font-size: 16px;
    background: no-repeat center bottom, center calc(100% - 1px);
    width: 100%;   
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
							<li class="nav-item " style="list-style-type: none"><a
								class="nav-link" href="/regList.do"> <i
									class="material-icons">assignment</i>
									<p>작성글</p>
							</a></li>
						</ul>
						<ul class="nav-item active" id="nav3">
							<li class="nav-item active " style="list-style-type: none"><a
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
										<b>User Profile</b>
									</h2>
								</div>
								<div class="card-body">
									<form method="post" onsubmit="return doSubmit(this);" action="userup_proc.do">
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">이름</label>
													<p style="color: red">이름은 수정이 불가능합니다.</p>
													<input type="text" class="form-control"
														value="<%=CmmUtil.nvl(uDTO.getUser_name())%>" readonly>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">ID</label>
													<p style="color: red">ID는 수정이 불가능합니다.</p>
													<input type="text" class="form-control"
														value="<%=CmmUtil.nvl(uDTO.getUser_id())%>" readonly>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">이메일</label>
													<p style="color: red">이메일 수정은 관리자에게 문의해주세요.</p>
													<input type="text" class="form-control"
														value="<%=CmmUtil.nvl(uDTO.getEmail())%>" readonly>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">동호회</label> <img
														src="bootstrap/assets/img/reder.png">
														<%if(session_auth.endsWith("A")) {%>
													<p style="color: red">동호회 명은 수정이 불가능합니다.</p>
													<%}else{ %>
													<p style="color: red">동호회 정보는 리더만 수정 가능합니다.</p>
													<%} %>
													<input type="text" class="form-control"
														value="<%=CmmUtil.nvl(uDTO.getTeam_no())%>" readonly>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">생년월일</label> <input
														type="date" class="form-control" name="day"
														value="<%=CmmUtil.nvl(uDTO.getDay())%>">
													<div id="dayc"></div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">성별</label>
													<div class="form-control">
														<input type="radio" name="gender" value="1"
															<%=CmmUtil.checked(CmmUtil.nvl(uDTO.getGender()), "남자")%>>
														남자 &emsp;&emsp;&emsp; <input type="radio" name="gender"
															value="2"
															<%=CmmUtil.checked(CmmUtil.nvl(uDTO.getGender()), "여자")%>>
														여자
													</div>
													<div id="genderc"></div>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">나이</label>
													<p style="color: red">나이는 태어난 년도에 맞게 자동 설정됩니다.</p>
													<input type="text" class="form-control" value="<%=na%>"
														readonly>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">지역</label>
													<p style="color: red">지역은 주소에 맞게 자동 설정됩니다.</p>
													<input type="text" class="form-control"
														value="<%=local[0]%>" readonly>
												</div>
											</div>
										</div>
										<div class="row">
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">주소</label>
													<button type="button" class="btn btn-primary pull-right"
														id="post_btn">주소 찾기</button>
													<input type="text" class="form-control" id="post" name="post"
														value="<%=CmmUtil.nvl(uDTO.getPost())%>" readonly>
												</div>
											</div>
											<div class="col-md-12">
													<input type="text" class="non" name="addr1" id="addr1"
														value="<%=CmmUtil.nvl(uDTO.getAddr1())%>" readonly>
													<input type="text" class="form-control" name="addr2" id="addr2"
														value="<%=CmmUtil.nvl(uDTO.getAddr2())%>">
													<div id="addr"></div>
											</div>
										</div>
										<button type="button" id="reset" class="btn btn-primary pull-right"
											style="width: 100px">취소</button>
										<button class="btn btn-primary pull-right"
											style="width: 100px">수정</button>
										<div class="clearfix"></div>
									</form>
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