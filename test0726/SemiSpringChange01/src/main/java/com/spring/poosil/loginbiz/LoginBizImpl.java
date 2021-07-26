package com.spring.poosil.loginbiz;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.poosil.logindao.LoginDao;
import com.spring.poosil.logindto.LoginDto;

@Service
public class LoginBizImpl implements LoginBiz {
	
	@Autowired
	private LoginDao dao;
	
	
	@Override
	public LoginDto login(LoginDto dto) {
		return dao.login(dto);
	}

	@Override
	public int idCheck(String userid) {
		return 0;
	}

	@Override
	public int emailCheck(String useremail) {
		return 0;
	}

	@Override
	public int insertUser(LoginDto dto) {
		return 0;
	}

	@Override
	public int updateUser(LoginDto dto) {
		return 0;
	}

	@Override
	public int enabledout(String userid) {
		return dao.enabledout(userid);
	}

}
