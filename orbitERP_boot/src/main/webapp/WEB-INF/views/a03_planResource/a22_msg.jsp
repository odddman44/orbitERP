<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
    <script src="https://cdn.jsdelivr.net/npm/sockjs-client/dist/sockjs.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/stompjs/lib/stomp.min.js"></script>
    <script type="text/javascript">
        var socket = new SockJS('/ws');
        var stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/greetings', function(greeting){
                //console.log(greeting);
                console.log(greeting.body);
                console.log(JSON.parse(greeting.body).content);
                var obj = JSON.parse(greeting.body);
                var curName = document.getElementById('curName').value;
                if(curName==obj.name)
                	document.querySelector("#show").innerHTML += obj.name+":"+obj.msg+"<br>"
                //document.querySelector("#show").innerHTML = JSON.parse(greeting.body).content+"<br>"

            });
        });
        /*
      @MessageMapping("/hello")
    @SendTo("/topic/greetings")      
        */

        function sendName() {
        	
            var name = document.getElementById('name').value;
            var msg = document.getElementById('msg').value;
            document.querySelector("#show").innerHTML += "나:"+msg+"<br>"
            stompClient.send("/app/hello", {}, JSON.stringify({'name': name, 'msg':msg}));
        }
    </script>   
       
</head>
<body>
 	현재사람:<input id="curName" /><br>
 	받을사람:<input id="name" /><br>
 	메시지:<input id="msg" /><br>
 	<button type="button" onclick="sendName()">전송</button><br>
 	<div id="show"></div>

</body>
</html>