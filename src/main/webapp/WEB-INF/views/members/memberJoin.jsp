<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/img/logo.png">
<title>회원 등록</title>
<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
<link href="${pageContext.request.contextPath }/resources/css/nucleo-icons.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath }/resources/css/nucleo-svg.css" rel="stylesheet" />
<script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
<link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
<link id="pagestyle" href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
                  	<h4 class="text-white font-weight-bolder text-center mt-2 mb-0 text-white" style="cursor: default;">회원 등록</h4>
                  <div class="row mt-3">
                    <div class="col-2 text-center ms-auto">
                      <a class="btn btn-link px-3" href="javascript:;">
                        <i class="fa fa-facebook text-white text-lg"></i>
                      </a>
                    </div>
                    <div class="col-2 text-center px-1">
                      <a class="btn btn-link px-3" href="javascript:;">
                        <i class="fa fa-github text-white text-lg"></i>
                      </a>
                    </div>
                    <div class="col-2 text-center me-auto">
                      <a class="btn btn-link px-3" href="javascript:;">
                        <i class="fa fa-google text-white text-lg"></i>
                      </a>
                    </div>
                  </div>
                </div>
              </div>
              <div class="card-body">
                <form role="form" class="text-start" method="post">
                  <div class="input-group input-group-outline my-3">
                    <input type="text" class="form-control" name="id" placeholder="아이디 입력">
                  </div>
                  <div class="input-group input-group-outline mb-3">
                    <input type="password" class="form-control" name="pw" placeholder="패스워드 입력">
                  </div>
                  <div class="input-group input-group-outline mb-3">
                    <input type="text" class="form-control" name="name" placeholder="이름 입력">
                  </div>
                  <div class="input-group input-group-outline mb-3">
                    <input type="email" class="form-control" name="email" placeholder="이메일 입력">
                  </div>
                  <div class="input-group input-group-outline mb-3">
                    <input type="tel" class="form-control" name="contact" pattern="[0-9]{3}-[0-9]{4}-[0-9]{4}" placeholder="휴대전화번호 입력 ex)010-1234-1234" >
                  </div>
                 <div class="input-group input-group-outline mb-3">
                    <input type="text" class="form-control" id="sample5_address" placeholder="주소" name="address" style="border-top-right-radius: 0 !important; border-bottom-right-radius: 0 !important; " readonly>
					<button type="button" class="btn bg-gradient-dark mb-0" onclick="sample5_execDaumPostcode()">주소 검색</button>
                  </div>
                  <div class="text-center">
                    <button type="submit" class="btn bg-gradient-dark w-100 my-4 mb-2">회원 등록하기</button>
                  </div>
                  <p class="mt-4 text-sm text-center">
                   	 홈페이지로 이동하시겠습니까?
                    <a href="/" class="text-primary text-gradient font-weight-bold">EatIt</a>
                  </p>
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
                <a href="../" class="font-weight-bold text-white">EatIt</a>
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
  <!--   Core JS Files   -->
  <script src="${pageContext.request.contextPath }/resources/js/core/popper.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/core/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="${pageContext.request.contextPath }/resources/js/plugins/smooth-scrollbar.min.js"></script>
  <script>
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("sample5_address").value = addr;
            }
        }).open();
    }
</script>
</body>
</html>