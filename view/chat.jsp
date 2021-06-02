<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<script type="text/javascript" src="${ pageContext.request.contextPath }/js/jquery-1.4.2.js"></script>
    <link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/iconfont.css">
    <link rel="stylesheet" type="text/css" href="${ pageContext.request.contextPath }/css/chat.css">
    <script type="text/javascript" src="${ pageContext.request.contextPath }/js/chat.js"></script>
    <script>
	
	screenFuc();
    function screenFuc() {
        var topHeight = $(".chatBox-head").innerHeight();//聊天头部高度
        //屏幕小于768px时候,布局change
        var winWidth = $(window).width();
        if (winWidth <= 768) {
            var totalHeight = $(window).height(); //页面整体高度
            $(".chatBox-info").css("height", totalHeight - topHeight);
            var infoHeight = $(".chatBox-info").innerHeight();//聊天头部以下高度
            //中间内容高度
            $(".chatBox-content").css("height", infoHeight - 46);
            $(".chatBox-content-demo").css("height", infoHeight - 46);

            $(".chatBox-list").css("height", totalHeight - topHeight);
            $(".chatBox-kuang").css("height", totalHeight - topHeight);
            $(".div-textarea").css("width", winWidth - 106);
        } else {
            $(".chatBox-info").css("height", 495);
            $(".chatBox-content").css("height", 408);
            $(".chatBox-content-demo").css("height", 438);
            $(".chatBox-list").css("height", 495);
            $(".chatBox-kuang").css("height", 495);
            $(".div-textarea").css("width", 320);
        }
    }
    (window.onresize = function () {
        screenFuc();
    })();
    //未读信息数量为空时
    var totalNum = $(".chat-message-num").html();
    if (totalNum == "") {
        $(".chat-message-num").css("padding", 0);
    }
    $(".message-num").each(function () {
        var wdNum = $(this).html();
        if (wdNum == "") {
            $(this).css("padding", 0);
        }
    });
    function OpenOrCloseChat() {
    	 //打开/关闭聊天框
        $(".chatBtn").click(function () {
            $(".chatBox").toggle(10);
        })
        $(".chat-close").click(function () {
            $(".chatBox").toggle(10);
        })
	}
   
    //进聊天页面
    function gotoChat(){
    	$(".chat-list-people").each(function () {
            $(this).click(function () {
            	chatData.updateTime=new Date()
                var n = $(this).index();
                $(".chatBox-head-one").toggle();
                $(".chatBox-head-two").toggle();
                $(".chatBox-list").fadeToggle();
                $(".chatBox-kuang").fadeToggle();
                chatData.chatter=$(this).children(".chat-name").children("p").eq(0).html()
                chatData.chatterId=parseInt($(this).attr("id"))
                img=$(this).children().eq(0).children("img").attr("src").split('/')
                chatData.chatterImg=img[img.length-1]
                $.ajax({
        			type:"post",
        			url:"${ pageContext.request.contextPath }/chat/getMessage",
        			data:{userId:chatData.userId,chatterId:chatData.chatterId,date:new Date(0)},
        			success:function(data){
                    	$(".chatBox-content-demo").empty()
                    	data=parsetoJson(data)
                    	if(data==-1)return
                    	for(i=0;i<data.length;i++){
                    		d=data[i]
                    		date=new Date(d["date"])
                    		dateString=formatDate(date)
                    		userId=d["userId"]
                    		text=d["text"]
                    		$(".chatBox-content-demo").append(createClearfloat(userId,dateString,text))
                    	}
        			},
        			error:function(data){
        				alert("error")
        			}
            	})
                //传名字
                $(".ChatInfoName").text(chatData.chatter);
                
                //传头像
                $(".ChatInfoHead>img").attr("src",$(this).children().eq(0).children("img").attr("src"));
                //聊天框默认最底部
                $(document).ready(function () {
                    $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
                });
            })
        });
    }
    //返回列表
    function gobackList(){
    	$(".chat-return").click(function () {
            $(".chatBox-head-one").toggle(1);
            $(".chatBox-head-two").toggle(1);
            $(".chatBox-list").fadeToggle(1);
            $(".chatBox-kuang").fadeToggle(1);
        });
    }
    function sendMessage(){
    //      发送信息
    	$("#chat-fasong").click(function () {
            var textContent = $(".div-textarea").html().replace(/[\n\r]/g, '<br>')
            
            
            if (textContent != "") {
            	$.ajax({
        			type:"post",
        			url:"${ pageContext.request.contextPath }/chat/sendMessage",
        			data:{userId:chatData.userId,chatterId:chatData.chatterId,text:textContent},
        			success:function(data){
        				//chatData.updateTime=new Date()
        			},
        			error:function(data){
        				alert("error")
        			}
            	})
                //$(".chatBox-content-demo").append(createClearfloat(chatData.userId,formatDate(new Date()),textContent));
                //发送后清空输入框
                $(".div-textarea").html("");
                //聊天框默认最底部
                $(document).ready(function () {
                    $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
                });
            }
        });
    }
    //      发送表情
    $("#chat-biaoqing").click(function () {
        $(".biaoqing-photo").toggle();
    });
    $(document).click(function () {
        $(".biaoqing-photo").css("display", "none");
    });
    $("#chat-biaoqing").click(function (event) {
        event.stopPropagation();//阻止事件
    });
    $(".emoji-picker-image").each(function () {
        $(this).click(function () {
            var bq = $(this).parent().html();
            console.log(bq)
            $(".chatBox-content-demo").append("<div class=\"clearfloat\">" +
                "<div class=\"author-name\"><small class=\"chat-date\">2017-12-02 14:26:58</small> </div> " +
                "<div class=\"right\"> <div class=\"chat-message\"> " + bq + " </div> " +
                "<div class=\"chat-avatars\"><img src=\"${ pageContext.request.contextPath }/img/icon01.png\" alt=\"头像\" /></div> </div> </div>");
            //发送后关闭表情框
            $(".biaoqing-photo").toggle();
            //聊天框默认最底部
            $(document).ready(function () {
                $("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
            });
        })
    });
    
    
    function createClearfloat(userId,date,textContent){
    	if(chatData.userId==userId){
    		clearFloat="<div class=\"clearfloat\">" +
            "<div class=\"author-name\"><small class=\"chat-date\">"+date+"</small> </div> " +
            "<div class=\"right\"> <div class=\"chat-message\"> " + textContent + " </div> " +
            "<div class=\"chat-avatars\"><img src='${pageContext.request.contextPath}/img/icon/"+chatData.userImg+"'  /></div> </div> </div>"
    	}
    	else{
    		clearFloat="<div class=\"clearfloat\">" +
            "<div class=\"author-name\"><small class=\"chat-date\">"+date+"</small> </div> " +
            "<div class=\"left\"><div class=\"chat-avatars\"><img src='${pageContext.request.contextPath}/img/icon/"+chatData.chatterImg+"' /></div>"+
            " <div class=\"chat-message\"> " + textContent + " </div> </div> </div> " 
           
    	} 
        return clearFloat
    }
	
    function setChatManager(users){
    	$chatManager=$("#chat-manager")
    	$chatManager.empty()
    	for(i=0;i<users.length;i++){
    		user=users[i]
    		$manager=$("<option value='"+user.id+"' class='managerOption'>"+user.username+"</option>")
    		$chatManager.append($manager)
    		if($manager.val()==chatData.userId){
    			$manager.attr("selected","selected")
    		}
    	}
    	$chatManager.change(function(){
    		 $se=$(this).find('option:selected')
    		 
    		 id=$se.val()
    		 for(i=0;i<chatData.userList.length;i++){
    			 cha=chatData.userList[i]
    			 if(cha.id==id){
    				 chatData.userId=cha.id
    				 chatData.user=cha.userName
    				 chatData.userImg=cha.icon
    			 }
    		 }
    	});
           
    }
</script>
    
	<script type="text/javascript">
	chatData=new Object
	chatData.updateTime=new Date()
	$(document).ready(function(){
		
		$.ajax({
			type:"post",
			url:"${ pageContext.request.contextPath }/chat/getUser",
			data:{t1:1,t2:"ff"},
			success:function(data){
				/**
				<div class="chat-list-people" >
                <div><img src="${ pageContext.request.contextPath }/img/chat/icon01.png" alt="头像"/></div>
                <div class="chat-name">
                    <p>自酌一杯酒</p>
                </div>
            	</div>
            	**/
            	chatData.userId=3
            	chatData.user="阿斗"
            	chatData.userImg="ge4.jpg"
            	data= parsetoJson( data )
            	userList=[]
            	for(i=0;i<data.length;i++){
            		d=data[i]
            		
            		$chatListPeople=$("<div class='chat-list-people'></div>")
            		$imgdiv=$("<div></div>")
            		$img=$("<img src='${ pageContext.request.contextPath }/img/icon/"+d["icon"]+"' alt='头像'/>")
            		$namediv=$("<div class='chat-name'></div>")
            		$p=$("<p>"+d["username"]+"</p>")
            		$imgdiv.append($img)
            		$namediv.append($p)
            		$chatListPeople.append($imgdiv).append($namediv)
            		$chatListPeople.attr("id",d["id"])
            		$("#chatBox-list").append($chatListPeople)
            		user=new Object;
            		user.icon=d["icon"]
            		user.id=parseInt(d["id"])
            		user.username=d["username"]
            		userList.push(user)
            		
            	}
            	chatData.userList=userList;
            	gotoChat()
            	gobackList()
            	OpenOrCloseChat()
            	setChatManager(userList)
			},
			error:function(data){
				alert("获取用户列表信息失败")
			}
			
		}	
		);
		screenFuc()
		sendMessage()
		updateDialog()
	});
	//用于无刷新更新聊天室
	function updateDialog(){
		setInterval(function(){
			if(chatData.userId==null||chatData.chatterId==null)return;
			$.ajax({
        			type:"post",
        			url:"${ pageContext.request.contextPath }/chat/getMessage",
        			data:{userId:chatData.userId,chatterId:chatData.chatterId,date:chatData.updateTime},
        			success:function(data){
        				
                    	data=parsetoJson(data)
                    	if(data==-1)return
                    	for(i=0;i<data.length;i++){
                    		d=data[i]
                    		date=new Date(d["date"])
                    		dateString=formatDate(date)
                    		userId=d["userId"]
                    		text=d["text"]
                    		$(".chatBox-content-demo").append(createClearfloat(userId,dateString,text))
                    	}
                    	$("#chatBox-content-demo").scrollTop($("#chatBox-content-demo")[0].scrollHeight);
        			},
        			error:function(data){
        				console.log("实时更新失败")
        			}
            })
            chatData.updateTime=new Date()
		},2000);
	}
	
	</script>
	
</head>
<body>
<!-- <a href="${ pageContext.request.contextPath }/chat/test"><button>123</button></a> -->
<div class="chatContainer">
	<!-- 右下方显示按钮 -->
    <div class="chatBtn">
        <i class="iconfont icon-xiaoxi1"></i>
    </div>
    <div class="chat-message-num">10</div>
    <div class="chatBox" ref="chatBox">
        <div class="chatBox-head">
            <div class="chatBox-head-one">
                Conversations
                <div class="chat-close" style="margin: 10px 10px 0 0;font-size: 14px">关闭</div>
                
                <select class="chat-manager" id="chat-manager" style="margin: 25px 10px 0 0;font-size: 14px">
  						
				</select>
				<label for="chat-manager" class="chat-manager2" style="margin: 10px 10px 0 0;font-size: 14px">身份</label>
            </div>
            <div class="chatBox-head-two">
                <div class="chat-return">返回</div>
                <div class="chat-people">
                    <div class="ChatInfoHead">
                        <img src="" alt="头像"/>
                    </div>
                    <div class="ChatInfoName">这是用户的名字，看看名字到底能有多长</div>
                </div>
                <div class="chat-close">关闭</div>
            </div>
        </div>
        <div class="chatBox-info">
            <div class="chatBox-list" ref="chatBoxlist" id="chatBox-list">
                
            </div>
            <div class="chatBox-kuang" ref="chatBoxkuang">
                <div class="chatBox-content">
                    <div class="chatBox-content-demo" id="chatBox-content-demo">

                        <!--  <div class="clearfloat">
                            <div class="author-name">
                                <small class="chat-date">2017-12-02 14:26:58</small>
                            </div>
                            <div class="left">
                                <div class="chat-avatars"><img src="img/icon01.png" alt="头像"/></div>
                                <div class="chat-message">
                                    给你看张图
                                </div>
                            </div>
                        </div>-->
                    </div>
                </div>
                <div class="chatBox-send">
                    <div class="div-textarea" contenteditable="true"></div>
                    <div>
                        <button id="chat-fasong" class="btn-default-styles"><i class="iconfont icon-fasong"></i>
                        </button>
                    </div>
                    <div class="biaoqing-photo">
                       
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>


<script src="http://www.jq22.com/jquery/jquery-1.10.2.js"></script>

</body>
</html>
