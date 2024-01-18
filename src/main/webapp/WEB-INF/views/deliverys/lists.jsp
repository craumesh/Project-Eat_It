<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>
	<div class="col-12">
		<div class="card my-4 mx-4">		
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">				
				<div class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-4 pe-3 d-flex">			
					<h3 class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">배송 내역</h3>					
					<form action="/deliverys/lists" id="search-form" class="ms-md-auto bg-white rounded p-2 mb-0 d-flex align-items-center">
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
				<div class="text-end pe-4 pb-3">
					<a class="btn bg-gradient-dark mb-0" href="/orders/forms">
						<i class="material-icons text-sm">add</i> 주문서 작성하기
					</a>
				</div>	
				<div class="table-responsive p-0 min-vh-65">
					<table id="order-table" class="table align-items-center mb-0">					
						<thead>
							<tr>
								<th class="text-center text-secondary font-weight-bolder col-1">배송 번호</th>
								<th class="text-center text-secondary font-weight-bolder col-1">제품 정보</th>
								<th class="text-center text-secondary font-weight-bolder col-1">주문 수량</th>
								<th class="text-center text-secondary font-weight-bolder col-1">배송 시작일</th>
								<th class="text-center text-secondary font-weight-bolder col-1">배송 완료일</th>
								<th class="text-center text-secondary font-weight-bolder col-1">작업지시</th>
								<th class="text-center font-weight-bolder col-1">
									<div class="dropdown">
										<button class="btn btn-outline-secondary dropdown-toggle mb-0 fs-6 w-70" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
											<span id="dropdown-selected">${empty param.filter ? "전체" : param.filter }</span>
										</button>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
											<li><a class="dropdown-item">출고준비중</a></li>
											<li><a class="dropdown-item">출고완료</a></li>
											<li><a class="dropdown-item">배송준비중</a></li>
											<li><a class="dropdown-item">배송중</a></li>
											<li><a class="dropdown-item">배송완료</a></li>
										</ul>
									</div>
								</th>
							</tr>
						</thead>					
						<tbody>
							<c:forEach var="vo" items="${deliveryVOList }">				
								<tr>
									<td class="align-middle text-center identify-no modal-act">
                      					<a>
                   							<span class="text-secondary font-weight-bold">${vo.delivery_id }</span>
                      					</a>                  						
                     				</td>
									<td class="modal-act">
				                    	<div class="d-flex px-2 py-1 ms-5">
				                        	<div>
				                            	<img src="..${vo.photo_paths }" class="avatar avatar-sm me-3 border-radius-lg" alt="user1">
				                     		</div>
				                          	<div class="d-flex flex-column justify-content-center">
				                           		<h6 class="mb-0 text-sm">${vo.product_name }</h6>
				                            	<p class="text-xs text-secondary mb-0">
												    <c:set var="totalPrice" value="${vo.price * vo.quantity}" />
												    <fmt:formatNumber value="${totalPrice}" type="currency" currencyCode="KRW" />
												</p>
				                        	</div>
				                    	</div>
			                        </td>
					                <td class="align-middle text-center modal-act">							
										<span class="me-2 text-xs font-weight-bold">${vo.quantity }EA</span>
									</td>          		
									<td class="align-middle text-center modal-act">
										<span class="text-secondary text-xs font-weight-bold">
									    	<fmt:formatDate value="${vo.delivery_start_date}" pattern="yyyy-MM-dd" />
									    </span>
									</td>
									<td class="align-middle text-center modal-act">
										<span class="text-secondary text-xs font-weight-bold">
									    	<fmt:formatDate value="${vo.delivery_end_date}" pattern="yyyy-MM-dd" />
									    </span>
									</td>
									
									<c:choose>
									    <c:when test="${vo.delivery_status eq '출고완료'}">
											<td class="align-middle text-center text-sm">
												<button class="btn bg-gradient-info fs-6 mb-0 py-1 px-3" onclick="openShippingForm(${vo.delivery_id })">배송 시작</button>
											</td>
									    </c:when>
									    <c:when test="${vo.delivery_status eq '배송중'}">
											<td class="align-middle text-center text-sm">
												<button class="btn bg-gradient-info fs-6 mb-0 py-1 px-3" onclick="completeDelivery(${vo.delivery_id })">배송 완료</button>
											</td>
									    </c:when>    
									    <c:otherwise>
									        <td class="align-middle text-center text-xs">	
									        </td>
									    </c:otherwise>
									</c:choose> 	
												
									<td class="align-middle text-center text-xs">
			                        	<span id="status-badge" class="badge badge-sm fs-6 mb-0 py-2 px-3 w-60">${vo.delivery_status }</span>
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
							<li class="page-link link-container"><a href="/deliverys/${pageUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&query=${query}&filter=${filter}" class="link"><<</a></li>
						</c:if>
						<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
							<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
								<a href="/deliverys/${pageUrl }?page=${i }&query=${query}&filter=${filter}" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
							</li>				
						</c:forEach>
						<c:if test="${pageVO.next }">
							<li class="page-link link-container"><a href="/deliverys/${pageUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&query=${query}&filter=${filter}" class="link">>></a></li>
						</c:if>
					</ul>
				</div>
			</div>		
		</div>
	</div>

<%@ include file="../include/footer.jsp"%>

<script>

	$(document).ready(function() {
	
		var modal = document.getElementById("Modal");
		
		if($("#query").val()) {
			$(".input-group").addClass("focused is-focused");
		}
		
		if (!$(".dropdown-menu").hasClass("show")) {
			dropItemReposition();
		}

			$("#dropdownMenuButton").click(function(){
				dropItemReposition();
		});
	
		$("#searchbtn").click(function(){
			var value = $("#query").val();
			location.href = '/deliverys/lists?query=' + value;
		});	
		
		$('table tr').each(function() {
            var statusText = $(this).find('td:last-child #status-badge').text();

            switch(statusText){
	            case "출고준비중": $(this).find('td:last-child #status-badge').addClass("bg-gradient-primary"); break;
	            case "출고완료": $(this).find('td:last-child #status-badge').addClass("bg-gradient-warning"); break;
	            case "배송준비중": $(this).find('td:last-child #status-badge').addClass("bg-gradient-warning"); break;
	            case "배송중": $(this).find('td:last-child #status-badge').addClass("bg-gradient-warning"); break;
	            case "배송완료": $(this).find('td:last-child #status-badge').addClass("bg-gradient-success"); break;
            }
        });
		
		$("#order-table").on("click", "tr td.modal-act", function(event) {
			
		    var value = $(this).closest("tr").find("td.identify-no").text();
			
	        $.ajax({
	            url: '/orders/detail?order_id=' + value,
				method : 'GET',
				dataType: 'json',
				success : function(data) {
					console.log(data);
					$('#photo_paths').attr('src', data.photo_paths).attr('width', '100');
					$("#order_id").text(data.order_id);
					$("#product_name").text(data.product_name);
				    $("#quantity").text(data.quantity);
				    $("#member_name").text(data.name);
				    $("#company_name").text(data.company_name);
				    $("#company_tel").text(data.company_tel);
				    $("#company_address").text(data.company_address + ", " + data.company_address_detail);
				    $("#comments").text(data.comments);
				    $("#due_date").text(data.due_date);
				    modal.style.display = "block";
				},
				error : function(error) {
					console.log('실패:', error);
				}
			});
		        
	    });
		
		$("#closebtn").click(function(){
			modal.style.display = "none";
		});
		
		$("#closebtn").click(function(){
			var value = $("#query").val();
			modal.style.display = "none";
		});
		
		$(window).click(function(event){
			if (event.target == modal) {
				modal.style.display = "none";
			}
			
			if (!$(event.target).closest('.input-group').length) {
				if (!$("#query").val()) {
		       		$(".input-group").removeClass("focused is-focused");
				}
		    }
		});		
		
		$(".input-group").click(function(){
			$(this).addClass("focused is-focused");
		});
		
		$("#depart_name-select").on("change", function() {			
			updatePositionNameSelect();
		});	
		
		$(".dropdown-item").click(function(){
			$("#dropdown-selected").text($(this).text());
			$("#filter").val($("#dropdown-selected").text());
			$("#search-form").submit();
		});
				
	});
	
	var result = "${result}";
	
	if(result == "CREATEOK"){
		swal({
			title: "주문이 정상적으로 처리되었습니다.",
			icon: "success",
			buttons: "확인",
			});
	}
		
    function dropItemReposition(){
   		if (!$(".dropdown-menu").hasClass("show")) {
 	      $(".dropdown-menu").css('inset', '0 0 auto auto');
 	   	}
   	}
    
	// 배송 요청 페이지
    function openShippingForm(delivery_id) {
    	var newWindow = window.open('/deliverys/ships?delivery_id=' + delivery_id, '_blank', 'width=800,height=600');
    }
	
	// 배송완료 처리
    function completeDelivery(delivery_id) {
		
    	// 현재 시간을 얻어오기 위한 함수
        function getCurrentDateTime() {
            var now = new Date();
            return now.toLocaleString();
        }
    	
        $.ajax({
            url: "/deliverys/success", 
            type: "POST",
            data: { 
            	"delivery_id": delivery_id,  
            },
            success: function(data) {
            	var currentDateTime = getCurrentDateTime();
            	swal({
					title: "배송이 완료되었습니다.",
					text: "배송 완료: " + currentDateTime,
					icon: "success",
				}).then(function(){
					 window.location.reload();		 
  				})		
            	
            },
            error: function(error) {
            	swal({
					title: " ",
					text: " ",
					icon: "error",
					buttons: "실패",
   				})
            }
        });
    }
</script>