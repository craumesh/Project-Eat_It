////////////////////// 팝업 중앙 정렬 ////////////////////////
function popup() {
    const width = 720;
    const height = 775;

    // 현재 창의 중앙 좌표 계산
    const left = (window.innerWidth - width) / 2 + window.screenLeft;
    const top = (window.innerHeight - height) / 2 + window.screenTop;

    // 팝업 창 열기
    window.open('/warehouse/warehouseRegist', 'popup', `width=${width}, height=${height}, left=${left}, top=${top}`);
}
////////////////////// 팝업 중앙 정렬 ////////////////////////

/////////////////////// 상세 페이지(모달) ////////////////////
var modal = document.getElementById("warehouseModal");
var span = document.getElementsByClassName("btn-close")[0];

$(document).ready(function() {
    $(".warehouseDetailBtn").on("click", function() {
        var value = $(this).val();
//        console.log(value);
        $.ajax({
            url: '/warehouseContent?warehouse_no=' + value,
            type: 'GET',
            dataType: 'json',
            success: function(data) {
                $("#warehouse_no").text(data.warehouse_no);
                $("#location_name").text(data.location_name);
                $("#category").text(data.category);
                $("#warehouse_name").text(data.warehouse_name);
                $("#name").text(data.name);
                $("#contact").text(data.contact);
                $("#email").text(data.email);
                $("#use_status").text(data.use_status);
                $("#note").text(data.note);
                $("#updater").text(data.updater);
                
                // 날짜 포메팅 시작
                if(data.updatedate!=null){
//                $("#updatedate").text(data.updatedate);
                	var updateDate = new Date(data.updatedate);
                	var formattedDate = updateDate.getFullYear() + '-' + pad((updateDate.getMonth() + 1)) + '-' + pad(updateDate.getDate());
                	var formattedTime = formatTime(updateDate);
                	$("#updatedate").text(formattedDate + ', ' + formattedTime);
                }

                function pad(number) {
                    return (number < 10) ? '0' + number : number;
                }

                function formatTime(date) {
                    var hours = date.getHours();
                    var minutes = date.getMinutes();
                    var seconds = date.getSeconds();
                    var ampm = hours >= 12 ? '오후' : '오전';
                    hours %= 12;
                    hours = hours ? hours : 12; // 자정 처리
                    minutes = pad(minutes);
                    seconds = pad(seconds);
                    return ampm + ' ' + pad(hours) + ':' + minutes + ':' + seconds;
                }
                // 날짜 포메팅 끝
//                console.log(data);
                modal.style.display = "block";
            },
            error: function(error) {
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
			$("#view-table").toggleClass("d-none");
		    $("#edit-table").toggleClass("d-none");	
			$("#editbtn").text("수정 완료");
		    getEditInfo();
		} else {
			swal({
				  title: "정말 수정하시겠습니까?",
				  icon: "warning",
				  buttons: true,
				  dangerMode: true,
				})
				.then((willDelete) => {
				  if (willDelete) {
					swal("수정 완료!", {icon: "success"}).then(function(){
						$("#closebtn").click(); 
						$("#edit-form").submit();                
					});							
				  } else {
				    swal("수정 취소!");
				  }
			});		    
		}		    
	});
    
    if($("#searchword").val()) {
		$(".input-group").addClass("focused is-focused");
	}
	 	
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
    
    function getEditInfo() {
    	$("#warehouse_no-forSubmit").val($("#warehouse_no").text());
    	$("#category-input").val($("#category").text());
    	$("#warehouse_name-input").val($("#warehouse_name").text());
		$("#name-input").val($("#name").text());
		$("#contact-input").val($("#contact").text());
		$("#email-input").val($("#email").text());
		$("#note-input").val($("#note").text());
	}
    
    // 직책에 맞는 맴버 뽑아오기
    $("#choices-Position").change(function(){
    	wareUpdateDetailInfo();
    });
    
    function wareUpdateDetailInfo(){
    	let poName = $('#choices-Position').val();
    	$.ajax({
    		url:"/wareUpdateDetailInfo",
    		type:'get',
    		data:{position_name:poName},
    		dataType:'json',
    		success: function(result){
//    			console.log(result);
    			// 기존 내용 초기화
    			if(poName=="직책 선택"){
    				 $("#choices-Name").html("<option></option>");
    			}else{
    				$("#choices-Name").html("<option selected>이름 선택</option>");
    			}

                // 새로운 값 추가
                for (let i = 0; i < result.length; i++) {
                    $("#choices-Name").append(`<option value="${result[i]}">${result[i]}</option>`);
                }
    		},
    		error: function(result){
//    			console.log(result);
    			alert("올바르지 않는 접근입니다");
    		}
    	});
    }
    
    // 이름에 맞는 회원정보 출력
    $("#choices-Name").change(function(){
    	updateDetailInfoByName();
    });
    
    function updateDetailInfoByName(){
    	let infoByName = $('#choices-Name').val();
    	let poName = $('#choices-Position').val();
    	$.ajax({
    		url:"/updateDetailInfoByName",
    		type:'get',
    		data:{info:infoByName},
    		dataType:'json',
    		success: function(data){
    			console.log(data);
    			function getInfo(){
					$("#name-input").val($("#name").text());
					$("#contact-input").val($("#contact").text());
					$("#email-input").val($("#email").text());
				}
    			
    			if(infoByName=="이름 선택"){
    				getInfo();
    			}else{
    				$("#name-input").val(data[0].name);
    				$("#contact-input").val(data[0].contact);
    				$("#email-input").val(data[0].email);
    			}
    			
    		},
    		error: function(result){
    			alert("올바르지 않는 접근입니다");
    		}
    	});
    }
    
});
/////////////////////////// 상세 페이지(모달) //////////////////////////
