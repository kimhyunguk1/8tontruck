package kr.re.etri.lifeinfomatics.promes.mgr.handler;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;

import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.RecvPill;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.ScheduleManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class PrescriptionHandler {
	public PrescriptionHandler() {
		super();
	}

	/**
	 * 처방 정보 조회
	 * 
	 * @param userId
	 * @param name
	 * @param prescriptionId
	 * @param startDate
	 * @param endDate
	 * @param takenSatus
	 * @param pillBoxId
	 * @param disease
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PrescriptionInfo> getPrescriptions(String userId, String name, String prescriptionId, String startDate, String endDate, String takenSatus, String pillBoxId, String disease, String loginId ,String boxtype,String searchDate) throws Exception {
		Log.out.debug("=====> 처방전  조회(search) 시작");
		String sql = "SELECT P.ID, DATE_FORMAT(STR_TO_DATE(P.STARTDATE, '%Y%m%d'), '%Y-%m-%d'), P.TOTALDAYS,P.FREQUENCY, P.DISEASE, P.STATUS, U.NAME, U.ID, P.PILLBOX_ID, P.ISDETAILSCHEDULE, P.HOSPITAL, PI.TYPE , U.AGE, U.GENDER FROM PRESCRIPTION P LEFT JOIN PILLBOX PI ON P.PILLBOX_ID = PI.ID  , MEMBER U  WHERE P.MEMBER_ID = U.ID	";
		if (loginId != null && !loginId.equals("")) {
			if(loginId.equals("Total") || loginId.equals("admin")){
				sql += " AND P.PHARMACY not in ('dhong')";
			}else
				sql += " AND P.PHARMACY = '" + loginId + "'";
		}
		if (boxtype != null && !boxtype.equals("")) {
			sql += " AND PI.TYPE = '" + boxtype + "'";
		}
		if (userId != null && !userId.equals("")) {
			sql += " AND U.ID = '" + userId + "'";
		}
		if (name != null && !name.equals("")) {
			sql += " AND U.NAME = '" + name + "'";
		}
		if (prescriptionId != null && !prescriptionId.equals("")) {
			sql += " AND P.ID LIKE '%" + prescriptionId + "%'";
		}
		if (startDate != null && !startDate.equals("")) {
			sql += " AND P.STARTDATE >= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlString(startDate) + ", '%Y-%m-%d'), '%Y%m%d')";
		}
		if (endDate != null && !endDate.equals("")) {
			sql += " AND P.STARTDATE <= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlString(endDate) + ", '%Y-%m-%d'), '%Y%m%d')";
		}
		if (takenSatus != null && !takenSatus.equals("") && !takenSatus.equals("ALL")) {
			if (takenSatus.equals("OFF")) {
				sql += " AND P.ISDETAILSCHEDULE = '0'";
			}
			else {
				sql += " AND P.STATUS = " + Util.getSqlString(takenSatus);
			}
		}
		if (pillBoxId != null && !pillBoxId.equals("")) {
			sql += " AND P.PILLBOX_ID = " + Util.getSqlString(pillBoxId);
		}
		if (disease != null && !disease.equals("")) {
			sql += " AND P.P.DISEASE LIKE '%" + disease + "%'";
		}
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();

		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<PrescriptionInfo> prescriptions = this.toPrescriptionInfoListResultData(list, searchDate);
		Log.out.debug("=====> 처방전  조회(search) 끝");
		return prescriptions;
	}
	public ArrayList<PrescriptionInfo> getPrescriptionsNew(String userId, String name, String prescriptionId, String startDate, String endDate, String takenSatus, String pillBoxId, String disease, String loginId ,String boxtype,String searchDate,String sortName,String sortType,String startPoint,String offset) throws Exception {
		Log.out.debug("=====> 처방전  조회(search) 시작");
		String sql = "SELECT P.ID, DATE_FORMAT(STR_TO_DATE(P.STARTDATE, '%Y%m%d'), '%Y-%m-%d') as start, DATE_FORMAT(STR_TO_DATE(P.ENDDATE , '%Y%m%d'), '%Y-%m-%d') as end, P.TOTALDAYS,P.FREQUENCY, P.DISEASE, P.STATUS, U.NAME, U.ID, P.PILLBOX_ID, P.ISDETAILSCHEDULE, P.HOSPITAL, PI.TYPE , U.AGE, U.GENDER FROM PRESCRIPTION P, MEMBER U, PILLBOX PI  WHERE P.MEMBER_ID = U.ID AND P.PILLBOX_ID = PI.ID";
		if (loginId != null && !loginId.equals("")) {
			if(loginId.equals("Total") || loginId.equals("admin")){
				sql += " AND P.PHARMACY not in ('dhong')";
			}else
				sql += " AND P.PHARMACY = '" + loginId + "'";
		}
		if (boxtype != null && !boxtype.equals("")) {
			sql += " AND PI.TYPE = '" + boxtype + "'";
		}
		if (userId != null && !userId.equals("")) {
			sql += " AND U.ID = '" + userId + "'";
		}
		if (name != null && !name.equals("")) {
			sql += " AND U.NAME = '" + name + "'";
		}
		if (prescriptionId != null && !prescriptionId.equals("")) {
			sql += " AND P.ID LIKE '%" + prescriptionId + "%'";
		}
		if (startDate != null && !startDate.equals("")) {
			sql += " AND P.STARTDATE >= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlString(startDate) + ", '%Y-%m-%d'), '%Y%m%d')";
		}
		if (endDate != null && !endDate.equals("")) {
			sql += " AND P.STARTDATE <= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlString(endDate) + ", '%Y-%m-%d'), '%Y%m%d')";
		}
		if (takenSatus != null && !takenSatus.equals("") && !takenSatus.equals("ALL")) {
			if (takenSatus.equals("OFF")) {
				sql += " AND P.ISDETAILSCHEDULE = '0'";
			}
			else {
				sql += " AND P.STATUS = " + Util.getSqlString(takenSatus);
			}
		}
		if (pillBoxId != null && !pillBoxId.equals("")) {
			sql += " AND P.PILLBOX_ID = " + Util.getSqlString(pillBoxId);
		}
		if (disease != null && !disease.equals("")) {
			sql += " AND P.P.DISEASE LIKE '%" + disease + "%'";
		}if (sortName != null && !sortName.equals("")) {
			if(sortName.equals("org")){
				sql += " ORDER BY P.HOSPITAL";
			}else if(sortName.equals("id")){
				sql += " ORDER BY U.ID";
			}else if(sortName.equals("name")){
				sql += " ORDER BY U.NAME";
			}else if(sortName.equals("age")){
				sql += " ORDER BY U.AGE";
			}else if(sortName.equals("gender")){
				sql += " ORDER BY U.GENDER";
			}else if(sortName.equals("start")){
				sql += " ORDER BY start";
			}else if(sortName.equals("end")){
				sql += " ORDER BY end";
			}else if(sortName.equals("status")){
				sql += " ORDER BY P.STATUS";
			}
			
		}if (sortType != null && !sortType.equals("")) {
			sql += " " + sortType;
		}
		sql += " LIMIT " + startPoint + " , " + offset;
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();

		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<PrescriptionInfo> prescriptions = this.toPrescriptionInfoListResultDataNew(list, searchDate);
		Log.out.debug("=====> 처방전  조회(search) 끝");
		return prescriptions;
	}
	public String getPrescriptionsTotalCnt(String userId, String name, String prescriptionId, String startDate, String endDate, String takenSatus, String pillBoxId, String disease, String loginId ,String boxtype,String searchDate,String sortName,String sortType) throws Exception {
		Log.out.debug("=====> 처방전  COUNT(*) 시작");
		String sql = "SELECT COUNT(*) FROM PRESCRIPTION P, MEMBER U, PILLBOX PI  WHERE P.MEMBER_ID = U.ID AND P.PILLBOX_ID = PI.ID";
		if (loginId != null && !loginId.equals("")) {
			if(loginId.equals("Total") || loginId.equals("admin")){
				sql += " AND P.PHARMACY not in ('dhong')";
			}else
				sql += " AND P.PHARMACY = '" + loginId + "'";
		}
		if (boxtype != null && !boxtype.equals("")) {
			sql += " AND PI.TYPE = '" + boxtype + "'";
		}
		if (userId != null && !userId.equals("")) {
			sql += " AND U.ID = '" + userId + "'";
		}
		if (name != null && !name.equals("")) {
			sql += " AND U.NAME = '" + name + "'";
		}
		if (prescriptionId != null && !prescriptionId.equals("")) {
			sql += " AND P.ID LIKE '%" + prescriptionId + "%'";
		}
		if (startDate != null && !startDate.equals("")) {
			sql += " AND P.STARTDATE >= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlString(startDate) + ", '%Y-%m-%d'), '%Y%m%d')";
		}
		if (endDate != null && !endDate.equals("")) {
			sql += " AND P.STARTDATE <= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlString(endDate) + ", '%Y-%m-%d'), '%Y%m%d')";
		}
		if (takenSatus != null && !takenSatus.equals("") && !takenSatus.equals("ALL")) {
			if (takenSatus.equals("OFF")) {
				sql += " AND P.ISDETAILSCHEDULE = '0'";
			}
			else {
				sql += " AND P.STATUS = " + Util.getSqlString(takenSatus);
			}
		}
		if (pillBoxId != null && !pillBoxId.equals("")) {
			sql += " AND P.PILLBOX_ID = " + Util.getSqlString(pillBoxId);
		}
		if (disease != null && !disease.equals("")) {
			sql += " AND P.P.DISEASE LIKE '%" + disease + "%'";
		}
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		String totalCnt="";
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		for(ArrayList<?> tmp : list){
			totalCnt = String.valueOf(tmp.get(0));
		}
		Log.out.debug("=====> 처방전  COUNT(*) 끝");
		return totalCnt;
	}
	/**
	 * 처방번호 기반 처방 정보 조회
	 * 
	 * @param prescriptionId
	 * @return
	 * @throws Exception
	 */
	public PrescriptionInfo getPrescription(String prescriptionId, String hospital) throws Exception {
		Log.out.debug("=====> 처방전 조회 시작");
		String sql = "SELECT P.ID, P.MEMBER_ID, P.PILLBOX_ID, P.HOSPITAL, P.PHARMACY, P.TOTALDAYS, P.FREQUENCY, P.DISEASE, P.DIRECTION, ";
		sql += "DATE_FORMAT(STR_TO_DATE(P.STARTDATE, '%Y%m%d'), '%Y-%m-%d'), P.STARTTAKENORDER, DATE_FORMAT(STR_TO_DATE(P.ENDDATE, '%Y%m%d'), '%Y-%m-%d'), ";
		sql += "P.ENDTAKENORDER, P.TAKENORDERPROPERTIES, P.ISDETAILSCHEDULE, P.STATUS, P.LASTUPDATED, PI.TYPE ";
		sql += "FROM PRESCRIPTION P LEFT JOIN PILLBOX PI ON P.PILLBOX_ID = PI.ID WHERE P.ID = " + Util.getSqlString(prescriptionId);
		if (hospital != null && !hospital.equals("")) {
			sql += " AND P.HOSPITAL = " + Util.getSqlString(hospital);
		}
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();

		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		PrescriptionInfo prescriptionInfo = this.toPrescriptionInfoListResultData(list);
		Log.out.debug("=====> 처방전 조회 끝");
		return prescriptionInfo;
	}

	/**
	 * 사용자의 전체 처방전 ID List을 가져온다.
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<String> getPrescriptionToUserId(String userId) throws Exception {
		Log.out.debug("=====> 처방전 ID List 조회 끝");
		String sql = "SELECT ID, STATUS, HOSPITAL FROM PRESCRIPTION WHERE MEMBER_ID = " + Util.getSqlString(userId);
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();

		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<String> outList = new ArrayList<String>();
		if (list.size() > 0) {
			boolean bool = false;
			for (ArrayList<Object> rows : list) {
				String prescriptionId = rows.get(0).toString();
				String status = rows.get(0).toString();
				if (bool && status.equals(Define.PRESCRIPTION_SATUS_ON)) {
					outList.add(0, prescriptionId);
				}
				else {
					outList.add(prescriptionId);
				}
			}
		}
		Log.out.debug("=====> 처방전 ID List 조회 끝");
		return outList;
	}

	/**
	 * 사용자(약사, 의사)ID 기반으로 등록 처방 Count 조호
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int getPharmacistPrescriptionCount(String userId) throws Exception {
		Log.out.debug("=====> 처방전 Count 조회 시작");
		String sql = "SELECT COUNT(ID) FROM PRESCRIPTION WHERE PHARMACY = " + Util.getSqlString(userId);
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);

		int prescriptionCount = 0;
		if (list.size() > 0) {
			prescriptionCount = Integer.parseInt(list.get(0).get(0).toString());
		}
		Log.out.debug("=====> 처방전 Count 조회 끝");
		return prescriptionCount;
	}

	/**
	 * 사용자(환자) ID 기반으로 등록 처방 Count 조회
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public Hashtable<String, String> getPatientPrescriptionCount(String userId) throws Exception {
		Log.out.debug("=====> 처방전 Count 조회 시작");
		String sql = "SELECT ISDETAILSCHEDULE, COUNT(ISDETAILSCHEDULE)  FROM PRESCRIPTION WHERE MEMBER_ID = " + Util.getSqlString(userId) + " GROUP BY ISDETAILSCHEDULE";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);

		Hashtable<String, String> countHahs = new Hashtable<String, String>();
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				countHahs.put(rows.get(0).toString(), String.valueOf(rows.get(1)));
			}
		}
		Log.out.debug("=====> 처방전 Count 조회 시작");
		return countHahs;
	}

	/**
	 * 사용자에 등록된 처방전이 있는지 확인한다.(FINISH 제외한)
	 * 
	 * @param userId
	 */
	public ArrayList<String> getPrescriptionExceptFinish(String type, String userId) throws Exception {
		Log.out.debug("=====> 처방전 ID List(Except Finish) 조회 시작");
		String sql = "SELECT ID FROM PRESCRIPTION WHERE";
		if (type.equals(Define.USER_PATIENT)) {
			sql += " MEMBER_ID = " + Util.getSqlString(userId);
		}
		else {
			sql += " PHARMACY = " + Util.getSqlString(userId);
		}
		sql += " AND STATUS IN (";
		sql += Util.getSqlStringAnd(Define.PRESCRIPTION_SATUS_NOSCHEDULE);
		sql += Util.getSqlStringAnd(Define.PRESCRIPTION_SATUS_READY);
		sql += Util.getSqlStringAnd(Define.PRESCRIPTION_SATUS_ON);
		sql += Util.getSqlString(Define.PRESCRIPTION_SATUS_FINISH);
		sql += ")";
		Log.out.debug(sql);

		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);

		ArrayList<String> outputList = new ArrayList<String>();
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				outputList.add(rows.get(0).toString());
			}
		}
		Log.out.debug("=====> 처방전 ID List(Except Finish) 조회 종료");
		return outputList;
	}

	public void addPrescription(PrescriptionInfo prescriptionInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		this.addPrescription(connResource, prescriptionInfo);
	}

	public void addPrescription(ConnectionResource connResource, PrescriptionInfo prescriptionInfo) throws Exception {		
		Log.out.debug("=====> 처방전 추가 시작");
		String[] cols = this.toColumnValue(prescriptionInfo);
		String sql = "INSERT INTO PRESCRIPTION (ID, MEMBER_ID, PILLBOX_ID, HOSPITAL, PHARMACY, TOTALDAYS, FREQUENCY, DISEASE, ";
		sql += "DIRECTION, STARTDATE, STARTTAKENORDER, ENDDATE, ENDTAKENORDER, TAKENORDERPROPERTIES, ISDETAILSCHEDULE, STATUS, LASTUPDATED) VALUES (";
		for (int i = 0; i < cols.length; i++) {
			sql += cols[i];
		}
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 처방전 추가 끝");
	}
	
	public void addPrescriptionm(ConnectionResource connResource, RecvPill recvpill) throws Exception {
		Log.out.debug("=====> 수약관리 추가 시작");
		String sql = "INSERT INTO RECV_PILL (RecvPill_no, Patient_no, Management_no, Recv_DueDate, Recv_date, Medic_period)";
		sql += "VALUES (";
		sql += "'" + recvpill.getRecvPill_no() + "', '" + recvpill.getPatient_no() + "', '" + recvpill.getManagement_no() + "' , " +
				"STR_TO_DATE('" + recvpill.getRecvDueDate()  + "', '%Y-%m-%d') , STR_TO_DATE('" + recvpill.getRecvDate()  + "', '%Y-%m-%d %H:%i:%s'), '" + recvpill.getMedicperiod() + "'"; 
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 수약관리 추가 끝");
	}
	
	public void modifyPrescriptionPillBoxId(ConnectionResource connResource)
	{
		
	}

	public void modifyPrescription(ConnectionResource connResource, PrescriptionInfo prescriptionInfo) throws Exception {
		Log.out.debug("=====> 처장전 수정 시작");
		String[] cols = this.toColumnValue(prescriptionInfo, "UPDATE");
		String sql = "UPDATE PRESCRIPTION SET";
		int i = 1;
		sql += " MEMBER_ID = " + cols[i++];
		sql += " PILLBOX_ID = " + cols[i++];
		sql += " HOSPITAL = " + cols[i++];
		sql += " PHARMACY = " + cols[i++];
		sql += " TOTALDAYS = " + cols[i++];
		sql += " FREQUENCY = " + cols[i++];
		sql += " DISEASE = " + cols[i++];
		sql += " DIRECTION = " + cols[i++];
		sql += " STARTDATE = " + cols[i++];
		sql += " STARTTAKENORDER = " + cols[i++];
		sql += " ENDDATE = " + cols[i++];
		sql += " ENDTAKENORDER = " + cols[i++];
		sql += " TAKENORDERPROPERTIES = " + cols[i++];
		sql += " ISDETAILSCHEDULE = " + cols[i++];
		sql += " STATUS = " + cols[i++];
		// sql += " LASTUPDATED = " + cols[i++];
		sql += " WHERE ID = '" + prescriptionInfo.getId() + "'";
		sql += " AND HOSPITAL = '" + prescriptionInfo.getHospital() + "'";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 처장전 수정 끝");
	}

	public void updatePrescriptionStatus(ConnectionResource connResource, String prescriptionId, String status,String hospital) throws Exception {
		Log.out.debug("=====> Prescription Status UPDATE 시작");
		String sql = "UPDATE PRESCRIPTION SET STATUS = " + Util.getSqlStringAnd(status);
		sql += "LASTUPDATED = DATE_FORMAT(now(), '%Y%m%d %H%i%s')" + " WHERE ID = " + Util.getSqlString(prescriptionId);
		sql += " AND HOSPITAL = " + Util.getSqlString(hospital);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> Prescription Status UPDATE 끝");
	}

	public void updateDetailPrescription(ConnectionResource connResource, String isDetailSchedule, String prescription, String hospital) throws Exception {
		Log.out.debug("=====> ISDATAILSCHEDULE UPDATE 시작");
		String sql = "UPDATE PRESCRIPTION SET ISDETAILSCHEDULE = " + Util.getSqlStringAnd(isDetailSchedule);
		sql += "LASTUPDATED = DATE_FORMAT(now(), '%Y%m%d %H%i%s')" + " WHERE ID = " + Util.getSqlString(prescription);
		sql += " AND HOSPITAL = " + Util.getSqlString(hospital);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> ISDATAILSCHEDULE UPDATE 시작");
	}

	public void delPrescriptionToPrescriptionId(ConnectionResource connResource, String prescriptionId, String hospital) throws Exception {
		Log.out.debug("=====> 처방전 삭제 시작(Prescription ID)");
		String sql = "DELETE FROM PRESCRIPTION WHERE ID =" + Util.getSqlString(prescriptionId);
		sql += " AND HOSPITAL = " + Util.getSqlString(hospital);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 처방전 삭제 끝");
	}
	
	/*
	 * 처방전 약상자ID 변경
	 */
	public void updatePrescriptionPillboxId(String Id, String oldpillboxId, String newpillboxId) throws Exception {
		Log.out.debug("=====> 처방전 약상자ID 수정 시작");
		String sql = "UPDATE PRESCRIPTION  SET PILLBOX_ID = " + Util.getSqlString(newpillboxId);
		sql += " WHERE ID = " + Util.getSqlString(Id);
		sql += " AND PILLBOX_ID = " + Util.getSqlString(oldpillboxId);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(sql);
		Log.out.debug("=====> 처방전 약상자ID 수정 끝");		
	}
	
	/*
	 * 수약관리 삭제
	 */
	public void delPrescriptionToPrescriptionIdm(ConnectionResource connResource, String prescriptionId, String hospital) throws Exception {
		Log.out.debug("=====> 수약관리 삭제 시작(Prescription ID)");
		String sql = "DELETE FROM Recv_pill WHERE RecvPill_no =" + Util.getSqlString(prescriptionId);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 처방전 삭제 끝");
	}

	public void delPrescriptionToUserId(ConnectionResource connResource, String userId) throws Exception {
		Log.out.debug("=====> 처방전 삭제 시작(User ID)");
		String sql = "DELETE FROM PRESCRIPTION WHERE MEMBER_ID =" + Util.getSqlString(userId);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 처방전 삭제 끝");
	}

	public int checkPrescriptioin(String prescriptionId, String hospital) throws Exception {
		Log.out.debug("=====> 처방전 중복 확인 시작");
		String sql = "SELECT count(id) FROM PRESCRIPTION where id = " + Util.getSqlString(prescriptionId);
		sql += " and HOSPITAL = " + Util.getSqlString(hospital);
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		int count = -1;
		if (list.size() > 0) {
			count = Integer.parseInt(list.get(0).get(0).toString());
		}
		Log.out.debug("=====> 처방전 중복 확인 끝");
		return count;
	}

	public int checkPrescriptioin(String prescriptionId) throws Exception {
		Log.out.debug("=====> 처방전 중복 확인 시작");
		String sql = "SELECT count(id) FROM PRESCRIPTION where id = " + Util.getSqlString(prescriptionId);
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		int count = -1;
		if (list.size() > 0) {
			count = Integer.parseInt(list.get(0).get(0).toString());
		}
		Log.out.debug("=====> 처방전 중복 확인 끝");
		return count;
	}

	/*******************************************************************************************************************************************************************************************************************************************************************************************************
	 * SQL Data 변환
	 ******************************************************************************************************************************************************************************************************************************************************************************************************/
	public PrescriptionInfo toPrescriptionInfoListResultData(ArrayList<ArrayList<Object>> list) {
		PrescriptionInfo prescriptionInfo = new PrescriptionInfo();;
		if (list.size() > 0) {
			ArrayList<Object> rows = list.get(0);
			int i = 0;
			prescriptionInfo.setId(rows.get(i++).toString());
			prescriptionInfo.setMember_id(rows.get(i++).toString());
			prescriptionInfo.setPillBox_id(rows.get(i++).toString());
			prescriptionInfo.setHospital(rows.get(i++).toString());
			prescriptionInfo.setPharmacy(rows.get(i++).toString());
			prescriptionInfo.setTotalDays(Integer.parseInt(rows.get(i++).toString()));
			prescriptionInfo.setFrequency(Integer.parseInt(rows.get(i++).toString()));
			prescriptionInfo.setDisease(rows.get(i++).toString());
			prescriptionInfo.setDirection(rows.get(i++).toString());
			prescriptionInfo.setStartDate(rows.get(i++).toString());
			prescriptionInfo.setStartTakenOrder(rows.get(i++).toString());
			prescriptionInfo.setEndDate(rows.get(i++).toString());
			prescriptionInfo.setEndTakenOrder(rows.get(i++).toString());
			prescriptionInfo.setTakenOrderProperties(rows.get(i++).toString());
			prescriptionInfo.setDetailSchedule(rows.get(i++).toString());
			prescriptionInfo.setStatus(rows.get(i++).toString());
			prescriptionInfo.setLastUpdatedDateOfSchedule(rows.get(i++).toString());
			prescriptionInfo.setPillBox_type(rows.get(i++).toString());
		}
		return prescriptionInfo;
	}

	public ArrayList<PrescriptionInfo> toPrescriptionInfoListResultData(ArrayList<ArrayList<Object>> list, String searchDate) {
		ArrayList<PrescriptionInfo> prescriptions = new ArrayList<PrescriptionInfo>();;
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				int i = 0;
				PrescriptionInfo prescriptionInfo = new PrescriptionInfo();
				prescriptionInfo.setId(rows.get(i++).toString());
				prescriptionInfo.setStartDate(rows.get(i++).toString());
				prescriptionInfo.setTotalDays(Integer.parseInt(rows.get(i++).toString()));
				prescriptionInfo.setFrequency(Integer.parseInt(rows.get(i++).toString()));
				prescriptionInfo.setDisease(rows.get(i++).toString());
				prescriptionInfo.setStatus(rows.get(i++).toString());
				prescriptionInfo.setName(rows.get(i++).toString());
				prescriptionInfo.setMember_id(rows.get(i++).toString());
				prescriptionInfo.setPillBox_id(rows.get(i++).toString());
				prescriptionInfo.setDetailSchedule(rows.get(i++).toString());
				prescriptionInfo.setHospital(rows.get(i++).toString());
				prescriptionInfo.setPillBox_type(rows.get(i++).toString());
				prescriptionInfo.setAge(rows.get(i++).toString());
				prescriptionInfo.setGender(rows.get(i++).toString());
				ArrayList<ScheduleInfo> takendata = null;
				
				try {
					takendata = ScheduleManager.getInstance().getSchedules(prescriptionInfo.getMember_id(), prescriptionInfo.getId(), searchDate+" 0000", searchDate+" 2359", prescriptionInfo.getHospital(),prescriptionInfo.getPillBox_id());
					
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				if(takendata!=null){
					prescriptionInfo.setScheduleList(takendata);
					
				}
				prescriptions.add(prescriptionInfo);
			}
		}
		return prescriptions;
	}
	public ArrayList<PrescriptionInfo> toPrescriptionInfoListResultDataNew(ArrayList<ArrayList<Object>> list, String searchDate) {
		ArrayList<PrescriptionInfo> prescriptions = new ArrayList<PrescriptionInfo>();;
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				int i = 0;
				PrescriptionInfo prescriptionInfo = new PrescriptionInfo();
				prescriptionInfo.setId(rows.get(i++).toString());
				prescriptionInfo.setStartDate(rows.get(i++).toString());
				prescriptionInfo.setEndDate(rows.get(i++).toString());
				prescriptionInfo.setTotalDays(Integer.parseInt(rows.get(i++).toString()));
				prescriptionInfo.setFrequency(Integer.parseInt(rows.get(i++).toString()));
				prescriptionInfo.setDisease(rows.get(i++).toString());
				prescriptionInfo.setStatus(rows.get(i++).toString());
				prescriptionInfo.setName(rows.get(i++).toString());
				prescriptionInfo.setMember_id(rows.get(i++).toString());
				prescriptionInfo.setPillBox_id(rows.get(i++).toString());
				prescriptionInfo.setDetailSchedule(rows.get(i++).toString());
				prescriptionInfo.setHospital(rows.get(i++).toString());
				prescriptionInfo.setPillBox_type(rows.get(i++).toString());
				//만나이 계산
				String age = rows.get(i++).toString();
				for(int j = age.length(); j < 8; j++){
					if(j%2 == 0){
						age = age+"0";
					}else{
						age = age+"1";
					}
				}
				int byear = Integer.parseInt(age.substring(0, 4));
				int bmonth = Integer.parseInt(age.substring(4, 6));
				int bday = Integer.parseInt(age.substring(6, 8));
				
				Calendar cal = Calendar.getInstance();
				int tYear = cal.get(Calendar.YEAR);
				int tMonth = cal.get(Calendar.MONTH+1);
				int tday = cal.get(Calendar.DAY_OF_MONTH);
				
				int todayAge = 0;
				if(tYear <= byear){
				}else{
					todayAge = tYear - byear;
					if(tMonth>bmonth || (tMonth==bmonth && tday > bday)){
						todayAge =todayAge+1;
					}
				}
				prescriptionInfo.setAge(String.valueOf(todayAge));
				prescriptionInfo.setGender(rows.get(i++).toString());
				//ArrayList<ScheduleInfo> takendata = null;
				
				
				try {
					//takendata = ScheduleManager.getInstance().getSchedules(prescriptionInfo.getMember_id(), prescriptionInfo.getId(), searchDate+" 0000", searchDate+" 2359", prescriptionInfo.getHospital(),prescriptionInfo.getPillBox_id());
					ArrayList<ArrayList<Object>> takendata = ScheduleManager.getInstance().getSchedulesTakenStatus(prescriptionInfo.getMember_id(), prescriptionInfo.getId());
					
					for (ArrayList<Object> arrayList : takendata) {
						int step=0;
						prescriptionInfo.setFinishTakenCnt(arrayList.get(step++).toString());
						prescriptionInfo.setDelayTakenCnt(arrayList.get(step++).toString());
						prescriptionInfo.setUnTakenCnt(arrayList.get(step++).toString());
						prescriptionInfo.setFinishTakenPer(arrayList.get(step++).toString());
						prescriptionInfo.setDelayTakenPer(arrayList.get(step++).toString());
						prescriptionInfo.setUnTakenPer(arrayList.get(step++).toString());
					}
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				
				prescriptions.add(prescriptionInfo);
			}
		}
		return prescriptions;
	}

	public String[] toColumnValue(PrescriptionInfo data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getId()));
		vList.add(Util.getSqlStringAnd(data.getMember_id()));
		vList.add(Util.getSqlStringAnd(data.getPillBox_id()));
		vList.add(Util.getSqlStringAnd(data.getHospital()));
		vList.add(Util.getSqlStringAnd(data.getPharmacy()));
		vList.add(Util.getSqlIntegerAnd(data.getTotalDays()));
		vList.add(Util.getSqlIntegerAnd(data.getFrequency()));
		vList.add(Util.getSqlStringAnd(data.getDisease()));
		vList.add(Util.getSqlStringAnd(data.getDirection()));
		vList.add("DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(data.getStartDate()) + "'%Y-%m-%d'), '%Y%m%d'), ");
		vList.add(Util.getSqlStringAnd(data.getStartTakenOrder()));
		vList.add("DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(data.getEndDate()) + "'%Y-%m-%d'), '%Y%m%d'), ");
		vList.add(Util.getSqlStringAnd(data.getEndTakenOrder()));
		vList.add(Util.getSqlStringAnd(data.getTakenOrderProperties()));
		vList.add(Util.getSqlStringAnd(data.getDetailSchedule()));
		vList.add(Util.getSqlStringAnd(data.getStatus()));
		vList.add("DATE_FORMAT(now(), '%Y%m%d %H%i%s')");
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}

	public String[] toColumnValue(PrescriptionInfo data, String type) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getId()));
		vList.add(Util.getSqlStringAnd(data.getMember_id()));
		vList.add(Util.getSqlStringAnd(data.getPillBox_id()));
		vList.add(Util.getSqlStringAnd(data.getHospital()));
		vList.add(Util.getSqlStringAnd(data.getPharmacy()));
		vList.add(Util.getSqlIntegerAnd(data.getTotalDays()));
		vList.add(Util.getSqlIntegerAnd(data.getFrequency()));
		vList.add(Util.getSqlStringAnd(data.getDisease()));
		vList.add(Util.getSqlStringAnd(data.getDirection()));
		vList.add("DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(data.getStartDate()) + "'%Y-%m-%d'), '%Y%m%d'), ");
		vList.add(Util.getSqlStringAnd(data.getStartTakenOrder()));
		vList.add("DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(data.getEndDate()) + "'%Y-%m-%d'), '%Y%m%d'), ");
		vList.add(Util.getSqlStringAnd(data.getEndTakenOrder()));
		vList.add(Util.getSqlStringAnd(data.getTakenOrderProperties()));
		vList.add(Util.getSqlStringAnd(data.getDetailSchedule()));
		vList.add(Util.getSqlString(data.getStatus()));
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
}
