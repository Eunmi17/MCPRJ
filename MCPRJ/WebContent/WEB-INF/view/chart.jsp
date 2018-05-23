<%@page import="com.emlee.util.CmmUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<script src="//code.jquery.com/jquery-1.11.3.min.js"></script>
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
	String session_user_name = CmmUtil.nvl((String) session.getAttribute("session_user_name"));
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
					<li class="nav-item "><a class="nav-link" href="/userList.do">
							<i class="material-icons">person</i>
							<p>회원 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link" href="/teamL.do">
							<i class="material-icons">dvr</i>
							<p>게시판 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link" href="/boardL.do">
							<i class="material-icons">list</i>
							<p>자유게시판</p>
					</a></li>
					<li class="nav-item active "><a class="nav-link"
						href="bootstrap/examples/icons.html"> <i
							class="material-icons">assessment</i>
							<p>분석</p>
					</a></li>
				</ul>
			</div>
		</div>
		<div class="main-panel">
			<!-- Navbar -->
			<nav
				class="navbar navbar-expand-lg navbar-transparent  navbar-absolute fixed-top">
				<div class="container-fluid">
					<div class="collapse navbar-collapse justify-content-end"
						id="navigation">
						<div class="row">
							<div class="row">
								<i class="material-icons">person</i>
								<p><%=session_user_name%></p>
							</div>
							&emsp;&emsp;&emsp;&emsp; <a id="m" href="/logout.do">로그아웃</a>
						</div>
					</div>
				</div>
			</nav>
			<!-- End Navbar -->
			<script src="bootstrap/assets/js/Chart.js"></script>
			<script>
	           	$(document).ready(function(){
	           		
	           		
	           		var ctx = document.getElementById("gender");
	                
	                $.ajax({
	                	url:"genderData.do",
	                	method:"POST",
	                	success:function(data){
	                		var num1 = [];
	            			var num2 = [];
	                		$.each(data, function(key, value){
	                			console.log(value);
	                			if(value != null) {
	                				num1.push(value.gender)
	                				num2.push(value.data);
	                			}
	                			console.log(num1);
	                			console.log(num2);
	                		});
	                		var chartdata = {
	                				labels:num1,
	                				datasets:[{
	                					label:"성별",
	                					backgroundColor: [,
	                                        'rgba(54, 162, 235, 0.2)',
	                                        'rgba(255, 99, 132, 0.2)'
	                                    ],
	                                    borderColor: [
	                                        'rgba(54, 162, 235, 1)',
	                                        'rgba(255,99,132,1)'
	                                    ],
	                                    borderWidth: 1,
	                                    data:num2
	                				}]
	                		};
	                		options: {
	                            scales: {
	                                yAxes: [{
	                                    ticks: {
	                                        beginAtZero:true
	                                    }
	                                }]
	                            }
	                        }
	                		gender = new Chart(ctx, {
	                			type: 'bar',
	                			data: chartdata
	                		});
	                	},
	                	error: function(data){
	                		console.log(data);
	                	}
	                });
	                
	                
	                
					var gtctx = document.getElementById("gt").getContext('2d');
	                
	                $.ajax({
	                	url:"GTData.do",
	                	method:"POST",
	                	success:function(data){
	                		var num1 = [];
	            			var num2 = [];
	            			var num3 = [];
	                		$.each(data, function(key, value){
	                			console.log(value);
	                			if(value != null) {
	                				num1.push(value.gender);
	                				num2.push(value.data);
	                				num3.push(value.data1);
	                			}
	                			console.log(num1);
	                			console.log(num2);
	                			console.log(num3);
	                		});
	                		var chartdata = {
	                				labels:num1,
	                				datasets:[{
	                					label:'가입',
	                					backgroundColor:'rgba(54, 162, 235, 0.2)',
	                                    data:num2
	                			},{
		                				label:'미가입',
		            					backgroundColor:'rgba(255, 99, 132, 0.2)',
		                                data:num3
	                				}]
	                		};
	                		gt = new Chart(gtctx, {
	                			type: 'bar',
	                			data: chartdata,
		                		options: {
		        					title: {
		        						display: true,
		        						text:'성별별 동호회 가입 여부'
		        					},
		        					tooltips: {
		        						mode: 'index',
		        						intersect: false
		        					},
		        					responsive: true,
		        					scales: {
		        						xAxes: [{
		        							stacked: true,
		        						}],
		        						yAxes: [{
		        							stacked: true
		        						}]
		        					}
		        				}
	                		});
	                	},
	                	error: function(data){
	                		console.log(data);
	                	}
	                });
	           		
	           		
	                
					var tctx = document.getElementById("team");
	                
	                $.ajax({
	                	url:"teamData.do",
	                	method:"POST",
	                	success:function(data){
	                		var num1 = ["가입", "미가입"];
	            			var num2 = [];
	                		$.each(data, function(key, value){
	                			console.log(value);
	                			if(value != null) {
	                				num2.push(value.data)
	                				num2.push(value.data1);
	                			}
	                			console.log(num1);
	                			console.log(num2);
	                		});
	                		var chartdata = {
	                				labels:num1,
	                				datasets:[{
	                					label:'동호회 가입여부',
	                					backgroundColor: [,
	                                        'rgba(54, 162, 235, 0.2)',
	                                        'rgba(255, 99, 132, 0.2)'
	                                    ],
	                                    borderColor: [
	                                        'rgba(54, 162, 235, 1)',
	                                        'rgba(255,99,132,1)'
	                                    ],
	                                    borderWidth: 1,
	                                    data:num2
	                				}]
	                		};
	                		options: {
	                            scales: {
	                                yAxes: [{
	                                    ticks: {
	                                        beginAtZero:true
	                                    }
	                                }]
	                            }
	                        }
	                		team = new Chart(tctx, {
	                			type: 'bar',
	                			data: chartdata
	                		});
	                	},
	                	error: function(data){
	                		console.log(data);
	                	}
	                });
	           		
	                
	                $.ajax({
	                	url:"ageData.do",
	                	method:"POST",
	                	success:function(data){
	                		var num1 = [];
	            			var num2 = [];
	                		$.each(data, function(key, value){
	                			console.log(value);
	                			if(value != null) {
	                				num1.push(value.data)
	                				num2.push(value.data1);
	                			}
	                			console.log(num1);
	                			console.log(num2);
	                		});
			                var config = {
			                	type: 'pie',
			                	data: {
			                		datasets: [{
			                			data: num2,
			                        	backgroundColor: [
			                        		'rgba(255, 0, 0, 1)',
			                        		'rgba(0, 0, 255, 1)',
			            					'rgba(0, 255, 0, 1)',
			            					'rgba(255, 255, 0, 1)',
			            					'rgba(255, 0, 255, 1)',
			            					'rgba(0, 255, 255, 1)'
			                        	],
			                		}],
			                		labels: num1
			                	},
			                	options: {
			                		responsive: true
			                	}
			                };
		                    var agechart = document.getElementById('age').getContext('2d');
		                    age = new Chart(agechart, config);
		               },
	               error: function(data){
	           		console.log(data);
	               }
	           	});
	                
	           	
	                
	            $.ajax({
	            	url:"addrData.do",
	                method:"POST",
	                success:function(data){
	                	var num1 = [];
	            		var num2 = [];
	                	$.each(data, function(key, value){
	                		console.log(value);
	                		if(value != null) {
	                			num1.push(value.data)
	                			num2.push(value.data1);
	                		}
	                		console.log(num1);
	                		console.log(num2);
	                	});
			            var config = {
			                type: 'doughnut',
			                data: {
			                	datasets: [{
			                		data: num2,
			                   		backgroundColor: [
			                   			'rgba(255, 0, 0, 1)',
			                       		'rgba(0, 0, 255, 1)',
			            				'rgba(0, 255, 0, 1)',
			            				'rgba(255, 255, 0, 1)',
			            				'rgba(255, 0, 255, 1)',
			            				'rgba(0, 255, 255, 1)'
			                		],
			             		}],
			                	labels: num1
			                },
			                options: {
			                	responsive: true,
			    				legend: {
			    					position: 'top',
			    				},
			    				animation: {
			    					animateScale: true,
			    					animateRotate: true
			    				}
			    			}
			    		};
		                var addrchart = document.getElementById('addr').getContext('2d');
		                addr = new Chart(addrchart, config);
		    		},
	               	error: function(data){
	           		console.log(data);
	               }
	           	});
	           	
	        }); 
            </script>

			<!-- <div style="width: 70%;">
				<canvas id="myChart"></canvas>
			</div> -->

			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-4">
							<div class="card card-chart">
								<div class="card-header card-header-success">
									<div class="ct-chart">
										<canvas id="gender"></canvas>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card card-chart">
								<div class="card-header card-header-success">
									<div class="ct-chart">
										<canvas id="gt"></canvas>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card card-chart">
								<div class="card-header card-header-success">
									<div class="ct-chart">
										<canvas id="team"></canvas>
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="card card-chart">
								<div class="card-header card-header-success">
									<div class="ct-chart">
										<canvas id="age"></canvas>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card card-chart">
								<div class="card-header card-header-success">
									<div class="ct-chart">
										<canvas id="addr"></canvas>
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
						<p class="text-muted small mb-0">문의 : 관리자
							(dldmsal1123@gmail.com)</p>
						<br>
						<p class="text-muted small mb-0" align="left">
							정보출처 : 산림청 (<a id="m" href="http://www.forest.go.kr"
								target="_blank">www.forest.go.kr</a>)
						</p>
					</nav>
					<div class="copyright pull-right">&copy; 2018, made with love
						by emlee for a better web.</div>
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
