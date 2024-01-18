<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
<!-- 본문 시작 -->

<!-- Search and Add Section -->
<div class="col-11 mx-auto">
	<div class="card my-3 mx-auto pt-5 px-6 pb-2">
		<div class="card-header p-0 position-relative mx-3 z-index-2">

			<div
				class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">
				<h3
					class="text-white text-capitalize ps-5 align-items-center mb-0 py-1">원자재
					입/출고 관리</h3>
				<div
					class="ms-md-auto bg-white rounded p-2 d-flex align-items-center">
					<div class="align-items-center d-flex flex-column">
						<div class="input-group input-group-outline">
							<label class="form-label">검색어를 입력하세요</label> <input type="text"
								id="searchword" name="searchword" class="form-control"
								value="${param.searchword }">
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
		<div class="my-3 p-3 bg-white rounded shadow-sm">
			<h6 class="border-bottom border-gray pb-2 mb-0">입/출고 목록</h6>
			<div class="table-responsive">
				<table class="table table-bordered table-hover">
					<thead>
						<tr>
							<th scope="col" class="text-center">자재 입/출고 기록 번호</th>
							<th scope="col" class="text-center">자재 입/출고 기록 일자</th>
							<th scope="col" class="text-center">품목정보번호</th>
							<th scope="col" class="text-center">창고번호</th>
							<th scope="col" class="text-center">유통 기한</th>
							<th scope="col" class="text-center">자재 입/출고 수량</th>
							<th scope="col" class="text-center">입/출고</th>
						</tr>
					</thead>
					<tbody id="materialadd">
						<c:forEach var="materialaddList" items="${materialaddList}">
							<tr>
								<td class="text-center">${materialaddList.materialadd_no}</td>
								<td class="text-center">${materialaddList.materialadd_date}</td>
								<td class="text-center">${materialaddList.product_no}</td>
								<td class="text-center">${materialaddList.warehouse_no}</td>
								<td class="text-center">${materialaddList.expiry_date}</td>
								<td class="text-center">${materialaddList.quantity}</td>
								<td class="text-center">${materialaddList.status}</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>

				<div class="row">
					<div class="col-sm-5">
						<div class="ms-6">${pageVO.startPage }/ ${pageVO.endPage }
							of page</div>
					</div>
					<div class="col-sm-5 mb-3">
						<ul class="pagination">
							<c:if test="${pageVO.prev }">
								<li class="page-link link-container"><a
									href="/Material/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&filter=${filter}&searchword=${searchword}"
									class="link"><<</a></li>
							</c:if>
							<c:forEach var="i" begin="${pageVO.startPage }"
								end="${pageVO.endPage }" step="1">
								<li
									${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"}>
									<a
									href="/Material/${listUrl }?page=${i }&filter=${filter}&searchword=${searchword}"
									${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
								</li>
							</c:forEach>
							<c:if test="${pageVO.next }">
								<li class="page-link link-container"><a
									href="/Material/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&filter=${filter}&searchword=${searchword}"
									class="link">>></a></li>
							</c:if>
						</ul>
					</div>
					<div class="col-sm-2">
						<a onclick="popup();" class="btn bg-gradient-dark mt-3">입/출고
							등록</a>
					</div>
				</div>
			</div>
		</div>

	</div>
</div>

<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>

<script>
	$(document).ready(function() {
		loadmaterialadds();

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

	function loadmaterialadds() {
		$
				.ajax({
					url : '/Material/api/getmaterialaddList',
					method : 'GET',
					dataType : 'json',
					success : function(materialadds) {
						var materialaddList = $('#materialaddList'); // 해당 ID가 실제로 존재하는지 확인
						materialaddList.empty();

						//	if (materialadd && materialadd.length > 0) { // 데이터가 존재하고 배열이면 실행
						materialadds
								.forEach(function(materialadd, index) {

									var row = '<tr>'

											+ '<td>'
											+ materialaddList.materialadd_no
											+ '</td>'
											+ '<td>'
											+ (materialaddList.materialadd_date ? materialaddList.materialadd_date
													: '')
											+ '</td>'
											+ '<td>'
											+ materialaddList.product_no
											+ '</td>'
											+ '<td>'
											+ materialaddList.warehouse_no
											+ '</td>'
											+ '<td>'
											+ (materialaddList.expiry_date ? materialaddList.expiry_date
													: '') + '</td>' + '<td>'
											+ materialaddList.quantity
											+ '</td>' + '<td>'
											+ materialaddList.status + '</td>'
											+ '</tr>';

									materialaddList.append(row); // 생성한 로우를 tbody에 추가합니다.
								});

						//	} else {
						// 데이터가 없거나 유효하지 않을 때의 처리 로직
						//		console.error("No data or invalid data was returned");
						//	}

					},
					error : function(xhr, status, error) {
						console.error("입고목록을 불러오는 데 실패했습니다");
						console.error("오류 상태: " + status); // 오류 상태를 출력합니다. 예: 404, 500 등
						console.error("오류 내용: " + xhr.responseText); // 오류의 세부 내용을 출력합니다. 서버 응답이 포함될 수 있습니다.
						console.error("상세 오류: " + error); // JavaScript 오류 메시지를 출력합니다.
					}

				});
	}

	function popup() {
		const width = 900;
		const height = 900;
		// const left = 500;
		// const top = 500;

		// 현재 창의 중앙 좌표 계산
		//	const left = (window.innerWidth - width) / 2
		//			+ window.screenLeft;
		//				const top = (window.innerHeight - height) / 2
		//		+ window.screenTop;

		console.log(`width=${width}`);
		console.log(width);
		// 팝업 창 열기
		window.open("/Material/Material", "popup",
				" width = 900px, height = 900px, left = 900px, top = 900px ");
	}
</script>