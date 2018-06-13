<%@page import="org.jsoup.nodes.Element"%>
<%@page import="com.emlee.util.CmmUtil"%>
<%@page import="com.emlee.util.TextUtil"%>
<%@page import="org.jsoup.select.Elements"%>
<%@page import="org.jsoup.Jsoup"%>
<%@page import="org.jsoup.nodes.Document"%>
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
	String session_user_no = CmmUtil.nvl((String) session.getAttribute("session_user_no"));
	String session_user_id = CmmUtil.nvl((String) session.getAttribute("session_user_id"));
	System.out.print(session_user_no);
	String session_user_name = CmmUtil.nvl((String) session.getAttribute("session_user_name"));
	
	String url = "http://openapi.forest.go.kr/openapi/service/trailInfoService/getforeststoryservice?mntnNm=";
	String mntnNm = CmmUtil.nvl((String) request.getAttribute("nm"));
	String mntnHght = CmmUtil.nvl((String) request.getAttribute("hght"));
	String hght = "&mntnHght=";
	String servicekey = "&serviceKey=HNnmPvdDJDrKEsF3NjHy%2BNkeMnO3zSVJs9GbDxpnYAVpX7GeVtnWIiqpPIOugTK8gq0l9b7sVNBKHL%2FF39%2FClw%3D%3D";
	String allurl = url+mntnNm+hght+mntnHght+"&numOfRows=1"+servicekey;
	Document text = Jsoup.connect(allurl).get();
	
	Elements item = text.select("items > item");
	Elements totalCount = text.select("totalCount");
	
		Elements mntnid = text.select("mntnid");
		Elements mntnnm = text.select("mntnnm");
		Elements mntninfopoflc = text.select("mntninfopoflc");
		Elements mntninfohght = text.select("mntninfohght");
		Elements mntninfodscrt = text.select("mntninfodscrt");
		Elements mntninfodtlinfocont = text.select("mntninfodtlinfocont");
		Elements pbtrninfodscrt = text.select("pbtrninfodscrt");
		Elements crcmrsghtnginfodscrt = text.select("crcmrsghtnginfodscrt");
		Elements crcmrsghtnginfoetcdscrt = text.select("crcmrsghtnginfoetcdscrt");
		Elements mntnsbttlinfo = text.select("mntnsbttlinfo");
		Elements crcmrsghtngetcimageseq = text.select("crcmrsghtngetcimageseq");
		Elements mntnattchimageseq = text.select("mntnattchimageseq");
		Elements pageNo = text.select("pageNo");

%>
<script>

	window.onload = function() {
		
		var list = document.getElementById("list");
		<%if(!session_user_id.equals("admin")){%>
		var nav1 = document.getElementById("nav1");
		var nav2 = document.getElementById("nav2");
		var nav3 = document.getElementById("nav3");
		nav1.onclick = function() {
			nav2.style.display = "";
			nav3.style.display = "";
		};
	<%}%>
		list.onclick = function() {
			location.href = "/apiMain.do";
		};
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
		<div class="sidebar" data-color="gray" data-background-color="white"
			data-image="bootstrap/assets/img/sidebar-1.jpg">
			<!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | azure | green | orange | danger"

        Tip 2: you can also add an image using data-image tag
    -->
			<div class="logo">
				<a href="home.do" class="simple-text logo-normal"> Mountain Climbing </a>
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
							<p>동호회 관리</p>
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
            <jsp:include page="top.jsp" flush="true"/>
            <!-- End Navbar -->
			<div class="content">
				<div class="container-fluid">
					<div class="row">
					<div align="center">
						<div class="col-md-10" style="text-align: left;">
							<div class="card">
								<div class="card-header card-header-primary">
									<h5 align="right">
									산코드 : <%=mntnid.text() %>
									</h5>
									<h2 class="card-title ">
										<b><%=mntnnm.text() %></b>
									</h2>
								</div>
								<div class="card-body">
									<form>
									<div class="row">
										<%if(!mntnsbttlinfo.text().equals("")) {%>
											<div class="col-md-6" align="center">
												<div class="form-group">
													<img src="<%=mntnattchimageseq.text()%>" width="80%">
												</div>
											</div>
											<div class="col-md-5">
												<div class="form-group">
													<label class="bmd-label-floating">부재</label>
													<div class="sam"><%=TextUtil.exchangeEscape2(mntnsbttlinfo.text()) %><hr></div>
												</div>
												<div class="form-group">
													<label class="bmd-label-floating">소재지</label>
													<div class="sam"><%=mntninfopoflc.text() %><hr></div>
												</div>
												<div class="form-group">
													<label class="bmd-label-floating">높이</label>
													<div class="sam"><%=mntninfohght.text() %> M<hr></div>
												</div>
											</div>
										<%}else{ %>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">소재지</label>
													<div class="sam"><%=mntninfopoflc.text() %><hr></div>
												</div>
											</div>
											<div class="col-md-6">
												<div class="form-group">
													<label class="bmd-label-floating">높이</label>
													<div class="sam"><%=mntninfohght.text() %> M<hr></div>
												</div>
											</div>
										<%} %>
										</div>
										<%if(!mntninfodscrt.text().equals("&amp;nbsp;")&&!mntninfodscrt.text().equals("&nbsp;")&&!mntninfodscrt.text().equals("")&&!mntninfodscrt.text().equals("&amp;#160;")) {%>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label class="bmd-label-floating">개관</label>
													<div class="sam"><%=TextUtil.exchangeEscape2(mntninfodscrt.text())%><hr></div>
												</div>
											</div>
										</div>
										<%} %>
										<%if(!mntninfodtlinfocont.text().equals("&amp;nbsp;")&&!mntninfodtlinfocont.text().equals("&nbsp;")&&!mntninfodtlinfocont.text().equals("")&&!mntninfodscrt.text().equals("&amp;#160;")) {%>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label class="bmd-label-floating">상세</label>
													<div class="sam"><%=TextUtil.exchangeEscape2(mntninfodtlinfocont.text())%><hr></div>
												</div>
											</div>
										</div>
										<%} %>
										<%if(!crcmrsghtnginfodscrt.text().equals("&amp;nbsp;")&&!crcmrsghtnginfodscrt.text().equals("&nbsp;")&&!crcmrsghtnginfodscrt.text().equals("")&&!mntninfodscrt.text().equals("&amp;#160;")) {%>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label class="bmd-label-floating">주변관광</label>
													<div class="sam"><%=TextUtil.exchangeEscape2(crcmrsghtnginfodscrt.text())%><hr></div>
												</div>
											</div>
										</div>
										<%} %>
										<%if(!pbtrninfodscrt.text().equals("&amp;nbsp;")&&!pbtrninfodscrt.text().equals("&nbsp;")&&!pbtrninfodscrt.text().equals("")&&!mntninfodscrt.text().equals("&amp;#160;")) {%>
										<div class="row">
											<div class="col-md-12">
												<div class="form-group">
													<label class="bmd-label-floating">대중교통</label>
													<div class="sam"><%=TextUtil.exchangeEscape2(pbtrninfodscrt.text())%><hr></div>
												</div>
											</div>
										</div>
										<%} %>
										<%if(!crcmrsghtnginfoetcdscrt.text().equals("&amp;nbsp;")&&!crcmrsghtnginfoetcdscrt.text().equals("&nbsp;")&&!crcmrsghtnginfoetcdscrt.text().equals("")&&!mntninfodscrt.text().equals("&amp;#160;")) {%>
											<div class="row">
												<div class="col-md-6">
													<div class="form-group">
														<label class="bmd-label-floating">산행포인트</label>
														<div class="sam"><%=TextUtil.exchangeEscape2(crcmrsghtnginfoetcdscrt.text())%><hr>
														</div>
													</div>
												</div>
												<%
												if(crcmrsghtngetcimageseq.text().endsWith("swf")){
												%>
												<div class="col-md-6">
													<div class="form-group">
														<label class="bmd-label-floating">산행포인트 지도</label><br>
														<div class="sam"><a id="m" href="<%=crcmrsghtngetcimageseq.text()%>"><%=crcmrsghtngetcimageseq.text()%></a><hr></div>
														<p style="color: red;">링크를 클릭하시면 파일이 다운로드됩니다.</p>
													</div>
												</div>
												<%} %>
											</div>
											<%
												if(crcmrsghtngetcimageseq.text().endsWith("swf")){
											%>
											<div class="row">
												<div class="col-md-12" align="center">
													<div class="form-group">
														<embed src="<%=crcmrsghtngetcimageseq.text()%>" width="800" height="500"></embed>
													</div>
												</div>
											</div>
											<%} %>
										<%} %>
										<button type="button" id="list" class="btn btn-primary pull-right">리스트로 이동</button>
										<div class="clearfix"></div>
									</form>
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
