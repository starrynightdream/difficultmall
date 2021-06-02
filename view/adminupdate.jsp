<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css" />
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminupdate.css" />
		<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
		<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
		
		<script src="${ pageContext.request.contextPath }/js/adminupdate.js"></script>
	
		
	</head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
		
		<script>
	$(function(){
		//后台验证
		$("#tj").click(function(){
			var id=$("input[name='id']").val();
			var name=$("input[name='name']").val();
			var price=$("input[name='price']").val();
			var category=$("#selctg option:selected").val();
			var pnum=$("input[name='pnum']").val();
			var description=$("input[name='description']").val();
			//alert(valistr);
			
			if(category==""){
				$(".infocontent").css("color","#721c24");
				$(".infocontent").css("background-color","#f8d7da");
				$(".infocontent").css("border-color","#f5c6cb");
				$("#info_mation").text("category不能为空");
				return;
			}
			
			var regexPrice=/^(([0-9])|([1-9]([0-9]+)))(.[0-9]+)?$/;
			
			if(id.trim()==""||name.trim()==""||price.trim()==""||!price.match(regexPrice)||price<=0){
				$(".infocontent").css("color","#721c24");
				$(".infocontent").css("background-color","#f8d7da");
				$(".infocontent").css("border-color","#f5c6cb");
				$("#info_mation").text("有信息不符合要求");
				return;
			}
				
			var $pageContext = $("#PageContext").val();	
			var url=$pageContext+"/adminupdate";
			
			$.post(url,{"id":id,"name":name,"price":price,"category":category,"pnum":pnum,"description":description},function(data){
				if(data=="1"){
					$('#alertModal').modal('show');
					
					$("#alertModal").on('shown.bs.modal',function(){  //alert框
						$("#backinfo").html("修改成功！");
						$("#alertModal").on('hide.bs.modal',function(){  //点击确定或关闭后跳转到主页
							window.location.href=$pageContext+"/adminproducts";
						}); 
					}); 
				}
				else{
					$('#alertModal').modal('show');
					
					$("#alertModal").on('shown.bs.modal',function(){  //alert框
						$("#backinfo").html(data);
					});  
				}
			})
				
		});
		
		
		//文件上传后续事件
		$('#filebtn').click(function(){

			var $pageContext = $("#PageContext").val();	
			
			var vpath=$("#myfile").val();
		
			$("#img_url").val("");
			
			if(vpath.trim()!=""){
				var nametemp=new Array();		
				var nametemp=vpath.split("\\");
				
				//nametemp[nametemp.length-1]    //1.png
				var type=new Array();
				var type=nametemp[nametemp.length-1].split(".");
				
				//文件类型判断
				if(type[type.length-1]=="jpg"||type[type.length-1]=="png"){
 
					var reader = new FileReader();
			        reader.readAsDataURL(file);
			        reader.onload = function (e) {    //成功读取文件
			            var img =document.getElementById("newimg");
			            img.src = e.target.result;   //或 img.src = this.result / e.target == this
			        };
				}
				
			}

			$('#addfileModal').modal('hide');
		})
		
	})
	
	function checkform(){
		
		var vpath=$("#myfile").val();
		if(vpath.trim()==""){ 
			return false;
		}
		
		var nametemp=new Array();		
		var nametemp=vpath.split("\\");
		var type=new Array();
		var type=nametemp[nametemp.length-1].split(".");
		if(type[type.length-1].toLowerCase()!="jpg"&&type[type.length-1].toLowerCase()!="png"){	
			return false;
		}
		
		return true;
	}
	
	
	
	function addfile(){
		$('#addfileModal').modal('show');	
	}
	
	var file;
	
	function getfileobj(obj){
		file = obj.files[0];
	}
	
	</script>
		
	<body>
			
		<div class="container"> 
			<div class="row justify-content-center">
				<div class="col-center-block col-lg-4 col-md-4 col-sm-5 col-xl-5 jumbotron myformdiv pb-0">
					
					<!--验证码/表单信息-->
					<div class="tab-content">
									
							<h4 class="text-left">商品管理</h4>
							
							<!-- 提示框 -->
							<div class="alert alert-dismissible infocontent p-0 m-0"> <!-- alert-danger在js实现 -->
								<span id="info_mation" class="p-0">成功</span>
							</div>
							
								<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
								
								<div class="input-group mt-1 pt-1">
									<span><b>编号</b></span>
									<input type="text" class="form-control ml-1" name="id" autofocus="autofocus" value="${products.id }" readonly="readonly" autocomplete="off" />
								</div>					

								
								<div class="input-group mt-1 pt-1">
									<span><b>名称</b></span>
									<input type="text" class="form-control ml-1 pl-1"  name="name" value="${products.name }" autocomplete="off" />
								</div>
								<div class="input-group mt-1 pt-1">
									<span><b>类别</b></span>
									<select id="selctg" name="category" class="ml-2">
										<option value="${products.category }">${products.category }</option>
										<c:forEach items="${categorys}" var="c">
											<option value="${c}">${c}</option>
										</c:forEach>
									</select>
									<div style="display: inline">
										<input type="button" class="btn btn-outline-secondary selbtn m-0 p-0" value="+" data-toggle="modal" data-target="#myModal" />
									</div>
								</div>					
								<!-- 销量 -->
									<input type="hidden" class="form-control ml-1 pl-1" name="pnum" value="${products.pnum }" readonly="readonly" />
				
								<div class="input-group mt-1 pt-1">
									<span><b>现价</b></span>
									<input type="text" class="form-control ml-1 pl-1" name="price" value="${products.price }" autocomplete="off" />
								</div>
								<div class="input-group mt-1 pt-1">
									<span><b>描述</b></span>
									<input type="text" class="form-control ml-1 pl-1" name="description" value="${products.description }" autocomplete="off" />
								</div>
								
								<div class="input-group-lg mt-1 pt-1 clearfix w-100 text-center">
									<input type="button" class="btn m-1" value="添加图片" onclick="addfile()" />
									<img id="newimg" alt="" src="${ pageContext.request.contextPath }${products.imgurl}" class="adedit_img clearfix p-1 m-1" style="width:100px;height:100px" />
								</div> 
								<div>
									<input type="button" id="tj" class="btn btn-primary form-control pt-1" value="提交"/>
								</div>
								<a href="${ pageContext.request.contextPath }/adminuser/login">返回</a>

					</div>
							
					<br />		
				</div> 
			</div>
		</div>
		
		<iframe name="tempframe" style="display: none;"></iframe>
		
		<!-- 文件上传 -->
		<div class="modal fade" id="addfileModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			 <form action="${ pageContext.request.contextPath }/addfile" onsubmit="return checkform();" method="post" enctype="multipart/form-data" target="tempframe">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
							 <span class="modal-title">图片上传</span>
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			            </div>
			            <div class="modal-body">
			            	<small style="color:#ff0000;">只接受.jpg .png格式文件</small><br />
							<input type="file" class="infile" name="myfile" id="myfile" accept=".png,.jpg" onchange="getfileobj(this)" />
						</div>
			            <div class="modal-footer">
			                <input type="button" class="btn btn-default" data-dismiss="modal" value="关闭">
			                <input type="submit" class="btn btn-primary" value="确定" id="filebtn" />
						</div><!-- /.modal-content -->
					</div>
			    </div><!-- /.modal-dialog -->
			   </form>
			</div>
		
		
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
							 <span class="modal-title" id="myModalLabel">请输入新类：</span>
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			            </div>
			            <div class="modal-body">
							<input type="text" class="form-control" id="inctg" value="${products.category }" placeholder="请输入新类" autofocus="autofocus" autocomplete="off" />
						</div>
			            <div class="modal-footer">
			                <input type="button" class="btn btn-default cancelbtn" data-dismiss="modal" value="关闭">
			                <input type="button" class="btn btn-primary confirmbtn" value="提交" id="conbtn" />
						</div><!-- /.modal-content -->
					</div>
			    </div><!-- /.modal-dialog -->
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

		

	</body>
</html>
