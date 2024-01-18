<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>

<div class="card my-4">
	<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
		<div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-4">
			<h3 class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">발주 신청서</h3>
		</div>
	</div>	
	<div class="card-body px-0 pb-2">
		<div class="text-end pe-4 pb-3">
			<a class="btn bg-gradient-dark mb-0" href="/orders/lists">
				<i class="material-icons text-sm">more_horiz</i> 목록으로
			</a>
		</div>
		<div class="card-body">
			<!-- 폼테그 시작  -->
			<form role="form" method="post" name="fr" onsubmit="return check()">
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
										<button class="btn btn-dark border-radius-lg p-2 mt-n4 mt-md-0" type="button" onclick="openSearchCompany()">
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
											<th class="text-start text-secondary font-weight-bolder col-1">담당자</th>
											<th class="text-start text-secondary font-weight-bolder col-1">회사 정보</th>
											<th class="text-center text-secondary font-weight-bolder col-1">주소</th>
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
											<td>											
												<input type="hidden" id="company_no" name="company_no" value="">												
												<div class="d-flex px-2 py-1">
													<div>
														<img src="" id="companyImg" class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm" id="company_name">거래처를 선택하세요.</h6>
														<p class="text-xs text-secondary mb-0" id="companyTel"></p>
													</div>
												</div>
											</td>
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
											<th class="text-start text-secondary font-weight-bolder col-1">제품</th>
											<th class="text-start text-secondary font-weight-bolder col-1">수량</th>
											<th class="text-center text-secondary font-weight-bolder col-1">금액</th>
										</tr>
									</thead>	
									<tbody>
										<tr>
											<td class="align-items-center">
												<input type="hidden" id="product_no" name="product_no" value="">
												<div class="d-flex px-2 py-1 ms-15">
													<div>
														<img src="../resources/img/memberimg.png" id="prdImagePath"  class="avatar avatar-sm me-3" alt="">
													</div>
													<div class="d-flex flex-column justify-content-center">
														<h6 class="mb-0 text-sm" id="prdName">상품을 선택하세요.</h6>
														<p id="prdPrice" class="text-xs text-secondary mb-0"></p>
													</div>
												</div>
											</td>
											<td class="align-middle text-center text-sm">
												<div class="input-group input-group-outline">
													<input type="number" id="orderQuantity" name="quantity" class="form-control d-flex" placeholder="수량을 입력하세요" readonly="readonly">
												</div>
											</td>
											<td class="align-middle text-center">
												<h6 class="text-sm font-weight-bold pt-3" id="outputTotalPrice">₩0</h6>
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
								<div class="input-group input-group-static my-3 is-filled">
									<input type="date" name="due_date" class="form-control" onfocus="focused(this)" onfocusout="defocused(this)" data-gtm-form-interact-field-id="2">
								</div>								
								<div class="col-lg-6 col-7">
									<h6>요청사항</h6>
								</div>
								<div class="input-group input-group-outline mb-3">
									<textarea class="form-control" rows="7" placeholder="요청사항을 입력하세요" name="comments"></textarea>
								</div>	
							</div>
						</div>
					</div>
				</div>
				<!-- 버튼 -->
				<div class="text-center">
					<button type="submit" class="btn btn-lg bg-gradient-primary btn-lg w-100 mt-4 mb-0">신청하기</button>
				</div>
			</form>
		</div>
	</div>
</div>

<%@ include file="../include/footer.jsp"%>

<script>

	// 거래처 검색창 
    function openSearchCompany() {
        window.open('/orders/companys', '_blank', 'width=690,height=680');
    }

    // 상품 검색창
    function openSearchProduct() {
        window.open('/orders/products', '_blank', 'width=690,height=710');
    }
    
    // 거래처 변경
    function updateCompanyInfo(data) {

    	var address = "(" + data.company_zip_code + ") " + data.company_address + " " + data.company_address_detail;

        $("#company_no").val(data.company_no);
        $("#company_name").html(data.company_name);
        $("#companyImg").html(data.photo_paths);
        $("#companyTel").html(data.company_tel);
        $("#companyAddress").html(address);
    }
    
    function selectProduct(data) {
    	
    	var formattedPrice = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(data.price);
    	
    	$("#product_no").val(data.product_no);
        $("#prdName").html(data.product_name);
        $("#prdPrice").html(formattedPrice);   
        $("#prdImagePath").attr("src", ".." + data.photo_paths);      
    }
    
    $(document).ready(function(){
    	
	    $("#orderQuantity").on('input', function(e){

	        var quantity = $(this).val();

            if (quantity < 0) {
            	swal({
    				title: "1개 이상 주문이 가능합니다.",
    				text: "음수는 입력할 수 없습니다.",
    				icon: "error",
    				buttons: "실패",
    			})
                $(this).val(0);
            }else {
                var price = parseFloat($("#prdPrice").text().replace(/[^0-9.-]+/g, ""));
                var formattedTotalPrice = new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(price * quantity);

            	$("#outputTotalPrice").html(formattedTotalPrice);
            } 
	    
	    });
	
    });
    
    // 유효성 검사
    function check() {
    	
    	var company_no = document.fr.company_no.value;
    	var product_no = document.fr.product_no.value;
    	var quantity = document.fr.quantity.value;
    	var due_date = document.fr.due_date.value;
    	var inputDate = new Date(due_date);
    	var today = new Date();
		today.setHours(0, 0, 0, 0);
		var nextMonth = new Date();
		nextMonth.setMonth(nextMonth.getMonth() + 1);
    	
    	if(company_no == "") {
    		swal({
				title: "거래처가 선택되지 않았습니다.",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				openSearchCompany();				                
			})
    		return false;
    	}
    	
    	if(product_no == "") {
    		swal({
				title: "상품이 선택되지 않았습니다.",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				openSearchProduct();				                
			})
    		return false;
    	}
    	
    	if(quantity == "") {
    		swal({
				title: "수량이 입력되지 않았습니다.",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				document.fr.quantity.focus();                
			})
    		return false;
    	}else if(quantity < 0) {
    		swal({
				title: "1개 이상 주문이 가능합니다.",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				document.fr.quantity.focus();                
			})
    		return false;
    	}
    	
    	if(due_date == "") {
    		swal({
				title: "희망 납기일이 선택되지 않았습니다.",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				document.fr.due_date.focus();                				                
			})
    		return false;
    	}else if(inputDate < today) {
    		swal({
				title: "희망 납기일이 잘못 입력되었습니다.",
				text: "과거 날짜는 입력할 수 없습니다!",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				document.fr.due_date.focus();                
			})
    		return false;
    	}else if(inputDate > nextMonth) {
    		swal({
				title: "희망 납기일이 잘못 입력되었습니다.",
				text: "금일부터 한 달 동안만 신청이 가능합니다.",
				icon: "error",
				buttons: "실패",
			}).then(function(){
				document.fr.due_date.focus();                
			})
    		return false;
    	}
    	
    }

</script>