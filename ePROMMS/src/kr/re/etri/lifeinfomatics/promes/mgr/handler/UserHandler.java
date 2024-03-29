package kr.re.etri.lifeinfomatics.promes.mgr.handler;

import java.util.ArrayList;
import java.util.Hashtable;

import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.PostInfo;
import kr.re.etri.lifeinfomatics.promes.data.ProtectorInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.data.DoctorList;
import kr.re.etri.lifeinfomatics.promes.data.PatientInfo;
import kr.re.etri.lifeinfomatics.promes.data.ManagerInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.PillBoxManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class UserHandler {

	public UserHandler() {
		super();
	}

	/**
	 * 사용자 정보를 조회
	 * 
	 * @param type
	 * @param keyType
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public ArrayList<UserInfo> getUserInfo(String type, String keyType, String key) throws Exception {
		Log.out.debug("사용자 목록을 조회를 시작합니다.");
		String sql = "SELECT A.ID, A.NAME, A.COMPANY, A.MOBILEPHONENUMBER, A.EMAIL, B.STATE, B.MEDICBOX_NO FROM MEMBER A ";
		sql += "LEFT JOIN MEDICBOX B ON A.PILLBOXS = B.MEDICBOX_NO WHERE A.TYPE = '" + type.toUpperCase() + "' ";
		if (key != null && !key.equals("")) {
			if (keyType.equals("id")) {
				sql += "AND A.ID LIKE '%" + key + "%'";
			}
			else if (keyType.equals("name")) {
				sql += "AND A.NAME LIKE '%" + key + "%'";
			}
			else if (keyType.equals("email")) {
				sql += "AND A.EMAIL LIKE '%" + key + "%'";
			}
			else if (keyType.equals("ID_NAME")) {
				sql += "AND (A.COMPANY LIKE '%" + key + "%' OR A.NAME LIKE '%" + key + "%')";
			}
		}
		Log.out.debug(sql);

		DBManager dbManager = DBManager.getInstance();

		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<UserInfo> userInfoList = this.toUserInfoListResultData(list, "search");
		return userInfoList;
	}

	
	/**
	 * 사용자 이름으로 사용자를 조회(동명이인)
	 * 
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public ArrayList<UserInfo> getUserInfoToName(String name) throws Exception {
		Log.out.debug("=====> 사용자 목록을 조회 시작");
		String sql = "SELECT ID, NAME, COMPANY, MOBILEPHONENUMBER, EMAIL FROM MEMBER ";
		sql += "WHERE TYPE = '" + Define.USER_PATIENT + "' ";
		sql += "AND NAME LIKE '%" + name + "%'";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<UserInfo> userInfoList = this.toUserInfoListResultData(list, "search");
		Log.out.debug("=====> 사용자 목록을 조회 완료");
		
		// TODO : 약상자 넣자 !
		for (int i = 0 ; i < userInfoList.size() ; i++)
		{
			UserInfo temUserInfo = getUserInfo(userInfoList.get(i).getId());
			
			ArrayList<String> pillBoxIdList = Util.split("/", temUserInfo.getPillBoxsStr());

			ArrayList<PillBoxInfo> tmpPillBoxs = PillBoxManager.getInstance().getPillBoxList(userInfoList.get(i).getId(), pillBoxIdList);
			
			userInfoList.get(i).setPillBoxs(tmpPillBoxs);
		}
		
		return userInfoList;
	}

	/**
	 * 사용자 ID 기반을 사용자 정보를 조회
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public UserInfo getUserInfo(String id) throws Exception {
		Log.out.debug("=====> 사용자 조회 시작");
		String sql = "SELECT ID, NAME, PASSWORD, TYPE, MOBILEPHONENUMBER, RECEIPTSMS, EMAIL, PILLBOXS, PROTECTORS, ";
		sql += "MORNINGSTART, MORNINGEND, NOONSTART, NOONEND, EVENINGSTART, EVENINGEND, NIGHTSTART, NIGHTEND, COMPANY, TELEPHONENUMBER, ADDRESS , GENDER, AGE ";
		sql += "FROM MEMBER WHERE ID = " + Util.getSqlString(id);
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		UserInfo userInfo = this.toUserInfoResultData(list);
		Log.out.debug("=====> 사용자 조회 끝");
		return userInfo;
	}

	/**
	 * 사용자 ID, PASSWORD 기반으로 사용자 정보 조회
	 * 
	 * @param id
	 * @param pw
	 * @return
	 * @throws Exception
	 */
	public UserInfo getUserInfo(String id, String pw) throws Exception {
		
		Log.out.debug("=====> 사용자 조회 시작");
		String sql = "SELECT ID, NAME, PASSWORD, TYPE, MOBILEPHONENUMBER, RECEIPTSMS, EMAIL, PILLBOXS, PROTECTORS, ";
		sql += "MORNINGSTART, MORNINGEND, NOONSTART, NOONEND, EVENINGSTART, EVENINGEND, NIGHTSTART, NIGHTEND, COMPANY, TELEPHONENUMBER, ADDRESS , GENDER, AGE ";
		sql += "FROM MEMBER WHERE ID = " + Util.getSqlString(id);
		sql += "AND PASSWORD = " + Util.getSqlString(pw);
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		UserInfo userInfo = this.toUserInfoResultData(list);
		Log.out.debug("=====> 사용자 조회 끝");
		return userInfo;
	}
	

	/**
	 * 사용자 Type에 따른 Count를 조회
	 * 
	 * @return
	 * @throws Exception
	 */
	public Hashtable<String, String> getUserCount() throws Exception 
	{
		Log.out.debug("=====> 사용자 인원 조회 시작");
		Hashtable<String, String> userCounthash = new Hashtable<String, String>();
		String sql = "SELECT COUNT(ID) FROM MEMBER WHERE TYPE = 'PATIENT'";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		userCounthash.put("PATIENT", list.get(0).get(0).toString());

		sql = "SELECT COUNT(ID) FROM MEMBER WHERE TYPE = 'DOCTOR'";
		Log.out.debug(sql);
		list = dbManager.executeQuery(sql);
		userCounthash.put("DOCTOR", list.get(0).get(0).toString());

		sql = "SELECT COUNT(ID) FROM MEMBER WHERE TYPE = 'PHARMACIST'";
		Log.out.debug(sql);
		list = dbManager.executeQuery(sql);
		userCounthash.put("PHARMACIST", list.get(0).get(0).toString());
		
		sql = "SELECT COUNT(ID) FROM MEMBER WHERE TYPE = 'INCHARGE'";
		Log.out.debug(sql);
		list = dbManager.executeQuery(sql);
		userCounthash.put("INCHARGE", list.get(0).get(0).toString());
		
		Log.out.debug("=====> 사용자 인원 조회 종료");
		return userCounthash;
	}

	/**
	 * 환자 Count 조회
	 * 
	 * @param userId
	 * @throws Exception
	 */
	public int getPatientCount(String userId) throws Exception {
		Log.out.debug("=====> 환자 Count 시작");
		String sql = "SELECT MEMBER_ID FROM PRESCRIPTION WHERE PHARMACY = " + Util.getSqlString(userId) + " GROUP BY MEMBER_ID";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);

		int patientCount = 0;

		if (list.size() > 0) {
			patientCount = list.size();
		}
		Log.out.debug("=====> 환자 Count 끝");
		return patientCount;
	}
	
	/**
	 * 복용완료 환자리스트
	 * @Method Name : getTakecompliteList
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<String> getTakecompliteList(String userId) throws Exception {
		Log.out.debug("=====> 복용완료환자 select 시작");
		String sql = "SELECT A.NAME FROM MEMBER A, ";
		sql += "(SELECT DISTINCT C.MEMBER_ID FROM PRESCRIPTION C WHERE PHARMACY = "+ Util.getSqlString(userId) +" GROUP BY C.MEMBER_ID ";
		sql +="AND (C.MEMBER_ID) NOT IN (SELECT D.MEMBER_ID FROM PRESCRIPTION D WHERE PHARMACY ="+Util.getSqlString(userId)+" AND STATUS NOT IN ('FINISH') GROUP BY D.MEMBER_ID)) B ";
		sql += "WHERE A.ID=B.MEMBER_ID ";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		ArrayList<String> Namelist = new ArrayList<String>();
		for(ArrayList<Object> row : list){
			int i = 0;
			Namelist.add(i,row.get(i).toString());		
		}		
		Log.out.debug("=====> 복용완료환자 select 끝");
		return Namelist;
	}
	
	/**
	 * 복용완료가 아닌 환자 Count조회
	 * 
	 * @param userId
	 * @throws Exception
	 */
	public int getTakenPatientCount(String userId) throws Exception {
		Log.out.debug("=====> 복용환자 Count 시작");
		String sql = "SELECT MEMBER_ID FROM PRESCRIPTION WHERE PHARMACY ="+Util.getSqlString(userId)+" AND STATUS NOT IN ('FINISH') GROUP BY MEMBER_ID";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);

		int TakenpatientCount = 0;

		if (list.size() > 0) {
			TakenpatientCount = list.size();
		}
		Log.out.debug("=====> 복용환자 Count 끝");
		return TakenpatientCount;
	}

	public void addUserInfo(ConnectionResource connResource, UserInfo userInfo) throws Exception {
		Log.out.debug("=====> 사용자 저장 시작");
		String[] cols = this.toColumnValue(userInfo);
		String sql = "INSERT INTO MEMBER (ID, NAME, PASSWORD, TYPE, MOBILEPHONENUMBER, RECEIPTSMS, EMAIL, PILLBOXS, PROTECTORS, MORNINGSTART, ";
		sql += "MORNINGEND, NOONSTART, NOONEND, EVENINGSTART, EVENINGEND, NIGHTSTART, NIGHTEND, COMPANY, TELEPHONENUMBER, ADDRESS,GENDER,AGE) VALUES (";
		for (int i = 0; i < cols.length; i++) {
			sql += cols[i];
		}
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 사용자 저장 끝");
	}

	public void addUserInfo(UserInfo userInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		this.addUserInfo(connResource, userInfo);
	}
	
	//new
	public void addPatientInfo(ConnectionResource connResource, PatientInfo patientInfo) throws Exception {
		Log.out.debug("=====> new 사용자 저장 시작");
		String[] cols = this.toColumnValue(patientInfo);
		String sql = "INSERT INTO PATIENT (Patient_no, Name, ID, Password, Gender, Birth, Address, Phone, Mobile, ReceiptSMS, ";
		sql += "Manager_ID) VALUES (";
		for (int i = 0; i < cols.length; i++) {
			sql += cols[i];
		}
		sql += ")";
		
		Log.out.debug(sql);
		//DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> new 사용자 저장 끝");
	}

	//new
	public void addPatientInfo(PatientInfo patientInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		this.addPatientInfo(connResource, patientInfo);
	}
	
	//new
	public void addManagerInfo(ConnectionResource connResource, ManagerInfo managerInfo) throws Exception {
		Log.out.debug("=====> new 사용자 저장 시작");
		String[] cols = this.toColumnValue(managerInfo);
		String sql = "INSERT INTO MANAGER (Manager_ID, Name, Password, Phone, Mobile, RegDate, Permission_no, ";
		sql += "Org_no) VALUES (";
		for (int i = 0; i < cols.length; i++) {
			sql += cols[i];
		}
		sql += ")";
		
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> new 사용자 저장 끝");
	}

	//new
	public void addManagerInfo(ManagerInfo managerInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		this.addManagerInfo(connResource, managerInfo);
	}

	public void modifyUserInfo(ConnectionResource connResource, UserInfo userInfo) throws Exception {
		Log.out.debug("=====> 사용자 수정 시작");
		String[] cols = this.toColumnValue(userInfo);
		String sql = "UPDATE MEMBER SET";
		int i = 1;
		sql += " NAME = " + cols[i++];
		sql += " PASSWORD = " + cols[i++];
		i++;
		sql += " MOBILEPHONENUMBER = " + cols[i++];
		sql += " RECEIPTSMS = " + cols[i++];
		sql += " EMAIL = " + cols[i++];
		sql += " PILLBOXS = " + cols[i++];
		sql += " PROTECTORS = " + cols[i++];
		sql += " MORNINGSTART = " + cols[i++];
		sql += " MORNINGEND = " + cols[i++];
		sql += " NOONSTART = " + cols[i++];
		sql += " NOONEND = " + cols[i++];
		sql += " EVENINGSTART = " + cols[i++];
		sql += " EVENINGEND = " + cols[i++];
		sql += " NIGHTSTART = " + cols[i++];
		sql += " NIGHTEND = " + cols[i++];
		sql += " COMPANY = " + cols[i++];
		sql += " TELEPHONENUMBER = " + cols[i++];
		sql += " ADDRESS = " + cols[i++];
		sql += " GENDER = " + cols[i++];
		sql += " AGE = " + cols[i++];
		sql += " WHERE ID = '" + userInfo.getId() + "'";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 사용자 수정 종료");
	}

	public void modifyUserInfo(UserInfo userInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		this.modifyUserInfo(connResource, userInfo);
		connResource.commit();
	}

	public void delUserInfo(ConnectionResource connResource, String userId) throws Exception {
		Log.out.debug("=====> 사용자 삭제 시작");
		String sql = "DELETE FROM MEMBER WHERE ID = " + Util.getSqlString(userId);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 사용자 삭제 끝");
	}

	public void delUserInfo(String userId) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		this.delUserInfo(connResource, userId);
	}

	public boolean checkUserId(String id) throws Exception {
		Log.out.debug("=====> 사용자 ID 중복 확인 시작");
		String sql = "SELECT ID FROM MEMBER ";
		sql += "WHERE ID = " + Util.getSqlString(id);
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		if (list.size() > 0) {
			return true;
		}
		Log.out.debug("=====> 사용자 ID 중복 확인 끝");
		return false;
	}

	public ArrayList<PostInfo> searchPost(String key) throws Exception {
		Log.out.debug("=====> 우편번호 조회 시작");
		String sql = "SELECT CODE, SIDO, GUGUN, DONG FROM ZIPPOST ";
		sql += "WHERE DONG LIKE '%" + key + "%' ORDER BY IDX ASC";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<PostInfo> posts = this.toPostInfoListResultData(list);
		Log.out.debug("=====> 우편번호 조회 끝");
		return posts;
	}
	
	/**
	 * 의사 모두 조회
	 * 
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public ArrayList<DoctorList> getDoctorInfoList() throws Exception {
		Log.out.debug("=====> 의사 목록 조회 시작");
		String sql = "SELECT ID, NAME FROM MEMBER WHERE TYPE = '" + Define.USER_DOCTOR + "'";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<DoctorList> doctorInfoList = this.toDoctorListResultData(list);
		Log.out.debug("=====> 의사 목록 조회 완료");
		
		return doctorInfoList;
	}

	

	

	/*******************************************************************************************************************************************************************************************************************************************************************************************************
	 * SQL Data 변환
	 ******************************************************************************************************************************************************************************************************************************************************************************************************/

	public UserInfo toUserInfoResultData(ArrayList<ArrayList<Object>> list) {
		if (list.size() > 0) {
			int i = 0;
			ArrayList<Object> rows = list.get(0);
			UserInfo userInfo = new UserInfo();
			userInfo.setId(rows.get(i++).toString());
			userInfo.setName(rows.get(i++).toString());
			userInfo.setPw(rows.get(i++).toString());
			String type = rows.get(i++).toString();
			userInfo.setType(type);
			userInfo.setHp(rows.get(i++).toString());
			String receiptSms = rows.get(i++).toString();
			if (receiptSms.equals("1")) {
				userInfo.setSms(true);
			}
			else {
				userInfo.setSms(false);
			}
			userInfo.setE_mail(rows.get(i++).toString());
			String pillBoxsStr = rows.get(i++).toString();
			userInfo.setPillBoxsStr(pillBoxsStr);
			String protectorsStr = rows.get(i++).toString();
			if (protectorsStr != null && !protectorsStr.equals("")) {
				protectorsStr = protectorsStr.replace("[", "");
				ArrayList<String> protectorList = Util.split("]", protectorsStr);
				ArrayList<ProtectorInfo> protectors = ProtectorInfo.split(protectorList);
				userInfo.setProtectors(protectors);
			}
			userInfo.setMorningStart(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setMorningEnd(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setNoonStart(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setNoonEnd(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setEveningStart(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setEveningEnd(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setNightStart(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setNightEnd(Util.changeIntToTime(rows.get(i++).toString()));
			userInfo.setCompany(rows.get(i++).toString());
			userInfo.setPh(rows.get(i++).toString());
			userInfo.setAddr(rows.get(i++).toString());
			userInfo.setGender(rows.get(i++).toString());
			userInfo.setAge(rows.get(i++).toString());
			return userInfo;
		}
		return null;
	}

	public ArrayList<UserInfo> toUserInfoListResultData(ArrayList<ArrayList<Object>> list, String type) {
		ArrayList<UserInfo> userInfoList = new ArrayList<UserInfo>();;
		if (list.size() > 0) {
			if (type.equals("search")) {
				for (ArrayList<Object> rows : list) {
					int i = 0;
					UserInfo userInfo = new UserInfo();
					userInfo.setId(rows.get(i++).toString());
					userInfo.setName(rows.get(i++).toString());
					userInfo.setCompany(rows.get(i++).toString());
					userInfo.setPh(rows.get(i++).toString());
					userInfo.setE_mail(rows.get(i++).toString());
					if (rows.size() > 5)
					{
						userInfo.setPillBoxState(rows.get(i++).toString());
						userInfo.setPillBoxsStr(rows.get(i++).toString());
					}
					userInfoList.add(userInfo);
				}
			}
		}
		return userInfoList;
	}

	public ArrayList<PostInfo> toPostInfoListResultData(ArrayList<ArrayList<Object>> list) {
		ArrayList<PostInfo> posts = new ArrayList<PostInfo>();;
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				int i = 0;
				PostInfo postInfo = new PostInfo();
				postInfo.setCode(rows.get(i++).toString());
				postInfo.setSido(rows.get(i++).toString());
				postInfo.setGugun(rows.get(i++).toString());
				postInfo.setDong(rows.get(i++).toString());
				posts.add(postInfo);
			}
		}
		return posts;
	}
	
	public ArrayList<DoctorList> toDoctorListResultData(ArrayList<ArrayList<Object>> list) {
		ArrayList<DoctorList> doctorList = new ArrayList<DoctorList>();;
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				int i = 0;
				DoctorList userInfo = new DoctorList();
				userInfo.setID(rows.get(i++).toString());
				userInfo.setName(rows.get(i++).toString());
				doctorList.add(userInfo);
			}
		}
		return doctorList;
	}

	public String[] toColumnValue(UserInfo data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getId()));
		vList.add(Util.getSqlStringAnd(data.getName()));
		vList.add(Util.getSqlStringAnd(data.getPw()));
		vList.add(Util.getSqlStringAnd(data.getType()));
		vList.add(Util.getSqlStringAnd(data.getHp()));
		if (data.isSms()) {
			vList.add(Util.getSqlStringAnd("1"));
		}
		else {
			vList.add(Util.getSqlStringAnd("0"));
		}
		vList.add(Util.getSqlStringAnd(data.getE_mail()));
		ArrayList<PillBoxInfo> pillBoxs = data.getPillBoxs();
		String pillBoxIdStr = "";
		for (int i = 0; i < pillBoxs.size(); i++) {
			PillBoxInfo pillBoxInfo = pillBoxs.get(i);
			pillBoxIdStr += pillBoxInfo.getId();
			if (i != pillBoxs.size() - 1) {
				pillBoxIdStr += "/";
			}
		}
		vList.add(Util.getSqlStringAnd(pillBoxIdStr));
		vList.add(Util.getSqlStringAnd(data.getProtectorsStr()));
		vList.add(Util.getSqlStringAnd(data.getMorningStart()));
		vList.add(Util.getSqlStringAnd(data.getMorningEnd()));
		vList.add(Util.getSqlStringAnd(data.getNoonStart()));
		vList.add(Util.getSqlStringAnd(data.getNoonEnd()));
		vList.add(Util.getSqlStringAnd(data.getEveningStart()));
		vList.add(Util.getSqlStringAnd(data.getEveningEnd()));
		vList.add(Util.getSqlStringAnd(data.getNightStart()));
		vList.add(Util.getSqlStringAnd(data.getNightEnd()));
		vList.add(Util.getSqlStringAnd(data.getCompany()));
		vList.add(Util.getSqlStringAnd(data.getPh()));
		vList.add(Util.getSqlStringAnd(data.getAddr()));
		vList.add(Util.getSqlStringAnd(data.getGender()));
		vList.add(Util.getSqlString(data.getAge()));
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
	
	//new
	public String[] toColumnValue(PatientInfo data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();		
		vList.add(Util.getSqlStringAnd(data.getPatientNo()));
		vList.add(Util.getSqlStringAnd(data.getName()));
		vList.add(Util.getSqlStringAnd(data.getId()));		
		vList.add(Util.getSqlStringAnd(data.getPw()));
		vList.add(Util.getSqlStringAnd(data.getGender()));
		vList.add(Util.getSqlStringAnd(data.getBirth()));
		vList.add(Util.getSqlStringAnd(data.getAddress()));
		vList.add(Util.getSqlStringAnd(data.getPhone()));
		vList.add(Util.getSqlStringAnd(data.getMobile()));
		if (data.isSms()) {
			vList.add(Util.getSqlStringAnd("1"));
		}
		else {
			vList.add(Util.getSqlStringAnd("0"));
		}
		vList.add(Util.getSqlString(data.getManagerID()));
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
	
	//new
		public String[] toColumnValue(ManagerInfo data) throws Exception {
			ArrayList<String> vList = new ArrayList<String>();		
			vList.add(Util.getSqlStringAnd(data.getId()));
			vList.add(Util.getSqlStringAnd(data.getName()));					
			vList.add(Util.getSqlStringAnd(data.getPw()));
			vList.add(Util.getSqlStringAnd(data.getPhone()));
			vList.add(Util.getSqlStringAnd(data.getMobile()));
			vList.add(Util.getSqlStringAnd(data.getRegDate()));
			vList.add(Util.getSqlStringAnd(data.getPermission()));
			vList.add(Util.getSqlString(data.getOrgNo()));
			String[] value = new String[vList.size()];
			vList.toArray(value);
			return value;
		}
}
