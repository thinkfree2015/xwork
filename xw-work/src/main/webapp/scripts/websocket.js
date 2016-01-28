var host = "192.168.1.80:8001";

//推送消息
var ws = null;
//通知页面改变
var ws2 = null;
var url = null;
function connect() {
    if ('WebSocket' in window) {
        ws = new WebSocket("ws://"+host+"/websck");
        ws2 = new WebSocket("ws://"+host+"/websck");
    } else if ('MozWebSocket' in window) {
        ws = new MozWebSocket("ws://websck");
    } else {
        ws = new SockJS("http://"+host+"/sockjs/websck");
        ws2 = new SockJS("http://"+host+"/sockjs/websck");
    }
    ws.onopen = function () {
    };
    ws2.onopen = function () {
    };
    ws.onmessage = function (event) {
        if ((event.data).indexOf("Hint") == 0) {//判断message是否为初始化的message
//                alert(event.data);
            var count = event.data.toString().split(",");
            $("#message-number").find(".admin-fullText").html(count[1]);
        } else {
            var obj = $.parseJSON(event.data);//把发送过来的消息转换成对象
            var task = obj.content;
            if(obj.type.indexOf("1") != -1) {
                //根据消息中的参数来判断哪个页面需要刷新
                if (obj.path == "problem") {
                    reload_my_problem(task);//调用我的问题页面刷新方法
                } else if (obj.path == "projectView") {
                    //调用项目-->任务管理-->页面刷新方法
                     if(obj.message=="true"){
                         alert(obj.content);
                     }
                    //alert(obj.content)
                }
            }
        }
    };
    ws.onclose = function (event) {
        console.log("关闭连接")
    };
    ws2.onclose = function (event) {
        console.log("关闭连接")
    };
}

function disconnect() {
    if (ws != null) {
        ws.close();
        ws = null;
    }
}
$(document).ready(function () {
    connect();
});