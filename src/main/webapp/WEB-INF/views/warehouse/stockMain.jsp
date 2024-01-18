<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="../include/header.jsp"%>

<!-- 본문 시작  -->
	<div class="col-12">
		<div class="card my-4 mx-4">
			<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
				<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex align-items-center">
					<h3 class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">창고 재고 현황</h3>
					<form action="/warehouse/stockMain" id="search-form" class="ms-md-auto bg-white rounded p-1 mb-0 d-flex align-items-center">
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
			
			<div class="card-body px-0 pb-2">
				<div class="table-responsive p-0 min-vh-65">
					<form role="form" method="post" class="w-sm-auto">
					<input type="hidden" id="searchword-forSubmit" name="searchword">
					<input type="hidden" id="filter-forSubmit" name="filter">
						<div class="dropdown text-end me-6">
							<button class="btn btn-outline-secondary dropdown-toggle mb-0 w-8 fs-7 py-1" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
								<span id="dropdown-selected">${empty param.filter ? "전체" : param.filter }</span>
							</button>
							<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton" >
								<li><a class="dropdown-item">전체</a></li>
								<li><a class="dropdown-item">완제품</a></li>
								<li><a class="dropdown-item">자재</a></li>
							</ul>
						</div>
					<table class="table align-items-center mb-0 ">
						<thead>
						<tr>
							<th class="text-uppercase text-secondary text-xs font-weight-bolder opacity-7 ">
								<input type="checkbox" id="cbx_chkAll">
							</th>
							<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">품목코드</th>
							<th class="text-center text-secondary text-xs font-weight-bolder opacity-7 px-1">창고번호</th>
							<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">구분</th>
							<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">품목이름</th>
							<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">재고수량</th>
							<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">단위</th>
							<th class="text-center text-uppercase text-secondary text-xs font-weight-bolder opacity-7">유통기한</th>
						</tr>
					</thead>
	 				<tbody id="employeeTableBody">
						<c:forEach var="vo" items="${stockList}">
							<tr class="memList">
								<td class="text-uppercase text-secondary text-xxs font-weight-bold opacity-7" style="padding: 0.75rem 1.5rem;">
									<input type="checkbox" name="chk" value="${vo.identify_code}">
								</td>
								<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.product_code}</span>
                   				</td>
                   				<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.warehouse_no}</span>
                   				</td>
                   				<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.category}</span>
                   				</td>
                   				<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.product_name}</span>
                   				</td>
                   				<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.quantity}</span>
                   				</td>
                   				<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.product_unit}</span>
                   				</td>
                   				<td class="text-center">
                   					<span class="text-secondary text-sm font-weight-bold">${vo.expiry_date}</span>
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
					<div class="col-sm-5 mb-3">
						<ul class="pagination">
							<c:if test="${pageVO.prev }">
								<li class="page-link link-container"><a href="/warehouse/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&searchword=${searchword}" class="link"></a></li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
								<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
									<a href="/warehouse/${listUrl }?page=${i }&searchword=${searchword}" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
								</li>				
							</c:forEach>
							<c:if test="${pageVO.next }">
								<li class="page-link link-container"><a href="/warehouse/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&searchword=${searchword}" class="link">>></a></li>
							</c:if>
						</ul>
					</div>
					<div class="col-2 text-end ">
		                <button type="button" id="deleteBtn" class="btn bg-gradient-dark py-2 me-5" >창고 재고 삭제</button>
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
 	 	
		// 삭제 버튼 클릭시, 창고 번호를 사용해서 삭제 처리
		$("#deleteBtn").click(function(){
			var chkboxes = $("input[name='chk']:checked");
			
			 if (chkboxes.length === 0) {
		            swal({
		                title: "삭제할 재고를 선택해주세요",
		                icon: "warning",
		                buttons:{
		                    confirm: true
		                }
		            });
		            return;
		        }
			
			swal({
				  title: "정말 삭제하시겠습니까?",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true
				})
				.then((willDelete) => {
				  if (willDelete) {
					swal("삭제 완료", {icon: "success"}).then(function(){
						$("#closebtn").click();
						formObj.attr("action","/warehouse/stockMain");
						formObj.submit();
					});							
				  }
			});	
		});
 	 	
 	 	$(".input-group").click(function(){
			$(this).addClass("focused is-focused");
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