package com.spring.poosil.logindao;


import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.poosil.logindto.LoginDto;

@Repository
public class LoginDaoImpl implements LoginDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public LoginDto login(LoginDto dto) {
		
		try {
			dto = sqlSession.selectOne(namespace+"Login",dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
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
		
		int res =0;
		
		try {
			res=sqlSession.update(namespace+"enabledout", userid);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return res;
	}

}
