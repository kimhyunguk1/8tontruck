package kr.re.etri.lifeinfomatics.promes.data;

public class PatientInfo {
	private String patient_no;
	private String name;
	private String id;	
	private String password;
	private String gender;
	private String birth;
	private String address;
	private String phone;
	private String mobile;
	private boolean sms;
	private String manager_id;

	public String getPatientNo() {
		return patient_no;
	}

	public void setPatientNo(String no) {
		this.patient_no = no;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPw() {
		return password;
	}

	public void setPw(String pw) {
		this.password = pw;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}
	
	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}
	
	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
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

	public boolean isSms() {
		return sms;
	}

	public void setSms(boolean sms) {
		this.sms = sms;
	}
	
	public String getManagerID() {
		return manager_id;
	}

	public void setManagerID(String manager_id) {
		this.manager_id = manager_id;
	}


	public String toString() {
		String str = "";
		str += "============= new환자 정보 =======================\n";
		str += " ID : " + id + "\n";
		str += " NAME : " + name + "\n";
		str += " PASSWORD : " + password + "\n";
		str += " GENDER : " + gender + "\n";
		str += " BIRTH : " + birth + "\n";
		str += " ADDRESS : " + address + "\n";
		str += " PHONE : " + phone + "\n";
		str += " MOBILE : " + mobile + "\n";
		str += " RECEIPTSMS : " + sms + "\n";
		str += " MANAGER_ID : " + manager_id + "\n";
		str += "================================================";
		return str;
	}
}
