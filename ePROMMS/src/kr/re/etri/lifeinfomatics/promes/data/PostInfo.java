package kr.re.etri.lifeinfomatics.promes.data;

public class PostInfo {
	private String code;
	private String sido;
	private String gugun;
	private String dong;

	public String getCode() {
		return code;
	}

	public String[] getCodeArr(){
		return code.split("-");
	}
	
	public void setCode(String code) {
		this.code = code;
	}

	public String getSido() {
		return sido;
	}

	public void setSido(String sido) {
		this.sido = sido;
	}

	public String getGugun() {
		return gugun;
	}

	public void setGugun(String gugun) {
		this.gugun = gugun;
	}

	public String getDong() {
		return dong;
	}

	public void setDong(String dong) {
		this.dong = dong;
	}

	public String toWebString() {
		String str = "";
		str += this.sido + " ";
		str += this.gugun + " ";
		str += this.dong;
		return str;
	}
}
