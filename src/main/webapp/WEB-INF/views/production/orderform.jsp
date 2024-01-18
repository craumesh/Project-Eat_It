<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>
	<div class="col-12">
		<div class="card my-4">		
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">				
				<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">			
					<h3 class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">주문 내역</h3>					
						<div class="align-items-center d-flex flex-column mx-1">	
							<div class="input-group input-group-outline">
								
							</div>
						</div>					
						<div class="align-items-center d-flex flex-column py-1 ct-example">
							
						</div>
			
				</div>				
			</div>			
			<div class="card-body px-0 pb-2">	
				<div class="text-end pe-4 pb-3">
				</div>	
				<div class="table-responsive p-0">
					<table id="order-table" class="table align-items-center mb-0">					
						<thead>
							<tr>
								
								<th class="text-center text-secondary font-weight-bolder col-1">주문 번호</th>
								<th class="text-center text-secondary font-weight-bolder col-1">제품 정보</th>
								<th class="text-center text-secondary font-weight-bolder col-1">재고량</th>
								<th class="text-center text-secondary font-weight-bolder col-1">주문 일자</th>
								<th class="text-center text-secondary font-weight-bolder col-1">거래처 정보</th>
								<th class="text-center text-secondary font-weight-bolder col-1">작업 지시</th>	
							</tr>
						</thead>					
						<tbody>
							<c:forEach var="vo" items="${ordersVOList }">				
								<tr>
                    				<td class="align-middle text-center identify-no modal-act">
                      					<a>
                   							<span class="text-secondary font-weight-bold">${vo.order_id }</span>
                      					</a>                  						
                     				</td>
                     				
								<td class="modal-act">
				                    	<div class="d-flex px-2 py-1 ms-5">
												<input id="productno" type="hidden" value="${vo.product_no }">
				                          	<div class="d-flex flex-column justify-content-center">
				                           		<h6 class="mb-0 text-sm">${vo.product_name }</h6>
				                            	<p class="text-xs text-secondary mb-0">${vo.quantity }EA</p>
				                        	</div>
				                    	</div>
			                        </td>
                      				<c:choose>
							            <c:when test="${(vo.stock_quantity / 500) * 100 >= 50}">
							                <td class="align-middle text-center modal-act" id="progress-bar_${vo.order_id }">
												<div class="d-flex flex-sm-column align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold" id="prdInv_${vo.order_id}">${vo.stock_quantity }EA</span>
													<div>
														<div class="progress">
															<div class="progress-bar bg-gradient-info" id="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${(vo.stock_quantity / 500) * 100};"></div>
														</div>
													</div>
												</div>
											</td>
							            </c:when>
							            <c:when test="${(vo.stock_quantity / 500) * 100 == 0}">
							                <td class="align-middle text-center modal-act" id="progress-bar_${vo.order_id }">
												<div class="d-flex flex-sm-column align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold" id="prdInv_${vo.order_id}">재고 없음</span>
												</div>
											</td>
							            </c:when>
						          	  	<c:otherwise>
							                <td class="align-middle text-center modal-act" id="progress-bar_${vo.order_id }">
												<div class="d-flex flex-sm-column align-items-center justify-content-center">
													<span class="me-2 text-xs font-weight-bold" id="prdInv_${vo.order_id}">${vo.stock_quantity }EA</span>
													<div>
														<div class="progress">
															<div class="progress-bar bg-gradient-warning" id="progress-bar" role="progressbar" aria-valuenow="60" aria-valuemin="0" aria-valuemax="100" style="width: ${(vo.stock_quantity / 500) * 100};"></div>
														</div>
													</div>
												</div>
											</td>
						            	</c:otherwise>
							        </c:choose>	                        		
									<td class="align-middle text-center modal-act">
										<span class="text-secondary text-xs font-weight-bold">
									    	<fmt:formatDate value="${vo.order_date}" pattern="yyyy-MM-dd" />
									    </span>
									</td>
									<td class="align-middle text-center modal-act">
				                        <p class="text-xs font-weight-bold mb-0">${vo.company_name }</p>
				                        <p class="text-xs text-secondary mb-0">${vo.company_tel }</p>
                      				</td>
                      				<c:choose>
								    <c:when test="${vo.quantity < vo.stock_quantity}">
								        <td class="align-middle text-center text-sm">
								            <button class="btn bg-gradient-info fs-6 mb-0 py-1 px-3" onclick="openDeliveryForm('${vo.order_id}')">출고 요청</button>
								        </td>
								    </c:when>
								    <c:otherwise>
								        <td class="align-middle text-center">
								             <span id="status-badge" class="badge badge-sm bg-gradient-warning">생산 요청</span>
								        </td>
								    </c:otherwise>
								</c:choose>
								</tr>
							</c:forEach>
						</tbody>												
					</table>
				</div>
			</div>
			<!-- 페이징 처리 -->			
			<div class="row">
				<div class="col-sm-5">
					
				</div>
				<div class="col-sm-5 mb-3">
					<ul class="pagination">
						<c:if test="${pageVO.prev }">
							<li class="page-link link-container"><a href="/production/${productionUrl }?page=${pageVO.endPage-pageVO.displayPageNum }" class="link"><<</a></li>
						</c:if>
						<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
							<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
								<a href="/production/${productionUrl }?page=${i }" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
							</li>				
						</c:forEach>
						<c:if test="${pageVO.next }">
							<li class="page-link link-container"><a href="/production/${productionUrl }?page=${pageVO.startPage+pageVO.displayPageNum }" class="link">>></a></li>
						</c:if>
					</ul>
				</div>
			</div>		
		</div>
	</div>
	
<!-- 모달 -->
<div id="openmodalRequest" class="modal top-10 position-absolute z-index-4" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog" style="max-width:800">
        <div class="modal-content w-100">
            <div class="modal-header">
                <button id="closebtn" class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5" onclick="closeModal()">X</button>
                <h3 class="modal-title mx-auto">생산 지시</h3>
            </div>
            <div class="modal-body p-5">
                <div id="tableContainer">
                    <form action="/production/production" id="myForm" method="post" class="d-flex">
                        <table class="table align-items-center mb-0">
                            <tbody id="statusTableBody">

                             <tr>
                                 <th class="text-center fs-5"> 주문 번호 : </th>
                                 <td class="fs-5" id="order_id"></td></tr>
                             <tr>
							<th class="text-center fs-5"> 생산 설비 : </th>
							 <td class="fs-5" id=machinelist>
							
							 </td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 제품 :  </th>
							<td class="fs-5" id="product_name"> </td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 수량 :  </th>
							<td class="fs-5" id="quantity">  EA </td>
							</tr>
							
							
							
					</tbody>
						</table>
						
						<table class="table align-items-center mb-0">
							<tbody id="tdadd">
							<tr>
							<th class="text-center fs-5" colspan="2"> 레시피  </th>
							</tr>
							
							
							</tbody>
						</table>
						
                    </form>
                </div>
                        <div class="text-center">
                            <button class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" onclick="registerEquipment()">생산지시</button>
                            <button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" onclick="closeWindow()">취소</button>
                        </div>
            </div>
        </div>
    </div>
</div>
	
<%@ include file="../include/footer.jsp"%>

<script>


		$("#order-table").on("click", "tr td.modal-act", function(event) {
		    var orderId = $(this).closest("tr").find("td.identify-no span").text();
		    var productno = $(this).closest("tr").find("#productno").val();
		
		    $.ajax({
		    	url: '/production/getorderform?order_id=' + orderId + '&product_no=' + productno,
		        method: 'GET',
		        dataType: 'json',
		        success: function(data) {

		        	
		        	var newSelect = $("<select>").attr("name", "machine_code").addClass("w-100 text-center");
		        	addOptionsToSelect(newSelect, data.machine);
		        	
		        	
		        	$("#machinelist").append(newSelect);	
		            $("#order_id").text(data.Detail.order_id);
		            $("#product_name").text(data.Detail.product_name);
		            $("#quantity").text(data.Detail.quantity);
		            $("#recipe").text(data.recipe);
		            $("#openmodalRequest").modal('show');
					
		            var $tdadd = $("#tdadd");
		            
		            if (data.recipe !== '미등록') {      
		                var recipe = JSON.parse(data.recipe)[data.Detail.product_no];
		                
		                  for (var key in recipe) {
		                   var value = recipe[key]*data.Detail.quantity;
		                   $tdadd.append("<tr><td class='text-center fs-5'>" + key + "</td><td class='text-center fs-5'>" + value + "</td></tr>");

		                }                 
		             }
		            
		            
		        },
		        error: function(error) {
		            console.log('에러:', error);
		        }
		    });
		});
		
		function closeModal() {
		    $("#openmodalRequest").modal('hide');
		}
		
		function closeWindow() {
		    closeModal();
		    location.reload();
		}
		
		function addOptionsToSelect(selectElement, optionsArray) {
		       optionsArray.forEach(function(optionValue) {
		           var newOption = $("<option>");
		           

		           newOption.text(optionValue.machine_name+"_"+optionValue.machine_code).appendTo(selectElement);
		       });
		   }
		    
		
		
		
</script>


