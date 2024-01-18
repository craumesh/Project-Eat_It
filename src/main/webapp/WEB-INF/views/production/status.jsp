<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>


	<div class="col-11 mx-auto">
	<div class="card my-4">
		<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 ">
			<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">
				<h3 class="text-white text-capitalize ps-5 align-items-center mb-0 py-1"> ${infolist.machine_name }_${infolist.machine_code } </h3>
				<input type="hidden" id="machineCodeHidden" value="${infolist.machine_code}">
					<div class="align-items-center d-flex flex-column">
						<div class="input-group input-group-outline">
						</div>
					</div>
				
			</div>
		</div>		
	
		<div class="card-body mx-5 px-0 pb-4">
			<div class="table-responsive p-0">
				<form action="" method="post" id="checkbox_form">
				<table class="table align-items-center mb-0">
							<thead>
								<tr>
								<th class="text-center w-7"><span id="status-badge" class="badge badge-sm bg-gradient-success">${infolist.machine_status }</span></th>
								<td></td>
								</tr>
							</thead>
							<tbody id="statusTableBody">
							<tr>
							<th class="text-center fs-5"> 생산 번호 : </th>
							 <td class="fs-5">${status.ordersVOlist[0].order_id != null ? status.ordersVOlist[0].order_id : "생산중인 제품이 없습니다."}</td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 제품 :  </th>
							<td class="fs-5"> ${status.name  != null ? status.name : "생산중인 제품이 없습니다."}</td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 수량 :  </th>
							<td class="fs-5"> ${status.ordersVOlist[0].quantity != null ? status.ordersVOlist[0].quantity : "OOOO"} EA </td>
							</tr>
							
<!-- 							<tr> -->
<!-- 							<th class="text-center fs-5"> 생산 완료 :  </th> -->
<%-- 							<td class="fs-5">${status.infolist[0].product_time != null ? status.infolist[0].product_time : "00:00:00" } </td> --%>
<!-- 							</tr> -->
					</tbody>
						</table>
		</form>
			</div>
		</div>
		<div class="col-6 w-100 text-end">		
		<button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" onclick="openModal()">생산 완료</button>
		<button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" onclick="closeWindow()">닫기</button>
		</div>
		<div class="row">
			<div class="col-sm-5">
				
			</div>
		</div>
</div>
</div>

<!-- 모달 -->
<div id="myModal" class="modal top-10 position-absolute z-index-4" data-bs-backdrop="static" data-bs-keyboard="false">
    <div class="modal-dialog">
        <div class="modal-content w-100">
            <div class="modal-header">
                <button id="closebtn" class="btn bg-gradient-primary position-absolute py-1 px-2 mt-2 end-5" onclick="closeModal()">X</button>
                <h3 class="modal-title mx-auto">생산 완료</h3>
            </div>
            <div class="modal-body p-5">
                <div id="tableContainer">
                    <form action="/production/production" id="myForm" method="post">
                    <table class="table align-items-center mb-0">
							<tbody id="statusTableBody">
							<tr><td>
							<input type="hidden" name="product_no" value="${status.masterdataVOlist[0].product_no}">
							<input type="hidden" name="machine_code" value="${infolist.machine_code}">
							</td></tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 번호 : </th>
							 <td class="fs-5">${status.ordersVOlist[0].order_id != null ? status.ordersVOlist[0].order_id : "생산중인 제품이 없습니다."}</td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 제품 :  </th>
							<td class="fs-5"> ${status.name  != null ? status.name : "생산중인 제품이 없습니다."}</td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 생산 수량 :  </th>
							<td class="fs-5" style="display: flex; align-items: center; text-align-last: center;">
							<input class="form-control" style="width: 20%;font-size: 21;" name=production_quantity value="${status.ordersVOlist[0].quantity != null ? status.ordersVOlist[0].quantity : 'OOOO'}">  EA </td>
							</tr>

							<tr>
							<th class="text-center fs-5"> 입고 창고 : </th>
							<td class="fs-5"> 2 </td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 소비 기한 : </th>
							
							<td class="fs-5"> 생산일로 부터 ${status.masterdataVOlist[0].EXP_intervar} 일
							<input type="hidden" class="form-control" name="EXP_intervar" value="${status.masterdataVOlist[0].EXP_intervar }"> 
							</td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 정상 수량:  </th>
							 <td class="fs-5">
							 <input type="number" class="w-50" id="normalInput" name="products" min="0" maxlength="3" max="${status.ordersVOlist[0].quantity}" oninput="validateInput(this)">
							 </td>
							</tr>
							
							<tr>
							<th class="text-center fs-5"> 불량 수량:  </th>
							<td class="fs-5"> <input type="number" class="w-50" min="0" id="defectiveInput" name="defective_product"> </td>
							</tr>
							
					</tbody>
						</table>
                        <div class="text-center">
                            <button class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" onclick="registerEquipment()">생산완료</button>
                            <input type="button" class="btn bg-gradient-danger fs-6 mb-0 py-2 px-3" onclick="closeModal()" value="취소">
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../include/footer.jsp"%>

<script>
	function closeWindow() {
    	window.close();
	}
	
	  function openModal() {
	        $('#myModal').modal('show');
	    }
	  function closeModal() {
	        $('#myModal').modal('hide');
	    }


	    $('#myModal').on('hidden.bs.modal', function () {
	       
	        location.reload(); 
	    });
	    
	    $(document).ready(function () {
	        function updateInputs() {
	            var totalQuantity = parseInt("${status.ordersVOlist[0].quantity}");
	            var normalInput = parseInt($("#normalInput").val()) || 0;

	            normalInput = Math.max(normalInput, 0);
	            normalInput = Math.min(normalInput, totalQuantity);

	            var defectiveInput = totalQuantity - normalInput;
	            $("#defectiveInput").val(defectiveInput);
	        }

	        $("#normalInput").on("input", function () {
	            updateInputs();
	        });

	        $("#defectiveInput").on("input", function () {
	            updateInputs();
	        });
	    });

	    function validateInput(input) {
	        var max = parseInt(input.getAttribute("max"));
	        var value = parseInt(input.value) || 0;

	        if (value > max) {
	            input.value = max;
	        }

	        updateInputs();
	    }
    	
	    function registerEquipment() {
	        var formData = new FormData(document.getElementById("myForm"));

	        $.ajax({
	            type: "POST",
	            url: "/production/production",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function (response) {

	            	
	            },
	            error: function (error) {

	                console.error("에에러:", error);
	            }
	        });
	    }

	   
    
</script>

