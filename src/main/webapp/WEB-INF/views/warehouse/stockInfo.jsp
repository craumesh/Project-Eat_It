<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>

<!-- 본문 시작  -->
	<div class="col-12">
		<div class="card my-4 mx-4">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 ">
				<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex align-items-center">
					<h3 class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">창고 입출고 관리</h3>
					<form action="/warehouse/stockInfo" id="search-form" class="ms-md-auto bg-white rounded p-1 mb-0 d-flex align-items-center">
					<div class="align-items-center d-flex flex-column mx-1">	
						<div class="input-group input-group-outline">
							<label class="form-label">검색어</label>
							<input type="text" id="searchword" name="searchword" class="form-control" value="${param.searchword }">
							<input type="hidden" id="filter" name="filter" value="${param.filter }">
						</div>
					</div>					
					<div class="align-items-center d-flex flex-column py-1 ct-example">
						<button type="button" id="searchbtn" class="btn btn-outline-primary mb-0 py-2 mx-1">검색</button>
					</div>
				</form>
				</div>
			</div>
			<div class="card-body px-0 pb-2 z-index-1">
				<div class="table-responsive p-0 min-vh-65">
					<form role="form" method="post" class="w-sm-auto">
					<input type="hidden" id="searchword-forSubmit" name="searchword">
					<input type="hidden" id="filter-forSubmit" name="filter">
					<input type="hidden" id="page-forSubmit" name="page" value="${empty page ? 1 : page }">
					<table class="table align-items-center mb-0 ">
						<thead>
							<tr>
								<th class="text-uppercase text-secondary text-xs font-weight-bolder opacity-7 ">
									<input type="checkbox" id="cbx_chkAll">
								</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">식별코드</th>
								<th class="text-center text-secondary text-xs font-weight-bolder opacity-7 px-1">창고번호</th>
								<th class="text-center text-secondary text-xs font-weight-bolder opacity-7">입출고 구분</th>
								<th class="text-center text-secondary text-xs font-weight-bolder opacity-7 ">카테고리</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">품목이름</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">입출고 수량</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">단위</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">가격(만원)</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">유통기한</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">입출고 요청일</th>
								<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7 px-1">처리상태</th>
								<th class="text-center font-weight-bolder col-1 px-1">
									<div class="dropdown">
										<button class="btn btn-outline-secondary dropdown-toggle mb-0 fs-7 w-70 py-1" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
											<span id="dropdown-selected">${empty param.filter ? "전체" : param.filter }</span>
										</button>
										<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
											<li><a class="dropdown-item">전체</a></li>
											<li><a class="dropdown-item">대기중</a></li>
											<li><a class="dropdown-item">승인</a></li>
											<li><a class="dropdown-item">취소</a></li>
											<li><a class="dropdown-item">입고</a></li>
											<li><a class="dropdown-item">출고</a></li>
											<li><a class="dropdown-item">자재</a></li>
											<li><a class="dropdown-item">완제품</a></li>
										</ul>
									</div>
								</th>
							</tr>
						</thead>
						
						<tbody>
							<c:forEach var="stockInfoList" items="${stockInfoList}">
								<tr>
									<td class="text-uppercase text-secondary text-xxs font-weight-bold opacity-7" style="padding: 0.75rem 1.5rem;">
										<input type="checkbox" name="chk" value="${stockInfoList.identify_code}">
									</td>
									<td class="text-center">
                      					<span class="text-secondary text-sm font-weight-bold">${stockInfoList.identify_code}</span>
                     				</td>
									<td class="text-center px-1">
                      					<span class="text-secondary text-sm font-weight-bold">${stockInfoList.warehouse_no}</span>
			                        </td>
									<td class="text-center">
                      					<span class="text-secondary text-sm font-weight-bold">${stockInfoList.io_classification}</span>
			                        </td>
									<td class="text-center">
				                        <span class="text-secondary text-sm font-weight-bold">${stockInfoList.category}</span>
                      				</td>
									<td class="text-center">
										<span class="text-secondary text-sm font-weight-bold">${stockInfoList.name}</span>
									</td>
									<td class="text-center text-sm">
			                        	<span class="text-secondary text-sm font-weight-bold">${stockInfoList.io_quantities}</span>
			                      	</td>
									<td class="text-center text-sm">
			                        	<span class="text-secondary text-sm font-weight-bold">${stockInfoList.unit}</span>
			                      	</td>
									<td class="text-center text-sm">
			                        	<span class="text-secondary text-sm font-weight-bold">${stockInfoList.price}</span>
			                      	</td>
									<td class="text-center text-sm">
			                        	<span class="text-secondary text-sm font-weight-bold">${stockInfoList.expiry_date}</span>
			                      	</td>
									<td class="text-center text-sm">
			                        	<span class="text-secondary text-sm font-weight-bold">${stockInfoList.io_date}</span>
			                      	</td>
									<td class="text-center text-sm">
			                        	<span id="status" class="badge badge-sm bg-gradient-success">${stockInfoList.status}</span>
			                      	</td>
									<td class="text-center text-sm px-1">
			                        	<button type="button" class="btn bg-gradient-dark mb-0 py-0 allowBtn" >승인</button>
			                      	</td>
								</tr>
							</c:forEach>
						</tbody>	
					</table>
					<input type="hidden" name="identify_code" id="identify_code_for_submit">
					</form>
				</div>
				<div class="row">
					<div class="col-sm-5">
						<div class="ms-6">Showing ${pageVO.startPage } to ${pageVO.endPage } </div>
					</div>
					<div class="col-sm-6 mb-3">
						<ul class="pagination">
							<c:if test="${pageVO.prev }">
								<li class="page-link link-container"><a href="/warehouse/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&searchword=${searchword}" class="link"></a></li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
								<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
									<a href="/warehouse/${listUrl }?page=${i}&searchword=${searchword}" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
								</li>				
							</c:forEach>
							<c:if test="${pageVO.next }">
								<li class="page-link link-container"><a href="/warehouse/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&searchword=${searchword}" class="link">>></a></li>
							</c:if>
						</ul>
					</div>
					<div class="col-sm-1 text-end ">
		                <button type="button" id="cancelBtn" class="btn bg-gradient-dark py-2 me-3" >취소</button>
		            </div>
				</div>
			</div>
		</div>
	</div>
<!--본문 종료  -->
<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
		// 필요한 변수 저장
		var formObj = $("form[role='form']");
		
	 	if (!$(".dropdown-menu").hasClass("show")) {
	      dropItemReposition();
	  	}
	 	
 	 	$("#dropdownMenuButton").click(function(){
	 	      dropItemReposition();
 	   	});
 	 	
		// 체크박스 전체선택 기능
		$("#cbx_chkAll").click(function() {
			if ($("#cbx_chkAll").is(":checked")) $("input[name=chk]").prop("checked", true);
			else $("input[name=chk]").prop("checked", false);
		});
		
		// 승인 버튼 클릭시, 식별코드를 사용해서 승인 처리
		 $(".allowBtn").click(function(){
		       var row = $(this).closest("tr");
		       var identifyCode = row.find("input[name='chk']").val();
		       var statusVal = row.find("span[id='status']").text();
		
		       if (statusVal === "대기중") {
		           swal({
		               title: "승인하시겠습니까?",
		               icon: "info",
		               buttons: true,
		               dangerMode: true
		           }).then((willApprove) => {
		               if (willApprove) {
		                   swal("승인 완료", {icon: "success"}).then(function(){
		                       $("#closebtn").click();
		                       if('${param.searchword}'!=""){
									$("#searchword-forSubmit").val('${param.searchword}');
								}		
								$("#filter-forSubmit").val($("#dropdown-selected").text());	
		                       formObj.find("#identify_code_for_submit").val(identifyCode);
		                       formObj.attr("action", "/warehouse/stockInfo");
		                       formObj.submit();
		                   });
		               }
		           });
		       } else {
		           swal({
		               title: "이미 처리된 요청사항입니다",
		               icon: "error",
		               buttons: {
		                   confirm: true
		               }
		           });
		       }
		   });
		
		// 삭제 버튼 클릭시, 창고 번호를 사용해서 삭제 처리
		$("#cancelBtn").click(function(){
		    var chkboxes = $("input[name='chk']:checked");
		    var statusVal = chkboxes.closest("tr").find("span[id='status']").text();
		    
		    if (chkboxes.length === 0) {
		        swal({
		            title: "처리할 사항을 선택해주세요",
		            icon: "warning",
		            buttons: {
		                confirm: true
		            }
		        });
		        return;
		    }
		
		    if (statusVal.trim() !== "대기중" && (statusVal.includes("취소") || statusVal.includes("승인"))) {
		        swal({
		            title: "대기중인 항목만 취소할 수 있습니다",
		            icon: "warning",
		            buttons: {
		                confirm: true
		            }
		        });
		        return;
		    }
		
		    swal({
		        title: "승인 취소하시겠습니까?",
		        icon: "warning",
		        buttons: true,
		        dangerMode: true
		    })
		    .then((willDelete) => {
		        if (willDelete) {
		            swal("승인 취소 완료", {icon: "success"}).then(function(){
		                $("#closebtn").click();
		                var formObj = $("form[role='form']");
		                formObj.attr("action", "/warehouse/cancelStockInfo");
		                formObj.submit();
		            });
		        }
		    });
		});
		
		// 상태 변경
		$('table tr').each(function() {
	        var statusText = $(this).find('#status').text().trim().toLowerCase();
//	        console.log("span: " + statusText);
	        switch(statusText){
	        case "승인": $(this).find('#status').addClass("bg-gradient-success"); break;
	        case "대기중": $(this).find('#status').addClass("bg-gradient-info"); break;
	        case "취소": $(this).find('#status').addClass("bg-gradient-danger"); break;
	        }
	    });
		
		$("#searchbtn").click(function(){
			$("#search-form").submit();
		});	
		
		$(".dropdown-item").click(function(){
			$("#dropdown-selected").text($(this).text());
			$("#filter").val($("#dropdown-selected").text());
			$("#search-form").submit();
		});
		 
	});

function dropItemReposition(){
   if (!$(".dropdown-menu").hasClass("show")) {
      $(".dropdown-menu").css('inset', '0 0 auto auto');
   }
}
</script>
<script src="/resources/js/plugins/warehouseMain.js"></script>
</html>