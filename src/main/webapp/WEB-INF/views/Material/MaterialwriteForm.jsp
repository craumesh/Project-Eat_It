<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%-- <%@ include file="../include/header.jsp"%> --%>
<%@ include file="../include/js.jsp"%>
<head>
<meta charset="UTF-8">
<link rel="icon" type="image/png" href="${path}/resources/img/logo.png">
<link rel="stylesheet" type="text/css"
	href="https://fonts.googleapis.com/css?family=Roboto:300,400,500,700,900|Roboto+Slab:400,700" />
<link href="/resources/css/nucleo-icons.css" rel="stylesheet" />
<link href="/resources/css/nucleo-svg.css" rel="stylesheet" />
<script src="https://kit.fontawesome.com/42d5adcbca.js"
	crossorigin="anonymous"></script>
<link
	href="https://fonts.googleapis.com/icon?family=Material+Icons+Round"
	rel="stylesheet">
<link id="pagestyle" href="/resources/css/main.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
</head>
<div class="card my-4">
	<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
		<div
			class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-4">
			<h3
				class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">원자재
				발주 신청서</h3>
		</div>
	</div>
	<div class="card-body">
		<!-- 폼테그 시작  -->
		<form name="registForm" method="POST">
			<!-- 거래처 정보 -->
			<div class="row mb-4">
				<div class="card">
					<div class="card-header pb-0">
						<div class="row">
							<div class="col-lg-6 col-7">
								<h6>거래처</h6>
							</div>
							<div class="col-lg-6 col-5 my-auto text-end">
								<div class="dropdown float-lg-end pe-4">
									<button class="btn btn-dark border-radius-lg p-2 mt-n4 mt-md-0"
										type="button" onclick="openSearchCompany()">
										<i class="material-icons p-2">search</i>
									</button>
								</div>
							</div>
						</div>
					</div>
					<div class="card-body px-0 pb-2">
						<div class="table-responsive">

							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th class="text-start text-secondary font-weight-bolder col-1">거래처</th>
										<th
											class="text-center text-secondary font-weight-bolder col-1">주소</th>
									</tr>
								</thead>
								<tbody>
									<tr>

										<td><input type="hidden" id="company_no"
											name="company_no" value="${companyVO.company_no }">
											<div class="d-flex px-2 py-1">
												<div>
													<img src="" id="companyImg" class="avatar avatar-sm me-3"
														alt="">
												</div>
												<div class="d-flex flex-column justify-content-center">
													<h6 class="mb-0 text-sm" id="company_name">거래처를 선택하세요.</h6>
													<p class="text-xs text-secondary mb-0" id="companyTel"></p>
												</div>
											</div></td>
										<td class="text-center">
											<h6 class="text-sm font-weight-bold pt-3" id="companyAddress"></h6>
										</td>
									</tr>
								</tbody>
							</table>

						</div>
					</div>
				</div>
			</div>
			<!-- 자재 정보 -->
			<div class="row mb-4">
				<div class="card">
					<div class="card-header pb-0">
						<div class="row">
							<div class="col-lg-6 col-7">
								<h6>주문자재</h6>
							</div>
						</div>
					</div>
					<div class="card-body px-0 pb-2">
						<div class="table-responsive">
							<table class="table align-items-center mb-0">
								<thead>
									<tr>
										<th class="text-start text-secondary font-weight-bolder col-1">발주자사번</th>
										<th class="text-start text-secondary font-weight-bolder col-1">자재</th>
										<th class="text-start text-secondary font-weight-bolder col-1">수량</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<td>
											<div class="input-group input-group-dynamic mb-4">
												<input type="text" name="employee_no" class="form-control"
													placeholder="발주자사번" aria-label="발주자사번"
													aria-describedby="basic-addon1">
											</div>
										</td>
										<td>
											<div class="input-group input-group-dynamic mb-4">
												<input type="text" name="product_no" class="form-control"
													placeholder="자재 코드" aria-label="자재 코드"
													aria-describedby="basic-addon1">
											</div>
										</td>
										<td>
											<div class="input-group input-group-dynamic mb-4">
												<input type="text" name="quantity" class="form-control"
													placeholder="수량" aria-label="수량"
													aria-describedby="basic-addon1">
											</div>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
			<div class="text-center">
				<button type="button"
					class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0"
					onclick="registAlert()">신청하기</button>
			</div>
		</form>
	</div>
</div>


<%@ include file="../include/footer.jsp"%>

<script>
	//거래처 검색창 
	function openSearchCompany() {
		window.open('/orders/companys', '_blank', 'width=600,height=680');
	}

	//거래처 변경
	function updateCompanyInfo(data) {

		var address = "(" + data.company_zip_code + ") " + data.company_address
				+ " " + data.company_address_detail;

		$("#company_no").val(data.company_no);
		$("#company_name").html(data.company_name);
		$("#companyImg").html(data.photo_paths);
		$("#companyTel").html(data.company_tel);
		$("#companyAddress").html(address);
	}

	function registAlert() {
		swal({
			text : "발주 등록 완료",
			icon : "success",
			buttons : false
		});

		setTimeout(function() {
			document.forms["registForm"].submit();
		}, 700);

	}
</script>