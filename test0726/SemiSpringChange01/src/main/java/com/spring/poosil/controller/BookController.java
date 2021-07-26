package com.spring.poosil.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.poosil.bookbiz.BookBiz;

@Controller
public class BookController {
    @Autowired
    private BookBiz service; 
    
    //키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    
    @RequestMapping("bookList.do")
    public ModelAndView bookList(@RequestParam(required=false)String keyword){
        ModelAndView mav = new ModelAndView();
        
        if(keyword !=null)
        {
            mav.addObject("bookList",service.searchBook(keyword,100,1));
        }
        mav.setViewName("bookList");
        return mav;
    }
}
 


