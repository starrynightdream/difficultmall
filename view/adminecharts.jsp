<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML>
<html>
	<head>
		
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/bootstrap.css" />
		<script src="${ pageContext.request.contextPath }/js/jquery.min.js"></script>
		<script src="${ pageContext.request.contextPath }/js/bootstrap.min.js"></script>		
		<script src="${ pageContext.request.contextPath }/js/jquery-1.4.2.js"></script>
		
		<script src="${ pageContext.request.contextPath }/js/echarts.min.js"></script>
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/css/adminecharts.css" />

	</head>
	<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
	
	
	
	<body>

		<!-- 将头部(head.jsp)包含进来 -->
		<jsp:include page="/WEB-INF/jsp/adminhead.jsp"/>
		
		<div class="row">
			<div class="container">
			
			<input id="PageContext" type="hidden" value="${pageContext.request.contextPath}" />
			
				<div class="row adindex_btn w-100 mt-1 pt-1 btn-group">
					<a href="${ pageContext.request.contextPath }/adminorder/downloadOrders" class="btn btn-danger w-50">导出订单详情</a>
					<a href="${ pageContext.request.contextPath }/adminorder/downloadSales" class="btn btn-primary w-50">导出销量榜单</a>
				</div>
				<p>&nbsp;</p>
				<div id="main01" style="width: 900px;height:400px;margin:0 auto;"></div>
				<p>&nbsp;</p>
				<div id="main02" style="width: 900px;height:400px;margin:0 auto;"></div>
			</div>
		</div>
		
		<!-- 将尾部(foot.jsp)包含进来 -->
		<jsp:include page="/WEB-INF/jsp/adminfoot.jsp"/>

		
	</body>
	
	
	<!-- 这必须在最后面 -->
	<script type="text/javascript">
	//条形图
		var $pageContext = $("#PageContext").val();	
	    // 基于准备好的dom，初始化echarts实例
	    var myChart01 = echarts.init(document.getElementById('main01'));
	    myChart01.setOption({
	        title: {
	             text: 'EasyMall各类订单的统计',
	             left:'left'
	         },
	         legend:{
	            data:['订单量']
	         },
	         xAxis:{
	            data:[]
	         },
	         yAxis:{},
	        series : [{
	           name:'订单数',
	           type:'bar',
	           data:[]
	        }
	        ]
	    });
	
	    myChart01.showLoading({text: '数据正在加载中...'  }); 
	    //这里设置定时器模拟数据延时加载
	    setTimeout(function(){
	       $.ajax({  
	           url:$pageContext+"/echarts/getOrdersDatas",  
	           type:"post",
	           dataType:"json",  
	           success:function(jsonData){   
	               myChart01.setOption({  
	                  xAxis: {  
	                      data: jsonData.xAxisCategory  
	                  },  
	                  series: [{  
	                      // 根据名字对应到相应的系列  
	                      name: '订单数',  
	                      data: jsonData.datas  
	                  }]  
	              });  
	              // 设置加载等待隐藏  
	              myChart01.hideLoading();  
	           }  
	       }); 
	   },2000);
	</script>
	
	<script type="text/javascript">
	//折线图
	var $pageContext = $("#PageContext").val();	
	    // 基于准备好的dom，初始化echarts实例
	    var myChart02 = echarts.init(document.getElementById('main02'));
	    myChart02.setOption({
	        title: {
	             text: 'EasyMall各类商品的数量',
	             left:'left'
	         },
	         legend:{
	            data:['数量']
	         },
	         xAxis:{
	            data:[]
	         },
	         yAxis:{},
	        series : [{
	           name:'商品数量',
	           type:'line',
	           data:[]
	        }
	        ]
	    });
	
	    myChart02.showLoading({text: '数据正在加载中...'  }); 
	    //这里设置定时器模拟数据延时加载
	    setTimeout(function(){
	       $.ajax({  
	           url:$pageContext+"/echarts/getProductsDatas",  
	           type:"post",
	           dataType:"json",  
	           success:function(jsonData){   
	               myChart02.setOption({  
	                  xAxis: {  
	                      data: jsonData.xAxisCategory  
	                  },  
	                  series: [{  
	                      // 根据名字对应到相应的系列  
	                      name: '商品数量',  
	                      data: jsonData.datas  
	                  }]  
	              });  
	              // 设置加载等待隐藏  
	              myChart02.hideLoading();  
	           }  
	       }); 
	   },2000);
	
	</script>
	



</html>
