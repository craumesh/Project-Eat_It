<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>
<!-- 본문 시작 -->
<div class="col-12">
	<div class="card my-4 mx-4">
		<div class="card-header position-relative p-0 mt-n4 mx-3 z-index-2">
			<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex align-items-center">
				<h3 class="text-white text-capitalize ps-5 my-2 py-1">인사 승인 관리 테이블</h3>
			</div>
		</div>		
		<div class="row">
			<div class="card-body mx-5 px-0 pt-0 col-lg-3">
				<div class="table-responsive p-0 mt-4">
		 			<form action="/hr/batch" id="batch-form" method="post">
						<table id="hr-table" class="table table-hover mb-0">
							<thead>
								<tr>
									<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 py-3">
										<input type="checkbox" class="m-1" id="selectAll">
									</th>
									<th class="text-center font-weight-bolder py-3 col-2">사원번호</th>
									<th class="text-center font-weight-bolder py-3 col-1">아이디</th>
									<th class="text-center font-weight-bolder py-3 col-1">이름</th>
									<th class="text-center font-weight-bolder py-3 col-3">이메일</th>
									<th class="text-center font-weight-bolder py-3 col-3">연락처</th>
								</tr>
							</thead>
			 				<tbody id="employeeTableBody">
								<c:forEach var="vo" items="${list}">
									<tr class="memList">
										<td class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 py-3">
											<input type="checkbox" class="checkbox m-1" name="checkgroup" value="${vo.employee_no}">
										</td>
										<td class="text-center py-3 identify-no">${vo.employee_no}</td>
										<td class="text-center py-3">${vo.id}</td>
										<td class="text-center py-3">${vo.name}</td>
										<td class="text-center py-3">${vo.email}</td>
										<td class="text-center py-3">${vo.contact}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<input type="hidden" name="ad_identify" id="batchad_identify-forSubmit">
						<input type="hidden" name="page" id="batchad_page-forSubmit" value="${empty page ? 1 : page }">
					</form>
				</div>
				<div class="col-lg-auto mt-2">
					<div class="row d-flex">
						<div class="col-lg-4 col-sm-6 col-12">${pageVO.startPage } / ${pageVO.endPage } of 총 개수</div>
						<div class="col-lg-2 col-sm-6 col-6 ms-auto">
							<button class="btn bg-gradient-success fs-6 w-100 mb-0 toast-btn px-2" id="batchaccessbtn" type="button" data-target="successToast">선택 승인</button>
						</div>
						<div class="col-lg-2 col-sm-6 col-6">
							<button class="btn bg-gradient-danger fs-6 w-100 mb-0 toast-btn px-2" id="batchdeniedbtn" type="button" data-target="dangerToast">선택 거부</button>
						</div>
					</div>
				</div>
				<div class="col-lg-auto d-flex justify-content-center">										
					<ul class="pagination mx-auto">
						<c:if test="${pageVO.prev }">
							<li class="page-link link-container"><a href="/hr/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&searchword=${searchword}" class="link"><<</a></li>
						</c:if>
						<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
							<li ${pageVO.cri.page == i ? "class='page-link link-container active'" : "class='page-link link-container'"} >
								<a href="/hr/${listUrl }?page=${i }&searchword=${searchword}" ${pageVO.cri.page == i ? "class='link-white'" : "class=''"}>${i }</a>
							</li>				
						</c:forEach>
						<c:if test="${pageVO.next }">
							<li class="page-link link-container"><a href="/hr/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&searchword=${searchword}" class="link">>></a></li>
						</c:if>
					</ul>
				</div>
			</div>			
			<div id="infoCard" class="card col-lg-5 my-4 me-5 border h-100" >
				<div class="d-flex card-header pt-4 pb-2">
					<h3 class="mx-auto">사원 정보</h3>
				</div>
				<hr class="horizontal dark m-2">
				<div class="card-body p-4">					
					<div class="card card-frame position-absolute top-50 start-50 translate-middle w-90 h-75 overflow-hidden bg-gradient-light z-index-3" id="overlay">
						<div class="card-body align-items-center d-flex">
							<label class="m-auto fs-4">처리할 신청 정보를 클릭해주세요</label>
						</div>
					</div>
					<div id="overlay-toggle">
						<div class="user-container d-flex text-center align-items-center">
							<img class="img-thumbnail mb-4 me-4 max-width-200 w-25" alt="회원사진" id="photo_paths">
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
									<th class="fs-5">이메일</th>
									<td class="fs-5" id="email"></td>
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
									<th class="fs-5">신청일</th>
									<td class="fs-5" id="regdate"></td>
								</tr>
							</table>
							
							<form id="edit-form" method="post">
								<input type="hidden" name="employee_no" id="employee_no-forSubmit">
								<input type="hidden" name="ad_identify" id="ad_identify-forSubmit">
								<input type="hidden" name="page" id="page-forSubmit" value="${empty page ? 1 : page }">
						  	</form>
						</div>
						<div class="row d-flex justify-content-center py-3">
							<div class="col-lg-3 col-sm-6 col-12">
								<button class="btn bg-gradient-success fs-6 w-100 mb-0 toast-btn" id="accessbtn" type="button" data-target="successToast">승인</button>
							</div>
							<div class="col-lg-3 col-sm-6 col-12">
								<button class="btn bg-gradient-danger fs-6 w-100 mb-0 toast-btn" id="deniedbtn" type="button" data-target="dangerToast">거부</button>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- 본문 종료 -->

<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>

<script>
	$(document).ready(function() {
		
		var infoCard = document.getElementById("infoCard");
		
		$("#overlay-toggle").addClass("d-none");
				
		$("#hr-table").on("click", "tr td:not(:first-child)", function(event) {
	        var value = $(this).closest("tr").find("td.identify-no").text();
	        $.ajax({
	            url: '/hr/content?employee_no=' + value,
				method : 'GET',
				dataType: 'json',
				success : function(data) {
					$("#overlay-toggle").removeClass("d-none");
					$("#overlay").addClass("d-none");
					
					$('#photo_paths').attr('src', data.photo_paths).attr('width', '100');
					$("#employee_no").text(data.employee_no);
					$("#employee_no-forSubmit").val(data.employee_no);
					$("#id").text(data.id);
				    $("#name").text(data.name);
				    $("#email").text(data.email);
				    $("#contact").text(data.contact);
				    $("#address").text(data.address);
				    $("#regdate").text(data.regdate);
				},
				error : function(error) {
					console.log('실패:', error);
				}
			});
	    });
		
		$('#selectAll').change(function () {
            $('.checkbox').prop('checked', $(this).prop('checked'));
        });
		
		$("#accessbtn, #batchaccessbtn").click(function(){
			if(this.id == "accessbtn") {
				accessDeniedAlert("access",false);
			} else if(this.id == "batchaccessbtn") {
				accessDeniedAlert("access",true);
			}
		});	
		
		$("#deniedbtn, #batchdeniedbtn").click(function(){
			if(this.id == "deniedbtn") {
				accessDeniedAlert("denied",false);
			} else if(this.id == "batchdeniedbtn") {
				accessDeniedAlert("denied",true);
			}
		});	
		
		function accessDeniedAlert(select, batch){
			swal({
				  title: "정말 "+(select=="access"?"승인":select=="denied"?"거부":"")+" 하시겠습니까?",
				  text: "진짜??",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
					swal("처리되었습니다!", {icon: "success"}).then(function(){
						if(batch){
							$("#batchad_identify-forSubmit").val(select);
							$("#batch-form").submit();   
						} else {
							$("#employee_no-forSubmit").val($("#employee_no").text());
							$("#ad_identify-forSubmit").val(select);
							$("#edit-form").submit();							
						}                
					});							
				  } else {
				    swal("취소되었습니다!");
				  }
			});
		}
	});
</script>