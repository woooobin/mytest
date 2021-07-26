package com.spring.poosil.logindto;

public class LoginDto {
	
	private String userid;
	private String password;
	private String username;
	private String usernickname;
	private String useremail;
	private int userphone;
	private String address;
	private String avartar;
	private String userrole;
	private String userenabled;

	public LoginDto() {
	}

	public LoginDto(String userid, String password, String username, String usernickname, String useremail,
			int userphone, String address, String avartar, String userrole, String userenabled) {
		super();
		this.userid = userid;
		this.password = password;
		this.username = username;
		this.usernickname = usernickname;
		this.useremail = useremail;
		this.userphone = userphone;
		this.address = address;
		this.avartar = avartar;
		this.userrole = userrole;
		this.userenabled = userenabled;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getUsernickname() {
		return usernickname;
	}

	public void setUsernickname(String usernickname) {
		this.usernickname = usernickname;
	}

	public String getUseremail() {
		return useremail;
	}

	public void setUseremail(String useremail) {
		this.useremail = useremail;
	}

	public int getUserphone() {
		return userphone;
	}

	public void setUserphone(int userphone) {
		this.userphone = userphone;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvartar() {
		return avartar;
	}

	public void setAvartar(String avartar) {
		this.avartar = avartar;
	}

	public String getUserrole() {
		return userrole;
	}

	public void setUserrole(String userrole) {
		this.userrole = userrole;
	}

	public String getUserenabled() {
		return userenabled;
	}

	public void setUserenabled(String userenabled) {
		this.userenabled = userenabled;
	}

}
