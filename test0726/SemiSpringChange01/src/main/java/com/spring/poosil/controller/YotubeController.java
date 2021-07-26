package com.spring.poosil.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class YotubeController {
	
	@RequestMapping("youtubeif.do")
	public String youtube() {
		
		
		return"youtubeform";
	}

}
