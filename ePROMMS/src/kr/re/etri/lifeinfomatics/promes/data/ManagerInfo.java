package kr.re.etri.lifeinfomatics.promes.data;

public class ManagerInfo {
	private String manager_id;
	private String name;
	private String password;
	private String phone;
	private String mobile;
	private String regDate;
	private String permission_no;
	private String org_no;


	public String getId() {
		return manager_id;
	}

	public void setId(String id) {
		this.manager_id = id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	
	public String getPw() {
		return password;
	}

	public void setPw(String pw) {
		this.password = pw;
	}
	
	public String getPhone() {
		return phone;
	}

	public String[] getPhoneArr() {
		String[] hpArr = { "", "", "" };
		if (phone != null && !phone.equals("")) {
			hpArr = phone.split("-");
		}
		return hpArr;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}
	
	public String getMobile() {
		return mobile;
	}
	
	public String[] getMobileArr() {
		String[] hpArr = { "", "", "" };
		if (mobile != null && !mobile.equals("")) {
			hpArr = mobile.split("-");
		}
		return hpArr;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	
	public String getPermission() {
		return permission_no;
	}

	public void setPermission(String permission_no) {
		this.permission_no = permission_no;
	}
	
	public String getOrgNo() {
		return org_no;
	}

	public void setOrgNo(String org_no) {
		this.org_no = org_no;
	}


	public String toString() {
		String str = "";
		str += "============= new매니져 정보 =======================\n";
		str += " ID : " + manager_id + "\n";
		str += " NAME : " + name + "\n";
		str += " PASSWORD : " + password + "\n";
		str += " PHONE : " + phone + "\n";
		str += " MOBILE : " + mobile + "\n";
		str += " REGDATE : " + regDate + "\n";
		str += " PERMISSION_NO : " + permission_no + "\n";
		str += " ORG_NO : " + org_no + "\n";
		str += "================================================";
		return str;
	}

}
