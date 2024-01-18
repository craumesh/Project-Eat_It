<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>

<div class="card my-4">
	<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
		<div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-4">
			<h3 class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">배송 신청서</h3>
		</div>
	</div>	
	<div class="card-body px-0 pb-2">
		<div class="card-body">
			<!-- 폼테그 시작  -->
			<form role="form" method="post" name="fr">
				<!-- 거래처 정보 -->
				<div class="row mb-4">
					<div class="card">
						<div class="card-header pb-0">
							<div class="row">
								<div class="col-lg-6 col-7">
									<h6>직원 정보</h6>
								</div>
							</div>
						</div>
						<div class="card-body px-0 pb-2">
							<div class="table-responsive">
								<table class="table align-items-center mb-0">
									<thead>
										<tr>
											<th class="text-start text-secondary font-weight-bolder col-1">승인 담당자</th>
										</tr>
									</thead>
									<tbody>	
										<tr>
											<td>
												<input type="hidden" name="employee_no" value="${memberVO.employee_no }">
												<div class="d-flex px-2 py-1">
													<div>
														<img src="${memberVO.photo_paths }" class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">${memberVO.name }</h6>
														<p class="text-xs text-secondary mb-0">${memberVO.contact }</p>
													</div>
												</div>
											</td>																												
										</tr>
									</tbody>									
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 상품 정보 -->
				<div class="row mb-4">
					<div class="card">
						<div class="card-header pb-0">
							<div class="row">
								<div class="col-lg-6 col-7">
									<h6>거래처</h6>
								</div>
							
							</div>
						</div>
						<div class="card-body px-0 pb-2">
							<div class="table-responsive">
								<table class="table align-items-center mb-0">
									<thead>
										<tr>
											<th class="text-start text-secondary font-weight-bolder col-1">거래처명</th>
											<th class="text-center text-secondary font-weight-bolder col-1">주소</th>
											<th class="text-center text-secondary font-weight-bolder col-1">요청사항</th>
										</tr>
									</thead>	
									<tbody>
										<tr>
											<td class="align-items-center">
												<div class="d-flex px-2 py-1">
													<div>
														<img src="" id="companyImg" class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm" id="company_name">${deliveryVO.company_name }</h6>
														<p class="text-xs text-secondary mb-0" id="companyTel">${deliveryVO.company_tel }</p>
													</div>
												</div>
											</td>
											<td class="text-center">
												<h6 class="text-sm font-weight-bold pt-3" id="companyAddress">(${deliveryVO.company_zip_code }) ${deliveryVO.company_address }, ${deliveryVO.company_address_detail } </h6>
											</td>	
											<td class="align-middle text-center">
												<h6 class="text-sm font-weight-bold pt-3" id="outputTotalPrice">${deliveryVO.comments }</h6>
											</td>
										</tr>
									</tbody>						
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="text-center">
					<button type="button" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0" onclick="registAlert()">신청하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>

<script>

	function registAlert(){
		swal({
			text: "배송 시작",
			icon: "success",
			buttons: false
		});
		
		
		setTimeout(function() {
		  document.forms["fr"].submit();
		}, 700);
		
	}
	
</script>