package com.eatit.mainDomain;

/**
 * 
 * 페이징 처리를 위해서 생성한 객체
 * => 페이지번호, 페이지사이즈를 저장하는 객체
 *
 */
public class Criteria {
	private int page;
	private int pageSize;
	
	public Criteria() {
		this.page = 1;
		this.pageSize = 10;
	}
	
	public void setPage(int page) {
		
		if(page <= 0) {
			this.page = 1;
			return;
		}
		this.page = page;
	}
	public void setPageSize(int pageSize) {
		
		if(pageSize <= 0 || pageSize > 100) {
			this.pageSize = 10;
			return;
		}
		this.pageSize = pageSize;
	}	
	
	public int getPage() {
		return page;
	}
	public int getPageSize() {
		return pageSize;
	}
	
	//private int startPage 변수 선언 없이 get 메서드만 구현
	// 변수는 없지만 mapper에서 사용, #(startPage} 가 호출
	public int getstartPage() {
		// 페이지 정보를 쿼리에 사용할 값으로 변경
		return (this.page-1)*pageSize;
	}
	
	@Override
	public String toString() {
		return "Criteria [page=" + page + ", pageSize=" + pageSize + "]";
	}	
	
}
