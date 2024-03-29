package kr.re.etri.lifeinfomatics.promes.data;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpSessionBindingEvent;

import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;
import kr.re.etri.lifeinfomatics.promes.util.sort.SortInterface;

public class UserInfo implements SortInterface {
	private String id;
	private String name;
	private String pw;
	private String type;
	private String hp;
	private boolean sms;
	private String e_mail;
	private String pillBoxsStr = "";
	private ArrayList<PillBoxInfo> pillBoxs = new ArrayList<PillBoxInfo>();
	private String protectorsStr = "";
	private ArrayList<ProtectorInfo> protectors = new ArrayList<ProtectorInfo>();
	private String morningStart;
	private String morningEnd;
	private String noonStart;
	private String noonEnd;
	private String eveningStart;
	private String eveningEnd;
	private String nightStart;
	private String nightEnd;
	private String company;
	private String addr;
	private String ph;
	private String pillBoxState;
	private String age;
	private String gender;

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getPillBoxState() {
		return pillBoxState;
	}

	public void setPillBoxState(String pillBoxState) {
		this.pillBoxState = pillBoxState;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPw() {
		return pw;
	}

	public void setPw(String pw) {
		this.pw = pw;
	}

	public String getType() {
		return type;
	}
	
	public void setType(String type) {
		this.type = type;
	}
	
	public String getHp() {
		return hp;
	}

	public String[] getHpArr() {
		String[] hpArr = { "", "", "" };
		if (hp != null && !hp.equals("")) {
			hpArr = hp.split("-");
		}
		return hpArr;
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

	public String getE_mail() {
		return e_mail;
	}

	public String[] getE_mailArr() {
		String[] e_mailArr;
		if (e_mail != null && !e_mail.equals("")) {
			return e_mail.split("@");
		}
		else {
			return new String[2];
		}
	}

	public void setE_mail(String e_mail) {
		this.e_mail = e_mail;
	}

	public ArrayList<PillBoxInfo> getPillBoxs() {
		return pillBoxs;
	}

	public void setPillBoxs(ArrayList<PillBoxInfo> pillBoxs) {
		this.pillBoxs = pillBoxs;
	}

	public ArrayList<ProtectorInfo> getProtectors() {
		return protectors;
	}

	public void setProtectors(ArrayList<ProtectorInfo> protectors) {
		this.protectors = protectors;
	}

	public void setTime(ArrayList<String> timeList) {
		int i = 0;
		this.morningStart = timeList.get(i++);
		this.morningEnd = timeList.get(i++);
		this.noonStart = timeList.get(i++);
		this.noonEnd = timeList.get(i++);
		this.eveningStart = timeList.get(i++);
		this.eveningEnd = timeList.get(i++);
		this.nightStart = timeList.get(i++);
		this.nightEnd = timeList.get(i++);
	}

	public String getMorningStart() {
		return morningStart;
	}

	public String[] getMorningStartArr() {
		if (!morningStart.contains(":")) {
			return Util.changeIntToTime(morningStart).split(":");
		}
		return morningStart.split(":");
	}

	public void setMorningStart(String morningStart) {
		this.morningStart = morningStart;
	}

	public String getMorningEnd() {
		return morningEnd;
	}

	public String[] getMorningEndArr() {
		if (!morningEnd.contains(":")) {
			return Util.changeIntToTime(morningEnd).split(":");
		}
		return morningEnd.split(":");
	}

	public void setMorningEnd(String morningEnd) {
		this.morningEnd = morningEnd;
	}

	public String getNoonStart() {
		return noonStart;
	}

	public String[] getNoonStartArr() {
		if (!noonStart.contains(":")) {
			return Util.changeIntToTime(noonStart).split(":");
		}
		return noonStart.split(":");
	}

	public void setNoonStart(String noonStart) {
		this.noonStart = noonStart;
	}

	public String getNoonEnd() {
		return noonEnd;
	}

	public String[] getNoonEndArr() {
		if (!noonEnd.contains(":")) {
			return Util.changeIntToTime(noonEnd).split(":");
		}
		return noonEnd.split(":");
	}

	public void setNoonEnd(String noonEnd) {
		this.noonEnd = noonEnd;
	}

	public String getEveningStart() {
		return eveningStart;
	}

	public String[] getEveningStartArr() {
		if (!eveningStart.contains(":")) {
			return Util.changeIntToTime(eveningStart).split(":");
		}
		return eveningStart.split(":");
	}

	public void setEveningStart(String eveningStart) {
		this.eveningStart = eveningStart;
	}

	public String getEveningEnd() {
		return eveningEnd;
	}

	public String[] getEveningEndArr() {
		if (!eveningEnd.contains(":")) {
			return Util.changeIntToTime(eveningEnd).split(":");
		}
		return eveningEnd.split(":");
	}

	public void setEveningEnd(String eveningEnd) {
		this.eveningEnd = eveningEnd;
	}

	public String getNightStart() {
		return nightStart;
	}

	public String[] getNightStartArr() {
		if (!nightStart.contains(":")) {
			return Util.changeIntToTime(nightStart).split(":");
		}
		return nightStart.split(":");
	}

	public void setNightStart(String nightStart) {
		this.nightStart = nightStart;
	}

	public String getNightEnd() {
		return nightEnd;
	}

	public String[] getNightEndArr() {
		if (!nightEnd.contains(":")) {
			return Util.changeIntToTime(nightEnd).split(":");
		}
		return nightEnd.split(":");
	}

	public void setNightEnd(String nightEnd) {
		this.nightEnd = nightEnd;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getAddr() {
		return addr;
	}

	public String[] getCompanyAddr() {
		String[] companyAddrAddr = { "", "", "" };
		if (addr != null && !addr.equals("")) {
			String tmpAddr = addr.replace("[", "");
			String[] tmpArr = tmpAddr.split("]");
			if (tmpArr.length > 1) {
				companyAddrAddr[2] = tmpArr[1];
			}
			String[] tmpPost = tmpArr[0].split("-");
			if (tmpPost.length == 0) {
				return companyAddrAddr;
			}
			else {
				companyAddrAddr[0] = tmpPost[0];
				if (tmpPost.length > 1) {
					companyAddrAddr[1] = tmpPost[1];
				}
			}
		}
		return companyAddrAddr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getPh() {
		return ph;
	}

	public String[] getPhArr() {
		String[] phArr = { "", "", "" };
		if (ph != null && !ph.equals("")) {
			ArrayList<String> phList = Util.split("-", ph);
			phList.toArray(phArr);
		}
		return phArr;
	}

	public void setPh(String ph) {
		this.ph = ph;
	}

	public String getPillBoxsStr() {
		return pillBoxsStr;
	}

	public void setPillBoxsStr(String pillBoxsStr) {
		this.pillBoxsStr = pillBoxsStr;
	}

	public String getProtectorsStr() {
		return protectorsStr;
	}

	public void setProtectorsStr(String protectorsStr) {
		this.protectorsStr = protectorsStr;
	}
	
	public String getSortKey(String type) {
		String key = "";
		if (type.equals("ID")) {
			key = this.id;
		}
		else if (type.equals("NAME")) {
			key = this.name;
		}
		else if (type.equals("PHONE")) {
			key = this.ph;
			key = key.replaceAll("- ", "");
		}
		else if (type.equals("EMAIL")) {
			key = this.e_mail;
		}else if (type.equals("COMPANY")) {
			key = this.company;
		}
		return key;
	}

	public String toString() {
		String str = "";
		str += "============= 사용자 정보 =======================\n";
		str += " ID : " + id + "\n";
		str += " NAME : " + name + "\n";
		str += " PASSWORD : " + pw + "\n";
		str += " TYPE : " + type + "\n";
		str += " MOBILEPHONENUMBER : " + hp + "\n";
		str += " RECEIPTSMS : " + sms + "\n";
		str += " EMAIL : " + e_mail + "\n";
		str += " PILLBOXS : " + pillBoxsStr + "\n";
		str += " PROTECTORS : " + protectorsStr + "\n";
		str += " MORNINGSTART : " + morningStart + "\n";
		str += " MORNINGEND : " + morningEnd + "\n";
		str += " NOONSTART : " + noonStart + "\n";
		str += " NOONEND : " + noonEnd + "\n";
		str += " EVENINGSTART : " + eveningStart + "\n";
		str += " EVENINGEND : " + eveningEnd + "\n";
		str += " NIGHTSTART : " + nightStart + "\n";
		str += " NIGHTEND : " + nightEnd + "\n";
		str += " COMPANY : " + addr + "\n";
		str += " TELEPHONENUMBER : " + ph + "\n";
		str += " ADDRESS : " + addr + "\n";
		str += "================================================";
		return str;
	}

	@Override
	public void valueBound(HttpSessionBindingEvent event) {
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 기본 데이타베이스 저장 타입
		Date d = gc.getTime(); // Date -> util 패키지
		String str = sf.format(d);
		System.out.println(str + "################connect");
		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent event) {
		GregorianCalendar gc = new GregorianCalendar();
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 기본 데이타베이스 저장 타입
		Date d = gc.getTime(); // Date -> util 패키지
		String str = sf.format(d);
		System.out.println(str + "################disconnect");
		
		
	}
}

