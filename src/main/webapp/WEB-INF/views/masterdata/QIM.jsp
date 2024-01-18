<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%@ include file="../include/header.jsp"%>

<style>
.modal {
	display: none;
	position: fixed;
	z-index: 1;
	left: 0;
	top: 0;
	width: 100%;
	height: 100%;
	overflow: auto;
	background-color: rgba(0, 0, 0, 0.4);
	 z-index: 1000;
}

.modal-content {
	background-color: #fefefe;
	margin: 5% auto;
	padding: 20px;
	border: 1px solid #ddd;
	border-radius: 5px;
	width: 50%;
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
}

.close {
	color: #aaa;
	float: right;
	font-size: 28px;
	font-weight: bold;
	cursor: pointer;
	position: absolute;
	right: 20px;
	top: 20px;
}

.close:hover, .close:focus {
	color: black;
	text-decoration: none;
	cursor: pointer;
}

.fixed-size-textarea {
	resize: none; /* 드래그에 의한 크기 조정을 막습니다. */
	width: 500px; /* 가로 크기를 조절할 수 있습니다. */
	height: 150px; /* 세로 크기를 조절할 수 있습니다. */
}
</style>
<!-- 본문 시작 -->
<div class="col-12">
	<div class="card my-4 mx-4">
		<div class="card-header position-relative p-0 mt-n4 mx-3 z-index-2">
			<div
				class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-3 d-flex align-items-center">
				<h3 class="text-white text-capitalize ps-5 my-2 py-1">품질 정보 관리</h3>
				<form action="/masterdata/QIMsearch"
					class="ms-md-auto bg-white rounded p-2 mb-0 d-flex align-items-center"
					method="GET">
					<div class="align-items-center d-flex flex-column mx-1">
						<div class="input-group input-group-outline">
							<label class="form-label">검색어</label> <input type="text"
								name="keyword" class="form-control" value="${keyword }">
						</div>
					</div>

					<div class="align-items-center d-flex flex-column py-1 ct-example">
						<button type="submit" id="searchbtn"
							class="btn btn-outline-primary mb-0 py-2 mx-1 fs-6">검색</button>
					</div>
				</form>
			</div>
		</div>

		<div class="card-body mx-5 px-0 pb-4">
			<div class="p-0">
				<table id="hr-table"
					class="table table-hover align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-center py-3 font-weight-bolder col-2">품질정보번호</th>
							<th class="text-center font-weight-bolder col-1">품목코드</th>
							<th class="text-center font-weight-bolder col-1">품목이름</th>
							<th class="text-center font-weight-bolder col-1">외관</th>
							<th class="text-center font-weight-bolder col-1">맛</th>
							<th class="text-center font-weight-bolder col-3">향</th>
							<th class="text-center font-weight-bolder col-2">질감</th>
							<th class="text-center font-weight-bolder col-3">개선조치</th>

							<th class="text-center font-weight-bolder col-1">


								<ul class="navbar-nav  justify-content-end">
									<li class="nav-item d-flex align-items-center"><span
										class="d-sm-inline d-none"><button
												onclick="openModal()" class="btn btn-success">품질정보등록</button></span></li>
												<li class="nav-item d-flex align-items-center"><span
										class="d-sm-inline d-none"><button
												onclick="opentestModal()" class="btn btn-success" style="width: 122;">테스트과정등록</button></span></li>

								</ul>



							</th>
						</tr>
					</thead>
					<tbody id="productTableBody">
						<c:forEach var="product" items="${QIMList}">
							<tr>
								<td class="text-center py-2-3">${product.quality_no}</td>
								<td class="text-center py-2-3 identify-no">${product.code}</td>
								<td class="text-center py-2-3" >${product.name}</td>
								<td class="text-center py-2-3" >${product.product_visual}</td>
								<td class="text-center py-2-3">${product.taste}</td>
								<td class="text-center py-2-3" >${product.scent}</td>
								<td class="text-center py-2-3" >${product.texture}</td>
								<td class="text-center py-2-3" >${product.measure}</td>

								<td class="text-center py-2-3">
									<button onclick="openEditModal(event)"
										class="btn btn-secondary">품질정보수정</button>

									<form action="/masterdata/QIMdelete" method="post">
										<input type="hidden" name="quality_no"
											value="${product.quality_no}"> <input type="hidden"
											name="quality_no" value="${product.quality_no}">
											<input type="hidden"
											name="product_code" value="${product.product_code}">
										<button type="submit" class="btn btn-dark">품질정보삭제</button>
									</form>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
		
		
		<c:if test="${not empty referer}">
			<a href="${referer}" class="btn btn-primary">뒤로 가기</a>
		</c:if>

		<div class="row">
			<div class="col-sm-5">
				<div class="ms-6"></div>
			</div>
			<div class="col-sm-5 mb-3">
				<ul class="pagination">
					<c:if test="${pageVO.prev}">
						<li class="page-link link-container"><a
							href="javascript:void(0);"
							onclick="goToPageWithKeyword(${pageVO.startPage - 1})"
							class="page-link rounded fw-bolder${pageVO.cri.page == pageVO.startPage - 1 ? ' link-white' : ''}"><<</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage}"
						end="${pageVO.endPage}" step="1">
						<c:if test="${i <= pageVO.totalCount / pageVO.cri.pageSize + 1}">
							<li
								${pageVO.cri.page == i ? 'class="link-container active"' : 'class="link-container"'}>
								<a href="javascript:void(0);"
								onclick="goToPageWithKeyword(${i})"
								class="page-link rounded fw-bolder${pageVO.cri.page == i ? ' link-white' : ''}">${i}</a>
							</li>
						</c:if>
					</c:forEach>
					<c:if test="${pageVO.next}">
						<li class="page-link link-container"><a
							href="javascript:void(0);"
							onclick="goToPageWithKeyword(${pageVO.endPage + 1})"
							class="page-link rounded fw-bolder${pageVO.cri.page == pageVO.endPage + 1 ? ' link-white' : ''}">>></a></li>
					</c:if>
				</ul>
			</div>
		</div>
	</div>

</div>
<!-- 본문 종료 -->


<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>

<div id="myModal" class="modal">
	<div class="modal-content">

		<div class="modal-header py-4">
			<button id="closebtn"
				class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5"
				onclick="closeModal()">X</button>
			<h3 class="modal-title mx-auto">품질정보 등록</h3>
		</div>
		<div class="modal-body p-5">

			<div id="tableContainer" class="modal-body">
				<form id="myForm" method="post" action="/masterdata/QIMinsert">
					<table id="view-table" class="table">
						<tbody>


							<tr>

								<th class="fs-5">품목코드</th>
								<td class="fs-5" id="position_name"><select
									name="product_code" class="form_select" style="width: 500px;">
										<c:forEach var="product" items="${categoryList}">
											<option value="${product.code}">${product.code}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<th class="fs-5">외관</th>
								<td class="fs-5" id="address"><input type="text"
									name="product_visual" class="form-control"></td>
							</tr>
							<tr>
								<th class="fs-5">맛</th>
								<td class="fs-5" id="extension_no"><input type="text"
									name="taste" class="form-control"></td>
							</tr>
							<tr>
								<th class="fs-5">향</th>
								<td class="fs-5" id="address"><input type="text"
									name="scent" class="form-control"></td>
							</tr>
							<tr>
								<th class="fs-5">질감</th>
								<td class="fs-5" id="address"><input type="text"
									name="texture" class="form-control"></td>
							</tr>

							<tr>
								<th class="fs-5">개선조치</th>
								<td class="fs-5" id="status"><textarea name="measure"
										class="fixed-size-textarea"></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="text-center">
						<button id="editbtn"
							class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" type="submit">품질정보
							등록</button>
					</div>

				</form>
			</div>


		</div>

	</div>
</div>
<div id="mytestModal" class="modal">
	<div class="modal-content">

		<div class="modal-header py-4">
			<button id="closebtn"
				class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5"
				onclick="closetestModal()">X</button>
			<h3 class="modal-title mx-auto">품질테스트과정 정보 등록</h3>
		</div>
		<div class="modal-body p-5">

			<div id="tableContainer" class="modal-body">
				<form id="mytestForm" method="post" action="/masterdata/QIMTestInsert">
					<table id="view-table" class="table">
						<tbody>


							<tr>

								<th class="fs-5">품목코드</th>
								<td class="fs-5" id="position_name"><select
									name="product_code" class="form_select" style="width: 500px;">
										<c:forEach var="product" items="${categoryList}">
											<option value="${product.code}">${product.code}</option>
										</c:forEach>
								</select></td>
							</tr>
							<tr>
								<th class="fs-5">테스트도구</th>
								<td class="fs-5" id="address"><input type="text"
									name="test_tool" class="form-control"></td>
							</tr>
							
							<tr>
								<th class="fs-5">테스트장비</th>
								<td class="fs-5" id="address"><input type="text"
									name="test_equipment" class="form-control"></td>
							</tr>
							

							<tr>
								<th class="fs-5">테스트방법</th>
								<td class="fs-5" id="status"><textarea name="test_method"
										class="fixed-size-textarea"></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="text-center">
						<button id="editbtn"
							class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" type="submit">품질테스트과정
							등록</button>
					</div>

				</form>
			</div>


		</div>

	</div>
</div>

<div id="myInfoModal" class="modal">
	<div class="modal-content">

		<div class="modal-header py-4">
			<button id="closebtn"
				class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5"
				onclick="closeInfoModal()">X</button>
			<h3 class="modal-title mx-auto">품질테스트과정 정보 </h3>
		</div>
		<div class="modal-body p-5">

			<div id="tableContainer" class="modal-body">
				<form id="myInfoForm" method="post" action="/masterdata/QIMTestInsert">
					<table id="view-table" class="table">
						<tbody>


							<tr>
								<th class="fs-5">품목코드</th>
								<td class="fs-5" id="address"><input type="text"
									name="product_code" class="form-control"></td>
							</tr>
							
							<tr>
								<th class="fs-5">테스트도구</th>
								<td class="fs-5" id="address"><input type="text"
									name="test_tool" class="form-control"></td>
							</tr>
							
							<tr>
								<th class="fs-5">테스트장비</th>
								<td class="fs-5" id="address"><input type="text"
									name="test_equipment" class="form-control"></td>
							</tr>
							

							<tr>
								<th class="fs-5">테스트방법</th>
								<td class="fs-5" id="status"><input type="text"
									name="test_method" class="form-control"></td>
							</tr>
						</tbody>
					</table>
					<div class="text-center">
						
					</div>

				</form>
			</div>


		</div>

	</div>
</div>




<div id="editModal" class="modal">
	<div class="modal-content">

		<div class="modal-header py-4">
			<button id="closebtn"
				class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5"
				onclick="closeEditModal()">X</button>
			<h3 class="modal-title mx-auto">품질정보 수정</h3>
		</div>
		<div class="modal-body p-5">

			<div id="tableContainer" class="modal-body">
				<form id="editForm" method="post" action="/masterdata/QIMedit">
					<table id="view-table" class="table">
						<tbody>
							<tr>
								<td><input type="hidden" name="quality_no"
									value="quality_no"></td>
							</tr>
							<tr>
								<th class="fs-5">품목코드</th>
								<td class="fs-5" id="depart_name"><input type="text"
									name="product_code" class="form-control" readonly="readonly"></td>
							</tr>
							<tr>
								<th class="fs-5">품목이름</th>
								<td class="fs-5" id="position_name"><input type="text"
									name="product_name" class="form-control" readonly="readonly"></td>
							</tr>
							<tr>
								<th class="fs-5">외관</th>
								<td class="fs-5" id="extension_no"><input type="text"
									name="product_visual" class="form-control"></td>
							</tr>
							<tr>
								<th class="fs-5">맛</th>
								<td class="fs-5" id="extension_no"><input type="text"
									name="taste" class="form-control"></td>
							</tr>
							
							<tr>
								<th class="fs-5">향</th>
								<td class="fs-5" id="address"><input type="text"
									name="scent" class="form-control"></td>
							</tr>
							<tr>
								<th class="fs-5">질감</th>
								<td class="fs-5" id="status"><input type="text"
									name="texture" class="form-control"></td>
							</tr>
							<tr>
								<th class="fs-5">개선조치</th>
								<td class="fs-5" id="status"><textarea name="measure"
										class="fixed-size-textarea"></textarea></td>
							</tr>
						</tbody>
					</table>
					<div class="text-center">
						<button id="editbtn"
							class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" type="submit">품질정보
							수정</button>
					</div>

				</form>
			</div>


		</div>

	</div>
</div>

<script>



</script>


<c:if test="${searchError}">
	<script>
    
    swal("검색 오류", "해당하는 검색어가 없습니다!", "error").then(function() {
        window.history.back(); // 이전 페이지로 이동
    });

    </script>
</c:if>



<script>
window.onload = function() {
    const urlParams = new URLSearchParams(window.location.search);
    const keyword = urlParams.get('keyword') || '';
    const cells = document.querySelectorAll("#productTableBody td"); // 모든 셀을 가져옴

    if (keyword) { // 검색어가 있는 경우에만 실행
        cells.forEach(cell => {
            const cellText = cell.textContent.toLowerCase(); // 셀의 텍스트를 소문자로 변환

            if (cellText.includes(keyword.toLowerCase())) { // 검색어를 포함하는 경우
                const newText = cellText.replace(new RegExp(keyword.toLowerCase(), 'g'), '<span style="background-color: gray; color: white;">' + keyword.toLowerCase() + '</span>');
                cell.innerHTML = newText;
            }
        });
    }
};


</script>

<script>
function goToPageWithKeyword(page) {
    var keyword = new URLSearchParams(window.location.search).get('keyword');
    var currentUrl = window.location.href;
    var urlWithoutParams = currentUrl.split('?')[0];

    var url = urlWithoutParams + '?page=' + page;

    if (keyword) {
        url += '&keyword=' + keyword;
    }

    window.location.href = url;
}
</script>





<script>
    document.addEventListener('DOMContentLoaded', () => {
        const deleteForms = document.querySelectorAll('form[action="/masterdata/QIMdelete"]');

        deleteForms.forEach(form => {
            form.addEventListener('submit', function(event) {
                event.preventDefault(); // 기본 제출 동작 막기

                const product_no = this.querySelector('input[name="quality_no"]').value;

                swal({
                    title: '품질정보 삭제',
                    text: '정말 삭제하시겠습니까?',
                    icon: 'warning',
                    buttons: true,
                    dangerMode: true,
                }).then((willDelete) => {
                    if (willDelete) {
                        swal('삭제 성공', '삭제가 완료되었습니다', 'info').then(() => {
                            this.submit(); // 확인 시 폼 제출
                        });
                    } else {
                        swal('삭제 취소', '삭제가 취소되었습니다.', 'info');
                    }
                });

            });
        });
    });
</script>


 <script>
 function closeInfoModal() {
	    var modal = document.getElementById("myInfoModal");
	    modal.style.display = "none";
	}
 
 
 $(document).ready(function() {
	    var modal = document.getElementById("myInfoModal");

	    $("#hr-table").on("click", "tr td", function(event) {
	        var value = $(this).closest("tr").find("td.identify-no").text();
	        $.ajax({
	            url: '/masterdata/content?product_code=' + value,
	            method: 'GET',
	            dataType: 'json',
	            success: function(data) {
	                console.log(data);
	                $("#address input[name='product_code']").prop('readonly', true).val(data.product_code);
	                $("#address input[name='test_tool']").prop('readonly', true).val(data.test_tool);
	                $("#address input[name='test_equipment']").prop('readonly', true).val(data.test_equipment);
	                $("#status input[name='test_method']").prop('readonly', true).val(data.test_method);

	                modal.style.display = "block";
	            },
	            error: function(error) {
	                console.log('실패:', error);
	                swal("품질테스트과정을 거치지 않은 제품입니다!", "", "error");
	            }
	        });
	    });
	});
</script>



















<script>
    function openModal() {
        document.getElementById("myModal").style.display = "block";
    }

    function closeModal() {
        document.getElementById("myModal").style.display = "none";
        
    }
    
    function opentestModal() {
        document.getElementById("mytestModal").style.display = "block";
    }

    function closetestModal() {
        document.getElementById("mytestModal").style.display = "none";
        
    }
   

   
    

    
    
    
    

    function openEditModal(event) {
        // 수정 버튼이 속한 <tr> 요소를 찾습니다.
        const selectedRow = event.target.closest('tr');

        // 각 셀의 데이터를 가져와 변수에 저장합니다.
        const qualityNo = selectedRow.cells[0].innerText;
        const productCode = selectedRow.cells[1].innerText;
        const productName = selectedRow.cells[2].innerText;
        const productVisual = selectedRow.cells[3].innerText;
        const taste = selectedRow.cells[4].innerText;
        const scent = selectedRow.cells[5].innerText;
        const texture = selectedRow.cells[6].innerText;
        const measure = selectedRow.cells[7].innerText;

        // 가져온 데이터를 수정 모달에 넣어줍니다.
        document.getElementById("editModal").style.display = "block";
        document.querySelector('#editForm [name="quality_no"]').value = qualityNo;
        document.querySelector('#editForm [name="product_code"]').value = productCode;
        document.querySelector('#editForm [name="product_name"]').value = productName;
        document.querySelector('#editForm [name="product_code"]').disabled = true; // 수정 불가능 설정
        document.querySelector('#editForm [name="product_name"]').disabled = true; // 수정 불가능 설정
        document.querySelector('#editForm [name="product_visual"]').value = productVisual;
        document.querySelector('#editForm [name="taste"]').value = taste;
        document.querySelector('#editForm [name="scent"]').value = scent;
        document.querySelector('#editForm [name="texture"]').value = texture;
        document.querySelector('#editForm [name="measure"]').value = measure;
    }
    function closeEditModal() {
        document.getElementById("editModal").style.display = "none";
        
    }
    function validateForm(formId) {
        const form = document.getElementById(formId);
        const inputs = form.getElementsByTagName('input');

        for (let i = 0; i < inputs.length; i++) {
            if (inputs[i].value.trim() === '') {
                
                return false;
            }
        }
        return true;
    }

    document.getElementById('myForm').addEventListener('submit', function (event) {
    	 event.preventDefault(); // 기본 제출 동작 방지

 	    if (!validateForm('myForm')) {
 	        // 폼이 유효하지 않은 경우
 	        swal('입력하지 않은 칸이 있습니다!', '', 'warning');
 	        return;
 	    }

 	    // 유효한 경우 SweetAlert로 사용자에게 확인 요청
 	    swal({
 	        title: '품질정보 등록',
 	        text: '정말 등록하시겠습니까? 한 번 더 정보를 확인해 주세요',
 	        icon: 'info',
 	        buttons: true,
 	        dangerMode: false,
 	    })
 	    .then((willSubmit) => {
 	        if (willSubmit) {
 	            swal('등록이 성공적으로 완료됐습니다!', '', 'success')
 	            .then(() => {
 	                event.target.submit(); // 확인을 누르면 submit 실행
 	            });
 	        } else {
 	            swal('등록 취소', '등록이 취소되었습니다.', 'info');
 	        }
 	    });
    });
    
    document.getElementById('mytestForm').addEventListener('submit', function (event) {
   	 event.preventDefault(); // 기본 제출 동작 방지

	    if (!validateForm('mytestForm')) {
	        // 폼이 유효하지 않은 경우
	        swal('입력하지 않은 칸이 있습니다!', '', 'warning');
	        return;
	    }

	    // 유효한 경우 SweetAlert로 사용자에게 확인 요청
	    swal({
	        title: '품질테스트과정 등록',
	        text: '정말 등록하시겠습니까? 한 번 더 정보를 확인해 주세요',
	        icon: 'info',
	        buttons: true,
	        dangerMode: false,
	    })
	    .then((willSubmit) => {
	        if (willSubmit) {
	            swal('등록이 성공적으로 완료됐습니다!', '', 'success')
	            .then(() => {
	                event.target.submit(); // 확인을 누르면 submit 실행
	            });
	        } else {
	            swal('등록 취소', '등록이 취소되었습니다.', 'info');
	        }
	    });
   });
    

    document.getElementById('editForm').addEventListener('submit', function (event) {
    	 event.preventDefault(); // 기본 제출 동작 방지

    	    if (!validateForm('editForm')) {
    	        // 폼이 유효하지 않은 경우
    	        swal('입력하지 않은 칸이 있습니다!', '', 'warning');
    	        return;
    	    }

    	    // 유효한 경우 SweetAlert로 사용자에게 확인 요청
    	    swal({
    	        title: '품목정보 수정',
    	        text: '정말 수정하시겠습니까? 한 번 더 정보를 확인해 주세요',
    	        icon: 'info',
    	        buttons: true,
    	        dangerMode: false,
    	    })
    	    .then((willSubmit) => {
    	        if (willSubmit) {
    	            swal('수정이 성공적으로 완료됐습니다!', '', 'success')
    	            .then(() => {
    	                event.target.submit(); // 확인을 누르면 submit 실행
    	            });
    	        } else {
    	            swal('수정 취소', '수정이 취소되었습니다.', 'info');
    	        }
    	    });
    });
    
    
   
   
    
    
</script>
