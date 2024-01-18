<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
<!-- 본문 시작 -->
<div class="col-12">
	<div class="card my-4 mx-4">
		<div class="card-header position-relative p-0 mt-n4 mx-3 z-index-2">
			<div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-3 d-flex align-items-center">
				<h3 class="text-white text-capitalize ps-5 my-2 py-1">인사 정보 테이블</h3>
				<form action="/hr/searchlist" id="search-form" class="ms-md-auto bg-white rounded p-2 mb-0 d-flex align-items-center">
					<div class="align-items-center d-flex flex-column mx-1">	
						<div class="input-group input-group-outline">
							<label class="form-label">검색어</label>
							<input type="text" id="searchword" name="searchword" class="form-control" value="${param.searchword }">
							<input type="hidden" id="filter" name="filter" value="${param.filter }">
						</div>
					</div>					
					<div class="align-items-center d-flex flex-column py-1 ct-example">
						<button type="button" id="searchbtn" class="btn btn-outline-primary mb-0 py-2 mx-1 fs-6">검색</button>
					</div>
				</form>
			</div>
		</div>		
	
		<div class="card-body mx-5 px-0 pb-4">
			<div class="p-0">
				<table id="hr-table" class="table table-hover align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-center py-3 font-weight-bolder col-2">사원번호</th>
							<th class="text-center font-weight-bolder col-1">이름</th>
							<th class="text-center font-weight-bolder col-1">부서</th>
							<th class="text-center font-weight-bolder col-1">직책</th>
							<th class="text-center font-weight-bolder col-3">이메일</th>
							<th class="text-center font-weight-bolder col-2">내선번호</th>
							<th class="text-center font-weight-bolder col-3">연락처</th>
							<th class="text-center font-weight-bolder col-1">
								<div class="dropdown">
									<button class="btn btn-outline-secondary dropdown-toggle mb-0 fs-6" type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
										<span id="dropdown-selected">${empty param.filter ? "전체" : param.filter }</span>
									</button>
									<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
										<li><a class="dropdown-item">전체</a></li>
										<li><a class="dropdown-item">재직</a></li>
										<li><a class="dropdown-item">휴가</a></li>
										<li><a class="dropdown-item">휴직</a></li>
										<li><a class="dropdown-item">퇴직</a></li>
									</ul>
								</div>
							</th>
						</tr>
					</thead>
	 				<tbody id="employeeTableBody">
						<c:forEach var="vo" items="${list}">
							<tr class="memList">
								<td class="text-center py-2-3 identify-no">${vo.employee_no}</td>
								<td class="text-center py-2-3">${vo.name}</td>
								<td class="text-center py-2-3">${vo.depart_name}</td>
								<td class="text-center py-2-3">${vo.position_name}</td>
								<td class="text-center py-2-3">${vo.email}</td>
								<td class="text-center py-2-3">${vo.extension_no}</td>
								<td class="text-center py-2-3">${vo.contact}</td>
								<td class="text-center py-2-3">
									<span id="status-badge" class="badge badge-sm">${vo.status}</span>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		<div class="row">
			<div class="col-sm-5">
				<div class="ms-6">${pageVO.startPage } / ${pageVO.endPage } of 미구현</div>
			</div>
			<div class="col-sm-5 mb-3">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="page-link link-container"><a href="/hr/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&filter=${filter}&searchword=${searchword}" class="link"><<</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						<li ${pageVO.cri.page == i ? "class='link-container active'" : "class='link-container'"} >
							<a href="/hr/${listUrl }?page=${i }&filter=${filter}&searchword=${searchword}" ${pageVO.cri.page == i ? "class='page-link rounded fw-bolder link-white'" : "class='page-link rounded fw-bolder'"}>${i }</a>
						</li>				
					</c:forEach>
					<c:if test="${pageVO.next }">
						<li class="page-link link-container"><a href="/hr/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&filter=${filter}&searchword=${searchword}" class="link">>></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>
</div>
<!-- 본문 종료 -->

<div id="Modal" class="modal top-7 position-absolute h-auto">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header py-4">
				<button id="closebtn" class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5">X</button>
				<h3 class="modal-title mx-auto">사원 정보</h3>
			</div>
			<div class="modal-body p-5">
				<div class="user-container d-flex align-items-center">
					<img class="img-thumbnail mb-4 me-4 max-width-200 w-30" alt="회원사진" id="photo_paths">
					<div class="user-info d-flex w-100">
						<table class="table">
							<tr>
								<th class="fs-5">사번</th>
								<td class="fs-5" id="employee_no"></td>
							</tr>
							<tr>
								<th class="fs-5">이름</th>
								<td class="fs-5" id="name"></td>
							</tr>
							<tr>
								<th class="fs-5">아이디</th>
								<td class="fs-5" id="id"></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="tableContainer" class="modal-body">
					<table id="view-table" class="table">
						<tr>
							<th class="fs-5">부서</th>
							<td class="fs-5" id="depart_name"></td>
						</tr>
						<tr>
							<th class="fs-5">직책</th>
							<td class="fs-5" id="position_name"></td>
						</tr>
						<tr>
							<th class="fs-5">이메일</th>
							<td class="fs-5" id="email"></td>
						</tr>
						<tr>
							<th class="fs-5">내선번호</th>
							<td class="fs-5" id="extension_no"></td>
						</tr>
						<tr>
							<th class="fs-5">연락처</th>
							<td class="fs-5" id="contact"></td>
						</tr>
						<tr>
							<th class="fs-5">주소</th>
							<td class="fs-5" id="address"></td>
						</tr>
						<tr>
							<th class="fs-5">재직상태</th>
							<td class="fs-5" id="status"></td>
						</tr>
					</table>
					
					<form action="/hr/list" id="edit-form" method="post">
						<input type="hidden" id="employee_no-forSubmit" name="employee_no">
						<input type="hidden" id="searchword-forSubmit" name="searchword">
						<input type="hidden" id="filter-forSubmit" name="filter">
						<input type="hidden" id="page-forSubmit" name="page" value="${empty page ? 1 : page }">
						<table id="edit-table" class="d-none table">
					    	<tr>
								<th class="fs-5">부서</th>
								<td class="fs-6">
									<select id="depart_name-select" name="depart_name">
										<option value="미정">미정</option>
										<option value="관리">관리</option>
										<option value="생산">생산</option>
										<option value="영업">영업</option>
										<option value="총괄">총괄</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="fs-5">직책</th>
								<td class="fs-6">
									<select id="position_name-select" name="position_name"></select>
								</td>
							</tr>
							<tr>
								<th class="fs-5">이메일</th>
								<td class="input-group input-group-dynamic">
									<input id="email-input" class="fs-6 p-0 form-control" type="email" name="email"required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">내선번호</th>
								<td class="input-group input-group-dynamic">
									<input id="extension_no-input" class="fs-6 p-0 form-control" type="tel" name="extension_no" required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">연락처</th>
								<td class="input-group input-group-dynamic" >
									<input id="contact-input" class="fs-6 p-0 form-control" type="tel" name="contact" required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">주소</th>
								<td class="input-group input-group-dynamic">
									<input id="address-input" class="fs-6 p-0 form-control" type="text" name="address" required="required">
								</td>
							</tr>
							<tr>
								<th class="fs-5">재직상태</th>
								<td class="fs-6">
									<select id="status-select" name="status">
										<option value="재직">재직</option>
										<option value="휴가">휴가</option>
										<option value="휴직">휴직</option>
										<option value="퇴직">퇴직</option>
									</select>
								</td>
							</tr>
					  	</table>
				  	</form>
				</div>
				<div class="text-center">
					<button id="editbtn" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3">정보 수정</button>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>

<script>
	$(document).ready(function() {
		
		var modal = document.getElementById("Modal");
		
		if($("#searchword").val()) {
			$(".input-group").addClass("focused is-focused");
		}
		
		$('table tr').each(function() {
            var statusText = $(this).find('td:last-child #status-badge').text();
            console.log("span: " + statusText);
            switch(statusText){
            case "재직": $(this).find('td:last-child #status-badge').addClass("bg-gradient-success"); break;
            case "휴가": $(this).find('td:last-child #status-badge').addClass("bg-gradient-info"); break;
            case "휴직": $(this).find('td:last-child #status-badge').addClass("bg-gradient-warning"); break;
            case "퇴직": $(this).find('td:last-child #status-badge').addClass("bg-gradient-dark"); break;
            }
        });
		
		$("#searchbtn").click(function(){
			$("#search-form").submit();
		});		
		
		$("#hr-table").on("click", "tr td", function(event) {
	        var value = $(this).closest("tr").find("td.identify-no").text();
	        $.ajax({
	            url: '/hr/content?employee_no=' + value,
				method : 'GET',
				dataType: 'json',
				success : function(data) {
					$('#photo_paths').attr('src', data.photo_paths).attr('width', '100');
					$("#employee_no").text(data.employee_no);
					$("#employee_no-forSubmit").val(data.employee_no);
					$("#id").text(data.id);
				    $("#name").text(data.name);
				    $("#depart_name").text(data.depart_name);
				    $("#position_name").text(data.position_name);
				    $("#email").text(data.email);
				    $("#extension_no").text(data.extension_no);
				    $("#contact").text(data.contact);
				    $("#address").text(data.address);
				    $("#status").text(data.status);
				    modal.style.display = "block";
				},
				error : function(error) {
					console.log('실패:', error);
				}
			});
	    });
		
		$("#closebtn").click(function(){
			modal.style.display = "none";
			location.reload();
		});
		
		$("#editbtn").click(function(){
			if ($("#edit-table").hasClass("d-none")) {
				$("#editbtn").text("수정 완료");
				toggleTable();
			    getEditInfo();
			    updatePositionNameSelect();
			} else {
				swal({
					  title: "정말 수정하시겠습니까?",
					  text: "이 사람도 누군가의 가장입니다",
					  icon: "warning",
					  buttons: true,
					  dangerMode: true,
					})
					.then((willDelete) => {
					  if (willDelete) {
						swal("당신은 정말 잔인한 사람이에요!", {icon: "success"}).then(function(){
							if('${param.searchword}'!=""){
								$("#searchword-forSubmit").val('${param.searchword}');
							}		
							$("#filter-forSubmit").val($("#dropdown-selected").text());					
							$("#edit-form").submit();                
						});							
					  } else {
					    swal("우유부단 하시군요!");
					  }
				});		    
			}		    
		});		
		
		$(window).click(function(event){
			if (event.target == modal) {
				$("#closebtn").trigger("click");
			}
			
			if (!$(event.target).closest('.input-group').length) {
				if (!$("#searchword").val()) {
		       		$(".input-group").removeClass("focused is-focused");
				} else {
					$(".input-group").addClass("focused is-focused");
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
	
	function getEditInfo() {
	    getSelected("#depart_name");
	    getSelected("#position_name");
		$("#email-input").val($("#email").text());
		$("#extension_no-input").val($("#extension_no").text());
		$("#contact-input").val($("#contact").text());
		$("#address-input").val($("#address").text());
	    getSelected("#status");
	}
	
	function updatePositionNameSelect() {
	    var selectedValue = $("#depart_name-select").val();
	    var positionNameSelect = $("#position_name-select");

	    positionNameSelect.empty();

	    switch (selectedValue) {
	      case "미정":
	        addOption(positionNameSelect, "미정");
	        break;
	      case "관리":
	        addOption(positionNameSelect, "정보");
	        addOption(positionNameSelect, "재고");
	        break;
	      case "생산":
	        addOption(positionNameSelect, "상품");
	        addOption(positionNameSelect, "설비");
	        break;
	      case "영업":
	        addOption(positionNameSelect, "자재");
	        addOption(positionNameSelect, "납품");
	        break;
	      case "총괄":
	        addOption(positionNameSelect, "임원");
	        break;
	    }
	}
	
	function toggleTable(){
		$("#view-table").toggleClass("d-none");
	    $("#edit-table").toggleClass("d-none");			
	}
	
	function addOption(selectElement, value) {
		var option = $("<option>").text(value).val(value);
		selectElement.append(option);
	}
	
	function getSelected(id) {
		var optionToSelect = $(id+"-select option").filter(function() {
			return $(this).text().indexOf($(id).text()) !== -1;
		});
		
		if (optionToSelect.length > 0) {
		    optionToSelect.prop("selected", true);
	    }
	}	
</script>