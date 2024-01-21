<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/img/logo.png">
<title>로그인</title>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
<link href="${pageContext.request.contextPath }/resources/css/nucleo-icons.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/nucleo-svg.css" rel="stylesheet" />
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link id="pagestyle" href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<body class="bg-gray-200">
  <main class="main-content  mt-0">
    <div class="page-header align-items-start min-vh-100" style="background-image: url('https://images.unsplash.com/photo-1497294815431-9365093b7331?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1950&q=80');">
      <span class="mask bg-gradient-dark opacity-6"></span>
      <div class="container my-auto">
        <div class="row">
          <div class="col-lg-4 col-md-8 col-12 mx-auto">
            <div class="card z-index-0 fadeIn3 fadeInBottom">
              <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
                <div class="bg-gradient-dark shadow-primary border-radius-lg py-3 pe-1">
                  	<h4 class="text-white font-weight-bolder text-center mt-2 mb-0"><a class="text-white" href="../"><img src="../resources/img/asideLogo.png" class="w-40"></a></h4>
             
                </div>
              </div>
              <div class="card-body">
                <form role="form" class="text-start" method="post" onsubmit="login();">
                  <div class="input-group input-group-outline my-3">
                    <input type="text" class="form-control" id="userId" name="id" placeholder="아이디" value="${savedId }" required>
                  </div>
                  <div class="input-group input-group-outline mb-3">
                    <input type="password" class="form-control" name="pw" placeholder="패스워드" required>
                  </div>
                  <div class="form-check form-switch d-flex align-items-center mb-3">
                    <input class="form-check-input" type="checkbox" id="rememberMe">
                    <label class="form-check-label mb-0 ms-3" for="rememberMe">아이디 정보 기억</label>
                  </div>
                  <div class="text-center">
                    <input type="submit" class="btn bg-gradient-dark w-100 my-4 mb-2" id="loginBtn" value="로 그 인">
                  </div>
                  <p class="mt-4 text-sm text-center">
                   	 회원 신청하시겠습니까?
                    <a href="/members/memberJoin" class="text-primary text-gradient font-weight-bold">회원 등록</a>
                  </p>
                  <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">
                </form>
              </div>
            </div>
          </div>
        </div>
      </div>
      <footer class="footer position-absolute bottom-2 py-2 w-100">
        <div class="container">
          <div class="row align-items-center justify-content-lg-between">
            <div class="col-12 col-md-6 my-auto">
              <div class="copyright text-center text-sm text-white text-lg-start">
                © <script>
                  document.write(new Date().getFullYear())
                </script>,
               	항상 여러분 곁에는
                <a href="${path }/" class="font-weight-bold text-white">EatIt</a>
                <i class="fa fa-heart" aria-hidden="true"></i>
               	이 함께합니다.
              </div>
            </div>
          </div>
        </div>
      </footer>
    </div>
    <%@ include file="../include/js.jsp" %>
  </main>
 <script>
    document.addEventListener("DOMContentLoaded", function() {
      // 쿠키에서 아이디 값을 가져와서 표시
      const savedId = getCookie("savedId");
      if (savedId) {
        document.getElementById("userId").value = savedId;
        document.getElementById("rememberMe").checked = true;
      }
    });

    function login() {
      // 로그인 시 아이디 저장 여부 확인
      const rememberMe = document.getElementById("rememberMe").checked;
      const userId = document.getElementById("userId").value;

      if (rememberMe) {
        // 쿠키에 아이디 저장 (유효기간: 7일)
        setCookie("savedId", userId, 7);
      } else {
        // 쿠키에서 아이디 삭제
        deleteCookie("savedId");
      }

      // 로그인 처리 등 다른 로직 수행
      // 여기에 실제 로그인 처리 코드를 추가하면 됩니다.
    }

    // 쿠키 설정 함수
    function setCookie(name, value, days) {
      const expires = new Date();
      expires.setTime(expires.getTime() + days * 24 * 60 * 60 * 1000);
      document.cookie = name + "=" + value + ";expires=" + expires.toUTCString() + ";path=/";
    }

    // 쿠키 가져오기 함수
    function getCookie(name) {
      const cookies = document.cookie.split(";");
      for (let i = 0; i < cookies.length; i++) {
        const cookie = cookies[i].trim();
        if (cookie.startsWith(name + "=")) {
          return cookie.substring(name.length + 1);
        }
      }
      return null;
    }

    // 쿠키 삭제 함수
    function deleteCookie(name) {
      document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 UTC;path=/;";
    }
  </script>
  
</body>
</html>