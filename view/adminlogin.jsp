<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css"/>
<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminlogin.css" />
<script src="${ pageContext.request.contextPath }/js/adminlogin.js"></script>

<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<script>
	$(function(){
		//后台验证
		$("#tj").click(function(){
			var username=$("input[name='username']").val();
			var password=$("input[name='password']").val();
			var valistr=$("input[name='valistr']").val();
			//alert(valistr);
				
			var $pageContext = $("#PageContext").val();	
			var url=$pageContext+"/adminuser/dologin";
			
			if(username.trim()==""||password.trim()==""||valistr.trim()==""){
				
				$(".infocontent").css("color","#721c24");
				$(".infocontent").css("background-color","#f8d7da");
				$(".infocontent").css("border-color","#f5c6cb");
				$("#info_mation").text("有信息未符合要求");
				return;
			}
			
			$.post(url,{"username":username,"password":password,"valistr":valistr},function(data){
				console.log(data)
				if(data=="1"){
					window.location.href=$pageContext+"/adminorder/showorder";
				}
				else{
					
					$('#alertModal').modal('show');
					
					$("#alertModal").on('shown.bs.modal',function(){  //alert框
						$("#backinfo").html(data);
					});  
					//更新验证码
					$("#alertModal").on('hide.bs.modal',function(){  //alert框
						$("#img").attr("src",$pageContext+"/index/valiImage?time="+new Date().getTime());
						//文本框全部赋空
						$("input[name='username']").val("");
						$("input[name='password']").val("");
						$("input[name='valistr']").val("");
					}); 
				}
			})
				
		});
	})
</script>
		
<div class="container"> 
	<div class="row justify-content-center">
		<div class="col-center-block col-lg-4 col-md-4 col-sm-5 col-xl-5 jumbotron myformdiv pb-0">
			<!-- 1F内容-->
			
			<div class="floor1">
				<ul class="nav nav-tabs mt-0 p-0 text-center ml-3">
					<li class="nav-item password_login"><a href="#password_login" class="nav-link" data-toggle="tab"><span>密码登录</span></a></li>
					<li class="nav-item code_login" id="do_qrcode"><a href="#code_login" class="nav-link" data-toggle="tab"><span>扫码登录</span></a></li> 
				</ul>
				<a href="javascript:void(0);" onclick="qrcode()" class="password_login"><img src="${ pageContext.request.contextPath }/img/adminlogin/qrcode_front.png" alt="" class="img_code" /></a>
				<a href="javascript:void(0);" onclick="pwdcode()" class="code_login"><img src="${ pageContext.request.contextPath }/img/adminlogin/password_front.png" alt="" class="img_code" /></a>
			</div> 
			
			<br />
				
			<!--验证码/表单信息-->
			<div class="tab-content">
				<div class="tab-pane password_login">		
				
					<h4 class="text-left">后台登录</h4> 
					<!--信息提示框-->
					<div class="alert alert-dismissible infocontent p-0 m-0"> <!-- alert-danger在js实现 -->
						<span id="info_mation" class="p-0">成功</span>
					</div>
						<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
						<div class="input-group-lg">
							<span><b>Username</b></span>
							<input type="text" class="form-control clearback" id="user" placeholder="Username" name="username" autofocus="autofocus" autocomplete="off" />
						</div>
						<div class="input-group-lg">
							<span><b>Password</b></span>
							<input type="password" class="form-control clearback" id="pwd" placeholder="Password" name="password" autocomplete="off" />
						</div>
						<div class="input-group-lg">
							<span class="chktest"><b>Verify</b></span>
							<div class=input-group>
								<input type="text" class="form-control verify-text clearback" id="chk" placeholder="Verify" name="valistr" autocomplete="off" />
								<img id="img" class="verify-img p-0 m-0" src="${ pageContext.request.contextPath }/index/valiImage"/>
							</div>
						</div>
						<div class="mt-1 pt-1">
							<button class="btn btn-primary form-control mt-1 pt-1" id="tj">登录</button>
						</div>
				</div>
				<div class="tab-pane code_login">
					<img src="${ pageContext.request.contextPath }/img/adminlogin/qrcode.png" alt="" class="scan_code" />
				</div>
			</div>
					
			<br />

					<!--其他登陆方式-->
					<p class="font p-0 mb-0">其他登录方式</p>
					<div class="text-left">
						<ul class="list-unstyled"> <!--去掉小圆点的-->
							<li class="text-left">
							<a href="" class="text-muted my_small"><img src="${ pageContext.request.contextPath }/img/adminlogin/icon_weixinweb.png" alt="" class="img_logo" /></a>
							<a href="" class="text-muted my_small"><img src="${ pageContext.request.contextPath }/img/adminlogin/icon_qq.png" alt="" class="img_logo" /></a>
							<a href="" class="text-muted my_small"><img src="${ pageContext.request.contextPath }/img/adminlogin/icon_weibo.png" alt="" class="img_logo" /></a>
							</li>
						</ul>
						<p class="my_small"><a href="#">忘记密码?</a></p>
						<p class="my_small">Lorem ipsum dolor sit amet, consectetur.</p>
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
			    </div><!-- //.modal-dialog -->
			</div>
			
			
			
		</div>	
			