<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css"/>
<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminhead.css" />

<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
	<div class="row head_title">
		<div class="col-lg-9 col-md-6 col-sm-9 mt-2 p-0 mt-3 welcome" >
			<!-- 未登录 -->
			<c:if test="${ empty sessionScope.admin }">
	            欢迎光临本店，请<a href="${ pageContext.request.contextPath }/index/login">登录</a>
	        </c:if>
	        
	        <!-- 已登录 -->
    		<c:if test="${ !(empty sessionScope.admin) }">
    			${ sessionScope.admin.username }欢迎您！<a href="${ pageContext.request.contextPath }/adminuser/loginout">退出</a>
    		</c:if>  
	    </div>
       
		<div class="col-lg-3 col-md-6 col-sm-3 p-0 mt-3 head_title2 pr-3">
            <!--面包屑导航-->
            <ul class="breadcrumb justify-content-end p-0 m-0"> <!--清除内外边距 ml:margin-left-->
            	<!-- 未登录 -->
				<c:if test="${ empty sessionScope.admin }">
	            	<li class="breadcrumb-item"><a href="${ pageContext.request.contextPath }/index/login" class="text-muted">前台登录</a></li>
	            	<li class="breadcrumb-item"><a href="${ pageContext.request.contextPath }/index/register" class="text-muted">前台注册</a></li>
	            	<li class="breadcrumb-item"><a href="#" class="text-muted">后台登陆</a></li>
           		</c:if>
           		<!-- 已登录 -->
				<c:if test="${ !(empty sessionScope.admin) }">
	            	<li class="breadcrumb-item"><a href="${ pageContext.request.contextPath }/admin/regist" class="text-muted">后台注册</a></li>
	            	<li class="breadcrumb-item"><a href="${ pageContext.request.contextPath }/adminuser/loginout" class="text-muted">退出</a></li>
           		</c:if>
            </ul>
        </div>
					
	</div>
	<hr />
	<div class="row">
		<div class="col-lg-3 p-0 mr-0">
			<img src="${ pageContext.request.contextPath }/img/adminhead/logo.jpg" alt="" />
		</div>
		<!--水平导航-->
		<div class="col-lg-5 p-0">
			<ul class="nav">
				<li class="nav-item"><a href="${ pageContext.request.contextPath }/adminorder/showorder" class="nav-link">订单管理</a></li>
				<li class="nav-item"><a href="${ pageContext.request.contextPath }/adminproducts"  class="nav-link">商品管理</a></li>
				<li class="nav-item"><a href="${ pageContext.request.contextPath }/adminorder/showecharts" class="nav-link">报表查看</a></li>
			</ul>
		</div>
		<div class="col-lg-4 p-0 mt-2 text-left">
			<img src="${ pageContext.request.contextPath }/img/adminhead/qr.jpg" alt="" />
		</div>
	</div>
</div>