package org.ict.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/board/*")
public class BoardController {

	@GetMapping("list")
	public String getList() {
		
		return "/board/list";
	}
	
	@GetMapping("register")
	public String register() {
		
		return "/board/register";
	}
	
	@GetMapping("get")
	public String get() {
		
		return "/board/get";
	}
	@GetMapping("modifyForm")
	public String modifyForm() {
		
		return "/board/modifyForm";
	}
}
