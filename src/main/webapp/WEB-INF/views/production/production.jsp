<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<%@ include file="../include/header.jsp" %>
<html>

<div class="col-11 mx-auto">
	<div class="card my-4">
		<div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 ">
			<div class="bg-gradient-primary shadow-primary border-radius-lg pt-3 pb-3 pe-3 d-flex">
				<h3 class="text-white text-capitalize ps-5 align-items-center mb-0 py-1">생산 관리</h3>
				<div class="ms-md-auto bg-white rounded p-2 d-flex align-items-center">
					<div class="align-items-center d-flex flex-column">
						<div class="input-group input-group-outline">
							<label class="form-label">검색어</label>
							<input type="text" id="searchword" name="searchword" class="form-control" value="${param.searchword }">
						</div>
					</div>
					<div class="align-items-center d-flex flex-column py-1">
						<button id="searchbtn" class="btn btn-outline-primary btn-sm mb-0 py-1 ms-2">검색</button>
					</div>
				</div>
			</div>
		</div>		
		<div class="card-body mx-5 px-0 pb-4">
			<div class="table-responsive p-0">
				
				<table id="hr-table" class="table table-hover align-items-center mb-0">
					<thead>
						<tr>
							<th class="text-center font-weight-bolder col-2">설비 코드</th>
							<th class="text-center font-weight-bolder col-2">관리자</th>
							<th class="text-center font-weight-bolder col-3">마지막 작동</th>
							<th class="text-center font-weight-bolder col-3">생산 시작 시간</th>
							<th class="text-center font-weight-bolder col-3">생산 완료</th>
							<th class="text-center font-weight-bolder col-1">설비 상태</th>
						</tr>
					</thead>
	 				<tbody id="employeeTableBody">
						 <c:forEach var="ml" items="${machinelist}">
							<tr class="mllist">
								<td class="text-center">${ml.machine_name}_${ml.machine_code}</td>
								<td class="text-center">${ml.name}</td>
								 <c:forEach var="history" items="${ml.infolist}">
								<td class="text-center">${history.use_history }</td>	
								<td class="text-center">
								<fmt:formatDate value="${history.operating_time}" pattern="MM월 dd일 HH:mm" />
								</td>
								<td class="text-center"><c:choose>
							        <c:when test="${history.product_time eq 0}">
							            00:00:00
							        </c:when>
							        <c:otherwise>
							           <fmt:formatDate value="${history.timeto_c}" pattern="MM월 dd일 HH:mm" />
							        </c:otherwise>
							    </c:choose></td>
								</c:forEach>
									<td class="text-center"><span id="status-badge"
										class="badge badge-sm bg-gradient-success"
										onclick="openStatusWindow('${ml.machine_code}', '/production/status')">
											${ml.machine_status} </span></td>
								</tr>
						</c:forEach>
					</tbody>
		
				</table>

			</div>
		</div>
		<div class="col-6 w-100 text-end">
		<button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" onclick="새창열기('/production/orderform')">발주서 확인</button>
        <button class="btn bg-gradient-dark fs-6 mb-0 py-2 px-3 me-3" onclick="새창열기('/production/request')">자재 요청</button>
		</div>
		<div class="row">
			<div class="col-sm-5">
				
			</div>
			<div class="col-sm-5">
				<ul class="pagination">
					<c:if test="${pageVO.prev }">
						<li class="page-link link-container"><a href="/production/${listUrl }?page=${pageVO.endPage-pageVO.displayPageNum }&searchword=${searchword}" class="link"><<</a></li>
					</c:if>
					<c:forEach var="i" begin="${pageVO.startPage }" end="${pageVO.endPage }" step="1">
						<li ${pageVO.cri.page == i ? "class='page-link link-container active'" : "class='page-link link-container'"} >
							<a href="/production/${listUrl }?page=${i }&searchword=${searchword}" ${pageVO.cri.page == i ? "class='link-white'" : "class=''"}>${i }</a>
						</li>				
					</c:forEach>
					<c:if test="${pageVO.next }">
						<li class="page-link link-container"><a href="/production/${listUrl }?page=${pageVO.startPage+pageVO.displayPageNum }&searchword=${searchword}" class="link">>></a></li>
					</c:if>
				</ul>
			</div>
		</div>
</div>
</div>



<%@ include file="../include/footer.jsp" %>
<%@ include file="../include/js.jsp" %>
<script type="text/javascript">
    
    
   
    
$(document).ready(function() {
    $('table tr').each(function() {
        var statusBadge = $(this).find('td:last-child #status-badge');
        var statusText = statusBadge.text().trim(); // 텍스트 앞뒤 공백 제거
        console.log("span: " + statusText);

        switch(statusText){
            case "생산중": statusBadge.addClass("bg-gradient-success"); break; // 초록
            case "생산 대기": statusBadge.addClass("bg-gradient-info"); break; // 파랑
            case "생산 완료": statusBadge.addClass("bg-gradient-danger"); break; // 빨강
            case "수리중": statusBadge.addClass("bg-gradient-warning"); break; // 노랑
            case "점검중": statusBadge.addClass("bg-gradient-warning"); break; // 노랑
            case "고장": statusBadge.addClass("bg-gradient-dark"); break; // 회색
            default: console.log("Unknown status: " + statusText);
        }
    });
});
    
    
    function 새창열기(url) {
        var screenWidth = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
        var screenHeight = window.innerHeight || document.documentElement.clientHeight || document.body.clientHeight;
        var popupWidth = 900;
        var popupHeight = 800;
        var leftPosition = (screenWidth - popupWidth) / 2;
        var topPosition = (screenHeight - popupHeight) / 2;

        window.open(url, "_blank", 'width=' + popupWidth + ',height=' + popupHeight + ',left=' + leftPosition + ',top=' + topPosition);
    }

    function openStatusWindow(machineCode, url) {
        var fullUrl = url + '?code=' + machineCode;
        새창열기(fullUrl);
    }
    
    
    
    
    
    
</script>


</html>