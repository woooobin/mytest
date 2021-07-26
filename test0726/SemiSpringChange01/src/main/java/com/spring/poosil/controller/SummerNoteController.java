package com.spring.poosil.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SummerNoteController {
	@RequestMapping("summernoteres.do")
	public String summbernoteres() {
		
		return"introduce/mypage";
	}

	@RequestMapping("summernote.do")
	public String summbernote() {
		
		return"introduce/summernote";
	}
}
