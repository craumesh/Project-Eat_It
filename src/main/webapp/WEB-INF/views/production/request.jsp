<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ include file="../include/header.jsp"%>
<%@ include file="../include/js.jsp"%>


	<div class="col-11 mx-auto">
	<div class="card my-4">
		<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 ">
			<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">
				<h3 class="text-white text-capitalize ps-5 align-items-center mb-0 py-1"> 자재 요청 </h3>
					<div class="align-items-center d-flex flex-column">
						<div class="input-group input-group-outline">
						</div>
					</div>
			</div>
		</div>		
		<div class="card-body mx-5 px-0 pb-4">
			<div class="table-responsive p-0">
               <form id="editform" method="post" class="d-flex">
                  <table id="edit-table" class="table h-25 ms-3">
                     <thead>
                        <tr class="row">
                           <th class="fs-5 text-center col" colspan="3">
                              자재 발주서                                       
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
                              수량
                           </th>
                           <th class="fs-6 text-center col col-1 px-0">
                           </th>
                        </tr>
                     </thead>
                     <tbody>
                     </tbody>
                  </table>
               </form>      
               <div class="col-6 w-100 text-end">		
			 		<button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" id="editbtn">자재 요청</button>
					<button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" onclick="closeWindow()">닫기</button>
               </div>
            </div>
         </div>
      </div>
   </div>



<%@ include file="../include/footer.jsp"%>

<script>
		
		var materialNamesArr=[];
		
		$.ajax({
		     url: '/production/getrequest',
		   method : 'GET',
		   dataType: 'json',
		   success : function(data) { 

			   
			   for(var i=0; i<data.length; i++){
				   materialNamesArr.push(data[i].name);
			   }
			   console.log(materialNamesArr);
			   
		   },
		   error : function(error) {
		      console.log('실패:', error);
		   }
		});	
		
		$("#addbtn").click(function(){
		      addRequiredEditTr(materialNamesArr,"","");
		   });
		
		
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

		       $("#edit-table tbody").append(newRow);
		   }
		
		   $("#edit-table").on("click", ".removebtn", function() {
		       $(this).closest("tr").remove();
		   });
	
		   
		   function addOptionsToSelect(selectElement, optionsArray, key) {
		       optionsArray.forEach(function(optionValue) {
		           var newOption = $("<option>");
		           
		           if(key == optionValue){
		              newOption.attr("selected", "selected");
		           }
		           
		           newOption.text(optionValue).appendTo(selectElement);
		       });
		   }
		   
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
							  title: "자재 요청을 하시겠습니까?",
							  text: "수량을 꼭 확인하세요!",
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
							    swal("최소하셨습니다");
							  }
						});	
					}
				}		    
			});	
		   
		   
    
</script>

