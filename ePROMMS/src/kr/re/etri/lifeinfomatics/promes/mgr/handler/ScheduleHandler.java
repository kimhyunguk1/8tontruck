package kr.re.etri.lifeinfomatics.promes.mgr.handler;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;

import kr.re.etri.lifeinfomatics.promes.data.ChartData;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.LoadCellInfo;
import kr.re.etri.lifeinfomatics.promes.data.MedicationState;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.data.TakenOrderProperty;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.ImageSrcManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class ScheduleHandler {
	public ScheduleHandler() {
		super();
	}

	/**
	 * 세부 스케줄 조회
	 * 
	 * @param userId
	 * @param prescriptionId
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	public ArrayList<ScheduleInfo> getSchedules(String userId, String prescriptionId, String startDate, String endDate, String hospital) throws Exception {
		Log.out.debug("=====> 세부 스케줄 조회 시작");
		String sql = "";
		sql += "SELECT a.ID, a.PRESCRIPTION_ID, a.PRESCRIPTION_HOSPITAL, a.ALARMSTART, a.ALARMEND, a.TAKENORDER, a.CONTAINERNO, a.TAKENSTATUS, a.TAKENTIME, b.MEMO_CONTENT, b.CATEGORY, b.ERROR_CONTENT,b.TAKENCHECK ";
		sql += "FROM SCHEDULES_" + userId + " a LEFT JOIN MEMO b ON a.PRESCRIPTION_ID = b.PRESCRIPTION_ID AND a.ID = b.ID AND b.USER_ID = '" + userId + "'";
		sql += " WHERE a.PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
		sql += " AND a.PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		sql += " AND a.ALARMSTART >= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(startDate) + "'%Y%m%d%H%i'), '%Y%m%d %H%i') ";
		sql += " AND a.ALARMSTART <= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(endDate) + "'%Y%m%d%H%i'), '%Y%m%d %H%i') ";
		sql += "ORDER BY a.ID ASC";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		ArrayList<ScheduleInfo> schedules = this.toScheduleInfoListResultData(list);
		Log.out.debug("=====> 세부 스케줄 끝 시작");
		return schedules;
	}
	public ArrayList<ScheduleInfo> getSchedules(String userId, String prescriptionId, String startDate, String endDate, String hospital, String pillboxId) throws Exception {
		Log.out.debug("=====> 세부 스케줄 조회 시작");
		String sql = "";
		sql += "SELECT a.ID, a.PRESCRIPTION_ID, a.PRESCRIPTION_HOSPITAL, a.ALARMSTART, a.ALARMEND, a.TAKENORDER, a.CONTAINERNO, a.TAKENSTATUS, a.TAKENTIME, b.MEMO_CONTENT, b.CATEGORY, b.ERROR_CONTENT,b.TAKENCHECK ";
		sql += "FROM SCHEDULES_" + userId + " a LEFT JOIN MEMO b ON a.PRESCRIPTION_ID = b.PRESCRIPTION_ID AND a.ID = b.ID AND b.USER_ID = '" + userId + "'";
		sql += " WHERE a.PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
		sql += " AND a.PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		sql += " AND a.ALARMSTART >= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(startDate) + "'%Y%m%d%H%i'), '%Y%m%d %H%i') ";
		sql += " AND a.ALARMSTART <= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(endDate) + "'%Y%m%d%H%i'), '%Y%m%d %H%i') ";
		sql += "ORDER BY a.ID ASC";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		ArrayList<ScheduleInfo> schedules = this.toScheduleInfoListResultData(list,pillboxId);
		Log.out.debug("=====> 세부 스케줄 끝 시작");
		return schedules;
	}
	public ArrayList<ArrayList<Object>> getSchedulesTakenStatus(String userId, String prescriptionId) throws Exception {
		Log.out.debug("=====> 복용 퍼센트 구하기 시작");
		String sql = "";
		sql += "SELECT b.finishtaken , c.delaytaken , d.untaken, ";
		sql += " TRUNCATE(( b.finishtaken / a.totalcnt * 100 ), 0) finish,";
		sql += " TRUNCATE(( c.delaytaken / a.totalcnt * 100 ), 0) delay, ";
		sql += " TRUNCATE(( d.untaken / a.totalcnt * 100 ), 0) untaken ";
		sql += "FROM ";
		sql += " ( ";
		sql += " select count(*) totalcnt ";
		sql += " from SCHEDULES_" + userId;
		sql += " where prescription_id = " + Util.getSqlString(prescriptionId);
		sql += " ) a, ";
		sql += " ( ";
		sql += " select count(b.TAKENSTATUS) finishtaken ";
		sql += " from SCHEDULES_" + userId + " a left JOIN ";
		sql += " ( ";
		sql += " select * ";
		sql += " from SCHEDULES_" + userId;
		sql += " where prescription_id = " + Util.getSqlString(prescriptionId) + " and TAKENSTATUS = 'FINISHTAKEN' ";
		sql += " ) b on a.ID=b.ID ";
		sql += ") b, ";
		sql += " ( ";
		sql += " select count(b.TAKENSTATUS) delaytaken ";
		sql += " from SCHEDULES_" + userId + " a left JOIN ";
		sql += " ( ";
		sql += " select * ";
		sql += " from SCHEDULES_" + userId;
		sql += " where prescription_id = " + Util.getSqlString(prescriptionId) + " and TAKENSTATUS = 'DELAYTAKEN' ";
		sql += " ) b on a.ID=b.ID ";
		sql += ") c, ";
		sql += " ( ";
		sql += " select count(b.TAKENSTATUS) untaken ";
		sql += " from SCHEDULES_" + userId + " a left JOIN ";
		sql += " ( ";
		sql += " select * ";
		sql += " from SCHEDULES_" + userId;
		sql += " where prescription_id = " + Util.getSqlString(prescriptionId) + " and TAKENSTATUS = 'UNTAKEN' ";
		sql += " ) b on a.ID=b.ID ";
		sql += ") d";
		
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		Log.out.debug("=====> 복용 퍼센트 구하기 끝");
		return list;
	}

	/**
	 * Web Chart 정보 조회
	 * 
	 * @param userId
	 * @param prescriptionId
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	public Hashtable<String, ChartData> getChartData(String userId, String prescriptionId, String hospital, String startDate, String endDate) throws Exception {
		Log.out.debug("=====> 통계 정보 수집 시작");
		String sql = "SELECT  TAKENORDER, TAKENSTATUS, COUNT(TAKENSTATUS) FROM SCHEDULES_" + userId;
		sql += " WHERE PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
		sql += " AND PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		if (startDate != null && !startDate.equals("")) {
			sql += " AND ALARMSTART >= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(startDate) + "'%Y%m%d %H%i'), '%Y%m%d %H%i') ";
		}
		if (endDate != null && !endDate.equals("")) {
			sql += " AND ALARMSTART <= DATE_FORMAT(STR_TO_DATE(" + Util.getSqlStringAnd(endDate) + "'%Y%m%d%H%i'), '%Y%m%d %H%i') ";
		}
		sql += " GROUP BY TAKENORDER, TAKENSTATUS ORDER BY TAKENORDER ASC";
		Log.out.debug(sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		Hashtable<String, ChartData> chartHash = this.toChartDataResultData(list);
		Log.out.debug("=====> 통계 정소 수집 끝");
		return chartHash;
	}

	/**
	 * 세부 스케줄을 등록한다.
	 * 
	 * @param connResource
	 * @param userId
	 * @param schedules
	 * @throws Exception
	 */
	public void addSchedule(ConnectionResource connResource, String userId, ArrayList<ScheduleInfo> schedules) throws Exception {
		Log.out.debug("=====> 세부 스케줄 등록 시작");
		for (int i = 0; i < schedules.size(); i += 10) 
		{
			String sql = "";
			sql += "INSERT INTO SCHEDULES_" + userId + "(ID, PRESCRIPTION_ID, PRESCRIPTION_HOSPITAL, ALARMSTART, ALARMEND, TAKENORDER, CONTAINERNO, TAKENSTATUS, TAKENTIME) VALUES";
			for (int j = 0; j < 10; j++) 
			{
				if (i + j < schedules.size()) 
				{
					String[] cols = this.toColumnValue(schedules.get(i + j));
					sql += " (";
					for (int k = 0; k < cols.length; k++) {
						sql += cols[k];
					}
					sql += "),";
				}
			}
			sql = sql.substring(0, sql.length() - 1);
			//sql += " SELECT * FROM DUAL";
			Log.out.debug(sql);
			DBManager.getInstance().updateQuery(connResource, sql);
		}
		Log.out.debug("=====> 세부 스케줄 등록 끝");
	}
	
	public void addLoadcellScheduleinfo(ConnectionResource connResource, ArrayList<LoadCellInfo> schedules) throws Exception {
		Log.out.debug("=====> 세부 Scheduleinfo 등록 시작");
		for (int i = 0; i < schedules.size(); i += 10) {
			String sql = "";
			sql += "INSERT INTO SCHEDULEINFO(ID, SCHEDULES_ID,PRESCRIPTION_ID,MEDICBOX_ID) VALUES";
			for (int j = 0; j < 10; j++) {
				if (i + j < schedules.size()) {
					String[] cols = this.toColumnValue(schedules.get(i + j));
					sql += " (";
					for (int k = 0; k < cols.length; k++) {
						sql += cols[k];
					}
					sql += "),";
				}
			}
			sql = sql.substring(0, sql.length() - 1);
			//sql += " SELECT * FROM DUAL";
			Log.out.debug(sql);
			DBManager.getInstance().updateQuery(connResource, sql);
		}
		Log.out.debug("=====> 세부 Scheduleinfo 등록 끝");
	}
	
	public void addSchedulem(ConnectionResource connResource, String userId, ArrayList<MedicationState> medicationstate) throws Exception {
		// TODO : 복약상황 스케쥴 등록
		Log.out.debug("=====> 새로운 복약상황 세부 스케줄 등록 시작-");
		for (int i = 0; i < medicationstate.size(); i += 10) {
			String sql = "";
			sql += "INSERT INTO medication_state (MedicState_no, Patient_no, Management_no, RecvPill_no, AlarmStart, AlarmEnd, State, MedicationTime) VALUES";
			for (int j = 0; j < 10; j++) {
				if (i + j < medicationstate.size()) {
					String[] cols = this.toColumnValue(medicationstate.get(i + j));
					MedicationState med = medicationstate.get(i + j);
					sql += " (";
					sql += " '" + med.getMedicState_no() + "', '" + med.getPatient_no() + "', '" + med.getManagement_no() + "', '" + med.getRecvpill_no() + "', ";
					sql += "STR_TO_DATE('" + med.getAlarmstart()  + "', '%Y-%m-%d %H:%i'), " + "STR_TO_DATE('" +med.getAlarmend() + "', '%Y-%m-%d %H:%i'), '" + med.getState() + "', " + med.getMedicationtime();
					sql += "),";
				}
			}
			sql = sql.substring(0, sql.length() - 1);
			//sql += " SELECT * FROM DUAL";
			Log.out.debug(sql);
			DBManager.getInstance().updateQuery(connResource, sql);
		}
		Log.out.debug("=====> 세부 스케줄 등록 끝");
	}

	/**
	 * 하나의 세부 스케줄를 수정한다.
	 * 
	 * @param connResource
	 * @throws Exception
	 */
	public void updateSchedule(ConnectionResource connResource, String userId, String hospital, String scheduleId, String alarmStart, String alarmEnd) throws Exception {
		Log.out.debug("=====> 세부 스케줄 변경 시작");
		String sql = "UPDATE SCHEDULES_" + userId + " SET";
		sql += " ALARMSTART = " + Util.getSqlStringAnd(alarmStart);
		sql += " ALARMEND = " + Util.getSqlString(alarmEnd);
		sql += " WHERE ID = " + Util.getSqlString(scheduleId);
		sql += " AND PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 세부 스케줄 변경 끝");
	}
	/**
	 * TakenStatus를 수정한다.
	 * 
	 * @param connResource
	 * @throws Exception
	 */
	public void updateTakenStatus(ConnectionResource connResource, String userId, String hospital, String scheduleId, String prescriptionId) throws Exception {
		Log.out.debug("=====> TakenStatus 변경 시작");
		String sql = "UPDATE SCHEDULES_" + userId + " SET";
		sql += " TAKENSTATUS = 'FINISHTAKEN'";		
		sql += " WHERE ID = " + Util.getSqlString(scheduleId);
		sql += " AND PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		sql += " AND PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);		
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> TakenStatus 변경 끝");
	}
	/**
	 * TakenStatus를 수정한다.
	 * 
	 * @param connResource
	 * @throws Exception
	 */
	public void updateTakenStatus(ConnectionResource connResource, String userId, String hospital, String scheduleId, String prescriptionId, String takenStatus) throws Exception {
		Log.out.debug("=====> TakenStatus 변경 시작");
		String sql = "UPDATE SCHEDULES_" + userId + " SET";
		sql += " TAKENSTATUS = " + Util.getSqlString(takenStatus);	
		sql += " WHERE ID = " + Util.getSqlString(scheduleId);
		sql += " AND PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		sql += " AND PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);		
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> TakenStatus 변경 끝");
	}
	/**
	 * 현시간 이후의 세부 스케줄 정보를 업데이트 한다.
	 * 
	 * @param connResource
	 * @param userId
	 * @param takenOrderProperty
	 */
	public void updateSchedules(ConnectionResource connResource, String userId, String prescriptionId, String Hospital, ArrayList<TakenOrderProperty> takenOrderPropertyList) throws Exception {
		Log.out.debug("=====> 세부 스케줄 변경 시작");
		for (int i = 0; i < takenOrderPropertyList.size(); i++) {
			TakenOrderProperty takenOrderProperty = takenOrderPropertyList.get(i);
			String sql = "UPDATE SCHEDULES_" + userId + " SET";
			sql += " ALARMSTART = concat(DATE_FORMAT(STR_TO_DATE(ALARMSTART, '%Y%m%d %H%i'), '%Y%m%d '), " + Util.getSqlString(takenOrderProperty.getStartTime()) + "), ";
			sql += " ALARMEND = concat(DATE_FORMAT(STR_TO_DATE(ALARMSTART, '%Y%m%d %H%i'), '%Y%m%d '), " + Util.getSqlString(takenOrderProperty.getEndTime()) + "), ";
			sql += " CONTAINERNO = " + Util.getSqlString(String.valueOf(takenOrderProperty.getContainer()));
			sql += " WHERE PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
			sql += " AND PRESCRIPTION_HOSPITAL = " + Util.getSqlString(Hospital);
			sql += " AND ALARMEND > DATE_FORMAT(now(), '%Y%m%d %H%i')";
			sql += " and TAKENORDER = " + Util.getSqlString(String.valueOf(takenOrderProperty.getNo()));
			Log.out.debug(sql);
			DBManager.getInstance().updateQuery(connResource, sql);
		}
		Log.out.debug("=====> 세부 스케줄 변경 끝");
	}
	

	/**
	 * 세부 스케줄 삭제한다.
	 * 
	 * @param connResource
	 * @param prescriptionId
	 * @param userId
	 * @param sysTime
	 * @throws Exception
	 */
	public void deleteSchedules(ConnectionResource connResource, String prescriptionId, String userId, String hospital, boolean sysTime) throws Exception {
		Log.out.debug("=====> 세부 스케줄 삭제 시작");
		String sql = "";
		sql += "DELETE FROM SCHEDULES_" + userId;
		if (prescriptionId != null && !prescriptionId.equals("")) {
			sql += " WHERE PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
		}
		if (hospital != null && !hospital.equals("")) {
			sql += " AND PRESCRIPTION_HOSPITAL = " + Util.getSqlString(hospital);
		}
		if (sysTime) {
			sql += " AND ALARMEND > DATE_FORMAT(now(), '%Y%m%d %H%i')";
			sql += " AND TAKENSTATUS NOT IN (" + Util.getSqlStringAnd(Define.TAKEN_SATUS_PRETAKEN);
			sql += Util.getSqlStringAnd(Define.TAKEN_SATUS_FINISHTAKEN) + Util.getSqlString(Define.TAKEN_SATUS_FINISHUNTAKEN) + ")";
		}
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 세부 스케줄 삭제 끝");
	}
	
	/**
	 * 로드셀 스케줄 삭제한다.
	 * 
	 * @param connResource
	 * @param prescriptionId
	 * @param userId
	 * @param sysTime
	 * @throws Exception
	 */
	public void deleteLodecellSchedules(ConnectionResource connResource, String prescriptionId, String userId, String hospital, boolean sysTime) throws Exception {
		Log.out.debug("=====> 로드셀 스케줄 삭제 시작");
		String sql = "";
		sql += "DELETE FROM SCHEDULEINFO";
		if (prescriptionId != null && !prescriptionId.equals("")) {
			sql += " WHERE PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);			
		}
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 로드셀 스케줄 삭제 끝");
	}
	/*
	 * 복약상황 삭제
	 */
	public void deleteSchedulesm(ConnectionResource connResource, String prescriptionId, String userId, boolean sysTime) throws Exception {
		Log.out.debug("=====> 세부 복약상황 삭제 시작");
 		String sql = "";
		sql += "DELETE FROM medication_state";
		if (prescriptionId != null && !prescriptionId.equals("")) {
			sql += " WHERE RecvPill_no = " + Util.getSqlString(prescriptionId);
			// TODO : 다른 조건도 필요함.
		}
		if (sysTime) {
			sql += " AND ALARMEND > now()";
			sql += " AND state NOT IN (" + Util.getSqlStringAnd(Define.TAKEN_SATUS_PRETAKEN);
			sql += Util.getSqlStringAnd(Define.TAKEN_SATUS_FINISHTAKEN) + Util.getSqlString(Define.TAKEN_SATUS_FINISHUNTAKEN) + ")";
		}
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 세부 복약상황 삭제 끝");
	}

	/**
	 * 사용자 세부 스케줄 정보를 모두 삭제
	 * 
	 * @param connResource
	 * @param userId
	 * @param sysTime
	 * @throws Exception
	 */
	public void deleteSchedules(ConnectionResource connResource, String userId) throws Exception {
		this.deleteSchedules(connResource, null, userId, null, false);
		this.deleteSchedulesm(connResource, userId, null, false);
	}

	public void makeUserTable(ConnectionResource connResource, String userId) throws Exception {
		Log.out.debug("=====> 사용자 세부 스케줄 Table 생성 시작");
		String sql = "";
		sql += "CREATE TABLE SCHEDULES_" + userId + " (";
		sql += "ID VARCHAR(20) NOT NULL,";
		sql += " PRESCRIPTION_ID VARCHAR(20) NOT NULL,";
		sql += " PRESCRIPTION_HOSPITAL VARCHAR(20) NOT NULL,";
		sql += " ALARMSTART VARCHAR(15) NULL,";
		sql += " ALARMEND VARCHAR(15)  NULL,";
		sql += " TAKENORDER CHAR(1)  NULL,";
		sql += " CONTAINERNO CHAR(1) NULL,";
		sql += " TAKENSTATUS VARCHAR(15) NOT NULL,";
		sql += " TAKENTIME VARCHAR(15) NULL,";
		sql += " PRIMARY KEY(ID, PRESCRIPTION_Id, PRESCRIPTION_HOSPITAL),";
		sql += " FOREIGN KEY (PRESCRIPTION_ID, PRESCRIPTION_HOSPITAL) REFERENCES PRESCRIPTION(ID, HOSPITAL),";
		sql += " CONSTRAINT SCHEDULES_" + userId + " CHECK( TAKENSTATUS IN  ('NONE', 'PRETAKEN', 'FINISHTAKEN', 'UNTAKEN', 'PREUNTAKEN', 'FINISHUNTAKEN', 'PREOUTTAKEN', 'FINISHOUTTAKEN', 'SMSOUTTAKEN', 'NOPOSSESSION', 'SIDEEFFECT', 'TIMEOUT', 'NOCONDITION', 'ETC')))";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 사용자 세부 스케줄 Table 생성 끝");
	}

	public void dropUserTable(String userId) throws Exception {
		Log.out.debug("=====> 사용자 세부 스케줄 Table 삭제 시작");
		String sql = "";
		sql += "DROP TABLE SCHEDULES_" + userId;
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(sql);
		Log.out.debug("=====> 사용자 세부 스케줄 Table 삭제 끝");
	}

	/**
	 * 세부 스케줄 변경 위치를 찾는다.
	 * 
	 * @param connResource
	 * @param prescriptionId
	 * @param userId
	 * @return
	 * @throws Exception
	 */
//	public String getStartPoint(ConnectionResource connResource, String prescriptionId, String userId) throws Exception {
	public String getStartPoint(String prescriptionId, String userId) throws Exception {
		Log.out.debug("=====> 세부 스케줄 시작 위치 조회 시작");
		String sql = "SELECT ID FROM SCHEDULES_" + userId + " WHERE ALARMEND > DATE_FORMAT(now(), '%Y%m%d %H%i') ";
		sql += "AND PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
		Log.out.debug(sql);
//		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(connResource, sql);
		ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
		String startId = "";
		if (list.size() > 0) {
			startId = (String) list.get(0).get(0);
		}
		Log.out.debug("=====> 세부 스케줄 시작 위치 조회 끝");
		return startId;
	}

	/*******************************************************************************************************************************************************************************************************************************************************************************************************
	 * SQL Data 변환
	 ******************************************************************************************************************************************************************************************************************************************************************************************************/
	public ArrayList<ScheduleInfo> toScheduleInfoListResultData(ArrayList<ArrayList<Object>> list) {
		ArrayList<ScheduleInfo> scheduleInfoList = new ArrayList<ScheduleInfo>();
		for (ArrayList<Object> rows : list) {
			int i = 0;
			ScheduleInfo scheduleInfo = new ScheduleInfo();
			scheduleInfo.setId(rows.get(i++).toString());
			scheduleInfo.setPrescription_id(rows.get(i++).toString());
			scheduleInfo.setHospital(rows.get(i++).toString());
			scheduleInfo.setAlarmStart(rows.get(i++).toString());
			scheduleInfo.setAlarmEnd(rows.get(i++).toString());
			scheduleInfo.setTakenorder(rows.get(i++).toString());
			scheduleInfo.setContainerno(rows.get(i++).toString());
			
			String status = rows.get(i++).toString();

			if (Define.checkTakenSatus(status)) {
				scheduleInfo.setTakenStatus(status);
			}
			else {
				scheduleInfo.setTakenStatus(Define.TAKEN_SATUS_UNTAKEN);
			}

			scheduleInfo.setTakenTime(rows.get(i++).toString());
			scheduleInfo.setMemoContent(rows.get(i++).toString());
			scheduleInfo.setCategory(rows.get(i++).toString());
			scheduleInfo.setErrorContent(rows.get(i++).toString());
			scheduleInfo.setTakencheck(rows.get(i++).toString());
			
			scheduleInfoList.add(scheduleInfo);
		}
		return scheduleInfoList;
	}
	public ArrayList<ScheduleInfo> toScheduleInfoListResultData(ArrayList<ArrayList<Object>> list,String pillboxId) {
		ArrayList<ScheduleInfo> scheduleInfoList = new ArrayList<ScheduleInfo>();
		for (ArrayList<Object> rows : list) {
			int i = 0;
			ScheduleInfo scheduleInfo = new ScheduleInfo();
			scheduleInfo.setId(rows.get(i++).toString());
			scheduleInfo.setPrescription_id(rows.get(i++).toString());
			scheduleInfo.setHospital(rows.get(i++).toString());
			scheduleInfo.setAlarmStart(rows.get(i++).toString());
			scheduleInfo.setAlarmEnd(rows.get(i++).toString());
			scheduleInfo.setTakenorder(rows.get(i++).toString());
			scheduleInfo.setContainerno(rows.get(i++).toString());
			
			String status = rows.get(i++).toString();

			if (Define.checkTakenSatus(status)) {
				scheduleInfo.setTakenStatus(status);
			}
			else {
				scheduleInfo.setTakenStatus(Define.TAKEN_SATUS_UNTAKEN);
			}

			scheduleInfo.setTakenTime(rows.get(i++).toString());
			scheduleInfo.setMemoContent(rows.get(i++).toString());
			scheduleInfo.setCategory(rows.get(i++).toString());
			scheduleInfo.setErrorContent(rows.get(i++).toString());
			scheduleInfo.setTakencheck(rows.get(i++).toString());
			String imgSrc = ImageSrcManager.getInstance().ReturnImgsrc(pillboxId, scheduleInfo.getAlarmStart().substring(0,8));
			scheduleInfo.setGifImage(imgSrc);
			scheduleInfo.setPillboxId(pillboxId);
			scheduleInfoList.add(scheduleInfo);
		}
		return scheduleInfoList;
	}

	public Hashtable<String, ChartData> toChartDataResultData(ArrayList<ArrayList<Object>> list) {
		Hashtable<String, ChartData> chartHash = new Hashtable<String, ChartData>();
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				int i = 0;
				String takenOrder = rows.get(i++).toString();
				String takenStatus = rows.get(i++).toString();
				int takenStatusCount = Integer.parseInt(rows.get(i++).toString());
				if (!chartHash.containsKey(takenOrder)) {
					ChartData chartData = new ChartData(takenOrder);
					chartHash.put(takenOrder, chartData);
				}

				ChartData chartData = chartHash.get(takenOrder);
				chartData.setStatusCount(takenStatus, takenStatusCount);
				chartHash.put(takenOrder, chartData);
			}
		}
		return chartHash;
	}

	public String[] toColumnValue(ScheduleInfo data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getId()));
		vList.add(Util.getSqlStringAnd(data.getPrescription_id()));
		vList.add(Util.getSqlStringAnd(data.getHospital()));
		vList.add(Util.getSqlStringAnd(data.getAlarmStart()));
		vList.add(Util.getSqlStringAnd(data.getAlarmEnd()));
		vList.add(Util.getSqlStringAnd(data.getTakenorder()));
		vList.add(Util.getSqlStringAnd(data.getContainerno()));
		vList.add(Util.getSqlStringAnd(data.getTakenStatus()));
		vList.add(Util.getSqlString(data.getTakenTime()));
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
	public String[] toColumnValue(LoadCellInfo data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getUserId()));
		vList.add(Util.getSqlStringAnd(data.getSchedule_Id()));
		vList.add(Util.getSqlStringAnd(data.getPriscription_Id()));
		vList.add(Util.getSqlString(data.getMedicbox_Id()));		
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
	
	public String[] toColumnValue(MedicationState data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getMedicState_no()));
		vList.add(Util.getSqlStringAnd(data.getPatient_no()));
		vList.add(Util.getSqlStringAnd(data.getManagement_no()));
		vList.add(Util.getSqlStringAnd(data.getRecvpill_no()));
		// TODO : 날짜에 맞게 수정
		// vList.add(Util.getSqlStringAnd(data.getAlarmstart()));
		// vList.add(Util.getSqlStringAnd(data.getAlarmend()));
		vList.add(Util.getSqlStringAnd(data.getState()));
		// vList.add(Util.getSqlStringAnd(data.getMedicationtime()));
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
}
