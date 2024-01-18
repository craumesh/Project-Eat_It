<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
/* 품목정보관리 버튼 스타일 */
.btn-pim {
  background-color: black;
  color: white;
}

/* 원자재정보관리 버튼 스타일 */
.btn-mim {
  background-color: red;
  color: white;
}

/* 소요량관리 버튼 스타일 */
.btn-cim {
  background-color: green;
  color: white;
}

/* 품질관리 버튼 스타일 */
.btn-qim {
  background-color: blue;
  color: white;
}

/* 공통 버튼 스타일 */
.btn-pim,
.btn-mim,
.btn-cim,
.btn-qim {
  /* 다른 스타일들 추가 가능 */
  /* 이전의 호버 효과 스타일 등을 유지하거나 변경할 수 있어요 */
  border: none;
  border-radius: 5px;
  padding: 10px 20px;
  font-size: 16px;
  cursor: pointer;
  transition: all 0.3s ease;
  outline: none;
}

/* 호버 시의 스타일 */
.btn-pim:hover,
.btn-mim:hover,
.btn-cim:hover,
.btn-qim:hover {
  background-color: rgba(0, 0, 0, 0.1);
  color: #000;
  border-color: #000;
}
</style>

<meta charset="UTF-8">
 <title>디저트의 모든 것 EatIt</title>
</head>
  <%@ include file="../include/header.jsp" %>
    <!-- End Navbar -->
    <div class="container-fluid py-4">
      <div class="row">
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-dark shadow-dark text-center border-radius-xl mt-n4 position-absolute">
                <i class="material-icons opacity-10">weekend</i>
              </div>
              <div class="text-end pt-1">
                <p class="text-sm mb-0 text-capitalize">
                	<script>
                  		
                	</script> 
                </p>
                <h4 class="mb-0"><input type="button" onclick="window.location.href='/masterdata/PIM'" class="btn-pim" value="품목정보관리바로가기"></h4>
              </div>
            </div>
            <div class="card-footer p-3">
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-primary shadow-primary text-center border-radius-xl mt-n4 position-absolute">
                <i class="material-icons opacity-10">weekend</i>
              </div>
              <div class="text-end pt-1">
                <p class="text-sm mb-0 text-capitalize">
                	<script>
                  		
                	</script> 
                </p>
                <h4 class="mb-0"> <input type="button" onclick="window.location.href='/masterdata/MIM'" class="btn-mim" value="원자재정보관리바로가기"></h4>
              </div>
            </div>
            <div class="card-footer p-3">
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6 mb-xl-0 mb-4">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-success shadow-success text-center border-radius-xl mt-n4 position-absolute">
                <i class="material-icons opacity-10">weekend</i>
              </div>
              <div class="text-end pt-1">
                <p class="text-sm mb-0 text-capitalize"></p>
                <h4 class="mb-0"><input type="button" onclick="window.location.href='/masterdata/CIM'" class="btn-cim" value="소요량관리바로가기"></h4>
              </div>
            </div>
            <div class="card-footer p-3">
            </div>
          </div>
        </div>
        <div class="col-xl-3 col-sm-6">
          <div class="card">
            <div class="card-header p-3 pt-2">
              <div class="icon icon-lg icon-shape bg-gradient-info shadow-info text-center border-radius-xl mt-n4 position-absolute">
                <i class="material-icons opacity-10">weekend</i>
              </div>
              <div class="text-end pt-1">
                <p class="text-sm mb-0 text-capitalize">
                <h4 class="mb-0"> <input type="button" onclick="window.location.href='/masterdata/QIM'" class="btn-qim" value="품질관리바로가기"></h4>
              </div>
            </div>
            <div class="card-footer p-3">
            </div>
          </div>
        </div>
      </div>
      <div class="row mt-4">
		<div class="col-lg-4 col-md-6 mt-4 mb-4">
          <div class="card z-index-2 ">
            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
              <div class="bg-gradient-primary shadow-primary border-radius-lg py-3 pe-1">
                <div class="chart">
                  <canvas id="chart-bars" class="chart-canvas" height="170"></canvas>
                </div>
              </div>
            </div>
            <div class="card-body">
              <h6 class="mb-0 ">연도별 납품량</h6>
              <p class="text-sm "> (<span class="font-weight-bolder">+15%</span>) 전년도 대비 </p>
              <hr class="dark horizontal">
              <div class="d-flex ">
                <i class="material-icons text-sm my-auto me-1">schedule</i>
                <p class="mb-0 text-sm"> 수정 일자 </p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-md-6 mt-4 mb-4">
          <div class="card z-index-2  ">
            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
              <div class="bg-gradient-success shadow-success border-radius-lg py-3 pe-1">
                <div class="chart">
                  <canvas id="chart-line" class="chart-canvas" height="170"></canvas>
                </div>
              </div>
            </div>
            <div class="card-body">
              <h6 class="mb-0 ">월별 납품액 </h6>
              <p class="text-sm "> (<span class="font-weight-bolder">-5%</span>) 전달 대비</p>
              <hr class="dark horizontal">
              <div class="d-flex ">
                <i class="material-icons text-sm my-auto me-1">schedule</i>
                <p class="mb-0 text-sm"> 수정 일자 </p>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-4 mt-4 mb-3">
          <div class="card z-index-2 ">
            <div class="card-header p-0 position-relative mt-n4 mx-3 z-index-2 bg-transparent">
              <div class="bg-gradient-info shadow-dark border-radius-lg py-3 pe-1">
                <div class="chart">
                  <canvas id="chart-line-tasks" class="chart-canvas" height="170"></canvas>
                </div>
              </div>
            </div>
            <div class="card-body">
              <h6 class="mb-0 ">월별 납품량</h6>
              <p class="text-sm "> (<span class="font-weight-bolder">+5%</span>) 전달 대비</p>
              <hr class="dark horizontal">
              <div class="d-flex ">
                <i class="material-icons text-sm my-auto me-1">schedule</i>
                <p class="mb-0 text-sm">수정 일자</p>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="row mb-4">
        <div class="col-lg-8 col-md-6 mb-md-0 mb-4">
          <div class="card">
            <div class="card-header pb-0">
              <div class="row">
                <div class="col-lg-6 col-7">
                  <h6>공지사항</h6>
                </div>
                <div class="col-lg-6 col-5 my-auto text-end">
                  <div class="dropdown float-lg-end pe-4">
                    <ul class="dropdown-menu px-2 py-3 ms-sm-n4 ms-n5" aria-labelledby="dropdownTable">
                      <li><a class="dropdown-item border-radius-md" href="javascript:;">Action</a></li>
                      <li><a class="dropdown-item border-radius-md" href="javascript:;">Another action</a></li>
                      <li><a class="dropdown-item border-radius-md" href="javascript:;">Something else here</a></li>
                    </ul>
                  </div>
                </div>
              </div>
            </div>
            <div class="card-body px-0 pb-2">
              <div class="table-responsive">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
						<th
							class="text-secondary text-xxs font-weight-bolder opacity-7"
							style="width: 20px;">분류</th>
						<th
							class="text-center text-secondary text-xxs font-weight-bolder opacity-7">제목</th>
						<th
							class="text-center text-secondary text-xxs font-weight-bolder opacity-7"
							style="width: 20px;">조회수</th>
						<th
							class="text-center text-secondary text-xxs font-weight-bolder opacity-7"
							style="width: 20px;">작성일</th>
					</tr>
                  </thead>
                  <tbody>
                   <tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">전체</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">전체 공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">20</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-12-12</span>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">인사</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">인사 공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">53</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-12-10</span>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">자재</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">자재 공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">15</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-12-05</span>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">생산</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">생산 공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">32</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-12-03</span>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">창고</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">창고 공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">18</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-11-28</span>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">납품</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">납품  공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">5</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-11-24</span>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">설비</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6><a href="#">설비 공지글입니다.</a></h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">29</p>
					   </td>
					   <td class="align-middle text-center">
					   	   <span class="text-secondary text-xs font-weight-bold">2023-11-20</span>
					   </td>
					</tr>
                  </tbody>
                </table>
              </div>
            </div>
          </div>
        </div>
        <div class="col-lg-4 col-md-6">
          <div class="card h-100">
            <div class="card-header pb-0">
              <h6>이번달 우수사원</h6>
            </div>
            <div class="card-body p-3">
               <div class="table-responsive">
                <table class="table align-items-center mb-0">
                  <thead>
                    <tr>
						<th
							class="text-secondary text-xxs font-weight-bolder opacity-7"
							style="width: 20px;">부서</th>
						<th
							class="text-center text-secondary text-xxs font-weight-bolder opacity-7">직책</th>
						<th
							class="text-center text-secondary text-xxs font-weight-bolder opacity-7"
							style="width: 20px;">이름</th>
					</tr>
                  </thead>
                  <tbody>
                   <tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">인사</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>인사관리담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">이병헌</p>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">인사</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>인사OO담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">이민정</p>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">자재</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>자재OO담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">정우성</p>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">생산</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>생산OO담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">이정재</p>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">창고</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>창고OO담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">황정민</p>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">납품</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>납품OO담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">안내상</p>
					   </td>
					</tr>
					<tr>
					  <td>
						<div class="d-flex px-2 py-1">
							<div class="d-flex flex-column justify-content-center">
								<h6
									class="text-uppercase text-secondary text-xxs font-weight-bolder opacity-7"
									style="margin-left: 7px;">설비</h6>
							</div>
						</div>
					   </td>
					   <td class="align-middle text-center text-sm ">
							<h6>설비OO담당</h6>						 
					   </td>
					   <td class="align-middle text-center text-sm">
						  <p class="text-xs font-weight-bold mb-0">김태희</p>
					   </td>
					</tr>
                  </tbody>
                </table>
            </div>
          </div>
        </div>
      </div>
    </div>
    </div>
  	<%@ include file="../include/footer.jsp" %>
  	<%@ include file="../include/js.jsp" %>
  <script>
    var ctx = document.getElementById("chart-bars").getContext("2d");

    new Chart(ctx, {
      type: "bar",
      data: {
        labels: ['2020', '2021', '2022', '2023'],
        datasets: [{
          label: "전체 납품량",
          tension: 0.4,
          borderWidth: 0,
          borderRadius: 4,
          borderSkipped: false,
          backgroundColor: "rgba(255, 255, 255, .8)",
          data: [500, 1200, 1700, 2300],
          maxBarThickness: 6
        }, ],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5],
              color: 'rgba(255, 255, 255, .2)'
            },
            ticks: {
              suggestedMin: 0,
              suggestedMax: 500,
              beginAtZero: true,
              padding: 10,
              font: {
                size: 14,
                weight: 300,
                family: "Roboto",
                style: 'normal',
                lineHeight: 2
              },
              color: "#fff"
            },
          },
          x: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5],
              color: 'rgba(255, 255, 255, .2)'
            },
            ticks: {
              display: true,
              color: '#f8f9fa',
              padding: 10,
              font: {
                size: 14,
                weight: 300,
                family: "Roboto",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });


    var ctx2 = document.getElementById("chart-line").getContext("2d");

    new Chart(ctx2, {
      type: "line",
      data: {
        labels: ['2023-08', '2023-09', '2023-10', '2023-11', '2023-12'],
        datasets: [{
          label: "이번달 납품액",
          tension: 0,
          borderWidth: 0,
          pointRadius: 5,
          pointBackgroundColor: "rgba(255, 255, 255, .8)",
          pointBorderColor: "transparent",
          borderColor: "rgba(255, 255, 255, .8)",
          borderColor: "rgba(255, 255, 255, .8)",
          borderWidth: 4,
          backgroundColor: "transparent",
          fill: true,
          data: [5900000, 4900000, 6800000,7300000,6900000],
          maxBarThickness: 6

        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5],
              color: 'rgba(255, 255, 255, .2)'
            },
            ticks: {
              display: true,
              color: '#f8f9fa',
              padding: 10,
              font: {
                size: 14,
                weight: 300,
                family: "Roboto",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              color: '#f8f9fa',
              padding: 10,
              font: {
                size: 14,
                weight: 300,
                family: "Roboto",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });

    var ctx3 = document.getElementById("chart-line-tasks").getContext("2d");

    new Chart(ctx3, {
      type: "line",
      data: {
        labels: ['2023-08', '2023-09', '2023-10', '2023-11', '2023-12'],
        datasets: [{
          label: "이번달 납품량",
          tension: 0,
          borderWidth: 0,
          pointRadius: 5,
          pointBackgroundColor: "rgba(255, 255, 255, .8)",
          pointBorderColor: "transparent",
          borderColor: "rgba(255, 255, 255, .8)",
          borderWidth: 4,
          backgroundColor: "transparent",
          fill: true,
          data: [100, 200,500,300,320],
          maxBarThickness: 6

        }],
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: {
          legend: {
            display: false,
          }
        },
        interaction: {
          intersect: false,
          mode: 'index',
        },
        scales: {
          y: {
            grid: {
              drawBorder: false,
              display: true,
              drawOnChartArea: true,
              drawTicks: false,
              borderDash: [5, 5],
              color: 'rgba(255, 255, 255, .2)'
            },
            ticks: {
              display: true,
              padding: 10,
              color: '#f8f9fa',
              font: {
                size: 14,
                weight: 300,
                family: "Roboto",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
          x: {
            grid: {
              drawBorder: false,
              display: false,
              drawOnChartArea: false,
              drawTicks: false,
              borderDash: [5, 5]
            },
            ticks: {
              display: true,
              color: '#f8f9fa',
              padding: 10,
              font: {
                size: 14,
                weight: 300,
                family: "Roboto",
                style: 'normal',
                lineHeight: 2
              },
            }
          },
        },
      },
    });
  </script>
</html>