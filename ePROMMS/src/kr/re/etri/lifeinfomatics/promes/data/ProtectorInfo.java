package kr.re.etri.lifeinfomatics.promes.data;

import java.util.ArrayList;

public class ProtectorInfo {
	private String name;
	private String hp;
	private boolean sms = false;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getHp() {
		return hp;
	}

	public void setHp(String hp) {
		this.hp = hp;
	}

	public boolean isSms() {
		return sms;
	}

	public void setSms(boolean sms) {
		this.sms = sms;
	}

	public static ProtectorInfo split(String str) {
		ProtectorInfo protectorInfo = new ProtectorInfo();
		String[] strArr = str.split("/");
		protectorInfo.setName(strArr[0]);
		protectorInfo.setHp(strArr[1]);
		if(strArr[2].equals("1")){
			protectorInfo.setSms(true);
		}else{
			protectorInfo.setSms(false);
		}
		return protectorInfo;
	}

	public static ArrayList<ProtectorInfo> split(String[] strArr) {
		ArrayList<ProtectorInfo> protectors = new ArrayList<ProtectorInfo>();
		for (int i = 0; i < strArr.length; i++) {
			ProtectorInfo protectorInfo = ProtectorInfo.split(strArr[i]);
			protectors.add(protectorInfo);
		}
		return protectors;
	}

	public static ArrayList<ProtectorInfo> split(ArrayList<String> strList) {
		ArrayList<ProtectorInfo> protectors = new ArrayList<ProtectorInfo>();
		for (int i = 0; i < strList.size(); i++) {
			ProtectorInfo protectorInfo = ProtectorInfo.split(strList.get(i));
			protectors.add(protectorInfo);
		}
		return protectors;
	}
}
