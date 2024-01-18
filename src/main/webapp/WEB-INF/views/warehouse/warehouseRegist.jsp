<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%-- <%@ include file="../include/header.jsp"%> --%>
<%@ include file="../include/js.jsp"%>
<head>
<meta charset="UTF-8">
 <link rel="icon" type="image/png" href="${path}/resources/img/logo.png">
  <link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
  <link href="/resources/css/nucleo-icons.css" rel="stylesheet" />
  <link href="/resources/css/nucleo-svg.css" rel="stylesheet" />
  <script src="https://kit.fontawesome.com/42d5adcbca.js" crossorigin="anonymous"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons+Round" rel="stylesheet">
  <link id="pagestyle" href="/resources/css/main.css" rel="stylesheet" />
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<body class="g-sidenav-show  bg-gray-200">
<main class="main-content position-relative max-height-vh-100 h-100 border-radius-lg ">
<div class="card my-4">
	<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
		<div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
			<h6 class="text-white text-capitalize ps-3">창고 등록</h6>
		</div>
	</div>	
	<div class="card-body px-0 pb-2">
		<div class="card-body">
			<!-- 폼테그 시작  -->
			<form role="form" method="post" name="registForm">
			<input type="hidden" name="admin_no" value="${warehouseAdminInfo.employee_no}">
				<!-- 거래처 정보 -->
				<div class="row mb-4">
					<div class="card">
						<div class="card-header pb-0">
							<div class="row">
								<div class="col-lg-6 col-7">
									<h6>관리자 정보</h6>
<%-- 									${warehouseAdminInfo} --%>
								</div>
							</div>
						</div>
						<div class="card-body px-0 pb-2">
							<div class="table-responsive">
								<table class="table align-items-center mb-0">
									<thead>
										<tr>
											<th class="text-uppercase text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-3">관리자 이름</th>
											<th class="text-uppercase text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-3">연락처</th>
											<th class="text-uppercase text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">이메일</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<div class="d-flex px-2 py-1">
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">${warehouseAdminInfo.name}</h6>
													</div>
												</div>
											</td>
											<td>
												<div class="d-flex px-2 py-1">
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">${warehouseAdminInfo.contact}</h6>
													</div>
												</div>
											</td>
											<td class="align-middle">
												<div class="d-flex flex-column justify-content-center">
													<h6 class="mb-0 text-sm">${warehouseAdminInfo.email}</h6>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 창고 정보 -->
				<div class="row mb-4">
					<div class="card">
						<div class="card-header pb-0">
							<div class="row">
								<div class="col-lg-6 col-7">
									<h6>창고정보 입력</h6>
								</div>
							</div>
						</div>
						<div class="card-body px-0 pb-2">
							<div class="table-responsive">
								<table class="table align-items-center mb-0">
									<tbody>
										<tr>
											<td>
												<div class="input-group input-group-dynamic mb-4">
												    <input type="text" name="location_name"
												    class="form-control" placeholder="위치명" aria-label="위치명" aria-describedby="basic-addon1">
												</div>
											</td>
											<td class="align-middle text-start text-sm">
												<div class="input-group input-group-dynamic mb-4">
												    <input type="text" name="warehouse_name"
												    class="form-control" placeholder="창고명" aria-label="창고명" aria-describedby="basic-addon1">
												</div>
											</td>
											<td class="align-middle text-center">
												<div class="input-group input-group-dynamic mb-4 ">
													<select class="form-control" name="category" id="choices-button" >
													  <option value="자재" selected>자재</option>
													  <option value="완재품" >완재품</option>
													</select>
												</div>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 비고 -->
				<div class="row mb-4">
					<div class="card">
						<div class="card-header pb-0">
							<div class="row">
								<div class="col-lg-6 col-7">
									<h6>비고</h6>
								</div>
								<div class="input-group input-group-outline mb-3" style="padding-left: 0; padding-right: 0;">
									<textarea class="form-control" rows="7" placeholder="내용을 입력하세요" name="note"></textarea>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<!-- 등록 버튼 -->
				<div class="text-center">
					<button type="button" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0" onclick="registAlert()">등록하기</button>
				</div>
			</form>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>
<script>

function registAlert(){
	
	 // 창고명과 위치명을 유효성 검사
    var warehouseName = document.forms["registForm"]["warehouse_name"].value.trim();
    var locationName = document.forms["registForm"]["location_name"].value.trim();

    if (warehouseName === '' || locationName === '') {
        // SweetAlert 또는 다른 경고 메커니즘을 사용하여 오류 메시지 표시
        swal({
            text: "창고명과 위치명을 입력하세요.",
            icon: "error",
            buttons: false,
            timer: 1500 // 1.5초 동안 오류 메시지를 표시
        });
        return;
    }
	
	swal({
		text: "창고 등록 완료",
		icon: "success",
		buttons: false
	});
	
	
	setTimeout(function() {
	  document.forms["registForm"].submit();
	}, 700);
	
}
</script>
<script src="/resources/js/plugins/warehouseMain.js"></script>