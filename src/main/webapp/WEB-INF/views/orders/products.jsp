<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>

	<div class="col-12">
		<div class="card my-4">		
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">				
				<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">			
					<h5 class="text-white text-capitalize pt-4 ps-4">상품 검색</h5>					
					<form action="/orders/products" id="search-form" class="ms-md-auto bg-white rounded p-2 mb-0 d-flex align-items-center">
						<div class="align-items-center d-flex flex-column mx-1">	
							<div class="input-group input-group-outline">
								<label class="form-label">검색어</label>
								<input type="text" id="query" name="query" class="form-control" value="${param.query }">
								<input type="hidden" id="filter" name="filter" value="${param.filter }">
							</div>
						</div>					
						<div class="align-items-center d-flex flex-column py-1 ct-example">
							<button type="button" id="searchbtn" class="btn btn-outline-primary mb-0 py-2 mx-1 fs-6">검색</button>
						</div>
					</form>						
				</div>				
			</div>			
			<div class="card-body px-0 pb-2">			
				<div class="table-responsive">
					<table class="table align-items-center mb-0">
						<thead>
							<tr>
								<th class="text-center font-weight-bolder col-1">
									<div class="dropdown">
										<button class="btn btn-outline-secondary dropdown-toggle mb-0 fs-6 w-80" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
											<span id="dropdown-selected">${empty param.filter ? "전체" : param.filter }</span>
										</button>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
											<li><a class="dropdown-item">케이크</a></li>
											<li><a class="dropdown-item">쿠키</a></li>
										</ul>
									</div>
								</th>								
								<th class="text-center text-secondary font-weight-bolder col-1">제품</th>
								<th class="text-center text-secondary font-weight-bolder col-1">재고량</th>
								<th class="text-center text-secondary font-weight-bolder col-1"></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="vo" items="${productVOList }">
								<tr>
									<td class="align-middle text-center">
										<div class="d-flex align-items-center justify-content-center">
											<h6 class="mb-0 text-sm">${vo.category_detail }</h6>
										</div>
									</td>
									<td>
										<div class="d-flex px-2 py-1 ms-4 ps-4">
				                        	<div>
				                            	<img src="${vo.photo_paths }" class="avatar avatar-sm me-3 border-radius-lg" alt="user1">
				                     		</div>
				                          	<div class="d-flex flex-column justify-content-center">
				                           		<h6 class="mb-0 text-sm">${vo.product_name }</h6>
				                        	</div>
				                    	</div>
									</td>		
									<c:choose>
							            <c:when test="${(vo.stock_quantity / 500) * 100 >= 50}">
							                <td class="align-middle text-center modal-act">
												<div class="d-flex flex-sm-column align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold">${vo.stock_quantity }EA</span>
													<div>
														<div class="progress">
															<div class="progress-bar bg-gradient-info" id="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${(vo.stock_quantity / 500) * 100};"></div>
														</div>
													</div>
												</div>
											</td>
							            </c:when>
							            <c:when test="${(vo.stock_quantity / 500) * 100 == 0}">
							                <td class="align-middle text-center modal-act">
												<div class="d-flex flex-sm-column align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold">재고 없음</span>
												</div>
											</td>
							            </c:when>
						          	  	<c:otherwise>
							                <td class="align-middle text-center modal-act">
												<div class="d-flex flex-sm-column align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold">${vo.stock_quantity }EA</span>
													<div>
														<div class="progress">
															<div class="progress-bar bg-gradient-warning" id="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${(vo.stock_quantity / 500) * 100};"></div>
														</div>
													</div>
												</div>
											</td>
						            	</c:otherwise>
							        </c:choose>	       										
									<td class="align-middle text-center text-md">
										<button id="addCart" class="btn btn-primary btn-sm mb-0 py-1 ms-2" onclick="addToCart(${vo.product_no})">선택</button>
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
							<li class="page-link link-container"><a href="/orders/${pageUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&query=${query}&filter=${filter}" class="link"><<</a></li>
						</c:if>
						<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
							<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
								<a href="/orders/${pageUrl }?page=${i }&query=${query}&filter=${filter}" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
							</li>				
						</c:forEach>
						<c:if test="${pageVO.next }">
							<li class="page-link link-container"><a href="/orders/${pageUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&query=${query}&filter=${filter}" class="link">>></a></li>
						</c:if>
					</ul>
				</div>
			</div>		
		</div>
	</div>

<%@ include file="../include/footer.jsp"%>

<script>

    function addToCart(product_no) {

        // AJAX를 사용하여 서버에 데이터 전송
        $.ajax({
            url: "/orders/productSelect",
            type: "POST",
            data: {
            	product_no: product_no,
            },
            success: function (data) {
            	swal({
					title: "상품이 선택되었습니다.",
					text: "상품: " + data.product_name,
					icon: "success",
					buttons: "선택",
   				}).then(function(){
   					var parentWindow = window.opener;
   	                var quantityInput = parentWindow.document.querySelector('input[name="quantity"]');
   	                if (quantityInput) {
   	                    quantityInput.removeAttribute('readonly');
   	                }

   	                parentWindow.selectProduct(data);
   	                window.close();  
   				})	
            },
            error: function () {
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
    	
    	$(window).click(function(event){
    		
			if (!$(event.target).closest('.input-group').length) {				
				if (!$("#query").val()) {
		       		$(".input-group").removeClass("focused is-focused");
				} else {
					$(".input-group").addClass("focused is-focused");
				}
		    }
		});	
    	
    	$(".input-group").click(function(){
			$(this).addClass("focused is-focused");
		});
    	
    	$(".dropdown-item").click(function(){
			$("#dropdown-selected").text($(this).text());
			$("#filter").val($("#dropdown-selected").text());
			$("#search-form").submit();
		});
    	  	
    });

</script>

