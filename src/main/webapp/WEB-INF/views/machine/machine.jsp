<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<%@ include file="../include/header.jsp" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!-- 시작 -->
<div class="col-11 mx-auto">
	<div class="card my-4">
		<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 ">
			<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">
				<h3 class="text-white text-capitalize ps-5 my-2 py-1">설비 관리</h3>
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
			<div class="table-responsive p-0">
				<form action="/machine/delete" method="post" id="checkbox_form">
				<table id="hr-table" class="table table-hover align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2"></th>
							<th class="text-center font-weight-bolder col-2">설비 코드</th>
							<th class="text-center font-weight-bolder col-2">관리자</th>
							<th class="text-center font-weight-bolder col-2">작동 목적</th>
							<th class="text-center font-weight-bolder col-3">설비 설치일</th>
							<th class="text-center font-weight-bolder col-3">설비 위치</th>
							<th class="text-center font-weight-bolder col-1">설비 상태</th>
						</tr>
					</thead>
	 				<tbody id="employeeTableBody">
						<c:forEach var="ml" items="${machinelist}">
							<tr class="mllist">
								<td class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 py-3"><input type="checkbox" name="code" value="${ml.machine_code}"></td>
								<td class="text-center">${ml.machine_name}_${ml.machine_code}</td>
								<td class="text-center">${ml.name}</td>
								<td class="text-center">${ml.purpose_of_use}</td>
								<td class="text-center">${ml.installation_date}</td>
								<td class="text-center">${ml.machine_location}</td>
								<td class="text-center"><span id="status-badge" class="badge badge-sm bg-gradient-success">${ml.machine_status}</span></td>
							</tr>
						</c:forEach>
					</tbody>
		
				</table>
		</form>
			</div>
		</div>
		<div class="col-6 w-100 text-end">
		<button class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" onclick="openModal()">설비 추가</button>
		<button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3" id="delete_btn" >설비 삭제</button>
		<!-- <a class="btn bg-gradient-dark mb-0" onclick="deleteSelected()"><i class="material-icons text-sm"></i>&nbsp;&nbsp;설비 삭제</a> -->
		</div>
		<div class="row">
			<div class="col-sm-5">
				<%-- <div>Showing ${pageVO.startPage } to ${pageVO.endPage } of 미구현 entries</div> --%>
			</div>
			<div class="col-sm-5">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="page-link link-container"><a href="/machine/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&searchword=${searchword}" class="link"><<</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						<li ${pageVO.cri.page == i ? "class='page-link link-container active'" : "class='page-link link-container'"} >
							<a href="/machine/${listUrl }?page=${i }&searchword=${searchword}" ${pageVO.cri.page == i ? "class='link-white'" : "class=''"}>${i }</a>
						</li>				
					</c:forEach>
					<c:if test="${pageVO.next }">
						<li class="page-link link-container"><a href="/machine/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&searchword=${searchword}" class="link">>></a></li>
					</c:if>
				</ul>
			</div>
		</div>
</div>
</div>
<!-- 끝 -->
<div id="myModal" class="modal top-10 position-absolute z-index-3">
	<div class="modal-dialog">
		<div class="modal-content w-100">
			<div class="modal-header">
				<button id="closebtn" class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5" onclick="closeModal()">X</button>
				<h3 class="modal-title mx-auto">설비 추가</h3>
			</div>
			<div class="modal-body p-5">
				<div id="tableContainer">
				<form action="/machine/machine" id="myForm"  method="post">
					<table id="updatemachinetable" class="table">
						<tr>
							<th class="fs-5 w-50">설치 장비</th>
							<td><select id="machine_name" name="machine_name" onchange="updateMachineCode()" required>
								<option value="선택">--선택하세요--</option>
								<option value="CAKE">케이크</option>
								<option value="COOKIE">쿠키</option>
								<option value="ICECREAM">아이스크림</option>
							</select></td>
						</tr>
						<tr>
							<th class="fs-5">관리자</th>
							<td>
							<select id="employee_no" name="employee_no"  required>
								<option value="${no }">${name}</option>
							</select>
							<input type="hidden" id="machine_code" name="machine_code" value="${code }">
						</td>
						</tr>
						<tr>
							<th class="fs-5">설비 설치일</th>
							<td><input type="text" id="installation_date" name="installation_date"></td>
						</tr>
						<tr>
							<th class="fs-5">설비 위치</th>
							<td><select id="machine_location" name="machine_location">
								<option value="선택">--선택하세요--</option>
								<option value="A">A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
						</select></td>
						</tr>		
					</table>
					<div class="text-center">
					<button id="myForm" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3">등록</button>
					<input type="button" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" onclick="closeModal()" value="취소">
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>



	

	<!-- 설비 상세보기 -->
	<div id="Modal" class="modal top-10 position-absolute z-index-3" >
	<div class="modal-dialog">
		<div class="modal-content w-100">
			<div class="modal-header">
				<button id="closebtn" class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5" onclick="closeModal()">X</button>
				<h3 class="modal-title mx-auto">설비 정보</h3>
			</div>
			<div class="modal-body p-5">
				<div class="user-container d-flex align-items-center">
					<div class="user-info d-flex w-100">
						<table class="table">
							<tr>
								<th class="fs-5">설비 코드</th>
								<td class="fs-5" id="namecode">
								</td>
								<td class="fs-5" id="machineno" ></td>
								
									
							</tr>
							<tr>
								<th class="fs-5">점검일</th>
								<td class="fs-5" id="lastchecktime"></td>
							</tr>
							<tr>
								<th class="fs-5">최종 작동</th>
								<td class="fs-5" id="lastoperatingtime"></td>
							</tr>
						</table>
					</div>
				</div>
				<div id="tableContainer">
					<table id="view-table" class="table">
						<tr>
							<th class="fs-5 w-7">설비 상태</th>
							<td class="fs-5 w-20" id="status"></td>
						</tr>
						<tr>
							<th class="fs-5">관리자</th>
							<td class="fs-5" id="employeename"></td>
						</tr>
						<tr>
							<th class="fs-5">위치</th>
							<td class="fs-5" id="machinelocation"></td>
						</tr>
					</table>
					
					<form action="/machine/machineupdate" id="edit-form" method="post">
						<input type="hidden" name="employeeno" id="employee_no-forSubmit">
						<input type="hidden" name="searchword" id="searchword-forSubmit">
						<table id="edit-table" class="d-none table">
					    	<tr>
								<th class="fs-5">설비 상태</th>
								<td class="fs-6">
									<select name="status" id="machine_status">
										<option value="점검중">점검중</option>
										<option value="수리중">수리중</option>
										<option value="고장">고장</option>
										<option value="생산중">생산중</option>
										<option value="생산 대기">생산 대기</option>
										<option value="생산 완료">생산 완료</option>
									</select>
								</td>
							</tr>
							<tr>
								<th class="fs-5">관리자</th>
								<td class="fs-6">
									<input type="text" name="employeename" id="name">
									<input type="hidden" name="machineno" id="codemachine">
								</td>
							</tr>
							<tr>
								<th class="fs-5">위치</th>
								<td class="fs-6">
								<select name="machinelocation" id="machine_location">  
								<option value="A">A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
								</select></td>
							</tr>
					  	</table>
				  	</form>
				</div>
				<div class="text-center">
					<button id="editbtn" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3">수정</button>
				</div>
			</div>
		</div>
	</div>
</div>
<%@ include file="../include/footer.jsp" %>
<%@ include file="../include/js.jsp" %>
<script>

$(document).ready(function () {
	
	
	
    $("#hr-table").on("click", "tr td:not(:first-child)", function () {
        // 추출한 machine_code
        var machineCode = $(this).closest("tr").find("td:eq(1)").text().match(/\d+/);

        $.ajax({
            url: '/machine/machineinfo?machine_code=' + machineCode, 
            method: 'GET',
            data: { machineCode: machineCode ? parseInt(machineCode[0]) : 0 },
            dataType: 'json',
            success: function (data) {

                for (var i = 0; i < data.infolist.length; i++) {
                    var historyData = data.infolist[i];
                }


                var namecode = data.machine_name + "_" + historyData.machine_code;
                $("#namecode").text(namecode);
                $("#code").text(historyData.machine_code);
                $("#name").text(data.machine_name);
                $("#status").text(data.machine_status);
                $("#employeename").text(data.name);
                $("#machineno").val(historyData.machine_code);

                function formatDate1(dateString) {
                	var formattedDate = dateString.replace(/(\d+)월 (\d+), (\d+)/, function(match, p1, p2, p3) {
                        return p3 + '-' + (p1.length === 1 ? '0' + p1 : p1) + '-' + (p2.length === 1 ? '0' + p2 : p2);
                    });
                    return formattedDate;
                }
                
                function formatDate(dateString) {
                    var date = new Date(dateString);

                    var year = date.getFullYear();
                    var month = (date.getMonth() + 1).toString().padStart(2, '0');
                    var day = date.getDate().toString().padStart(2, '0');

                    var formattedDate = year + '-' + month + '-' + day;

                    return formattedDate;
                }
       
                $("#lastchecktime").text(formatDate1(historyData.check_time));
                $("#lastoperatingtime").text(formatDate(historyData.operating_time));
                $("#installationdate").text(formatDate(data.installation_date));
                $("#machinelocation").text(data.machine_location);
				
                console.log(data);
              
                document.getElementById("Modal").style.display = "block";
            },
            error: function (error) {
                console.log('실패:', error);
            }
        });
    });


	$("#editbtn").click(function(){
		if ($("#edit-table").hasClass("d-none")) {
			$("#editbtn").text("수정 완료");
			toggleTable();
		    getEditInfo();
		} else {
			swal({
				  title: "수정하시겠습니까?",
				  text: "수정 중 입니다.",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
					swal("수정 완료 되었습니다!", {icon: "success"}).then(function(){
						if($("#searchword").val()){
							$("#searchword-forSubmit").val($("#searchword").val());
						}							
						$("#edit-form").submit();                
					});							
				  } else {
				    swal("수정 취소했습니다!");
				  }
			});		    
		}		    
});
$(window).click(function(event){
	var modal = document.getElementById("Modal");
	if (event.target == modal) {
		modal.style.display = "none";
		location.reload();
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
});	
		function toggleTable(){
			$("#view-table").toggleClass("d-none");
  		    $("#edit-table").toggleClass("d-none");			
				}

		function getEditInfo() {
 		 $("#machine_status").val($("#status").text());
 		 $("#machine_location").val($("#machinelocation").text());
 		 $("#name").val($("#employeename").text());
 		 $("#codemachine").val($("#machineno").val());
	}

		

		function openModal() {
			document.getElementById("myModal").style.display = "block";
			var today = new Date();
			var dd = String(today.getDate()).padStart(2, '0');
			var mm = String(today.getMonth() + 1).padStart(2, '0');
			var yyyy = today.getFullYear();
			today = yyyy + '-' + mm + '-' + dd;
			document.getElementById("installation_date").value = today;
		}

		function closeModal() {
			document.getElementById("myModal").style.display = "none";
			document.getElementById("Modal").style.display = "none";
			
			location.reload();
		}

		window.onclick = function(event) {
			var modal = document.getElementById('myModal');
			var modal2 = document.getElementById('MachinModal');
			if (event.target == modal) {
				closeModal();
			}
			if (event.target == modal2) {
				closeModal();
			}
		}
		
		function getSelected(id) {
			var optionToSelect = $(id+"-select option").filter(function() {
				return $(this).text().indexOf($(id).text()) !== -1;
			});
			
			if (optionToSelect.length > 0) {
			    optionToSelect.prop("selected", true);
		    }
		}	
		
		$('table tr').each(function() {
            var statusText = $(this).find('td:last-child #status-badge').text();
            console.log("span: " + statusText);
            switch(statusText){
            case "생산중": $(this).find('td:last-child #status-badge').addClass("bg-gradient-success"); break; // 초록
            case "생산 대기": $(this).find('td:last-child #status-badge').addClass("bg-gradient-info"); break;	// 파랑
            case "생산 완료": $(this).find('td:last-child #status-badge').addClass("bg-gradient-danger"); break;	// 빨강
            case "수리중": $(this).find('td:last-child #status-badge').addClass("bg-gradient-warning"); break;	// 노랑
            case "점검중": $(this).find('td:last-child #status-badge').addClass("bg-gradient-warning"); break;	// 노랑
            case "고장": $(this).find('td:last-child #status-badge').addClass("bg-gradient-dark"); break;	// 회색
            
            }
        });
		
		
		
		$("#delete_btn").click(function (event) {
		    var selectedCount = $('input[name="code"]:checked').length;

		    if (selectedCount === 0) {
		        
		        swal({
		            title: "알림",
		            text: "삭제할 설비를 선택하세요.",
		            icon: "warning",
		            button: "확인"
		        });
		        event.preventDefault();
		    } else {
		        
		        swal({
		            title: "삭제 확인",
		            text: "선택한 설비를 삭제하시겠습니까?",
		            icon: "warning",
		            buttons: true,
		            dangerMode: true,
		        }).then((willDelete) => {
		            if (willDelete) {
		             
		                swal("선택한 설비가 삭제되었습니다.", {
		                    icon: "success",
		                    buttons: false,
		                    timer: 1500
		                });
		                $("#checkbox_form").submit();
		            } else {
		                // 삭제 취소 시 아무 동작 없음
		            }
		        });
		    }
		});
		
	
		
		
		

		
	</script>

</html>