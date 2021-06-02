<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css"/>
<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>

<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminfoot.css"/>

<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<div class="container">
	<div class="row">
		<div class="ended">
			<hr />
			<p>联系我们：</p>
			<ul class="list-unstyled foot_ul"> <!--去掉小圆点的-->
				<li class="text-left">
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/share.png" alt="" class="img_logo" /></a>
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/weibo.png" alt="" class="img_logo" /></a>
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/qq.png" alt="" class="img_logo" /></a>
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/wechat.png" alt="" class="img_logo" /></a>
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/tcweibo.png" alt="" class="img_logo" /></a>
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/qqzone.png" alt="" class="img_logo" /></a>
					<a href="#" class="text-muted"><img src="${ pageContext.request.contextPath }/img/adminfoot/renren.png" alt="" class="img_logo" /></a>
				</li>
			</ul>
		</div>
		<div class="text-center col-12 p-0">
			<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Reiciendis nisi!版权所有</p>
		</div>
	</div>
</div>