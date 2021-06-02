<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css" />
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminregister.css" />
		<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
		<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
		<script src="${ pageContext.request.contextPath }/js/adminregister.js"></script>
		
		<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
		<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
	</head>
	
	<script>
	$(function(){
		//后台验证
		$("#tj").click(function(){
			var username=$("input[name='username']").val();
			var password=$("input[name='password']").val();
			var passw2=$("input[name='passw2']").val();
			var authority=$("#authority option:selected").val();
			var valistr=$("input[name='valistr']").val();
			//alert(valistr);
			
			if(authority==""){
				
				$(".infocontent").css("color","#721c24");
				$(".infocontent").css("background-color","#f8d7da");
				$(".infocontent").css("border-color","#f5c6cb");
				$("#info_mation").text("Authority不能为空");
					
				return;
			}
			
			if(username.trim()==""||password.trim()==""||valistr.trim()==""||passw2.trim()!=password.trim()||password.trim().length<3){
				
				$(".infocontent").css("color","#721c24");
				$(".infocontent").css("background-color","#f8d7da");
				$(".infocontent").css("border-color","#f5c6cb");
				$("#info_mation").text("有信息未符合要求");
				return;
			}
			
				
			var $pageContext = $("#PageContext").val();	
			var url=$pageContext+"/admin/register";
			
			$.post(url,{"username":username,"password":password,"passw2":passw2,"authority":authority,"valistr":valistr},function(data){
				if(data=="1"){
					$('#alertModal').modal('show');
					
					$("#alertModal").on('shown.bs.modal',function(){  //alert框
						$("#backinfo").html("注册成功！");
						$("#alertModal").on('hide.bs.modal',function(){  //点击确定或关闭后跳转到主页
							window.location.href=$pageContext+"/adminorder/showorder";
						}); 
					}); 
				}
				else{
					$('#alertModal').modal('show');
					
					$("#alertModal").on('shown.bs.modal',function(){  //alert框
						$("#backinfo").html(data);
					});  
					//更新验证码
					$("#alertModal").on('hide.bs.modal',function(){  //alert框
						$("#img").attr("src",$pageContext+"/index/valiImage?time="+new Date().getTime());
						$("input[name='valistr']").val("");
					}); 
				}
			})
				
		});
	})
	</script>
	
	<body>
	
						
		
		<div class="container"> 
			<div class="row justify-content-center">
				<div class="col-center-block col-lg-4 col-md-4 col-sm-5 col-xl-5 jumbotron myformdiv pb-0">
					<!-- 1F内容-->
					
					
						
					<!--验证码/表单信息-->
					<div class="tab-content">
						<div class="tab-pane password_login">
								
							<h4 class="text-left">后台注册</h4>
								<!--信息体视框-->
								<div class="alert alert-dismissible infocontent p-0 m-0"><!--alert-danger在js实现 -->
									<span id="info_mation" class="p-0">通过</span>
								</div>
								
								<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
								
								<div class="input-group-lg mt-1">
									<span class="font"><b>Username</b></span>
									<input type="text" class="form-control clearfix" placeholder="Username" name="username" autofocus="autofocus" autocomplete="off" />
								</div>
								
								<div class="input-group-lg mt-1">
									<span class="font"><b>Password</b></span>
									<input type="password" class="form-control clearfix" placeholder="Password" name="password" autocomplete="off"  />
								</div>
								
								<div class="input-group-lg mt-1">
									<span class="font"><b>RePwd</b></span>
									<input type="password" class="form-control clearfix" placeholder="Re-Password" name="passw2" autocomplete="off"  />
								</div>
								
								<div class="input-group-lg mt-1">
									<span class="font"><b>Authority</b></span>
								     <select class="form-control" id="authority">
								        <option value="administration">administrator</option>
								        <option value="root">root</option>
								     </select>
								</div>
							
								<div class="input-group-lg">
									<span class="font"><b>Verify</b></span>
									<div class=input-group>
										<input type="text" class="form-control verify-text clearback" id="chk" placeholder="Verify" name="valistr" autocomplete="off" />
										<img id="img" class="verify-img p-0 m-0" src="${ pageContext.request.contextPath }/index/valiImage"/>
									</div>
								</div>
								<p>&nbsp;</p>
								<div>
									<button class="btn btn-primary form-control mt-1 pt-1" id="tj" >注册</button>
								</div>

						</div>
						<div class="tab-pane code_login">
							<img src="${ pageContext.request.contextPath }/img/adminregister/qrcode.png" alt="" class="scan_code" />
						</div>
					</div>
							
					<br />
							
							
						</div> 
					</div>
				</div>		
				
				<!-- alert框（Modal） -->
			<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
			            	<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			            </div>
			           <div class="modal-body">
						   <span id="backinfo"></span>
						</div>
			            <div class="modal-footer">
			                <input type="button" class="btn btn-primary cancelbtn" data-dismiss="modal" value="确定">
						</div><!-- /.modal-content -->
					</div>
			    </div><!-- /.modal-dialog -->
			</div>



	</body>
</html>
