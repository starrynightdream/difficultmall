<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css" />
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminproducts.css" />
		<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
		<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>
		
		<script src="${ pageContext.request.contextPath }/js/jquery-1.4.2.js"></script>
		<script src="${ pageContext.request.contextPath }/js/adminproducts.js"></script>

	</head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
	<script type="text/javascript">
		$(function(){
			
			var $pageContext = $("#PageContext").val();	
			
			$("#updateclass").click(function(){
				$('#updateModal').modal('show');
			})
			
			//修改
			$('.updyesupbtn').click(function() {
			    
				var newclass=$("input[name='upclass']").val().trim();
				var oldclass=$("#selupclass option:selected").val().trim();
				
				if(newclass.indexOf(",")>=0){
					newclass = newclass.replaceAll(',', '');
				}
				
				if(newclass!=""&&oldclass!=""){
					$.post($pageContext+"/adminupdateclass",{"newclass":newclass,"oldclass":oldclass},function(data){
						if(data=="1"){
							window.location.href=$pageContext+"/adminproducts";
						}
					});
				}
				
				$("input[name='upclass']").val("");
				$('#updateModal').modal('hide');
				
				});

			/************************/
		
			$("#deleteclass").click(function(){
				
				$('#deleteModal').modal('show');
				
				
			});
			
			//删除
			$('.delyesdebtn').click(function() {
			    
				var oldclass=$("#seldeclass option:selected").val().trim();
				
				if(oldclass!=""){
					$.post($pageContext+"/admindeleteclass",{"oldclass":oldclass},function(data){
						if(data=="1"){
							window.location.href=$pageContext+"/adminproducts";
						}
					});
					
				}
				
				$('#deleteModal').modal('hide');
				
			});
			
			/***********/
			})
	</script>
		
	<body>

		<!-- 将头部(head.jsp)包含进来 -->
		<jsp:include page="/WEB-INF/jsp/adminhead.jsp"/>
			
		<div class="container">
			<div class="row adindex_title">当前位置：商品管理</div>
			<div class="row adindex_btn w-100">
				<a href="${ pageContext.request.contextPath }/insertview" class="btn btn-danger w-100" >添加商品</a>
			</div>
			<div class="row adindex_btn btn-group mt-1 pt-1 w-100">
				<button id="updateclass" class="btn btn-info w-50">选择修改类别</button>
				<button id="deleteclass" class="btn btn-warning w-50">选择删除类别</button>
			</div>
		<p>&nbsp;</p>
		<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
			<c:forEach items="${productsList }" var="pr">
				<div class="row media detail_title p-0" id="div_${pr.id }">
					<div class="detail_img col-lg-2 col-md-3 col-sm-5 ssm_img p-0">
						<img src="${ pageContext.request.contextPath }${pr.imgurl }" alt="" class="img-responsive" />
					</div>
					<div class="media-body ml-2 col-lg-8 col-md-9 col-sm-7 ssm_div p-0 mt-0">
						<h6>${pr.name }</h6>
						<div class="detail_price p-0">
							<span class="detail_font1 detail_price_right clearfix text-left">
								类别：${pr.category}
							</span>
						</div>
						<div class="detail_price p-0">
							<span class="detail_font1 detail_price_left clearfix text-left">
								销量：${pr.pnum}件
							</span>
							<span class="detail_font1 detail_price_left clearfix text-left">
								现价：￥${pr.price}元
							</span>
						</div>
						
						<span class="detail_font1">
							描述：${pr.description}
						</span>
						<div class="detail_price p-0 input-group">
						<form action="${ pageContext.request.contextPath }/updateview" method="POST">
							<input type="hidden" name="id" value="${pr.id }" />
							<span class="detail_font1 detail_price_left clearfix text-center">
								<input type="submit" class="m-2 btn btn-info upprods" value="修改" />
							</span>
						</form>
							<span class="detail_font1 detail_price_right clearfix text-left">
								<button class="m-2 btn btn-warning delprods" id="delbtn_${pr.id}" >删除</button>
							</span>
						</div>
					</div>
				</div>
			</c:forEach>
			
			<!-- update类别（Modal） -->
			<div class="modal fade" id="updateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
							<span class="modal-title">修改类别</span>
			                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			            </div>
			           <div class="modal-body">
			           		<div class="input-group">
			           			<span class="modal-title">请选择修改的类：</span>				   
								<select id="selupclass" name="category" class="form-control">
									<c:forEach items="${categorys}" var="c">
										<option value="${c}">${c}</option>
									</c:forEach>
								</select>
			           		</div>
			           		<div class="input-group">
			           			<span class="modal-title" id="myModalLabel">修改为：</span>				   
								<input type="text" class="form-control mt-1" name="upclass" placeholder="请输入修改内容" autofocus="autofocus" />
			           		</div>
						</div>
			            <div class="modal-footer">
			                <input type="button" class="btn btn-default" data-dismiss="modal" value="关闭">
			                <input type="button" class="btn btn-primary updyesupbtn" value="确定"/>
						</div><!-- /.modal-content -->
					</div>
			    </div><!-- /.modal-dialog -->
			</div>
			
			<!-- delete类别（Modal） -->
					<div class="modal fade" id="deleteModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
					    <div class="modal-dialog">
					        <div class="modal-content">
					            <div class="modal-header">
									<span class="modal-title">删除类别</span>
					                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
					            </div>
					           	<div class="modal-body">
					           		<small style="color:#ff0000;">删除类别不可撤销，将会删除该类别的所有商品</small><br />			   
					           		<div class="input-group mt-1">
						           		<span class="modal-title">请选择删除的类：</span>	
										<select id="seldeclass" name="category" class="form-control">
											<option value="">请选择删除的类</option>
											<c:forEach items="${categorys}" var="c">
												<option value="${c}">${c}</option>
											</c:forEach>
										</select>
									</div>
								</div>
		
					            <div class="modal-footer">
					                <input type="button" class="btn btn-default" data-dismiss="modal" value="关闭" />
					                <input type="button" class="btn btn-primary delyesdebtn" value="确定" />
								</div><!-- /.modal-content -->
							</div>
						</div><!-- /.modal-dialog -->
					</div>
			
			
			
			
			
			<!-- 确认框（Modal） -->
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
							 <!-- <span class="modal-title" id="myModalLabel">请输入新类：</span> -->
			               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			            </div>
			           <div class="modal-body">
						   <span>确定删除吗？</span>
							<!-- <input type="text" class="form-control" id="inctg" placeholder="请输入新类" autofocus="autofocus" autocomplete="off" /> -->
						</div>
			            <div class="modal-footer">
			                <input type="button" class="btn btn-default cancelbtn" data-dismiss="modal" value="关闭">
			                <input type="button" class="btn btn-primary confirmbtn" value="确定" id="conbtn" />
						</div><!-- /.modal-content -->
					</div>
			    </div><!-- /.modal-dialog -->
			</div>
			
			
			
			
			
			
			
			<!-- alert框（Modal） -->
			<div class="modal fade" id="alertModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			    <div class="modal-dialog">
			        <div class="modal-content">
			            <div class="modal-header">
							 <!-- <span class="modal-title" id="myModalLabel">请输入新类：</span> -->
			               <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
			            </div>
			           <div class="modal-body">
						   <span id="backinfo"></span>
							<!-- <input type="text" class="form-control" id="inctg" placeholder="请输入新类" autofocus="autofocus" autocomplete="off" /> -->
						</div>
			            <div class="modal-footer">
			                <input type="button" class="btn btn-primary cancelbtn" data-dismiss="modal" value="确定">
						</div><!-- /.modal-content -->
					</div>
			    </div><!-- /.modal-dialog -->
			</div>
			
			
			
	</div>
		<!-- 将尾部(foot.jsp)包含进来 -->
		<jsp:include page="/WEB-INF/jsp/adminfoot.jsp"/>

		
	</body>
</html>
