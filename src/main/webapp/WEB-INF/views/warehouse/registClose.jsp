<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body>
<script type="text/javascript">
	// 띄우고 싶은 alert 메시지
	var result = "${result}";
	
	// 제어 필요할 시 추가 가능
// 	if(result = "registOK"){
	
// 	}
	
	window.opener.location.reload();
	
	window.close();
	
</script>
</body>
</html>