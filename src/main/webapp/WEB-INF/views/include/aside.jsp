<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <aside class="sidenav navbar navbar-vertical navbar-expand-xs border-0 border-radius-xl my-3 fixed-start ms-3   bg-gradient-dark" id="sidenav-main">
   <div class="sidenav-header">
     <a class="navbar-brand m-0" href="/">
       <!-- <span class="ms-1 font-weight-bold text-white">디저트카페 EatIt</span> -->
       <img src="../resources/img/asideLogo.png" class="w-100 min-vh-5">
     </a>
   </div>
   <hr class="horizontal light mt-0 mb-2">
   <div class="collapse navbar-collapse  w-auto" id="sidenav-collapse-main">
		 <div class="dropdown mb-3 mt-3 ms-4-5 w-100">
			  <button class="btn bg-gradient-secondary dropdown-toggle w-70 fs-6" type="button" id="totalDropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" onclick="totalCheck()">
			   	 기준정보 관리
			  </button>
			  <ul class="dropdown-menu w-80" aria-labelledby="totalDropdownMenuButton">
   			  	<li>
   			  		<a class="dropdown-item fs-6" href="${path}/masterdata/BomMain">BOM 관리</a>
		  		</li>
				<li>
					<a class="dropdown-item fs-6" href="${path}/masterdata/QualityManagement">설비정보관리</a>
				</li>
			  </ul>
		 </div>
   		 <div class="dropdown mb-3 ms-4-5 w-100">
	  		<button class="btn bg-gradient-secondary dropdown-toggle w-70 fs-6" type="button" id="materialDropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" onclick="materialCheck()">
	   			 자재 관리
 		    </button>
	  		<ul class="dropdown-menu w-80" aria-labelledby="materialDropdownMenuButton">
			    <li>
			    	<a class="dropdown-item fs-6" href="/Material/materialadd">자재 입출고 관리</a>
			    </li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/Material/MaterialOrderList">자재 발주 내역</a>
			    </li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/Material/list">자재 정보 관리</a>
			    </li>
	  		</ul>
		 </div>
      	 <div class="dropdown mb-3 ms-4-5 w-100">
			<button class="btn bg-gradient-secondary dropdown-toggle w-70 fs-6" type="button" id="machineDropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" onclick="machineCheck()">
			   	 설비 & 생산 관리
			</button>
  			<ul class="dropdown-menu w-80" aria-labelledby="machineDropdownMenuButton">
			    <li>
			    	<a class="dropdown-item fs-6" href="/machine/machine">설비 관리</a>
			    </li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/production/production">생산 관리</a>
			    </li>
			    <li>
			    	<a class="dropdown-item fs-6" href="#">서브메뉴 3</a>
			    </li>
	  		</ul>
		</div>
      	<div class="dropdown mb-3 ms-4-5 w-100">
			<button class="btn bg-gradient-secondary dropdown-toggle w-70 fs-6" type="button" id="warehouseDropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" onclick="warehouseCheck()">
			   	창고 관리
			</button>
	  		<ul class="dropdown-menu w-80" aria-labelledby="warehouseDropdownMenuButton">
		    	<li>
		    		<a class="dropdown-item fs-6" href="/warehouse/warehouseMain">창고 목록</a>
		    	</li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/warehouse/stockInfo">창고 입출고 관리</a>
			    </li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/warehouse/stockMain">창고 재고 현황</a>
			    </li>
			</ul>
		</div>
        <div class="dropdown mb-3 ms-4-5 w-100">
	  		<button class="btn bg-gradient-secondary dropdown-toggle w-70 fs-6" type="button" id="orderDropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" onclick="orderCheck()">
	   			납품 관리
	  		</button>
			<ul class="dropdown-menu w-80" aria-labelledby="orderDropdownMenuButton">
			  	<li>
			  		<a class="dropdown-item fs-6" href="/orders/lists">주문 목록</a>
			  	</li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/deliverys/lists">배송 목록</a>
			    </li>
			</ul>
		</div>
        <div class="dropdown ms-4-5 w-100">
			<button class="btn bg-gradient-secondary dropdown-toggle w-70 fs-6" type="button" id="hrDropdownMenuButton" data-bs-toggle="dropdown" aria-expanded="false" onclick="hrCheck()">
			   	인사 관리
			</button>
			<ul class="dropdown-menu w-80" aria-labelledby="hrDropdownMenuButton">
			    <li>
			    	<a class="dropdown-item fs-6" href="/hr/list">인사 정보</a>
			    </li>
			    <li>
			    	<a class="dropdown-item fs-6" href="/hr/reglist">승인 관리</a>
			    </li>
			</ul>
		</div>
   </div>
 </aside>