package com.spring.poosil.bookduck.paybiz;

import com.spring.poosil.bookduck.paydto.PayDto;

public interface PayBiz {
	
	public int insertPay(PayDto dto);
	public int updatememberrole(String member_id);
	

}
