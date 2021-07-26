package com.spring.poosil.loginbiz;

import com.spring.poosil.logindto.LoginDto;

public interface LoginBiz {
	
		
	
		//1.로그인
		public LoginDto login(LoginDto dto);
		
		//2.id 중복체크
		public int idCheck(String userid);
		
		//2-1email 중복체크
		public int emailCheck(String useremail);
		
		//3.회원가입
		public int insertUser(LoginDto dto);
		
		//4.회원정보 수정
		public int updateUser(LoginDto dto);
		
		//5.회원탈퇴(정보유지)
		public int enabledout(String userid);
		

}
