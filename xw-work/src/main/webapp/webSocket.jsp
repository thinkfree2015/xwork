<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <title>WebSocket/SockJS</title>


    <script src="http://cdn.sockjs.org/sockjs-0.3.min.js"></script>
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>

    <script type="text/javascript">

        var ws = null;
        var url = null;
        var transports = [];

        function setConnected(connected) {
           /* document.getElementById('connect').disabled = connected;
            document.getElementById('disconnect').disabled = !connected;*/
            document.getElementById('echo').disabled = !connected;
        }

        function connect() {
            if (!url) {
                alert('Select whether to use W3C WebSocket or SockJS');
                return;
            }

            if ('WebSocket' in window) {
                ws= new WebSocket("<c:url value='ws://192.168.1.61:8082/websck'/>");
            }else if ('MozWebSocket' in window) {
                alert("MozWebSocket");
                ws = new MozWebSocket("ws://websck");
            }else {
                ws = new SockJS("<c:url value='http://192.168.1.61:8082/sockjs/websck'/>");
            }

            ws.onopen = function () {
                alert('open');
                setConnected(true);
                //log('Info: connection opened.');
            };
            ws.onmessage = function (event) {
                alert('Received:' + event.data);
                log('Received: ' + event.data);
               /* if(window.URL){
                    URL = window.URL;
                }
                var uri = URL.createObjectURL(event.data)
                var img = document.createElement("img");
                img.src = uri;
                document.body.appendChild(img);*/
            };
            ws.onclose = function (event) {
                setConnected(false);
                log('Info: connection closed.');
                log(event);
            };
        }

        function disconnect() {
            if (ws != null) {
                ws.close();
                ws = null;
            }
            setConnected(false);
        }

        function echo() {
            if (ws != null) {
                var message = document.getElementById('message').value;
                log('Sent: ' + message);
                ws.send(message);
            } else {
                alert('connection not established, please connect.');
            }
        }

        function updateUrl(urlPath) {
            if (urlPath.indexOf('sockjs') != -1) {
                url = urlPath;
                //document.getElementById('sockJsTransportSelect').style.visibility = 'visible';
            }
            else {
                if (window.location.protocol == 'http:') {
                    url = 'ws://' + window.location.host + urlPath;
                } else {
                    url = 'wss://' + window.location.host + urlPath;
                }
                //document.getElementById('sockJsTransportSelect').style.visibility = 'hidden';
            }
        }

      /*  function updateTransport(transport) {
            alert(transport);
            transports = (transport == 'all') ?  [] : [transport];
        }*/

        function log(message) {
            var console = document.getElementById('console');
            var p = document.createElement('p');
            p.style.wordWrap = 'break-word';
            p.appendChild(document.createTextNode(message));
            console.appendChild(p);
            while (console.childNodes.length > 25) {
                console.removeChild(console.firstChild);
            }
            console.scrollTop = console.scrollHeight;
        }

        $(document).ready(function(){
            updateUrl('/websocket');
            connect();
        });

        $(window).unload(function(){
            disconnect();
        });


    </script>
</head>
<body>
<noscript><h2 style="color: #ff0000">Seems your browser doesn't support Javascript! Websockets
    rely on Javascript being enabled. Please enable
    Javascript and reload this page!</h2></noscript>
<div>
    <div id="connect-container">
       <%-- <input id="radio1" type="radio" name="group1" onclick="updateUrl('/websocket');">
        <label for="radio1">W3C WebSocket</label>
        <br>
        <input id="radio2" type="radio" name="group1" onclick="updateUrl('/sockjs/websocket');">
        <label for="radio2">SockJS</label>
        <div id="sockJsTransportSelect" style="visibility:hidden;">
            <span>SockJS transport:</span>
            <select onchange="updateTransport(this.value)">
                <option value="all">all</option>
                <option value="websocket">websocket</option>
                <option value="xhr-polling">xhr-polling</option>
                <option value="jsonp-polling">jsonp-polling</option>
                <option value="xhr-streaming">xhr-streaming</option>
                <option value="iframe-eventsource">iframe-eventsource</option>
                <option value="iframe-htmlfile">iframe-htmlfile</option>
            </select>
        </div>
        <div>
            <button id="connect" onclick="connect();">Connect</button>
            <button id="disconnect" disabled="disabled" onclick="disconnect();">Disconnect</button>
        </div>--%>
        <div>
            <textarea id="message" style="width: 350px">Here is a message!</textarea>
        </div>
        <div>
            <button id="echo" onclick="echo();" disabled="disabled">Echo message</button>
        </div>
    </div>
    <div id="console-container">
        <div id="console"></div>
    </div>
</div>
</body>

</html>