<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<%@ include file="../include/header.jsp"%>

<!-- 본문 시작 -->
<div class="col-12">
	<div class="card my-4 mx-4">
		<div class="card-header position-relative p-0 mt-n4 mx-3 z-index-2">
			<div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-3 d-flex align-items-center">
				<h3 class="text-white text-capitalize ps-5 my-2 py-1">소요 정보 관리</h3>
				<form id="searchForm" class="ms-md-auto bg-white rounded p-2 mb-0 d-flex align-items-center">
					<div class="align-items-center d-flex flex-column mx-1">
						<div class="input-group input-group-outline">
							<label class="form-label">검색어</label>
							<input type="text" id="query" name="query" class="form-control" value="${param.query }">
							<input type="hidden" id="filter" name="filter" value="${param.filter }">
						</div>
					</div>
					<div class="align-items-center d-flex flex-column py-1 ct-example">
						<div class="align-items-center d-flex flex-column py-1 ct-example">
							<button type="button" id="searchbtn" class="btn btn-outline-primary mb-0 py-2 mx-1 fs-6">검색</button>
						</div>
					</div>
				</form>
			</div>
		</div>

		<div class="w-100" style="background-image: url('/resources/img/backgroundLogo.png'); background-repeat: no-repeat; background-position: center center; z-index: 0 !important;">
			<div class="card-body mx-5 px-0 py-0 z-index-1 min-vh-65">
				<div class="table-responsive p-0 mx-4 overflow-hidden "  style="background-color: white;">
					<form action="/masterdata/delRequires" id="batchForm" method="post">
						<input type="hidden" id="query-forDelSubmit" name="query">
						<input type="hidden" id="filter-forDelSubmit" name="filter">
						<c:if test="${empty page }">
							<input type="hidden" id="page-forDelSubmit" name="page" value="1">
						</c:if>
						<table id="required_table" class="table table-hover align-items-center mb-0">
							<thead>
								<tr>
									<th class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 py-3 col-1">
										<input type="checkbox" class="m-1" id="selectAll">
									</th>
									<th class="text-center py-3 font-weight-bolder col-1">품목정보번호</th>
									<th class="text-center font-weight-bolder col-1">품목코드</th>
									<th class="text-center font-weight-bolder col-2">품목이름</th>
									<th class="text-center font-weight-bolder col-1">분류</th>
									<th class="text-center font-weight-bolder col-2">거래처</th>
									<th class="text-center font-weight-bolder col-1">단위</th>
									<th class="text-center font-weight-bolder col-1">단위 단가</th>
									<th class="text-center font-weight-bolder col-1">
										<div class="dropdown">
											<button class="btn btn-outline-secondary dropdown-toggle mb-0 fs-6"
											type="button" id="dropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false">
												<span id="dropdown-selected">${empty param.filter ? "전체" : param.filter }</span>
											</button>
											<ul class="dropdown-menu" aria-labelledby="dropdownMenuButton">
												<li><a class="dropdown-item">전체</a></li>
												<li><a class="dropdown-item">등록</a></li>
												<li><a class="dropdown-item">미등록</a></li>
											</ul>
										</div>
									</th>
								</tr>
							</thead>
							<tbody id="productTableBody" >
								<c:forEach var="product" items="${CIMList}">
									<tr>
										<td class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7 ps-2 py-3">
											<input type="checkbox" class="checkbox m-1" name="checkgroup" value="${product.product_no}">
										</td>
										<td class="text-center py-2-3 identify-no">${product.product_no}</td>
										<td class="text-center py-2-3">${product.code}</td>
										<td class="text-center py-2-3">${product.name}</td>
										<td class="text-center py-2-3">${product.category_detail}</td>
										<td class="text-center py-2-3">${product.company_name}</td>
										<td class="text-center py-2-3">${product.unit}</td>
										<td class="text-center py-2-3"><fmt:formatNumber value="${product.price}" type="currency" currencySymbol="₩" /></td>							
										<td class="text-center py-2-3">${product.recipe != "미등록" ? '등록' : product.recipe}</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</form>
				</div>
			</div>
		</div>
		<div class="row mb-2">
			<div class="col-sm-5">
				<div class="ms-5">Showing ${pageVO.startPage } to ${pageVO.endPage }</div>
			</div>
			<div class="col-sm-5">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="page-link link-container">
							<a href="/masterdata/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&filter=${filter}&query=${query}" class="link"><<</a>
						</li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						<li ${pageVO.cri.page == i ? "class='page-link link-container active'" : "class='page-link link-container'"} >
							<a href="/masterdata/${listUrl }?page=${i }&filter=${filter}&query=${query}" ${pageVO.cri.page == i ? "class='link-white'" : "class=''"}>${i }</a>
						</li>				
					</c:forEach>
					<c:if test="${pageVO.next }">
						<li class="page-link link-container">
							<a href="/masterdata/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&filter=${filter}&query=${query}" class="link">>></a>
						</li>
					</c:if>
				</ul>
			</div>
			<button id="delbtn" class="btn bg-gradient-dark fs-6 mx-5 py-2 px-0 col">
				선택 삭제
			</button>
		</div>
	</div>
</div>
<!-- 본문 종료 -->

<%@ include file="../include/footer.jsp"%>
<%@ include file="../include/js.jsp"%>

<div id="editModal" class="modal">
	<div class="modal-dialog" style="max-width:800">
		<div class="modal-content">
			<div class="modal-header py-4">
				<button id="closebtn"
					class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5"
					onclick="closeEditModal()">X</button>
				<h3 class="modal-title mx-auto">소요 정보</h3>
			</div>
			<div class="modal-body p-5">
				<div id="tableContainer" class="modal-body">
					<form id="editform" method="post" class="d-flex">
						<table class="table me-3">
							<tbody>
								<tr>
									<th class="fs-5 py-3">품목코드</th>
									<td class="fs-5 ps-5">
										<input type="text" id="code_forEdit" name="code" class="form-control" readonly="readonly">
										<input type="hidden" id="product_no_forEdit" name="product_no" value="product_no">
										<c:if test="${empty page }">
											<input type="hidden" id="page-forEdit" name="page" value="1">
										</c:if>
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">품목명</th>
									<td class="fs-5 ps-5">
										<input type="text" id="name_forEdit" name="name" class="form-control" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">대분류</th>
									<td class="fs-5 ps-5">
										<input type="text" id="category_forEdit" name="category" class="form-control" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">소분류</th>
									<td class="fs-5 ps-5">
										<input type="text" id="category_detail_forEdit" name="category_detail" class="form-control" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">거래처</th>
									<td class="fs-5 ps-5">
										<input type="text" id="company_name_forEdit" name="company_name" class="form-control" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">단위</th>
									<td class="fs-5 ps-5"> 
										<input type="text" id="unit_forEdit" name="unit" class="form-control" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">단위량</th>
									<td class="fs-5 ps-5"> 
										<input type="text" id="unit_quantity_forEdit" name="unit_quantity" class="form-control" readonly="readonly">
									</td>
								</tr>
								<tr>
									<th class="fs-5 py-3">단위단가</th>
									<td class="fs-5 ps-5">
										<input type="text" id="price_forEdit" name="price" class="form-control" readonly="readonly">
									</td>
								</tr>
							</tbody>
						</table>
						<table id="view-table" class="table h-25 ms-3">
							<thead>
								<tr class="row">
									<th class="fs-5 text-center col" colspan="3">
										레시피
									</th>
								</tr>
								<tr class="row">									
									<th class="fs-6 text-center col">
										자재명
									</th>
									<th class="fs-6 text-center col">
										소요량
									</th>
									<th class="fs-6 text-center col col-1 px-0">
									</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
						<table id="edit-table" class="table h-25 ms-3 d-none">
							<thead>
								<tr class="row">
									<th class="fs-5 text-center col" colspan="3">
										레시피														
										<button type="button" id="addbtn" class="btn bg-gradient-success btn-sm fs-6 py-0 px-2 mb-0 end-0 position-absolute">
											+
										</button>
									</th>
								</tr>							
								<tr class="row">									
									<th class="fs-6 text-center col">
										자재명
									</th>
									<th class="fs-6 text-center col">
										소요량
									</th>
									<th class="fs-6 text-center col col-1 px-0">
									</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</form>		
					<div class="text-center">
						<button id="editbtn" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3">
							소요 수정
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<script>
$(document).ready(function() {    
	var materialNamesArr;
	
	$.ajax({
        url: '/masterdata/materialNames',
		method : 'GET',
		dataType: 'json',
		success : function(data) { 
			materialNamesArr = data;
		},
		error : function(error) {
			console.log('실패:', error);
		}
	});
	
	if (!$(".dropdown-menu").hasClass("show")) {
		dropItemReposition();
	}
	
	if($("#query").val()) {
		$(".input-group").addClass("focused is-focused");
	}
	
	$('#selectAll').change(function () {
        $('.checkbox').prop('checked', $(this).prop('checked'));
	});
	
	$("#searchbtn").click(function(){
		$("#searchForm").submit();
	});
	
	$("#required_table").on("click", "tr td:not(:first-child)", function(event) {
        var value = $(this).closest("tr").find("td.identify-no").text();
        $.ajax({
            url: '/masterdata/cimContent?product_no='+value,
			method : 'GET',
			dataType: 'json',
			success : function(data) { 
				$("#product_no_forEdit").val(data.product_no);
				$("#code_forEdit").val(data.code);
				$("#name_forEdit").val(data.name);
				$("#category_forEdit").val(data.category);
				$("#category_detail_forEdit").val(data.category_detail);
				$("#company_name_forEdit").val(data.company_name);
				$("#unit_forEdit").val(data.unit);
				$("#unit_quantity_forEdit").val(data.unit_quantity);
				$("#price_forEdit").val(data.price);
				
				if (data.recipe !== '미등록') {		
					var recipe = JSON.parse(data.recipe)[data.product_no];
					
			        for (var key in recipe) {
						var value = recipe[key];
						setRequiredTr(key,value);
					}			        
				} else {
				    console.error('소요 정보가 등록 되어있지 않습니다!');
				}							
			    document.getElementById("editModal").style.display = "block";
			},
			error : function(error) {
				console.log('실패:', error);
			}
		});
    });
	
	$(window).click(function(event){
		if (event.target == document.getElementById("editModal")) {
			closeEditModal();
		}
		
		if (!$(event.target).closest('.input-group').length) {
			if (!$("#query").val()) {
	       		$(".input-group").removeClass("focused is-focused");
			} else {
				$(".input-group").addClass("focused is-focused");
			}
	    }
	});	
	
	$(".input-group").click(function(){
		$(this).addClass("focused is-focused");
	});
	
	$(".dropdown-item").click(function(){
		$("#dropdown-selected").text($(this).text());
		$("#filter").val($("#dropdown-selected").text());
		$("#searchForm").submit();
	});
	
	$("#dropdownMenuButton").click(function(){
		dropItemReposition();
	});
	
	$("#editbtn").click(function(){
		if ($("#edit-table").hasClass("d-none")) {
			$("#editbtn").text("수정 완료");
			
			$("#view-table").find('tbody tr').each(function() {		       
		            var material = $(this).find('td').find('.material-input');
		            var required = $(this).find('td').find('.required-input');
		           
		            addRequiredEditTr(materialNamesArr, material.val(), required.val());
		    });
			
			toggleTable();
		} else {
			var isEmpty = false;
			var isDuplication = false;
			
			var selectedValues = new Set();

			$('.materialGroup').each(function() {
			    var selectedValue = $(this).val();
			    if (selectedValues.has(selectedValue)) {
			    	isDuplication = true;
			        return false;
			    } else {
			        selectedValues.add(selectedValue);
			    }
			});
			
			$('.requiredGroup').each(function(){
				if ($(this).val().trim() === '') {
					isEmpty = true;
					return false;
				}
			});
			
			if(isEmpty){
				swal({
					  title: "소요량이 비어있습니다!",
					  text: "필요없는 자재를 제거하거나 소요량을 입력하세요!",
					  icon: "warning",
					  button: "확인",
					});
			} else if(isDuplication) {
		    	swal({
					  title: "중복된 자재가 있습니다!",
					  text: "중복된 자재를 제거하거나 변경하세요!",
					  icon: "warning",
					  button: "확인",
					});
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
							$("#editform").submit();                
						});							
					  } else {
					    swal("우유부단 하시군요!");
					  }
				});	
			}
		}		    
	});	
	
	$("#addbtn").click(function(){
		addRequiredEditTr(materialNamesArr,"","");
	});	

	$("#edit-table").on("click", ".removebtn", function() {
	    $(this).closest("tr").remove();
	});
	
	$("#delbtn").click(function(){
		swal({
			  title: "정말 삭제 하시겠습니까?",
			  text: "진짜??",
			  icon: "warning",
			  buttons: true,
			  dangerMode: true,
			})
			.then((willDelete) => {
			  if (willDelete) {
				swal("처리되었습니다!", {icon: "success"}).then(function(){					
					$("#query-forDelSubmit").val('${param.query}');
					$("#filter-forDelSubmit").val('${param.filter}');
					$("#batchForm").submit();
				});							
			  } else {
			    swal("취소되었습니다!");
			  }
		});
	});	
});

	function dropItemReposition(){
		if (!$(".dropdown-menu").hasClass("show")) {
			$(".dropdown-menu").css('inset', '0 0 auto auto');
		}
	}

	// Modal 에디트 테이블에 데이터 추가
	function addRequiredEditTr(materialNamesArr, key, value){
        console.log('key:', key);
        console.log('value:', value);
		var newRow = $("<tr>").addClass("row");
	    var selectTd = $("<td>").addClass("col w-50").appendTo(newRow);
	    var newSelect = $("<select>").attr("name", "materialGroup").addClass("w-100 text-center materialGroup");
	    var inputTd = $("<td>").addClass("col w-50").appendTo(newRow);
	    var buttonTd = $("<td>").addClass("col col-1").appendTo(newRow);
	    
	    addOptionsToSelect(newSelect, materialNamesArr, key);
		newSelect.appendTo(selectTd);
	    
	    $("<input>").attr({
	        "type": "number",
	        "name": "requiredGroup",
	        "value": (value == "" ? "" : value)
	    }).addClass("w-100 text-center requiredGroup").appendTo(inputTd);

	    $("<button>").attr("type", "button").addClass("btn bg-gradient-warning btn-sm fs-6 py-0 px-2 mb-0 removebtn").text("-").appendTo(buttonTd);

	    applyValidation(newRow.find('.requiredGroup'));
	    
	    $("#edit-table tbody").append(newRow);
	}

	// Modal 뷰 테이블에 초기부터 표기할 데이터
	function setRequiredTr(key, value){
		var newRow = $("<tr>").addClass("row");
		
	    var materialInput = $("<td>").addClass("col w-50 border-end");
	    $("<input>").attr({
	    	"type": "text",
	    	"value": key,
	    	"readonly": "readonly"
	    }).addClass("w-100 py-0 form-control text-center material-input").appendTo(materialInput);

	    var requiredInput = $("<td>").addClass("col w-50");
	    $("<input>").attr({
	    	"type": "text",
	    	"value": value,
	    	"readonly": "readonly"
	    }).addClass("w-100 py-0 form-control text-center required-input").appendTo(requiredInput);
	    
	    var emptyTdforBtn = $("<td>").addClass("col col-1 px-0");
	    
	    newRow.append(materialInput, requiredInput, emptyTdforBtn);
		$("#view-table tbody").append(newRow);
	}
	
	// 보이는 테이블 전환
	function toggleTable(){
		$("#view-table").toggleClass("d-none");
	    $("#edit-table").toggleClass("d-none");			
	}
	
	// 드롭다운에 동적으로 옵션 추가
	function addOptionsToSelect(selectElement, optionsArray, key) {
	    optionsArray.forEach(function(optionValue) {
	        var newOption = $("<option>");
	        
	        if(key == optionValue){
	        	newOption.attr("selected", "selected");
	        }
	        
	        newOption.text(optionValue).appendTo(selectElement);
	    });
	}
    
    function closeEditModal() {
        document.getElementById("editModal").style.display = "none";
        location.reload();
    }
    
    
    function applyValidation(element) {
        element.on("input", function(e) {
            var value = $(this).val();
            if (!/^[1-9]\d*$/.test(value)) {
                $(this).val($(this).data("prevValue") || "");
            } else {
                $(this).data("prevValue", value);
            }
        });
    }
</script>
