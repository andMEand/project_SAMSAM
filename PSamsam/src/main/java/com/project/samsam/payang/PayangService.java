package com.project.samsam.payang;

import java.util.List;


public interface PayangService {

	
	// 게시글 목록 조회
	public List<PayangVO> list() throws Exception;
	
	// 게시글 쓰기
	public void register(PayangVO payang) throws Exception;
	
	// 게시글 읽기
	public PayangVO read(Integer p_no) throws Exception;
	
	// 게시글 수정
	public void modify(PayangVO payang) throws Exception;
	
	// 게시글 삭제
	public void remove(Integer p_no) throws Exception;
	
	
}
