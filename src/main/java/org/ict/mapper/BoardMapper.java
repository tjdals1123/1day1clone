package org.ict.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.SearchCriteria;

public interface BoardMapper {

	public int searchCountPageNum(SearchCriteria search);

	public int getCountPageNum();

	public List<BoardVO> getList();
	
	public BoardVO read(Long bno);
	
	public void insert(BoardVO board);
	
	public void update(BoardVO board);
	
	public void delete(Long bno);
	
	public List<BoardVO> getListCriteria(Criteria cri);

	public List<BoardVO> getListSearch(@Param("cri") Criteria cri
									, @Param("searchType") String searchType
									, @Param("keyword") String keyword);
	
}
