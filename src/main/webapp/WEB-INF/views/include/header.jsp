<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<head>
<meta charset="UTF-8">
 <link rel="icon" type="image/png" href="${pageContext.request.contextPath }/resources/img/logo.png">
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <link href="${pageContext.request.contextPath }/resources/css/nucleo-icons.css" rel="stylesheet" />
  <link href="${pageContext.request.contextPath }/resources/css/nucleo-svg.css" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <link id="pagestyle" href="${pageContext.request.contextPath }/resources/css/main.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<!-- Navbar -->
<body class="g-sidenav-show  bg-gray-200">
<%@ include file="../include/aside.jsp" %>
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
<nav class="navbar navbar-main navbar-expand-lg px-0 mx-4 shadow-none border-radius-xl" id="navbarBlur" data-scroll="true">
	<div class="container-fluid py-1 px-3">
	  <nav aria-label="breadcrumb">
		<img src="../resources/img/headerLogo.png" class="font-weight-bolder mb-0 w-30">
	  </nav>
	  <ul class="navbar-nav justify-content-end">
		<li class="dropdown pe-2 d-flex align-items-center position-relative">
			<c:choose>
				<c:when test="${empty sessionScope.id}">
				  <a href="../members/memberLogin" class="nav-link text-body font-weight-bold px-0">
					<i class="fa fa-user me-sm-1"></i>
					<span class="d-sm-inline d-none">로그인</span>
				  </a>
			  </c:when>
			  <c:otherwise>
				  <a href="javascript:;" class="nav-link text-body p-0" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
					<img class="img-profile rounded-circle" src="${sessionScope.photo }" style="position: relative; top: -3px; border: solid 1px black;">
					<span class="d-sm-inline d-none" style="font-size: 20px; margin-left: 10px;">${sessionScope.depart_name}부서 ${sessionScope.name }</span>
				  </a>
				  <ul class="dropdown-menu dropdown-menu-end px-2 py-3 me-sm-n4" aria-labelledby="dropdownMenuButton">
					<li class="mb-2">
					  <a class="dropdown-item border-radius-md" id="profileBtn">
						<div class="d-flex py-1">
						  <div class="d-flex flex-column justify-content-center">
							<h6 class="text-sm font-weight-normal mb-1">
							  <span class="font-weight-bold">내 정보</span>
							</h6>
						  </div>
						</div>
					  </a>
					</li>
					<li class="mb-2">
					  <a class="dropdown-item border-radius-md" href="../members/memberLogout">
						<div class="d-flex py-1">
						  <div class="d-flex flex-column justify-content-center">
							<h6 class="text-sm font-weight-normal mb-1">
							  <span class="font-weight-bold">로그아웃</span>
							</h6>
						  </div>
						</div>
					  </a>
					</li>
				  </ul>
			  </c:otherwise>
			</c:choose>
		</li>
	  </ul>
	</div>
  </nav>
  <div id="InfoModal" class="modal top-5 position-absolute">
	<div class="modal-dialog max-width-800 my-0">
		<div class="modal-content w-100">
			<div class="modal-header">
				<button id="infoClosebtn" class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5">X</button>
				<h3 class="modal-title mx-auto">사원 정보</h3>
			</div>
			<div class="modal-body p-5">
				<div class="user-container d-flex align-items-center">
					<img class="img-thumbnail mb-4 me-4 max-width-200 w-30" alt="회원사진" id="info_photo_paths">
					<div class="user-info d-flex w-100">
						<table class="table">
							<tr>
								<th class="fs-5">사번</th>
								<td class="fs-5" id="info_employee_no"></td>
							</tr>
							<tr>
								<th class="fs-5">이름</th>
								<td class="fs-5" id="info_name"></td>
							</tr>
							<tr>
								<th class="fs-5">아이디</th>
								<td class="fs-5" id="info_id"></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="tableContainer" class="modal-body">
					<table id="infoView-table" class="table">
						<tr>
							<th class="fs-5">부서</th>
							<td class="fs-5" id="info_depart_name"></td>
						</tr>
						<tr>
							<th class="fs-5">직책</th>
							<td class="fs-5" id="info_position_name"></td>
						</tr>
						<tr>
							<th class="fs-5">이메일</th>
							<td class="fs-5" id="info_email"></td>
						</tr>
						<tr>
							<th class="fs-5">내선번호</th>
							<td class="fs-5" id="info_extension_no"></td>
						</tr>
						<tr>
							<th class="fs-5">연락처</th>
							<td class="fs-5" id="info_contact"></td>
						</tr>
						<tr>
							<th class="fs-5">주소</th>
							<td class="fs-5" id="info_address"></td>
						</tr>
						<tr>
							<th class="fs-5">재직상태</th>
							<td class="fs-5" id="info_status"></td>
						</tr>
					</table>
					
					<form action="/members/profile" id="infoEdit-form" method="post">
						<input type="hidden" name="employee_no" id="infoEmployee_no-forSubmit">
						<input type="hidden" name="prev-url" id="infoPrev-url-forSubmit">
						<table id="infoEdit-table" class="d-none table">
					    	<tr>
								<th class="fs-5">부서</th>
								<td class="fs-6">
									<select name="depart_name" id="info_depart_name-select">
										<option value="미정">미정</option>
										<option value="관리">관리</option>
										<option value="생산">생산</option>
										<option value="영업">영업</option>
										<option value="총괄">총괄</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="fs-5">직책</th>
								<td class="fs-6">
									<select name="position_name" id="info_position_name-select"></select>
								</td>
							</tr>
							<tr>
								<th class="fs-6">이메일</th>
								<td class="input-group input-group-dynamic">
									<input type="email" class="form-control fs-4 h-100" name="email" id="info_email-input" required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">내선번호</th>
								<td class="input-group input-group-dynamic">
									<input type="tel" name="extension_no" class="fs-5 p-0 form-control" id="info_extension_no-input" required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">연락처</th>
								<td class="input-group input-group-dynamic" >
									<input type="tel" name="contact" class="fs-5 p-0 form-control" id="info_contact-input" required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">주소</th>
								<td class="input-group input-group-dynamic fs-5">
									<input type="text" class="p-0 form-control" id="info_address-input" placeholder="주소" name="address" style="border-top-right-radius: 0 !important; border-bottom-right-radius: 0 !important; " readonly>
									<button type="button" class="btn bg-gradient-dark mb-0" style="height:40px !important;" onclick="sample5_execDaumPostcode()">검색</button>
								</td>
							</tr>
							<tr>
								<th class="fs-5">재직상태</th>
								<td class="fs-6">
									<select name="status" id="info_status-select">
										<option value="재직">재직</option>
										<option value="휴가">휴가</option>
										<option value="휴직">휴직</option>
										<option value="퇴직">퇴직</option>
									</select>
								</td>
							</tr>
					  	</table>
				  	</form>
				</div>
				<div class="text-center">
					<button id="infoEditbtn" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3">정보 수정</button>
				</div>
			</div>
		</div>
	</div>
</div>