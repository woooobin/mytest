package com.spring.poosil.bookduck.paydao;

import com.spring.poosil.bookduck.paydto.PayDto;

public interface PayDao {
	
	String namespace= "bookduckpay.";
	
	public int insertPay(PayDto dto);
	public int updatememberrole(String member_id);
}
