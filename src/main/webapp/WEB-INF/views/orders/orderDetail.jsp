<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>

<script>
    function openSearchProduct() {
        // 새 창을 여는 코드
        window.open('/purchaseOrder/search', '_blank', 'width=800,height=600');
    }
</script>

<div class="card my-4">
	<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
		<div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-3">
			<h6 class="text-white text-capitalize ps-3">발주서</h6>
		</div>
	</div>	
	<div class="card-body px-0 pb-2">	
		<div class="row gx-4 mb-2">	
			<div class="col-auto my-auto">
				<div class="h-100 ps-4">
					<h5 class="mb-1">${purchaseVO.order_id }</h5>
					<p class="mb-0 font-weight-normal text-sm">
						<fmt:formatDate value="${purchaseVO.order_date }" pattern="yyyy-MM-dd HH:mm:ss" var="order_date"/>
						${order_date }
					</p>
				</div>
			</div>
			<div class="col-lg-4 col-md-6 my-sm-auto ms-sm-auto me-sm-0 mx-auto mt-3">			
				<div class="text-end pe-3 pb-3">
					<a class="btn btn-outline-primary mb-0" href="/purchaseOrder/orderList">
						<i class="material-icons text-sm me-2">more_horiz</i> 목록으로
					</a>
					<a class="btn bg-gradient-danger mb-0">
						<i class="material-icons text-sm me-2">delete</i> 삭제하기
					</a>					 
				</div> 	
			</div>
		</div>			
		<div class="card-body">
			<!-- 폼테그 시작  -->
			<form role="form" action="/purchaseOrder/editForm" method="post">
			<input type="hidden" name="order_id" value="${purchaseVO.order_id }">
				<!-- 거래처 정보 -->
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
											<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">회사 정보</th>
											<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">매니저</th>
											<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">주소</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td>
												<div class="d-flex px-2 py-1">
													<div>
														<img src="" class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">거래처 이름 출력란</h6>
														<p class="text-xs text-secondary mb-0">거래처 전화번호 출력란</p>
													</div>
												</div>
											</td>
											<td>
												<div class="d-flex px-2 py-1">
													<div>
														<img src="" class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">신청자 이름 출력란</h6>
														<p class="text-xs text-secondary mb-0">신청자 전화번호 출력란</p>
													</div>
												</div>
											</td>
											<td class="align-middle">
												<div class="progress-wrapper w-75 mx-auto">
													<span class="text-xs font-weight-bold">거래처 주소 출력란</span>
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
									<h6>주문상품</h6>
								</div>
								<div class="col-lg-6 col-5 my-auto text-end">
									<div class="dropdown float-lg-end pe-4">
										<button class="btn btn-dark border-radius-lg p-2 mt-n4 mt-md-0" type="button" onclick="openSearchProduct()">
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
											<th class="text-uppercase text-secondary text-s font-weight-bolder opacity-7 ps-2">
												<div class="form-check form-check-info text-start ps-0">
													<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" data-gtm-form-interact-field-id="0">
												</div>
											</th>
											<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">제품</th>
											<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2">수량</th>
											<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">재고량</th>
											<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">수정/삭제</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="text-uppercase text-secondary text-s font-weight-bolder opacity-7 ps-2">
												<div class="form-check form-check-info text-start ps-0">
													<input class="form-check-input" type="checkbox" value="" id="flexCheckDefault" data-gtm-form-interact-field-id="0">
												</div>
											</td>				
											<td>
												<div class="d-flex px-2 py-1">
													<div>
														<img src="" class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm">제품 이름 출력란</h6>
													</div>
												</div>
											</td>
											<td class="align-middle text-start text-sm">
												<span class="text-xs font-weight-bold">XX개</span>
											</td>
											<td class="align-middle text-center">
												<div class="d-flex align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold">60%</span>
													<div>
														<div class="progress">
															<div class="progress-bar bg-gradient-info" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: 60%;"></div>
														</div>
													</div>
												</div>
											</td>
											<td class="align-middle text-center">
												<a class="btn btn-link text-dark px-3 mb-0" href="./update">
													<i class="material-icons text-sm me-2">edit</i>
													Edit
												</a>
												<a class="btn btn-link text-danger text-gradient px-3 mb-0" href="./delete">
													<i class="material-icons text-sm me-2">delete</i>
													Delete
												</a>
											</td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
				<!-- 고객 요청 사항 -->
				<div class="row mb-4">
					<div class="card">
						<div class="card-header pb-0">
							<div class="row">
								<div class="col-lg-6 col-7">
									<h6>희망 납기일</h6>
								</div>
								<div class="input-group input-group-outline mb-3">
									<input class="form-control" type="date" name="due_date" value="${purchaseVO.due_date }">
								</div>
								<div class="col-lg-6 col-7">
									<h6>요청사항</h6>
								</div>
								<div class="input-group input-group-outline mb-3">
									<textarea class="form-control" rows="7" name="comments">${purchaseVO.comments }</textarea>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="text-center">
					<button type="submit" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0">수정하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<script type="text/javascript">

 	$(document).ready(function(){
 		
 		var form = $('form[role="form"]');

 		$(".bg-gradient-danger").click(function(){
 			form.attr("action","/purchaseOrder/cancelForm");
 			form.submit();
 		});
 			
 	});

</script>

<%@ include file="../include/footer.jsp"%>