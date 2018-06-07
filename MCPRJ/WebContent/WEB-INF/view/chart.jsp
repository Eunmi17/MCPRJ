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
						href="/apiMain.do"> <i class="material-icons">filter_hdr</i>
							<p>정보</p>
					</a></li>
					<li class="nav-item "><a class="nav-link" href="/userList.do">
							<i class="material-icons">person</i>
							<p>회원 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link" href="/teamL.do">
							<i class="material-icons">dvr</i>
							<p>동호회 관리</p>
					</a></li>
					<li class="nav-item "><a class="nav-link" href="/boardL.do">
							<i class="material-icons">list</i>
							<p>자유게시판</p>
					</a></li>
					<li class="nav-item active "><a class="nav-link"
						href="/chart.do"> <i
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
	                					label: "성별",
	                					backgroundColor: [
	                						'rgba(54, 162, 235, 0.6)',
	          	          					'rgba(255,99,132,0.6)'
	                                    ],
	                                    data:num2
	                				}]
	                		};
	                		gender = new Chart(ctx, {
	                			type: 'bar',
	                			data: chartdata,
		                		options: {
		        					tooltips: {
		        						mode: 'index',
		        						intersect: false
		        					},
		        					responsive: true,
		                            scales: {
		                                yAxes: [{
		                                    ticks: {
		                                        beginAtZero:true
		                                    }
		                                }]
		                            }
		                        }
	                		});
	                		var content = "";
	                		var win = "";
	                		var loser = "";
	                		var vs = 0;
	                		
	                		if(parseInt(num2[0]) > parseInt(num2[1])){
	                			vs = parseInt(num2[0])-parseInt(num2[1]);
	                			win = num1[0];
	                			loser = num1[1];
	                			
	                			content = win+" > "+loser+", &nbsp; <span class='text-success'>"+win+" "+vs+"명 <i class='fa fa-long-arrow-up'></i></span>";
	                		}else if(parseInt(num2[0]) == parseInt(num2[1])){
	                			content = "남자와 여자의 비율은 <span class='text-success'>50%</span>로 동일";
	                		}else{
	                			vs = parseInt(num2[1])-parseInt(num2[0]);
	                			win = num1[1];
	                			loser = num1[0];
	                			
	                			content = win+" > "+loser+", &nbsp; <span class='text-success'>"+win+" "+vs+"명 <i class='fa fa-long-arrow-up'></i></span>";
	                		}
	                		
	                		$('#gtext').html(content);
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
	                					backgroundColor:'rgba(051, 204, 051, 0.6)',
	                                    data:num2
	                			},{
		                				label:'미가입',
		            					backgroundColor:'rgba(051, 102, 051, 0.6)',
		                                data:num3
	                				}]
	                		};
	                		gt = new Chart(gtctx, {
	                			type: 'bar',
	                			data: chartdata,
		                		options: {
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
	                		
	                		var content = "";
	                		var man = "";
	                		var woman = "";
	                		
	                		man = parseInt(parseInt(num2[0]) / (parseInt(num2[0]) + parseInt(num3[0])) * 100);
	                		woman = parseInt(parseInt(num2[1]) / (parseInt(num2[1]) + parseInt(num3[1])) * 100);
	                		
	                		content = "남자 가입 <span class='text-success'>"+man+"%</span>, 여자 가입 <span class='text-success'>"+woman+"%</span>";
	                		console.log("gttext : " + content);
	                		
	                		$('#gttext').html(content);
	                		
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
	                					backgroundColor: [
	                						'rgba(153, 102, 204, 0.6)',
	          				                'rgba(204, 051, 204, 0.6)'
	                                    ],
	                                    data:num2
	                				}]
	                		};
	                		team = new Chart(tctx, {
	                			type: 'bar',
	                			data: chartdata,
		                		options: {
		        					tooltips: {
		        						mode: 'index',
		        						intersect: false
		        					},
		        					responsive: true,
		                            scales: {
		                                yAxes: [{
		                                    ticks: {
		                                        beginAtZero:true
		                                    }
		                                }]
		                            }
		                        }
	                		});
	                		
	                		var content = "";
	                		var win = "";
	                		var loser = "";
	                		var vs = 0;
	                		
	                		if(parseInt(num2[0]) > parseInt(num2[1])){
	                			vs = parseInt(num2[0])-parseInt(num2[1]);
	                			win = num1[0];
	                			loser = num1[1];
	                			content = win+" > "+loser+", &nbsp; <span class='text-success'>"+win+" "+vs+"명 <i class='fa fa-long-arrow-up'></i></span>";
	                		}else if(parseInt(num2[0]) == parseInt(num2[1])){
	                			content = "가입수와 미가입수의 비율은 <span class='text-success'>50%</span>로 동일";
	                		}else{
	                			vs = parseInt(num2[1])-parseInt(num2[0]);
	                			win = num1[1];
	                			loser = num1[0];
	                			content = win+" > "+loser+", &nbsp; <span class='text-success'>"+win+" "+vs+"명 <i class='fa fa-long-arrow-up'></i></span>";
	                		}
	                		
	                		$('#ttext').html(content);
	                		
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
	            			var num = ['10대 미만', '10대', '20대', '30대', '40대', '50대', '60대 이상'];
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
			                        		'rgba(255, 051, 051, 0.8)',
			                        		'rgba(051, 102, 255, 0.8)',
			            					'rgba(153, 255, 102, 0.8)',
			            					'rgba(255, 255, 153, 0.8)',
			            					'rgba(255, 153, 255, 0.8)',
			            					'rgba(153, 255, 255, 0.8)',
			            					'rgba(255, 153, 051, 0.8)'
			                        	],
			                		}],
			                		labels: num
			                	},
			                	options: {
			                		responsive: true,
			                		legend: {
				    					position: 'right',
				    				}
			                	}
			                };
		                    var agechart = document.getElementById('age').getContext('2d');
		                    age = new Chart(agechart, config);
		                    
		                    var content = "";
			                var max = parseInt(num2[0]);
			                var month = "";
			                var hap = 0;
			                var p = 0;
			                
			                for(var i = 0; i < num2.length; i++){
			                	hap += parseInt(num2[i]);
			                }
			                for(var i = 0; i < num2.length; i++){
			                	if(parseInt(num2[i]) > max) {
			                		max = parseInt(num2[i]);
			                		month = num[i];
			                	}else if(parseInt(num2[i]) == max){
			                		if(i == 0){
			                			month = num[i];
			                		}else{
			                			month += ", "+num[i];
			                		}
			                	}
			                }
			                p = parseInt(max / hap * 100);
			                content = "<span class='text-success'>"+month+"</span>가(이) <span class='text-success'>"+p+"%</span>로 가장 수가 많은 연령대임";
			                $('#agetext').html(content);
		                    
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
		                		console.log(num1); //지역
		                		console.log(num2); //인원수
		                	});
				            var config = {
				                data: {
				                	datasets: [{
				                		data: num2,
				                   		backgroundColor: [
				                   			'rgba(255, 0, 0, 0.5)',
				                       		'rgba(0, 0, 255, 0.5)',
				                       		'rgba(0, 255, 0, 0.5)',
				                       		'rgba(255, 255, 0, 0.5)',
				                       		'rgba(0, 255, 255, 0.5)',
				                       		'rgba(255, 0, 255, 0.5)',
				                       		'rgba(255, 255, 255, 0.5)',
				                       		'rgba(0, 0, 0, 0.5)',
				                       		'rgba(153, 0, 153, 0.5)',
				                       		'rgba(0, 102, 51, 0.5)',
				                       		'rgba(255, 102, 51, 0.5)',
				                       		'rgba(153, 51, 0, 0.5)',
				                       		'rgba(153, 153, 153, 0.5)',
				                       		'rgba(153, 102, 0, 0.5)',
				                       		'rgba(51, 0, 51, 0.5)',
				                       		'rgba(204, 204, 153, 0.5)',
				                       		'rgba(255, 204, 255, 0.5)'
				                		],
				                		label : 'My dataset'
				             		}],
				                	labels: num1
				                },
				                options: {
				    				responsive: true,
				    				legend: {
				    					position: 'right'
				    				},
				    				scale: {
				    					ticks: {
				    						beginAtZero: true
				    					},
				    					reverse: false
				    				},
				    				animation: {
				    					animateRotate: false,
				    					animateScale: true
				    				}
				    			}
				    		};
			                var addrchart = document.getElementById('addr');
			                addr = new Chart.PolarArea(addrchart, config);
			                
			                var content = "";
			                var max = parseInt(num2[0]);
			                var month = "";
			                var hap = 0;
			                var p = 0;
			                
			                for(var i = 0; i < num2.length; i++){
			                	hap += parseInt(num2[i]);
			                }
			                for(var i = 0; i < num2.length; i++){
			                	if(parseInt(num2[i]) > max) {
			                		max = parseInt(num2[i]);
			                		month = num1[i];
			                	}else if(parseInt(num2[i]) == max){
			                		if(i=0){
			                			month = num1[i];
			                		}else{
			                			month += ", "+num1[i];
			                		}
			                	}
			                }
			                p = parseInt(max / hap * 100);
			                content = "<span class='text-success'>"+month+"</span>이(가) <span class='text-success'>"+p+"%</span>로 회원이 많이 분포되어있음";
			                $('#addrtext').html(content);
			                
			    		},
		               	error: function(data){
		           		console.log(data);
		               }
		           	});
		            
		            
		            $.ajax({
		            	url:"regData.do",
		                method:"POST",
		                success:function(data){
		            		var num2 = [];
		                	$.each(data, function(key, value){
		                		console.log(value);
		                		if(value != null) {
		                			num2.push(value.data1);
		                		}
		                		console.log(num2);
		                	});
			            var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
			    		var configs = {
			    			type: 'line',
			    			data: {
			    				labels: MONTHS,
			    				datasets: [{
			    					label: '가입자 수',
			    					fill: false,
			    					backgroundColor: 'rgba(000, 102, 153, 0.8)',
			    					borderColor: 'rgba(000, 102, 153, 0.8)',
			    					data: num2
			    				}]
			    			},
			    			options: {
			    				responsive: true,
			    				tooltips: {
			    					mode: 'index',
			    					intersect: false,
			    				},
			    				hover: {
			    					mode: 'nearest',
			    					intersect: true
			    				},
			    				scales: {
			    					xAxes: [{
			    						display: true,
			    						scaleLabel: {
			    							display: true
			    						}
			    					}],
			    					yAxes: [{
			    						ticks: {
			    							min: 0
			    						},
			    						display: true,
			    						scaleLabel: {
			    							display: true
			    						}
			    					}]
			    				}
			    			}
			    		};
		                var regchart = document.getElementById('reg').getContext('2d');
		                reg = new Chart(regchart, configs);
		                
		                var content = "";
		                var max = parseInt(num2[0]);
		                var month = "";
		                var hap = 0;
		                var p = 0;
		                
		                for(var i = 0; i < num2.length; i++){
		                	hap += parseInt(num2[i]);
		                }
		                for(var i = 0; i < num2.length; i++){
		                	if(parseInt(num2[i]) > max) {
		                		max = parseInt(num2[i]);
		                		month = parseInt(i+1);
		                	}else if(parseInt(num2[i]) == max){
		                		if(i = 0) {
		                			month = parseInt(i+1);
		                		}else{
		                			month += ", "+parseInt(i+1);
		                		}
		                	}
		                }
		                p = parseInt(max / hap * 100);
		                content = "<span class='text-success'>"+month+"월</span>이 <span class='text-success'>"+p+"%</span>로 가입률이 높음";
		                $('#jtext').html(content);
		           	},
	               	error: function(data){
	           		console.log(data);
	               	}
               });
		            
		            
		            
		            $.ajax({
		            	url:"boardData.do",
		                method:"POST",
		                success:function(data){
		            		var num2 = [];
		                	$.each(data, function(key, value){
		                		console.log(value);
		                		if(value != null) {
		                			num2.push(value.data1);
		                		}
		                		console.log(num2);
		                	});
			            var MONTHS = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
			    		var configss = {
			    			type: 'line',
			    			data: {
			    				labels: MONTHS,
			    				datasets: [{
			    					label: '게시글 수',
			    					fill: false,
			    					backgroundColor: 'rgba(000, 153, 051, 0.8)',
			    					borderColor: 'rgba(000, 153, 051, 0.8)',
			    					data: num2
			    				}]
			    			},
			    			options: {
			    				responsive: true,
			    				tooltips: {
			    					mode: 'index',
			    					intersect: false,
			    				},
			    				hover: {
			    					mode: 'nearest',
			    					intersect: true
			    				},
			    				scales: {
			    					xAxes: [{
			    						display: true,
			    						scaleLabel: {
			    							display: true
			    						}
			    					}],
			    					yAxes: [{
			    						ticks: {
			    							min: 0
			    						},
			    						display: true,
			    						scaleLabel: {
			    							display: true
			    						}
			    					}]
			    				}
			    			}
			    		};
		                var boardchart = document.getElementById('board').getContext('2d');
		                board = new Chart(boardchart, configss);
		                
		                var content = "";
		                var max = parseInt(num2[0]);
		                var month = "";
		                var hap = 0;
		                var p = 0;
		                
		                for(var i = 0; i < num2.length; i++){
		                	hap += parseInt(num2[i]);
		                }
		                for(var i = 0; i < num2.length; i++){
		                	if(parseInt(num2[i]) > max) {
		                		max = parseInt(num2[i]);
		                		month = parseInt(i+1);
		                	}else if(parseInt(num2[i]) == max){
		                		if(i = 0){
		                			month = parseInt(i+1);
		                		}else{
		                			month += ", "+parseInt(i+1);
		                		}
		                	}
		                }
		                p = parseInt(max / hap * 100);
		                content = "<span class='text-success'>"+month+"월</span>이 <span class='text-success'>"+p+"%</span>로 활동률이 높음";
		                $('#ntext').html(content);
		                
		           	},
	               	error: function(data){
	           		console.log(data);
	               	}
               });
		            
		            
		            
	           	
	        }); 
            </script>



			<div class="content">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-4">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="gender"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">성별 분석</h4>
									<p class="card-category" id="gtext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										회원 남녀 비율 확인
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="team"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">동호회 가입여부 분석</h4>
									<p class="card-category" id="ttext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										동호회 가입 비율 확인
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-4 ">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="gt"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">남녀별 동호회 가입여부 분석</h4>
									<p class="card-category" id="gttext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										남녀별로 동호회 가입 비율 확인
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="age"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">나이 분석</h4>
									<p class="card-category" id="agetext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										회원 나이 비율 확인
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="addr"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">지역 분석</h4>
									<p class="card-category" id="addrtext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										회원 거주지 비율 확인
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="row">
						<div class="col-md-6">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="reg"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">월별 회원 가입 비율 분석</h4>
									<p class="card-category" id="jtext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										회원이 어느달에 가입이 많이 되는지 확인
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="card card-chart">
								<div class="card-header card-header-primary">
									<div class="ct-chart">
										<canvas id="board"></canvas>
									</div>
								</div>
								<div class="card-body">
									<h4 class="card-title">월별 활동 비율 분석</h4>
									<p class="card-category" id="ntext"></p>
								</div>
								<div class="card-footer">
									<div class="stats">
										글이 많이 써지는 달을 기준으로 활발히 활동하는 시기 확인
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
