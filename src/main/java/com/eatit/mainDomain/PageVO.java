package com.eatit.mainDomain;

/**
 * 
 * 페이징 처리에 필요한 데이터 추가 저장 객체
 * 	=> 총 개수, 시작페이지 번호, 끝페이지 번호, 이전, 다음 링크, 블럭 크기
 * 		+Cri(페이지 번호, 페이지 사이즈)
 * 
 * 	총 개수 	: totalCount (DB조회)
 *	끝페이지 	: endPage = 올림(페이지 번호/블럭 크기) * 블럭 크기
 *	시작페이지 	: startPage = (endPage - 블럭 크기) + 1
 *	이전 링크 	: prev(boolean) = startPage != 1
 *	다음 링크 	: next(boolean) = (endPage * 페이지 사이즈) < totalCount
 */

// ex) 총 122개 / 페이지당 10개씩 출력 / 블럭 크기 : 10
// - 1페이지 : 시작페이지 1, 끝페이지 10, 이전버튼X, 다음버튼O
//				ceil(1/10)*10 => 10
// - 7페이지 : 시작페이지 1, 끝페이지 10, 이전버튼X, 다음버튼O
// - 12페이지 : 시작페이지 11, 끝페이지 20->13, 이전버튼O, 다음버튼X
//				ceil(12/10)*10 => 20

public class PageVO {
	private int totalCount; // 총 개수
	private int startPage; 	// 페이지 블럭 시작번호
	private int endPage; 	// 페이지 블럭 끝번호
	private boolean prev; 	// 이전링크
	private boolean next; 	// 다음링크
	
	
	private int displayPageNum = 10; // 페이지 블럭의 크기
	
	private Criteria cri;

	// => 페이지 번호, 페이지 사이즈 저장
	public void setCri(Criteria cri) {
		this.cri = cri;
	}
	
	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
		// 페이징 처리에 필요한 정보를 모두 계산
		calcData();
	}
	
	private void calcData() {
		// 페이징 정보를 모두 계산
		
		// 끝페이지
		endPage = (int)(Math.ceil(cri.getPage()/(double)displayPageNum))*displayPageNum;
		
		// 시작페이지
		startPage = endPage-displayPageNum+1;
		
		// 끝페이지 번호체크 (글이 없는 경우)
//		int tmpEndPage = totalCount / cri.getPageSize() + (totalCount % cri.getPageSize() == 0 ? 0 : 1);
		int tmpEndPage = (int)(Math.ceil(((double)totalCount / cri.getPageSize())));
		
		if(endPage > tmpEndPage) {
			endPage = tmpEndPage;
		}
		
		// 이전 링크
		prev = startPage != 1;
		
		// 다음 링크
		next = endPage*cri.getPageSize() < totalCount;
	}
	

	public int getTotalCount() {
		return totalCount;
	}

	public int getStartPage() {
		return startPage;
	}

	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}

	public int getEndPage() {
		return endPage;
	}

	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}

	public boolean isPrev() {
		return prev;
	}

	public void setPrev(boolean prev) {
		this.prev = prev;
	}

	public boolean isNext() {
		return next;
	}

	public void setNext(boolean next) {
		this.next = next;
	}

	public int getDisplayPageNum() {
		return displayPageNum;
	}

	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}

	public Criteria getCri() {
		return cri;
	}
	
	@Override
	public String toString() {
		return "PageVO [totalCount=" + totalCount + ", startPage=" + startPage + ", endPage=" + endPage + ", prev="
				+ prev + ", next=" + next + ", displayPageNum=" + displayPageNum + ", cri=" + cri + "]";
	}
}
