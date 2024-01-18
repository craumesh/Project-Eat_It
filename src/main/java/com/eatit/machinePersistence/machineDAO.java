package com.eatit.machinePersistence;

import java.util.List;

import com.eatit.machineDomain.machineVO;
import com.eatit.machineDomain.machinehistoryVO;
import com.eatit.mainDomain.Criteria;

public interface machineDAO {
	
	// 설비 추가 동작
	public void insertmachine(machineVO vo);
	
	// 설비 리스트조회 동작
	public List<machineVO> getmachinelist(Criteria cri);
	
	// 설비 기록
	public void machinehistory(machinehistoryVO vo);
	
	// 설비 코드
	public int getmachinecode();
	
	// 설비 정보
	public machineVO machineinfo(int code);
	
	// 설비 업데이트
	public int machineupdate(machineVO vo);
	
	// 설비 삭제
	public void machinedelete(machineVO vo);
	public void machinedeleteupdate(machineVO vo);
	
	// 페이징 처리 갯수
	public int totalCount(); 

	// 생산 리스트 조회
	public machineVO productstatus(int code);
	
	// 생산 가능 설비
	public List<machineVO> machinecategory();
}
