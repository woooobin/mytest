package com.spring.poosil.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class RouletteController {

	@RequestMapping("roulette.do")
	public String rouletteform() {
		
		return"rouletteform";
	}
}
