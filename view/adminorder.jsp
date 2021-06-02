<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
<html>
<head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<link href="${ pageContext.request.contextPath }/css/adminorder.css" rel="stylesheet" type="text/css">
</head>
<body>
<%@ include file = "adminhead.jsp" %>
	<div id="no_order_info">
		<c:if test="${empty orderInfos }">
			您还没有添加任何订单！
		</c:if>
	</div>
	<!-- 模版数据 -start -->
	
	<c:forEach items="${orderInfos }" var="orderInfo" varStatus="i">
	
	<div style="margin: 0 auto;width:999px;">
		<dl class="Order_information">
			<dt>
				<h3>订单信息</h3>
			</dt>
			<dd style="line-height: 26px;">
				订单编号：${orderInfo.order.id }
				<br />
				下单时间：${orderInfo.order.ordertime }
				<br /> 
				订单金额：￥${orderInfo.order.money }元
				<br /> 
				支付状态：
				  <c:if test="${orderInfo.order.paystate==1 }">
						<font color="red">买家已支付，未发货</font>&nbsp;&nbsp;
						<a href="${ pageContext.request.contextPath }/adminorder/sendorder?id=${orderInfo.order.id}"> 
					 		发货
						</a>
				  </c:if>
				  <c:if test="${orderInfo.order.paystate==2 }">
						<font color="blue">已发货，买家未确认</font>
				 </c:if>	
					<br /> 
				所属用户：${usernameList[i.index] }
				<br/> 
				收货地址：${orderInfo.order.receiverinfo }
				<br/> 
				支付方式：在线支付
			</dd>
		</dl>
	
		<table width="999" border="0" cellpadding="0"
			cellspacing="1" style="background:#d8d8d8;color:#333333">
			<tr>
				<th width="276" height="30" align="center" valign="middle" bgcolor="#f3f3f3">商品图片</th>
				<th width="247" align="center" valign="middle" bgcolor="#f3f3f3">商品名称</th>
				<th width="231" align="center" valign="middle" bgcolor="#f3f3f3">商品单价</th>
				<th width="214" align="center" valign="middle" bgcolor="#f3f3f3">购买数量</th>
				<th width="232" align="center" valign="middle" bgcolor="#f3f3f3">总价</th>
			</tr>
			<c:forEach items="${orderInfo.map }" var="entry">
			<tr>
				<td align="center" valign="middle" bgcolor="#FFFFFF">
					<img src="${ pageContext.request.contextPath }${entry.key.imgurl}" width="90" height="105">
				</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.key.name }</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">￥${entry.key.price }元</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">${entry.value }件</td>
				<td align="center" valign="middle" bgcolor="#FFFFFF">￥${entry.key.price*entry.value}元</td>
			</tr>
			</c:forEach>
		</table>
		<div class="Order_price">￥${orderInfo.order.money }元</div>
	</div>
	</c:forEach>
	
	<!-- 模版数据 -end -->
	<%@ include file = "_foot.jsp" %>
</body>
</html>
