<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>

	<div class="col-12">
		<div class="card my-4">		
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">				
				<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pe-3 d-flex">			
					<h6 class="text-white text-capitalize pt-3 ps-3">거래처 검색</h6>					
					<form action="" class="ms-md-auto bg-white rounded p-2 d-flex align-items-center">
						<div class="align-items-center d-flex flex-column">					
							<div class="input-group input-group-outline">
           						<input type="text" class="form-control" id="query" name="query" value="${param.query }" placeholder="거래처명을 입력하세요">							
							</div>						
						</div>						
						<div class="align-items-center d-flex flex-column py-1">
							<input type="submit" value="검색" class="btn btn-outline-primary btn-sm mb-0 py-1 ms-2">						
						</div>											
					</form>							
				</div>				
			</div>			
			<div class="card-body px-0 pb-2">			
				<div class="table-responsive">
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">거래처</th>
								<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">번호</th>
								<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7">주소</th>
								<th class="text-center text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${companyVOList }">
								<tr>			
									<td>
										<input type="hidden" name="company_name_${vo.company_no }" value="${vo.company_name }"/>
										<input type="hidden" name="photo_paths_${vo.company_no }" value="${vo.photo_paths }"/>
										<div class="d-flex px-2 py-1">
											<div>
												<img src="${vo.photo_paths }" class="avatar avatar-sm me-3" alt="">
											</div>
											<div class="d-flex flex-column justify-content-center">
												<h6 class="mb-0 text-sm">${vo.company_name }</h6>
											</div>
										</div>
									</td>
									<td class="align-middle text-center">
										<input type="hidden" name="company_tel_${vo.company_no }" value="${vo.company_tel }"/>
										<div class="d-flex align-items-center justify-content-center">
											<h6 class="mb-0 text-sm">${vo.company_tel }</h6>
										</div>
									</td>
									<td class="align-middle text-center">
										<input type="hidden" name="company_address_${vo.company_no }" value="(${vo.company_zip_code }) ${vo.company_address } ${vo.company_address_detail }"/>
										<div class="d-flex align-items-center justify-content-center">
											<h6 class="mb-0 text-sm">(${vo.company_zip_code }) ${vo.company_address } ${vo.company_address_detail }</h6>
										</div>
									</td>
									<td class="align-middle text-center text-md">
										<button id="selectCompany" class="btn btn-primary btn-sm mb-0 py-1 ms-2" onclick="selectCompany(${vo.company_no})">선택</button>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
			<!-- 페이징 처리 -->			
			<div class="row">
				<div class="col-sm-5">
					<div class="ms-6">${pageVO.startPage } / ${pageVO.endPage }</div>
				</div>
				<div class="col-sm-5 mb-3">
					<ul class="pagination">
						<c:if test="${pageVO.prev }">
							<li class="page-link link-container"><a href="/orders/${pageUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&query=${query}" class="link"><<</a></li>
						</c:if>
						<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
							<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
								<a href="/orders/${pageUrl }?page=${i }&query=${query}" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
							</li>				
						</c:forEach>
						<c:if test="${pageVO.next }">
							<li class="page-link link-container"><a href="/orders/${pageUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&query=${query} class="link">>></a></li>
						</c:if>
					</ul>
				</div>
			</div>			
		</div>
	</div>

<%@ include file="../include/footer.jsp"%>

<script>

    function selectCompany(company_no) {
    	
        $.ajax({
            url: "/orders/companySelect", 
            type: "POST",
            data: { 
            	"company_no": company_no,  
            },
            success: function(data) {
            	swal({
					title: "거래처가 선택되었습니다.",
					text: "거래처: " + data.company_name,
					icon: "success",
					buttons: "선택",
				}).then(function(){
	                window.opener.updateCompanyInfo(data);
	                window.close();			 
  				})		
            	
            },
            error: function(error) {
            	swal({
					title: "상품이 선택에 실패했습니다.",
					text: "상품: " + data.product_name,
					icon: "error",
					buttons: "실패",
   				})
            }
        });
    }
    
    $(document).ready(function() {
    	
    	if($("#query").val()) {
			$(".input-group").addClass("focused is-focused");
		}
			
		if (!$(event.target).closest('.input-group').length) {
			if (!$("#query").val()) {
	       		$(".input-group").removeClass("focused is-focused");
			} else {
				$(".input-group").addClass("focused is-focused");
			}
	    }
		
   	});	

</script>

