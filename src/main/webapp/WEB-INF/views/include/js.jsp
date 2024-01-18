<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
  <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/core/popper.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/core/bootstrap.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/plugins/perfect-scrollbar.min.js"></script>
  <script src="${pageContext.request.contextPath}/resources/js/plugins/smooth-scrollbar.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
  <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>

<script>
function checkAccess(departName, allowedDepartments) {
    return !allowedDepartments.includes(departName);
}

function handleAccessDenied() {
	swal("해당 메뉴에 접근할 권한이 없습니다.", "※부서를 이동하시거나 당신 일을 찾아 떠나세요※", "warning");
    document.body.classList.add('no-access');
}

function hideDropdown(dropdownButtonId) {
    var dropdownButton = document.getElementById(dropdownButtonId);
    var dropdownMenu = dropdownButton.nextElementSibling;

    if (dropdownButton && dropdownMenu) {
        dropdownButton.setAttribute('aria-expanded', 'false');
        dropdownMenu.classList.remove('show');
    }
}

function totalCheck() {
    var totalDepartName = '<%= String.valueOf(session.getAttribute("depart_name")) %>';
    var allowedDepartments = ["총괄"];

    if (checkAccess(totalDepartName, allowedDepartments)) {
        hideDropdown('totalDropdownMenuButton');
        handleAccessDenied();
    }
}

function materialCheck() {
    var materialDepartName = '<%= String.valueOf(session.getAttribute("depart_name")) %>';
    var allowedDepartments = ["총괄", "영업"];

    if (checkAccess(materialDepartName, allowedDepartments)) {
        hideDropdown('materialDropdownMenuButton');
        handleAccessDenied();
    }
}

function machineCheck() {
    var machineDepartName = '<%= String.valueOf(session.getAttribute("depart_name")) %>';
    var allowedDepartments = ["총괄", "생산"];

    if (checkAccess(machineDepartName, allowedDepartments)) {
        hideDropdown('machineDropdownMenuButton');
        handleAccessDenied();
    }
}

function warehouseCheck() {
    var warehouseDepartName = '<%= String.valueOf(session.getAttribute("depart_name")) %>';
    var allowedDepartments = ["총괄", "관리"];

    if (checkAccess(warehouseDepartName, allowedDepartments)) {
        hideDropdown('warehouseDropdownMenuButton');
        handleAccessDenied();
    }
}

function orderCheck() {
    var orderDepartName = '<%= String.valueOf(session.getAttribute("depart_name")) %>';
    var allowedDepartments = ["총괄", "영업"];

    if (checkAccess(orderDepartName, allowedDepartments)) {
        hideDropdown('orderDropdownMenuButton');
        handleAccessDenied();
    }
}

function hrCheck() {
    var hrDepartName = '<%= String.valueOf(session.getAttribute("depart_name")) %>';
    var allowedDepartments = ["총괄"];

    if (checkAccess(hrDepartName, allowedDepartments)) {
        hideDropdown('hrDropdownMenuButton');
        handleAccessDenied();
    }
}


</script>

<script>
var result = "${result}";

if(result == "LOGOUT"){
	swal('로그아웃을 해?',"일 해야지 어디가?",'success');
}
if(result == "LOGIN"){
	swal('로그인 성공!',"일하러 온 걸 환영해♥",'success');	
}
if(result == "FAILLOGIN"){
	swal("비밀번호를 틀리셨군요!","비밀번호를 다시 입력해주세요","error");
}
if(result == "JOIN"){
	swal("회원가입 성공!!","이제 일하러 가볼까?","success");
}
if(result == "WAIT"){
	swal("승인 대기중!!","인사담당에게 연락해보시오","warning");
}
</script>

  <script>
	var infoModal = document.getElementById("InfoModal");

	$(document).ready(function() {			
		var urlParams = window.location.href;	
		
		$("#profileBtn").click(function() {
			$.ajax({
				url : '/members/profile',
				method : 'GET',
				dataType: 'json',
				success : function(data) {
					$('#info_photo_paths').attr('src', data.photo_paths).attr('width', '100');
	                $("#info_employee_no").text(data.employee_no);
	                $("#infoEmployee_no-forSubmit").val(data.employee_no);
	                $("#info_id").text(data.id);
	                $("#info_name").text(data.name);
	                $("#info_depart_name").text(data.depart_name);
	                $("#info_position_name").text(data.position_name);
	                $("#info_email").text(data.email);
	                $("#info_extension_no").text(data.extension_no);
	                $("#info_contact").text(data.contact);
	                $("#info_address").text(data.address);
	                $("#info_status").text(data.status);
					infoModal.style.display = "block";
				},
				error : function(error) {
					console.log('실패:', error);
				}
			});
		});
		
		$("#infoClosebtn").click(function(){
			infoModal.style.display = "none";
			location.reload();
		});
		
		$("#infoEditbtn").click(function(){
			if ($("#infoEdit-table").hasClass("d-none")) {
				$("#infoView-table").toggleClass("d-none");
			    $("#infoEdit-table").toggleClass("d-none");	
				$("#infoEditbtn").text("수정 완료");
			    getEditMyInfo();
			    updatePositionMyNameSelect();
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
							$("#infoClosebtn").click(); 
							$("#infoPrev-url-forSubmit").val(urlParams);
							$("#infoEdit-form").submit();                
						});							
					  } else {
					    swal("우유부단 하시군요!");
					  }
				});		    
			}		    
		});		
		
		$(window).click(function(event){
			if (event.target == infoModal) {
				infoModal.style.display = "none";
				location.reload();
			}
			
			if (!$(event.target).closest('.input-group').length) {
		        $(".input-group").removeClass("focused is-focused");
		    }
		});		
		
		$(".input-group").click(function(){
			$(this).addClass("focused is-focused");
		});
		
		$("#info_depart_name-select").on("change", function() {			
			updatePositionMyNameSelect();
		});	
	});
	
	function getEditMyInfo() {
	    getSelected("#info_depart_name");
	    getSelected("#info_position_name");
		$("#info_email-input").val($("#info_email").text());
		$("#info_extension_no-input").val($("#info_extension_no").text());
		$("#info_contact-input").val($("#info_contact").text());
		$("#info_address-input").val($("#info_address").text());
	    getSelected("#info_status");
	}
	
	function updatePositionMyNameSelect() {
	    var infoSelectedValue = $("#info_depart_name-select").val();
	    var infoPositionNameSelect = $("#info_position_name-select");

	    infoPositionNameSelect.empty();

	    switch (infoSelectedValue) {
	      case "미정":
	        addOption(infoPositionNameSelect, "미정");
	        break;
	      case "관리":
	        addOption(infoPositionNameSelect, "정보");
	        addOption(infoPositionNameSelect, "재고");
	        break;
	      case "생산":
	        addOption(infoPositionNameSelect, "상품");
	        addOption(infoPositionNameSelect, "설비");
	        break;
	      case "영업":
	        addOption(infoPositionNameSelect, "자재");
	        addOption(infoPositionNameSelect, "납품");
	        break;
	      case "총괄":
	        addOption(infoPositionNameSelect, "임원");
	        break;
	    }
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

  <script>
    function sample5_execDaumPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                var addr = data.address; // 최종 주소 변수

                // 주소 정보를 해당 필드에 넣는다.
                document.getElementById("info_address-input").value = addr;
            }
        }).open();
    }
</script>