package org.ict.service;

import java.util.List;

import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.SearchCriteria;
import org.ict.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private BoardMapper mapper;
	
	@Override
	public List<BoardVO> getList() {
	
		return mapper.getList();
	}
	
	@Override
	public BoardVO get(Long bno) {
		
		return mapper.read(bno);
	}
	
	@Override
	public void modify(BoardVO board) {
		
		mapper.update(board);
	}
	
	@Override
	public void remove(Long bno) {
		
		mapper.delete(bno);
		
	}
	
	@Override
	public void register(BoardVO board) {
		
		mapper.insert(board);
	}

	@Override
	public List<BoardVO> getListCriteria(Criteria cri) {
		
		return mapper.getListCriteria(cri);
	}

	@Override
	public int countPageNum() {
		
		return mapper.getCountPageNum();
	}

	@Override
	public List<BoardVO> getListSearch(Criteria cri, String searchType, String keyword) {
		
		return mapper.getListSearch(cri, searchType, keyword);
	}

	@Override
	public int searchCountPageNum(SearchCriteria search) {
		
		return mapper.searchCountPageNum(search);
	}

	
}













