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
    //이 페이지 내에서 전송 및 보여주기를 모두 하고 있음 그래서 보낸사람이름:야야 가 불가능
        var socket = new SockJS('/ws');
        var stompClient = Stomp.over(socket);

        stompClient.connect({}, function(frame) {
            console.log('Connected: ' + frame);
            stompClient.subscribe('/topic/greetings', function(greeting){
                //console.log(greeting);
                console.log(greeting.body);
                console.log(JSON.parse(greeting.body).content);
                var obj = JSON.parse(greeting.body);
                console.log(obj) //{name: '김길동', msg: '너 이름이 뭐야?'}
                var curName = document.getElementById('curName').value; //내가 보내고자 하는 사람하고
                if(curName==obj.name) //현재 사람하고 이름이 같으면
                	document.querySelector("#show").innerHTML += obj.name+":"+obj.msg+"<br>"
                //document.querySelector("#show").innerHTML = JSON.parse(greeting.body).content+"<br>"

            });
        });
        /*
      @MessageMapping("/hello") //보내는
    @SendTo("/topic/greetings") //메시지
        */

        function sendName() {
        	
            var name = document.getElementById('name').value; // 보낼사람 이름
            var msg = document.getElementById('msg').value; // 보낼 메시지(알림이 도착했습니다. 예정)
            document.querySelector("#show").innerHTML += "나:"+msg+"<br>" //나에게 보여지는 내가 보낸 메시지
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