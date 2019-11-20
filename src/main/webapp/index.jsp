<%@ page contentType="text/html;charset=UTF-8" %>  
<html>  
<head>  
    <meta charset="UTF-8">  
    <title>Java后端WebSocket的Tomcat实现</title>  
</head>  
<body>  
    Welcome<br/><input id="text" type="text"/>  
    <button onclick="send()">发送消息</button>  
    <hr/>  
    <button onclick="closeWebSocket()">关闭WebSocket连接</button>  
    <hr/>  
    <div id="message"></div>  
</body>
<script>
    var webscket = null;
    //判断当前浏览器是否支持websocket
    //判断当前浏览器是否支持WebSocket
    if ('WebSocket' in window) {
        webscket = new WebSocket("ws://localhost:8080/demo/ws");
    }
    else {
        alert('当前浏览器 Not support websocket')
    }
    //连接发生错误回调方法
    //连接发生错误的回调方法
    webscket.onerror = function () {
        setMessageInnerHTML("WebSocket连接发生错误");
    };
    //连接成功建立的回调方法
    webscket.onopen=function () {
        setMessageInnerHTML("WebSocket连接成功")
    };
    //接收到消息的回调方法
    webscket.onmessage=function (event) {
        setMessageInnerHTML(event.data)
    };

    //连接关闭的回调方法
    webscket.onclose=function () {
        setMessageInnerHTML("WebSocket连接关闭");
    };
    //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
    window.onbeforeunload = function () {
        closeWebSocket();
    };
    //将消息显示在网页上
    function setMessageInnerHTML(innerHTML) {
        document.getElementById('message').innerHTML += innerHTML + '<br/>';
    }
    //关闭WebSocket连接
    function closeWebSocket() {
        webscket.close();
    }

    //发送消息
    function send() {
        var message = document.getElementById('text').value;
        webscket.send(message);
    }
</script>
</html>  