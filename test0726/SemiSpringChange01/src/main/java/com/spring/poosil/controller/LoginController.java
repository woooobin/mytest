package com.spring.poosil.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.poosil.loginbiz.LoginBiz;
import com.spring.poosil.logindto.LoginDto;

@Controller
public class LoginController {

	private Logger logger = LoggerFactory.getLogger(LoginController.class);

	@Autowired
	private LoginBiz biz;

	@RequestMapping("/loginform.do")
	public String loginform() {

		logger.info("[controller] : loginform");

		return "loginform";
	}

	@RequestMapping(value = "login.do", method = RequestMethod.POST)
	public String login(HttpServletRequest request, HttpServletResponse response, LoginDto dto) throws IOException {

		logger.info("[controller] : login");

		HttpSession session = request.getSession();

		dto = biz.login(dto);

		if (dto != null) {
			
			session.setAttribute("dto", dto);

			if (dto.getUserenabled().equals("Y")) {
				if (dto.getUserrole().equals("ADMIN")) {
					session.setAttribute("userid", dto);
					return "adminpage";

				} else if (dto.getUserrole().equals("USER")) {
					session.setAttribute("userid", dto);
					return "userpage";
				}

			} else if (dto.getUserenabled().equals("N")) {
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('탈퇴한 회원.'); location.href='loginform.do';</script>");
				out.flush();
			}

		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('다시 시도해 주세요.'); location.href='loginform.do';</script>");
			out.flush();
		}

		return "loginform";
	}

	@RequestMapping("/logout.do")
	public String logout(HttpSession session,HttpServletRequest request, HttpServletResponse response) throws IOException {
		logger.info("[controller] : logout");
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		out.println("<script>alert('로그아웃.');</script>");
		out.flush();
		return "loginform";
	}

	@RequestMapping("/enabledout.do")
	public String enabledout(HttpServletRequest request,HttpServletResponse response, String userid) throws IOException {
		logger.info("[controller] : enabeldout");
		HttpSession session = request.getSession();
		LoginDto dto = new LoginDto();
		int res =biz.enabledout(userid);
		if (res > 0 ) {
			session.invalidate();

			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('탈퇴성공.'); location.href='loginform.do';</script>");
			out.flush();

			return "loginform";
		} else {
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('탈퇴실패.'); location.href='loginform.do';</script>");
			out.flush();
			if (dto.getUserenabled().equals("Y")) {
				if (dto.getUserrole().equals("ADMIN")) {
					session.setAttribute("userid", dto);
					return "adminpage";

				} else if (dto.getUserrole().equals("USER")) {
					session.setAttribute("userid", dto);
					return "userpage";
				}
			}
			return "/";
		}

	}
}