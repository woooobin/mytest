package com.spring.poosil.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TtsController {

	@RequestMapping("ttstest.do")
	public String ttstest() {
		
		return "ttstest";
		
	}
}
