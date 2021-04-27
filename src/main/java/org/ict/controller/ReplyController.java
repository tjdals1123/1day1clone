package org.ict.controller;

import java.util.List;

import org.ict.domain.ReplyVO;
import org.ict.service.ReplyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/replies")
public class ReplyController {

	// 교안 08번 40페이지부터 진행
	
	@Autowired
	private ReplyService service;
	
	@RequestMapping(value="", method = RequestMethod.POST)
	public ResponseEntity<String> register(@RequestBody ReplyVO vo){
		
		ResponseEntity<String> entity = null;
		
		try {
			
			service.addReply(vo);
			entity = new ResponseEntity<String>(
					"SUCCESS", HttpStatus.OK);
		} catch (Exception e) {
			
			e.printStackTrace();
			entity = new ResponseEntity<String>(
					e.getMessage(), HttpStatus.BAD_REQUEST);
					
		}
		
		return entity;
	}
	
	@PostMapping(value="/all/{bno}", produces = {MediaType.APPLICATION_ATOM_XML_VALUE, MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<ReplyVO>> list(@PathVariable("bno") Integer bno){
		
		ResponseEntity<List<ReplyVO>> entity = null;
		
		try {
			entity = new ResponseEntity<>(service.listReply(bno), HttpStatus.OK);
			
		} catch (Exception e) {
			
			e.printStackTrace();
			entity = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
		}
		
		return entity;
	}
	
}












