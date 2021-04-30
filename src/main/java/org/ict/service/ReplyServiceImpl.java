package org.ict.service;

import java.util.List;

import org.ict.domain.Criteria;
import org.ict.domain.ReplyVO;
import org.ict.mapper.ReplyMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ReplyServiceImpl implements ReplyService{

	@Autowired
	private ReplyMapper mapper;
	
	@Override
	public void addReply(ReplyVO vo) {

		mapper.create(vo);
	}

	@Override
	public List<ReplyVO> listReply(int bno) {
		
		return mapper.getList(bno);
	}

	@Override
	public void modifyReply(ReplyVO vo) {

		mapper.update(vo);
	}

	@Override
	public void removeReply(int rno) {
		
		mapper.delete(rno);
	}

	@Override
	public List<ReplyVO> getListPage(int bno, Criteria cri) {
		
		return mapper.getListPage(bno, cri);
	}

	@Override
	public int count(int bno) {
		
		return mapper.count(bno);
	}
	
	

}
