<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE HTML>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
<meta name="viewport" content="initial-scale=1, user-scalable=no"/>
<style type="text/css">
    body, html {
        width: 100%;
        height: 100%;
        margin: 0;
        font-family: "微软雅黑";
    }

    #allmap {
        height: 50%;
        width: 100%;
    }
</style>
<!-- 设置你的百度地图ak -->
<script type="text/javascript"
        src="http://api.map.baidu.com/api?v=3.0&ak=V1PIoGXv1mHKC1eQ4jnlOGuBnN6456Fw"></script>
<script src="https://cdn.bootcss.com/jquery/3.1.1/jquery.min.js"></script>
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/1.6.4/jquery.js"></script>

<label>收货地址:&nbsp;</label>
<input type='text' name='receiverinfo' id="suggestId" value="百度" autocomplete="off" style="width: 300px">
<input type="button" onclick="$('#allmap').toggle();" value="隐藏/显示百度地图"/>
<div id='allmap' style='width: 95%; height: 50%; position: absolute;display: none'></div>

<script type="text/javascript">

    var map = new BMap.Map("allmap");
    var geoc = new BMap.Geocoder();  //地址解析对象
    var markersArray = [];
    var geolocation = new BMap.Geolocation();
    var point = new BMap.Point(116.331398, 39.897445);
    map.centerAndZoom(point, 12); // 中心点

    geolocation.getCurrentPosition(function (r) {
        if (this.getStatus() == BMAP_STATUS_SUCCESS) {
            var mk = new BMap.Marker(r.point);
            map.addOverlay(mk);
            map.panTo(r.point);
            map.enableScrollWheelZoom(true);
        }
        else {
            //alert('failed' + this.getStatus());
        }
    }, {enableHighAccuracy: true});
    map.addEventListener("click", showInfo);

    //鼠标滚动缩放
    map.enableScrollWheelZoom(true);
    //添加地图类型控件
    map.addControl(new BMap.MapTypeControl());

    var ac = new BMap.Autocomplete(    //建立一个自动完成的对象
        {
            "input": "suggestId"
            , "location": map
        });

    // ac.addEventListener("onhighlight", function (e) {  //鼠标放在下拉列表上的事件
    //
    // });

    ac.addEventListener("onconfirm", function (e) {    //鼠标点击下拉列表后的事件
        document.getElementById('allmap').style.display = 'none';

        setPlace();
    });

    function setPlace() {
        map.clearOverlays();    //清除地图上所有覆盖物
        function myFun() {
            var pp = local.getResults().getPoi(0).point;    //获取第一个智能搜索的结果
            map.centerAndZoom(pp, 18);
            map.addOverlay(new BMap.Marker(pp));    //添加标注
        }
        var local = new BMap.LocalSearch(map, { //智能搜索
            onSearchComplete: myFun
        });
        local.search(myValue);
    };

    //清除标识
    function clearOverlays() {
        if (markersArray) {
            for (i in markersArray) {
                map.removeOverlay(markersArray[i])
            }
        }
    }
    //地图上标注
    function addMarker(point) {
        var marker = new BMap.Marker(point);
        markersArray.push(marker);
        clearOverlays();
        map.addOverlay(marker);
    }
    //点击地图时间处理
    function showInfo(e) {
        geoc.getLocation(e.point, function (rs) {
            var addComp = rs.addressComponents;
            var address = addComp.province + addComp.city + addComp.district + addComp.street + addComp.streetNumber;
            if (confirm("确定地址是:" + address + "?")) {
                //document.getElementById('allmap').style.display = 'none';
                document.getElementById('suggestId').value = address;
            }
        });
        addMarker(e.point);
    }

</script>