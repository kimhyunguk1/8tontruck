package kr.re.etri.lifeinfomatics.promes.test;

import java.util.ArrayList;

import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;

public class TestData {

	public static ArrayList<PrescriptionInfo> getPrescription() {
		ArrayList<PrescriptionInfo> list = new ArrayList<PrescriptionInfo>();
		for (int i = 0; i < 6; i++) {
			PrescriptionInfo tmp = new PrescriptionInfo();
			tmp.setId("2009072700" + i);
			tmp.setStartDate("2009072" + i);
			tmp.setTotalDays(30);
			tmp.setDisease("°íÇ÷¾Ð");
			tmp.setPillBox_id("PH00" + i);
			tmp.setStatus(Define.PRESCRIPTION_SATUS_ON);
			list.add(tmp);
		}
		return list;
	}
	
	public static UserInfo getManagementInfo(){
		UserInfo userInfo = new UserInfo();
		userInfo.setName("È«±æµ¿");
		userInfo.setType(Define.USER_ADMIN);
		userInfo.setId("admin");
		userInfo.setPw("admin");
		return userInfo;
	}
	
	public static UserInfo getPatientInfo(){
		UserInfo userInfo = new UserInfo();
		userInfo.setName("È«±æµ¿");
		userInfo.setType(Define.USER_PATIENT);
		userInfo.setId("ID_0");
		userInfo.setPw("ID_0");
		return userInfo;
	}
	
	public static UserInfo getPharmacist(){
		UserInfo userInfo = new UserInfo();
		userInfo.setName("È«±æµ¿");
		userInfo.setType(Define.USER_PHARMACIST);
		userInfo.setId("ID_1");
		userInfo.setPw("ID_1");
		return userInfo;
	}
	
	public static UserInfo getDoctor(){
		UserInfo userInfo = new UserInfo();
		userInfo.setName("È«±æµ¿");
		userInfo.setType(Define.USER_DOCTOR);
		userInfo.setId("ID_2");
		userInfo.setPw("ID_2");
		return userInfo;
	}
	
	public static ArrayList<UserInfo> getUserList(){
		ArrayList<UserInfo> userList = new ArrayList<UserInfo>();
		for (int i = 0; i < 5; i++) {
			UserInfo userInfo = new UserInfo();
			userInfo.setId("ID_" + i);
			userInfo.setName("È«±æµ¿");
			userInfo.setE_mail(i + "mail@metabiz.com");
			userInfo.setPh("000-1111-123" + i);
			userInfo.setCompany("ETRI");
			userList.add(userInfo);
		}
		return userList;
	}
}
