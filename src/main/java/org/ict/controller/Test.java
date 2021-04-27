package org.ict.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


import org.ict.domain.BoardVO;
import org.ict.domain.Criteria;
import org.ict.domain.PageMaker;
import org.ict.domain.SearchCriteria;
import org.ict.domain.TestVO;
import org.ict.service.BoardService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.google.protobuf.Message;

import lombok.extern.log4j.Log4j;

@RestController
@Log4j
@RequestMapping("/test")
public class Test {
	
	@Autowired
	private BoardService service;
	
	@RequestMapping("/hello")
	public String sayHello() {
		
		return "Hello Hello";
	}
	
	@RequestMapping("/sendVO")
	public TestVO sendTestVO() {
		
		TestVO testVO = new TestVO();
		
		testVO.setName("전성민");
		testVO.setAge(21);
		testVO.setMno(1);
		
		return testVO;
	}
	
	@RequestMapping("/sendVOList")
	public List<TestVO> sendVoList(){
		
		List<TestVO> list = new ArrayList<>();
		
		for(int i = 0; i < 10; i++) {
			
			TestVO vo = new TestVO();
			
			vo.setMno(i);
			vo.setName(i+ "성민");
			vo.setAge(20 + i);
			
			list.add(vo);
		}
		return list;
	}
	
	@RequestMapping("/sendMap")
	public Map<Integer, TestVO> sendMap() {
		
		Map<Integer, TestVO> map = new HashMap<>();
		
		for(int i=0; i<10; i++) {
			
			TestVO vo = new TestVO();
			
			vo.setName("전성민");
			vo.setMno(i);
			vo.setAge(50+i);
			
			map.put(i,  vo);
		}
		return map;
	}
	
	@RequestMapping("/sendErrorAuth")
	public ResponseEntity<Void> sendListAuth(){
		
		return
			new ResponseEntity<>(HttpStatus.BAD_REQUEST);
	}
	
	@RequestMapping("/sendErrorNot")
	public ResponseEntity<List<TestVO>> sendListNot(){
		
		List<TestVO> list = new ArrayList<>();
		
		for (int i=0; i<10; i++) {
			
			TestVO vo = new TestVO();
			
			vo.setMno(i);
			vo.setName(i + "성민");
			vo.setAge(20+i);
			list.add(vo);
		}
		
		return
			new ResponseEntity<List<TestVO>>(
					list, HttpStatus.NOT_FOUND);
	}
	
	
	@PostMapping(value="/register", consumes="application/json",
							produces= {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<String> register(@RequestBody BoardVO board){
		
		ResponseEntity<String> entity = null;
		
		try {
			service.register(board);
			entity = new ResponseEntity<String> ("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e) {
			e.printStackTrace();
			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
	

	@GetMapping(value="/list/{page}" ,produces= {MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<Map<String, Object>> getList(@PathVariable("page") int page) {
		
		
		Criteria cri = new Criteria();
		
		cri.setPage(page);
	
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> result = new HashMap<String, Object>();
		
		List<BoardVO> list = service.getListCriteria(cri);
		
		result.put("list", list);
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
		
		pageMaker.setTotalBoard(service.countPageNum());
		
		result.put("pageMaker", pageMaker);
		
		
		
		try {
			
			entity = new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
			
		} catch (Exception e){
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		return entity;
		
	}
	
	@GetMapping(value="list/{page}/{searchType}/{keyword}" , produces= {MediaType.APPLICATION_JSON_UTF8_VALUE, MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<Map<String, Object>> getListSearch(@PathVariable("page") int page,
															@PathVariable("searchType") String searchType,
															@PathVariable("keyword") String keyword){
		
		ResponseEntity<Map<String, Object>> entity = null;
		
		Map<String, Object> result = new HashMap<>();
		
		Criteria cri = new Criteria();
		
		cri.setPage(page);
		
		SearchCriteria search = new SearchCriteria();
		
		search.setSearchType(searchType);
		search.setKeyword(keyword);
		
		List<BoardVO> list = service.getListSearch(cri, searchType, keyword);
		
		int count = service.searchCountPageNum(search);
		
		PageMaker pageMaker = new PageMaker();
		
		pageMaker.setCri(cri);
		
		pageMaker.setTotalBoard(count);
		
		result.put("list", list);
		result.put("cri", cri);
		result.put("pageMaker", pageMaker);

		
		try {
			
			entity = new ResponseEntity<Map<String,Object>>(result, HttpStatus.OK);
		} catch(Exception e) {
			
			entity = new ResponseEntity<Map<String,Object>>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	@RequestMapping(value="/delete/{bno}", method= {RequestMethod.DELETE},  produces= {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> remove (@PathVariable("bno") Long bno) {
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.remove(bno);
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch(Exception e) {
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	@RequestMapping(value="/modify/{bno}", produces= {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_VALUE},
					method= {RequestMethod.PUT}, consumes = "application/json")
	public ResponseEntity<String> modify (@PathVariable("bno") Long bno, @RequestBody BoardVO board){
		
		ResponseEntity<String> entity = null;
		
		try {
			log.info(board);
			log.info(bno);
			board.setBno(bno);
			service.modify(board);
			
			entity = new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			
		} catch (Exception e){
			
			entity = new ResponseEntity<String>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
		
	}
	
	@RequestMapping(value="/get/{bno}" ,
			produces= {MediaType.TEXT_PLAIN_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<BoardVO> read(@PathVariable("bno") Long bno) {
		
		BoardVO board;
		
		ResponseEntity<BoardVO> entity = null;
		
		try {
			
			board = service.get(bno);
			
			entity = new ResponseEntity<BoardVO>(board, HttpStatus.OK);
			
			log.info(entity);
		}catch(Exception e) {
			
			entity = new ResponseEntity<BoardVO>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
	
	
}



















