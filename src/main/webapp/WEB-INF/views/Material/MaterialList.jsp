<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
<!-- 본문 시작 -->

<!-- Search and Add Section -->
<div class="col-12">
	<div class="card my-4 mx-4">
		<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2">
			<div
				class="bg-gradient-primary shadow-primary border-radius-lg pt-4 pb-4 pe-3 d-flex">
				<h3
					class="text-white text-capitalize ps-5 align-items-center mt-2 py-1">원자재
					정보 관리</h3>
				<div
					class="ms-md-auto bg-white rounded p-2 d-flex align-items-center">
					<div class="align-items-center d-flex flex-column mx-1">

						<div class="input-group input-group-outline">
							<label class="form-label">검색어</label> <input type="text"
								id="searchword" name="searchword" class="form-control"
								value="${param.searchword }"> <input type="hidden"
								id="filter" name="filter" value="${param.filter }">
						</div>


					</div>
					<div class="align-items-center d-flex flex-column py-1">
						<button id="searchbtn"
							class="btn btn-outline-primary btn-sm mb-0 py-1 ms-2">검색</button>
					</div>

				</div>

			</div>
		</div>
		<!-- Materials Table -->
		<div class="card-body px-0 pb-2">
			<div class="table-responsive p-0 min-vh-65">
				<table class="table align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-center text-secondary font-weight-bolder col-1">번호</th>
							<th class="text-center text-secondary font-weight-bolder col-1">자재ID</th>
							<th class="text-center text-secondary font-weight-bolder col-1">자재코드</th>
							<th class="text-center text-secondary font-weight-bolder col-1">자재이름</th>
							<th class="text-center text-secondary font-weight-bolder col-1">자재종류</th>
							<th class="text-center text-secondary font-weight-bolder col-1">수량</th>
							<th class="text-center text-secondary font-weight-bolder col-1">창고번호</th>
							<th class="text-center text-secondary font-weight-bolder col-1">관리자</th>
							<th class="text-center text-secondary font-weight-bolder col-1">확인 날짜</th>
						</tr>
					</thead>
					<tbody id="materialList">
						<tr>
							<td class="align-middle text-center">${index + 1}</td>
							<td class="align-middle text-center">${materialList.material_num}</td>
							<td class="align-middle text-center">${materialList.product_code}</td>
							<td class="align-middle text-center">${materialList.product_name}</td>
							<td class="align-middle text-center">${materialList.product_category_detail}</td>
							<td class="align-middle text-center">${materialList.quantity}</td>
							<td class="align-middle text-center">${materialList.warehouse_no}</td>
							<td class="align-middle text-center">${materialList.employee_no}</td>
							<td class="align-middle text-center">${materialList.material_checkDate }</td>
							<!-- 수정, 삭제 기능 추가 -->
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-sm-5">
				<div class="ms-6">Showing ${pageVO.startPage } to
					${pageVO.endPage } </div>
			</div>
			<div class="col-sm-5 mb-3">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="page-link link-container"><a
							href="/Material/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&searchword=${searchword}"
							class="link"><<</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }"
						end="${pageVO.endPage }" step="1">
						<li
							${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"}>
							<a
							href="/Material/${listUrl }?page=${i }&searchword=${searchword}"
							${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
						</li>
					</c:forEach>
					<c:if test="${pageVO.next }">
						<li class="page-link link-container"><a
							href="/Material/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&searchword=${searchword}"
							class="link">>></a></li>
					</c:if>
				</ul>
			</div>
			<div class="col-sm-2">
				<a href="/Material/MaterialOrderList"
					class="btn bg-gradient-dark mt-3">발주서 작성하기</a>
			</div>
		</div>
	</div>
</div>



<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>
<script>
	$(document).ready(function() {
		loadMaterials();

		if ($("#searchword").val()) {
			$(".input-group").addClass("focused is-focused");
		}

		$(".input-group").click(function() {
			$(this).addClass("focused is-focused");
		});
	});

	$("#searchbtn").click(function() {
		var value = $("#searchword").val();
		location.href = '/Material/searchlist?searchword=' + value; // 경로 수정
	});

	$(window).click(function(event) {

		if (!$(event.target).closest('.input-group').length) {
			if (!$("#searchword").val()) {
				$(".input-group").removeClass("focused is-focused");
			}
		}
	});

	// 자재 목록을 로드하는 기능을 구현합니다.
	function loadMaterials() {
		// AJAX 요청을 사용하여 서버에서 자재 목록을 가져옴
		$
				.ajax({
					url : '/Material/api/materials',
					type : 'GET',
					dataType : 'json',
					success : function(materials) {
						var materialList = $('#materialList');
						materialList.empty(); // 목록 초기화
						materials
								.forEach(function(material, index) {
									var row = '<tr>'
											+ '<td class="align-middle text-center">'
											+ (index + 1)
											+ '</td>'
											+ '<td class="align-middle text-center">'
											+ material.material_num
											+ '</td>'
											+ // 여기서 materialList를 material로 바꿈
											'<td class="align-middle text-center">'
											+ material.product_code
											+ '</td>'
											+ // 이하 동일
											'<td class="align-middle text-center">'
											+ material.product_name
											+ '</td>'
											+ '<td class="align-middle text-center">'
											+ material.product_category_detail
											+ '</td>'
											+ '<td class="align-middle text-center">'
											+ material.material_quantity
											+ '</td>'
											+ '<td class="align-middle text-center">'
											+ material.warehouse_no
											+ '</td>'
											+ '<td class="align-middle text-center">'
											+ material.employee_no
											+ '</td>'
											+ '<td class="align-middle text-center">'
											+ (material.material_checkDate ? material.material_checkDate
													: '') + '</td>' + '</tr>';

									materialList.append(row); // 생성한 로우를 tbody에 추가합니다.
								});

					},
					error : function(error) {
						// 오류 처리
						console.error("자재 목록을 불러오는 데 실패했습니다:", error);
						// 적절한 사용자 피드백을 제공합니다.
					}
				});
	}

	// 자재 검색 기능을 구현합니다.
	function searchMaterials() {
		var searchField = $('#searchField').val(); // 검색 필드에서 값을 가져옵니다.

		// AJAX 요청을 사용하여 서버에서 필터링된 자재 목록을 가져옵니다.
		$
				.ajax({
					url : '/Material/api/materials/search', // 필터링된 자재 목록을 제공하는 서버의 API 엔드포인트
					type : 'GET',
					data : {
						'query' : searchField
					}, // 검색 필드를 쿼리 파라미터로 전달합니다.
					dataType : 'json',
					success : function(materials) {
						var materialList = $('#materialList');
						materialList.empty(); // 기존 목록을 초기화합니다.

						materials
								.forEach(function(material, index) {
									var row = '<tr>'
											+ '<th scope="row" class="text-center">'
											+ (index + 1)
											+ '</th>'
											+ '<td>'
											+ material.material_num
											+ '</td>'
											+ // 여기서 materialList를 material로 바꿈
											'<td>'
											+ material.product_code
											+ '</td>'
											+ // 이하 동일
											'<td>'
											+ material.product_name
											+ '</td>'
											+ '<td>'
											+ material.product_category_detail
											+ '</td>'
											+ '<td>'
											+ material.material_quantity
											+ '</td>'
											+ '<td>'
											+ material.warehouse_no
											+ '</td>'
											+ '<td>'
											+ material.employee_no
											+ '</td>'
											+ '<td>'
											+ (material.material_checkDate ? material.material_checkDate
													: '') + '</td>' + '</tr>';

									materialList.append(row); // 생성한 로우를 tbody에 추가합니다.
								});

					},
					error : function(error) {
						// 오류 처리
						console.error("자재 검색을 불러오는 데 실패했습니다:", error);
						// 적절한 사용자 피드백을 제공합니다.
					}
				});
	}
</script>