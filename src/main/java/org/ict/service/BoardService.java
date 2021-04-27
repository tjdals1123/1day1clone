package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.SearchCriteria;


public interface BoardService {

	public List<BoardVO> getList();
	
	public BoardVO get(Long bno);
	
	public void modify(BoardVO board);
	
	public void remove(Long bno);
	
	public void register(BoardVO board);
	
	public List<BoardVO> getListCriteria(Criteria cri);
	
	public int countPageNum();

	public List<BoardVO> getListSearch(Criteria cri, String searchType, String keyword);

	public int searchCountPageNum(SearchCriteria search);
	
}
