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
	
	String[] themeName = {"테마", "진달래", "철쭉", "동백", "단풍", "억새", "계곡", "섬", "눈",
							"바위", "고로쇠", "온천", "사찰", "호반", "철도", "동굴", "시산제"};
	String[] monthName = {"계절", "봄", "여름", "가을", "겨울"};
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
.page-linkm{
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
.page-linkm:not([href]):not([tabindex]){
	color: #999999
}
.page-linkt{
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
.page-linkt:not([href]):not([tabindex]){
	color: #999999
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
	var season = document.getElementById("season");
	var mountain = document.getElementById("mountain");
	var winter = document.getElementById("winter");
	var spring = document.getElementById("spring");
	var summer = document.getElementById("summer");
	var autumn = document.getElementById("autumn");
	var themeinfo = document.getElementById("themeinfo");
	var inf = document.getElementById("inf");
	
	$(document).on("change", ".month", function() {
		var val = $(".month").val();
		var month = "";
		console.log("month val : " + val);
		
		if(val == 4){
			winter.style.display = "";
			spring.style.display = "none";
			summer.style.display = "none";
			autumn.style.display = "none";
			month = "겨울";
		}else if(val == 1){
			winter.style.display = "none";
			spring.style.display = "";
			summer.style.display = "none";
			autumn.style.display = "none";
			month = "봄";
		}else if(val == 2){
			winter.style.display = "none";
			spring.style.display = "none";
			summer.style.display = "";
			autumn.style.display = "none";
			month = "여름";
		}else if(val == 3){
			winter.style.display = "none";
			spring.style.display = "none";
			summer.style.display = "none";
			autumn.style.display = "";
			month = "가을";
		}else{
			winter.style.display = "none";
			spring.style.display = "none";
			summer.style.display = "none";
			autumn.style.display = "none";
		}
		
		if(val == 0){
			mon.style.display = "";
			the.style.display = "none";
			ex1.style.display = "none";
			ex2.style.display = "";
			ex3.style.display = "none";
			info.style.display = "";
			infomation.style.display = "none";
			season.style.display = "none";
			inf.style.display = "";
			mountain.style.display = "none";
		}else{
			season.style.display = "";
			mountain.style.display = "none";
			inf.style.display = "none";
			infomation.style.display = "none";
			info.style.display = "";
		}
		
		console.log("계절 : " + month);
		$.ajax({
			url : "/month.do",
			method : "post",
			data : {'month' : month},
			dataType : "json",
			success : function(data) {
				var contents = "";
				contents += "<table class='table'><thead class=' text-primary'>";
				contents += "<th><strong>No</strong></th><th><strong>산명</strong></th>";
				contents += "<th></th></thead><tbody>";
				$.each(data, function (key, value) {
					contents += "<tr><td>"+value.no+"</td><td>"+value.name+"</td>";
					contents += "<td><img class='detail' id="+value.no+" src='bootstrap/assets/img/loupe.png'></td></tr>";
				});
				contents += "</tbody></table>";
				$('.table').html(contents);
			}
		});
		
		$.ajax({
			url : "/monthNum.do",
			method : "post",
			data : {'month' : month},
			success : function(data) {
				console.log("data : " + data);
				var page = 1;
				var countPage = 5;
				var countList = 5;
				var totalCount = data;
				var totalPage =  parseInt(totalCount / countList);
				
				if(totalCount % countList > 0){
					totalPage++;
				}
				if(totalPage < page){
					page = totalPage;
				}
				
				var startPage = 1;
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
					content += "<a class='page-linkm' id="+startPage-5+" value='"+month+"' aria-label='Previous'>";
					content += "<span aria-hidden='true'>&laquo;</span>";
					content += "<span class='sr-only'>Previous</span></a></li>";
				}
				for(var iCount = startPage; iCount <= endPage; iCount++){
					if(iCount == page) {
						content += "<li class='page-item'><a class='page-linkm'><b>("+iCount+")</b></a></li>";
					}else{
						content += "<li class='page-item'><a class='page-linkm' id='"+iCount+"' value='"+month+"'>"+iCount+"</a></li>";
					}
				}
				if(endPage != totalPage) {
					content += "<li class='page-item'>";
					content += "<a class='page-linkm' id="+startPage+5+" value='"+month+"' aria-label='Next'>";
					content += "<span aria-hidden='true'>&raquo;</span>";
					content += "<span class='sr-only'>Next</span></a></li>";
				}
				content += "</ul></nav></div>";
				$('#paging').html(content);
			},
			error : function(error) {alert("month : " + error)}
		});
		 
	});
	
	$(document).on("change", ".theme", function() {
		var val = $(".theme").val();
		var theme = "";
		console.log("theme val : " + val);
		
		var content = ""
		content += "<div class='form-group' id='themeinfo' style='display: '>";
		if(val == 1){
			theme = "진달래";
			content += "<label class='bmd-label-floating'>진달래 산행</label>";
			content += "<div class='sam'>";
			content += "가장 먼저 산천을 원색으로 물들이는 봄의 전령 진달래, 3월 말부터 피기 시작해 ４월초면 절정을이룬다. 비지땀을 흘리며 오르는 산악등반이 아니라 물소리와 새소리를 들으며 여유만만하게 걷는 진달래 산행";
		}else if(val == 2){
			theme = "철쭉";
			content += "<label class='bmd-label-floating'>철쭉 산행</label>";
			content += "<div class='sam'>";
			content += "계절의 여왕 5월, 봄의 전령사 진달래의 꽃이 4월을 장식하고 진달래가 바래지는 5월에 들어서면 철쭉꽃이 요염한 자태를 뽐낸다. 철쭉꽃과 함께 봄은 깊어만 간다. 산에 따라 5월초부터 피기 시작하여 5월의 끝을 장식하는 철쭉이 5월 하순이면 온산을 태워 버릴 듯 뒤덮는다. 짙어가는 산록을 배경으로 그 진분홍 철쭉의 바다를 가로지르는 철쭉산행지 명산";
		}else if(val == 3){
			theme = "동백";
			content += "<label class='bmd-label-floating'>동백 산행</label>";
			content += "<div class='sam'>";
			content += "남녘의 봄이 동백으로 피어난다. 바다를 향해 꽃봉오리를 터뜨리는 동백숲 농익은 붉은 꽃잎이 새악시 입술처럼 붉다. 11월부터 ４월까지 피고 지기를 계속해 봄꽃인지 겨울꽃인지 분간이 안되지만 짙푸른 잎새와 붉은 꽃잎，3월 중순에서 4월 초순까지 절정을 이룬다.";
		}else if(val == 4){
			theme = "단풍";
			content += "<label class='bmd-label-floating'>단풍 산행</label>";
			content += "<div class='sam'>";
			content += "여름내 푸르렀던 나무들이 붉은 색으로 곱게 치장한다. 만산홍엽, 가을산이 붉디붉게 타오른다. 층층 암봉마다 돌연한 유혹처럼 불타는 단풍";
		}else if(val == 5){
			theme = "억새";
			content += "<label class='bmd-label-floating'>억새 산행</label>";
			content += "<div class='sam'>";
			content += "단풍이 한창인 가을산에 은빛 너울대는 억새는 또다른 장관이다. 억새밭에 가을햇살이 엷게 비칠때 바람결이 빚어내는 억새들의 합창은 대자연의 교향악이다.";
		}else if(val == 6){
			theme = "계곡";
			content += "<label class='bmd-label-floating'>계곡 산행</label>";
			content += "<div class='sam'>";
			content += "계곡 또는 하천을 따라 걸으면서 산과 물의 조화를 본다. 아름다운 계곡의 비경을 즐기며 더위도 식힐 수 있는 명산유곡, 시원하고 아름다운 계곡과 함께하는 계곡산행";
		}else if(val == 7){
			theme = "섬";
			content += "<label class='bmd-label-floating'>섬 산행</label>";
			content += "<div class='sam'>";
			content += "산과 바다가 아름답게 어우러지는 섬 속의 산, 바다를 거니는듯 산을 오르는 듯 그림같은 바다, 시퍼런 파도가 발아래 출렁이는 섬산행";
		}else if(val == 8){
			theme = "눈";
			content += "<label class='bmd-label-floating'>눈 산행</label>";
			content += "<div class='sam'>";
			content += "탁트인 시야에 묵은 체증 내릴 듯 겨울산은 황홀하다. 산악인들 대다수도 겨울산행에 매료돼 등산과 인연을 맺었다고 토로할 정도. 겨울산은 그토록 색다른 낭만과 스릴을 제공한다.";
		}else if(val == 9){
			theme = "바위";
			content += "<label class='bmd-label-floating'>바위 산행</label>";
			content += "<div class='sam'>";
			content += "자연이 이루어 놓은 위대함, 웅장한 암봉이나 기암괴봉은 평범한 육산보다 산행의 또다른 감흥을 자아낸다. 암봉이나 기암괴봉을 즐길 수 있는 조망이 좋거나 아기자기한 바위 맛을 느낄 수 있는 바위산들";
		}else if(val == 10){
			theme = "고로쇠";
			content += "<label class='bmd-label-floating'>고로쇠 산행</label>";
			content += "<div class='sam'>";
			content += "숭늉처럼 뿌옇고 성분은 포도당, 과당이 들어가 단맛이 약간 난다. 신경통과 위장병에 효험이 있다하는 고로쇠, 경칩을 전후해 채취되지만 지역에 따라 기간이 달라진다. 산행도하고 고로쇠도 마시고";
		}else if(val == 11){
			theme = "온천";
			content += "<label class='bmd-label-floating'>온천 산행</label>";
			content += "<div class='sam'>";
			content += "국내 온천들은 대부분 주변에 훌륭한 산행지를 끼고 있다. 땀흘리며 산에 오른 뒤 뜨거운 온천에서 몸을 푸는 온천산행. 등산도 즐기고 하산후 온천욕을 즐길 수 있는 온천 산행지";
		}else if(val == 12){
			theme = "사찰";
			content += "<label class='bmd-label-floating'>사찰 산행</label>";
			content += "<div class='sam'>";
			content += "명산의 자락에 자리한 고찰, 대찰, 등산도 하고 수려한 경관속의 사찰도 둘러보고 문화유적 답사도 할 수 있는 사찰산행";
		}else if(val == 13){
			theme = "호반";
			content += "<label class='bmd-label-floating'>호반 산행</label>";
			content += "<div class='sam'>";
			content += "산자락을 오르면서 산 아래에 펼쳐져 있는 호수의 비경을 감상하다 보면 산행의 피로가 말끔히 가신다．아름다운 호반을 끼고 있는 산, 가족과 함께 찾을만한 대표적인 호반산행지";
		}else if(val == 14){
			theme = "철도";
			content += "<label class='bmd-label-floating'>철도 산행</label>";
			content += "<div class='sam'>";
			content += "기차에 낭만을 싣고 떠난다. 짜증나는 장거리 운전과 교통체증의 부담도 없다. 차창밖으로 스쳐지나가는 전원의 풍경이 호젓한 낭만과 추억에 빠져들게 한다.";
		}else if(val == 15){
			theme = "동굴";
			content += "<label class='bmd-label-floating'>동굴 산행</label>";
			content += "<div class='sam'>";
			content += "수천길 땅속에서 배어나오는 싱그러운 공기, 기암괴석 사이로 구슬 같이 괴어 흐르는 물방울, 화려한 빛깔로 단장한 석순, 석화, 석주 등 천연동굴은 태고의 신비와 천년의 비경을 간직한 별세계를 간직하고 있다. 산행에서 흐른 땀을 동굴에서 식히고...";
		}else if (val == 16){
			theme = "시산제";
			content += "<label class='bmd-label-floating'>시산제 산행</label>";
			content += "<div class='sam'>";
			content += "시산제란 한해의 안전산행을 기원하고 먼저 간 산우들을 추모하는 제사의식. 아울러 가정의 평온과 개인의 소망도 비는 자리다. 제수음식과 술을 곁들여 최근의 시산제는 산악회원들 사이에서 축제의 한마당으로 자리잡고 있다.";
			content += "<br>제사후 산행을 시작하는 게 올바른 순서다.그러나 인원이 많을 경우 산행을 마친 뒤 산제를 올려도 된다. 산행이 끝나면 제사를 지낸 자리에서 식사한다.";
			content += "<br>산제는 산악회원끼리 친목과 결속을 다지는 행사인 만큼 진지하고 경건한 자세로 임하도록 한다.";
		}else{
			content += "<label class='bmd-label-floating'>삐빅</label>";
			content += "<div class='sam'>";
			content += "에러";
		}
		content += "<hr></div></div>";
		console.log("test : " + content);
		$('#themeinfo').html(content);
		
		if(val == 0){
			mon.style.display = "none";
			the.style.display = "";
			ex1.style.display = "none";
			ex2.style.display = "none";
			ex3.style.display = "";
			info.style.display = "";
			infomation.style.display = "none";
			season.style.display = "none";
			inf.style.display = "";
			mountain.style.display = "none";
		}else{
			season.style.display = "none";
			mountain.style.display = "";
			themeinfo.style.display = "";
			inf.style.display = "none";
		}
		
		console.log("테마 : " + theme);
		$.ajax({
			url : "/theme.do",
			method : "post",
			data : {'theme' : theme},
			dataType : "json",
			success : function(data) {
				var contents = "";
				contents += "<table class='table'><thead class=' text-primary'>";
				contents += "<th><strong>No</strong></th><th><strong>산명</strong></th>";
				contents += "<th></th></thead><tbody>";
				$.each(data, function (key, value) {
					contents += "<tr><td>"+value.no+"</td><td>"+value.name+"</td>";
					contents += "<td><img class='detail' id="+value.no+" src='bootstrap/assets/img/loupe.png'></td></tr>";
				});
				contents += "</tbody></table>";
				$('.table').html(contents);
			}
		});
		/* 
		$.ajax({
			url : "/themeNum.do",
			method : "post",
			data : {'theme' : theme},
			dataType : "int",
			success : function(data) {
				//페이징
			},
			error : function(error) {alert("theme : " + error)}
		});
		 */
		
	});
	
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
		season.style.display = "none";
	});
	
	$(document).on("click", "#all", function() {
		var content = "";
		content += "<div align='center' style='width: 100%' id='d'>";
		content += "<span class='text-success' id='all'>전체</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='month'>계절</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='theme'>테마</span></div>";
		$('#d').html(content);
		
		mon.style.display = "none";
		the.style.display = "none";
		ex1.style.display = "";
		ex2.style.display = "none";
		ex3.style.display = "none";
		info.style.display = "";
		inf.style.display = "";
		infomation.style.display = "none";
		season.style.display = "none";
	});
	
	$(document).on("click", "#month", function() {
		var content = "";
		content += "<div align='center' style='width: 100%' id='d'>";
		content += "<span id='all'>전체</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span class='text-success' id='month'>계절</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='theme'>테마</span></div>";
		$('#d').html(content);
		
		$(".month").find("option:eq(0)").prop("selected", true);
		
		mon.style.display = "";
		the.style.display = "none";
		ex1.style.display = "none";
		ex2.style.display = "";
		ex3.style.display = "none";
		info.style.display = "";
		infomation.style.display = "none";
		season.style.display = "none";
		inf.style.display = "";
		mountain.style.display = "none";
		
		list();
	});
	
	$(document).on("click", "#theme", function() {
		var content = "";
		content += "<div align='center' style='width: 100%' id='d'>";
		content += "<span id='all'>전체</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span id='month'>계절</span>";
		content += "<span>&emsp;|&emsp;</span>";
		content += "<span class='text-success' id='theme'>테마</span></div>";
		$('#d').html(content);
		
		$(".theme").find("option:eq(0)").prop("selected", true);
		
		mon.style.display = "none";
		the.style.display = "";
		ex1.style.display = "none";
		ex2.style.display = "none";
		ex3.style.display = "";
		info.style.display = "";
		infomation.style.display = "none";
		season.style.display = "none";
		inf.style.display = "";
		mountain.style.display = "none";
		
		list();
	});
	
	var page = 1;
	var countPage = 5;
	var countList = 5;
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
				if(page % 5 == 0) {
					startPage = page - 4;
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
	
	$(document).on("click", ".page-linkm", function() {
		var num = $(this).attr('id');
		var month = $(this).attr('value');
		num = parseInt(num);
		console.log("num : " + num);
		console.log("month : " + month);
		$.ajax({
			url : "/monthPaging.do",
			method : "post",
			data : {"num" : num, "month" : month},
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
				if(page % 5 == 0) {
					startPage = page - 4;
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
	
	function list(){
		console.log("전체 리스트 불러오기");
		var num = 0;
		$.ajax({
			url : "/list.do",
			method : "post",
			data : {'num' : num},
			dataType : "json",
			success : function(data) {
				var contents = "";
				contents += "<table class='table'><thead class=' text-primary'>";
				contents += "<th><strong>No</strong></th><th><strong>산명</strong></th>";
				contents += "<th></th></thead><tbody>";
				$.each(data, function (key, value) {
					contents += "<tr><td>"+value.no+"</td><td>"+value.name+"</td>";
					contents += "<td><img class='detail' id="+value.no+" src='bootstrap/assets/img/loupe.png'></td></tr>";
				});
				contents += "</tbody></table>";
				$('.table').html(contents);
			}
		});
	};
	
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
											<span id='month'>계절</span>
											<span>&emsp;|&emsp;</span>
											<span id='theme'>테마</span>
										</div>
										<div align="right" style="display: none" id="mon">
											<select style="width: 80%;" name="month" class="month">
												<%for(int i = 0; i < monthName.length; i++) {%>
													<option value="<%=i%>"><%=monthName[i] %> 산행</option>
												<%} %>
											</select>
										</div>
										<div align="right" style="display: none" id="the">
											<select style="width: 80%;" name="theme" class="theme">
												<%for(int i = 0; i < themeName.length; i++) {%>
													<option value="<%=i%>"><%=themeName[i] %> 산행</option>
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
											<div id="inf">
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
											<div id="season" style="display: none">
												<div class="form-group" id='winter' style="display: none">
													<label class="bmd-label-floating">겨울 산행</label>
													<div class="sam">
															환상적인 설경 아래 겨울의 낭만과 아름다운 추억을 만들 수 있는 눈 , 겨울산행의 백미는 눈 내린 산을
															가로지르며 맛보는 짜릿한 비경에 있다． 전국의 높은 산들이 눈부시도록 하얀 눈꽃을 피우기 시작한다.
															울긋불긋 단풍이 물들었던 바로 그 자리가 은빛비단 천지다. 한적하면서도 운치있는 겨울산행. 하얀 눈,
															노송과 기암이 어우러진 겨울산은 무릎까지 빠지는 독특한 멋과 스릴로 산행의 색다른 묘미를 만끽할 수
															있다.<br> 겨울산은 황홀하다. 산악인들 대다수도 겨울산행에 매료돼 등산과 인연을 맺었다고 토로할 정도.
															겨울산은 그토록 색다른 낭만과 스릴을 제공한다.<Br><br> <b>겨울산행시 주의점</b><br> 장비를 단단히 챙기고 주의할 점을
															충분히 숙지해야한다.<br> 겨울산 조난과 그 대책도 찾아보는 것을 추천한다.
	
															<hr>
													</div>
												</div>
												<div class="form-group" id='spring' style="display: none">
													<label class="bmd-label-floating">봄 산행</label>
													<div class="sam">
															겨우네 얼어붙었던 산하도 몸도 기지개를 펴는 봄. 아지랑이 피고 초목에 물이 오른다．봄을 알리는
															피고지는 꽃들이 손짓하는 봄철은 겨울 산을 싫어했던 사람에게도 산에 오르고 싶은 욕구를 불러
															넣어준다．마른 가지에 봄물이 오르는 것을 보고 얼었던 계곡물이 흘러가는 소리를 듣다보면 마음가짐도
															새로워진다.<Br><br> <B>산행지 선택</B><br> 봄산행은 산행지 선택에 제한이 따르게 된다.<br>
															산불방지를 위하여 대부분의 산이 5월 중순 또는 하순까지 등산로가 전면 또는 부분적으로 통제되는 되는
															산이 많다. 국립공원으로 지정된 산은 국립공원관리공단 홈페이지에 등산로 통제 구간이 게시되지만 그
															이외의 산에 대한 등산로 통제는 신문기사나 지방자치단체의 관리부서 등에 등을 참조하여 등산로 통제여부를
															확인하여 산행지를 선택하여야 한다.<br><br> <B>위험요소</B><br> 겨울산행에 비해 초봄 산행은 여기저기 위험요소가 도사리고
															있다. 겨울산행은 장비에서부터 만반의 준비를하기 때문에 오히려 사고가 나지 않는다. 반면 해빙기인
															초봄에는 산을 쉽게 생각하고 야유회 정도로 생각하고 덤볐다가 낭패보기 십상이다．초봄 산행에서는 등산복을
															철저히 준비하고 산행속도를 조절하는 절제력이 무엇보다 중요하다． 봄철에는 낮과 밤의 기온차가 심하다.
															７백∼８백급의 산은 평지보다 섭씨５도가 낮다．３월이 돼도 산은 아직 ２월이라고 생각하면 된다．여기에
															바람이 강하게 불고 비라도 내린다면 체감온도는 급격히 떨어져 겨울로 되돌아가는 것이 아닌가 할 정도가
															된다． 이때 가장 주의해야 할 것이 저체온증이다. 따라서 방수 방풍이 되는 옷과 여벌 옷을 갖추는 것이
															초봄 산행의 생명이다．방수 방풍의는 바람이 강하게 불거나 비가 내릴 때 입는 옷이다. 그렇다고 방수
															방풍의가 무조건 좋은것은 아니다．계속 입고 걸으면 땀 배출속도가 몸에서 발생하는 땀의 양을 따라가지
															못해 결국 옷 안쪽에 남게 된다.상의는 남방셔츠나 긴팔 티셔츠에 조끼만 걸치고 산행하다 쉬는동안 방수
															방풍의로 체온의 저하를 막는 것이 봄철산행에서는 겨우내 얼어붙었던 만물이 생동하는 모습을 엿볼수 있다.

															<hr>
													</div>
												</div>
												<div class="form-group" id='summer' style="display: none">
													<label class="bmd-label-floating">여름 산행</label>
													<div class="sam">
															성하의 계절 여름 푸른 산과 맑은 계곡, 그리고 시원한 바다가 모두 그립다． 바다에 가면 산이 보고
															싶고 산에 가면 바다가 생각나는 여름, 뙤약볕을 받으며 장쾌한 능선길을 걸으며 발을 옮길 때마다 뚝뚝
															떨어지는 땀의 의미를 느끼는 것이 여름산행의 묘미다．뙤약볕 내리쬐는 능선을 걸으며 더위를 이기는
															여름산행은 산악인들의 또 다른 피서법이다.

															<hr>
													</div>
												</div>
												<div class="form-group" id='autumn' style="display: none">
													<label class="bmd-label-floating">가을 산행</label>
													<div class="sam">
															아침저녁으로 바람이 선선하다．"초록이 지쳐 단풍드는 계절", 여름내 푸르렀던 나무들이 붉은 색으로 곱게
															치장한다. 만산홍엽, 가을산이 붉디붉게 타오른다. 층층 암봉마다 돌연한 유혹처럼 불타는 단풍, 고운
															단풍잎에 비끼는 가을 햇살 또한 몽롱하게 눈부시다. 단풍이 한바탕 훑고 지나간 늦가을 산에 은빛꿈
															너울대는 억새가 장관이다．<br>오후의 햇살이 엷게 비칠 때 바람 따라 서걱서걱 울어대는 억새는 가을 산행의
															색다른 맛을 남겨준다. 은백색 억새풀 물결을 볼 수 있는 것은 가을 산행에 있어 즐거움의
															하나다．억새풀의 너울거림을 보는 것만으로도 가을의 정취와 여유로움을 한껏 느낄 수 있다.<br><br>
															<b>가을산행 유의사항</b><Br>
															가을산은 일몰시간이 빠르고 기온이 많이 떨어진다. 하산시간을 잘 맞춰 산행하는 것이 가을산행의
															요령이다.<br> 산행을 나서기전 오버 트라우저（방수방풍의）는 물론이거니와 스웨터나 파일 쟈킷 등 추위에
															대비할 장비를 꼭 챙겨야 한다. 특히 가을하늘은 이동성고기압때문에 맑다. 그러나 고기압 뒤편에는시속
															50km 정도로 빠르게 움직이는 한랭전선이 도사리고 있다. 이때문에 한없이 좋던 날씨도 한순간에
															바껴지게 된다. "가을비를 만나면 주저말고 하산하라"는 이야기를 잊지말아야 한다.

															<hr>
													</div>
												</div>
											</div>
											<div id="mountain" style="display: none">
												<div class="form-group" id='themeinfo' style="display: none">
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
