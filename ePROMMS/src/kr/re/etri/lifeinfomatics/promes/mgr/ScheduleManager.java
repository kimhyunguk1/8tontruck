package kr.re.etri.lifeinfomatics.promes.mgr;

import java.math.BigInteger;
import java.sql.Date;
import java.sql.Savepoint;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Hashtable;

import kr.re.etri.lifeinfomatics.promes.data.ChartData;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.LoadCellInfo;
import kr.re.etri.lifeinfomatics.promes.data.MedicationState;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.data.TakenOrderProperty;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.handler.ScheduleHandler;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class ScheduleManager {
	private static ScheduleManager instance = null;
	private ScheduleHandler scheduleHandler = new ScheduleHandler();

	/**
	 * 세부 스케줄을 조회한다.
	 * 
	 * @param userId
	 * @param prescriptionId
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	public ArrayList<ScheduleInfo> getSchedules(String userId, String prescriptionId, String startDate, String endDate, String hospital) throws Exception {
		return scheduleHandler.getSchedules(userId, prescriptionId, startDate, endDate, hospital);
	}
	public ArrayList<ScheduleInfo> getSchedules(String userId, String prescriptionId, String startDate, String endDate, String hospital,String pillboxId) throws Exception {
		return scheduleHandler.getSchedules(userId, prescriptionId, startDate, endDate, hospital,pillboxId);
	}
	public ArrayList<ArrayList<Object>> getSchedulesTakenStatus(String userId, String prescriptionId) throws Exception {
		return scheduleHandler.getSchedulesTakenStatus(userId, prescriptionId);
	}

	/**
	 * 세부 스케줄을 등록한다.
	 * 
	 * @param connResource
	 * @param prescriptionInfo
	 * @throws Exception
	 */
	public void addSchedule(ConnectionResource connResource, PrescriptionInfo prescriptionInfo) throws Exception {
		String userId = prescriptionInfo.getMember_id();
		String prescription_id = prescriptionInfo.getId();
		String startDate = prescriptionInfo.getStartDate();
		int startOrder = Integer.parseInt(prescriptionInfo.getStartTakenOrder());
		int endOrder = Integer.parseInt(prescriptionInfo.getEndTakenOrder());
		int totalDays = prescriptionInfo.getTotalDays();
		int frequency = prescriptionInfo.getFrequency();
		String takenOrderProperties = prescriptionInfo.getTakenOrderProperties();
		String hospital = prescriptionInfo.getHospital();
		String pharmacy = prescriptionInfo.getPharmacy();

		ArrayList<ScheduleInfo> schedules = this.makeSchedule(prescription_id, startDate, startOrder, endOrder, totalDays, frequency, takenOrderProperties, null, hospital);
		scheduleHandler.addSchedule(connResource, userId, schedules);
		
		if(prescriptionInfo.getPillBox_type().equals("la cellule de charge")){
			ArrayList<LoadCellInfo> loadcellschedule = this.makeLoadcellSchedule(prescription_id, startDate, startOrder, endOrder, totalDays, frequency, takenOrderProperties, null, hospital,userId,prescriptionInfo.getPillBox_id());
			scheduleHandler.addLoadcellScheduleinfo(connResource, loadcellschedule);
		}

		// TODO : 새로운 스케쥴 테이블 등록
		ArrayList<MedicationState> medicationstate = this.makeMedicationState(userId, prescription_id, startDate, startOrder, endOrder, totalDays, frequency, takenOrderProperties, null, hospital, pharmacy);
		scheduleHandler.addSchedulem(connResource, userId, medicationstate);
	}

	/**
	 * 세부 스케줄을 등록한다.
	 * 
	 * @param prescriptionInfo
	 * @throws Exception
	 */
	public void addSchedule(PrescriptionInfo prescriptionInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		try{    		
    		this.addSchedule(connResource, prescriptionInfo);
		}catch(Exception e){
			
		}finally {
			
			connResource.release();
			connResource = null;
		}
	}

	public Hashtable<String, ChartData> getChartData(String userId, String prescriptionId, String hospital, String startDate, String endDate) throws Exception {
		return scheduleHandler.getChartData(userId, prescriptionId, hospital, startDate, endDate);
	}

	/**
	 * 세부 스케줄을 수정한다.
	 * 
	 * @param connResource
	 * @param prescriptionInfo
	 * @throws Exception
	 */
	public void updateSchedules(ConnectionResource connResource, PrescriptionInfo prescriptionInfo) throws Exception {
		String userId = prescriptionInfo.getMember_id();
		String takenOrderProperties = prescriptionInfo.getTakenOrderProperties();
		takenOrderProperties = takenOrderProperties.replace("[", "");
		ArrayList<String> takenOrderPropertysArr = Util.split("]", takenOrderProperties);
		ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(takenOrderPropertysArr);
		scheduleHandler.updateSchedules(connResource, userId, prescriptionInfo.getId(), prescriptionInfo.getHospital(), takenOrderPropertyList);
	}

	/**
	 * 하루 세부 스케줄을 수정한다.
	 * 
	 * @param schedules
	 * @throws Exception
	 */
	public void updatSchedules(String userId, String prescriptionId, String hospital, String[] schedules) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		Savepoint point = connResource.setSavepoint();
		try {
			for (int i = 0; i < schedules.length; i++) {
				String tmp = schedules[i];
				if (tmp != null && !tmp.equals("")) {
					String[] tmpArr = tmp.split("/");
					if (tmpArr.length == 3) {
						scheduleHandler.updateSchedule(connResource, userId, hospital, tmpArr[0], tmpArr[1], tmpArr[2]);
					}
				}
			}
			PrescriptionManager.getInstance().updateDetailPrescription(connResource, Define.ISDETAILSCHEDULE_TRUE, prescriptionId, hospital);
			connResource.commit();
		} catch (Exception ex) {
			connResource.rollback(point);
			throw new Exception(ex);
		}finally {				
			connResource.release();
			connResource = null;
		}
	}
	/**
	 * Takenstatus을 수정한다.
	 * 
	 * @param schedules
	 * @throws Exception
	 */
	public void updatTakenstatus(String userId, String hospital, String scheduleId, String prescriptionId) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		Savepoint point = connResource.setSavepoint();
		try {			
			scheduleHandler.updateTakenStatus(connResource, userId, hospital, scheduleId, prescriptionId);		
			connResource.commit();
		} catch (Exception ex) {
			connResource.rollback(point);
			throw new Exception(ex);
		}finally {				
			connResource.release();
			connResource = null;
		}
	}

	/**
	 * 사용자 ID를 기반을 세부 스케줄 전부 삭제
	 * 
	 * @param connResource
	 * @param userId
	 * @throws Exception
	 */
	public void deleteSchedules(ConnectionResource connResource, String userId) throws Exception {
		scheduleHandler.deleteSchedules(connResource, userId);
	}

	/**
	 * 처방번호에 따른 세부 스케줄 삭제
	 * 
	 * @param connResource
	 * @param prescriptionId
	 * @param userId
	 * @throws Exception
	 */
	public void deleteSchedules(ConnectionResource connResource, String prescriptionId, String userId, String hospital, boolean today) throws Exception {
		scheduleHandler.deleteSchedules(connResource, prescriptionId, userId, hospital, today);
		scheduleHandler.deleteSchedulesm(connResource, prescriptionId, userId, today);
		scheduleHandler.deleteLodecellSchedules(connResource, prescriptionId, userId, hospital, today);
	}

	// public String getStartPoint(ConnectionResource connResource, String prescriptionId, String userId) throws Exception {
	// return scheduleHandler.getStartPoint(connResource, prescriptionId, userId);
	// }

	public void makeUserTable(ConnectionResource connResource, String userId) throws Exception {
		scheduleHandler.makeUserTable(connResource, userId);
	}

	public void dropUserTable(String userId) throws Exception {
		scheduleHandler.dropUserTable(userId);
	}

	public ArrayList<ScheduleInfo> makeSchedule(String prescription_id, String startDate, int startOrder, int endOrder, int totalDays, int frequency, String takenOrderProperties, String startId, String hospital) throws Exception {
		ArrayList<ScheduleInfo> schedules = new ArrayList<ScheduleInfo>();
		takenOrderProperties = takenOrderProperties.replace("[", "");
		ArrayList<String> takenOrderPropertysArr = Util.split("]", takenOrderProperties);

		ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(takenOrderPropertysArr);
		int idx = 0;
		boolean tmpBool = true;
		if (startId != null) {
			tmpBool = false;
		}
		Calendar cal2 = Util.getCalendar(startDate, "-");;
		for (int i = 0; i < (totalDays * frequency); i++) {
			
			String id = "00" + i;
			id = id.substring(id.length() - 3);
			idx = startOrder + i - 1;
			if(i!=0)
				cal2.add(Calendar.DATE, 1);
			
			if(cal2.get(Calendar.DAY_OF_WEEK)==1){ //1=일요일 
				cal2.add(Calendar.DATE, 1);
			}
			
			TakenOrderProperty takenOrderProperty = takenOrderPropertyList.get(idx % frequency);
			cal2.set(Calendar.HOUR_OF_DAY, Integer.parseInt(takenOrderProperty.getStartTimeArr()[0]));
			cal2.set(Calendar.MINUTE, Integer.parseInt(takenOrderProperty.getStartTimeArr()[1]));
			SimpleDateFormat form1 = new SimpleDateFormat("yyyyMMdd HHmm");
			String alarmStart = form1.format(cal2.getTime());
			cal2.set(Calendar.HOUR_OF_DAY, Integer.parseInt(takenOrderProperty.getEndTimeArr()[0]));
			cal2.set(Calendar.MINUTE, Integer.parseInt(takenOrderProperty.getEndTimeArr()[1]));
			String alarmEnd = form1.format(cal2.getTime());
			ScheduleInfo scheduleInfo = new ScheduleInfo();
			scheduleInfo.setId(id);
			scheduleInfo.setPrescription_id(prescription_id);
			scheduleInfo.setAlarmStart(alarmStart);
			scheduleInfo.setAlarmEnd(alarmEnd);
			scheduleInfo.setTakenorder("" + takenOrderProperty.getNo());
			scheduleInfo.setContainerno("" + takenOrderProperty.getContainer());
			scheduleInfo.setTakenStatus(Define.TAKEN_SATUS_NONE);
			scheduleInfo.setHospital(hospital);
			if (!tmpBool) {
				if (scheduleInfo.getId().equals(startId)) {
					tmpBool = true;
				}
			}
			if (tmpBool) {
				schedules.add(scheduleInfo);
			}
		}
		return schedules;
	}
	public ArrayList<LoadCellInfo> makeLoadcellSchedule(String prescription_id, String startDate, int startOrder, int endOrder, int totalDays, int frequency, String takenOrderProperties, String startId, String hospital, String userId, String medicbox_Id) throws Exception {
		ArrayList<LoadCellInfo> schedules = new ArrayList<LoadCellInfo>();
		takenOrderProperties = takenOrderProperties.replace("[", "");
		ArrayList<String> takenOrderPropertysArr = Util.split("]", takenOrderProperties);

		ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(takenOrderPropertysArr);
		int idx = 0;
		boolean tmpBool = true;
		if (startId != null) {
			tmpBool = false;
		}
		for (int i = 0; i < (totalDays * frequency); i++) {
			Calendar cal2 = Util.getCalendar(startDate, "-");;
			String id = "00" + i;
			id = id.substring(id.length() - 3);
			idx = startOrder + i - 1;
			cal2.add(Calendar.DATE, (int) (idx / frequency));
			TakenOrderProperty takenOrderProperty = takenOrderPropertyList.get(idx % frequency);
			cal2.set(Calendar.HOUR_OF_DAY, Integer.parseInt(takenOrderProperty.getStartTimeArr()[0]));
			cal2.set(Calendar.MINUTE, Integer.parseInt(takenOrderProperty.getStartTimeArr()[1]));
			SimpleDateFormat form1 = new SimpleDateFormat("yyyyMMdd HHmm");
			String alarmStart = form1.format(cal2.getTime());
			cal2.set(Calendar.HOUR_OF_DAY, Integer.parseInt(takenOrderProperty.getEndTimeArr()[0]));
			cal2.set(Calendar.MINUTE, Integer.parseInt(takenOrderProperty.getEndTimeArr()[1]));
			String alarmEnd = form1.format(cal2.getTime());			
			LoadCellInfo loadcellInfo = new LoadCellInfo();
			loadcellInfo.setUserId(userId);
			loadcellInfo.setSchedule_Id(id);
			loadcellInfo.setPriscription_Id(prescription_id);
			loadcellInfo.setMedicbox_Id(medicbox_Id);
		
			if (!tmpBool) {
				if (loadcellInfo.getSchedule_Id().equals(startId)) {
					tmpBool = true;
				}
			}
			if (tmpBool) {
				schedules.add(loadcellInfo);
			}
		}
		return schedules;
	}

	// 새로운 테이블 스케쥴 데이터 생성
	public ArrayList<MedicationState> makeMedicationState(String userId, String prescription_id, String startDate, int startOrder, int endOrder, int totalDays, int frequency, String takenOrderProperties, String startId, String hospital, String pharmacy) throws Exception {
		// TODO : 복약 상황 등록 하기
		ArrayList<MedicationState> schedules = new ArrayList<MedicationState>();
		takenOrderProperties = takenOrderProperties.replace("[", "");
		ArrayList<String> takenOrderPropertysArr = Util.split("]", takenOrderProperties);

		ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(takenOrderPropertysArr);

		int idx = 0;
		try {
			for (int i = 0; i < (totalDays * frequency); i++) {
				Calendar cal2 = Util.getCalendar(startDate, "-");;
				String id = "00" + i;
				id = id.substring(id.length() - 3);
				idx = startOrder + i - 1;
				cal2.add(Calendar.DATE, (int) (idx / frequency));
				TakenOrderProperty takenOrderProperty = takenOrderPropertyList.get(idx % frequency);
				cal2.set(Calendar.HOUR_OF_DAY, Integer.parseInt(takenOrderProperty.getStartTimeArr()[0]));
				cal2.set(Calendar.MINUTE, Integer.parseInt(takenOrderProperty.getStartTimeArr()[1]));
				SimpleDateFormat form1 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
				String alarmStart = form1.format(cal2.getTime());
				cal2.set(Calendar.HOUR_OF_DAY, Integer.parseInt(takenOrderProperty.getEndTimeArr()[0]));
				cal2.set(Calendar.MINUTE, Integer.parseInt(takenOrderProperty.getEndTimeArr()[1]));
				String alarmEnd = form1.format(cal2.getTime());

				MedicationState scheduleInfo = new MedicationState();
				scheduleInfo.setMedicState_no(id);
				// TODO : 환자번호
				scheduleInfo.setPatient_no(userId);
				// TODO : 관리번호
				scheduleInfo.setManagement_no(pharmacy);
				// TODO : 수약관리번호
				scheduleInfo.setRecvpill_no(prescription_id);
				
				scheduleInfo.setAlarmstart(alarmStart);
				scheduleInfo.setAlarmend(alarmEnd);
				scheduleInfo.setState(Define.TAKEN_SATUS_NONE);
				scheduleInfo.setMedicationtime(null);

				schedules.add(scheduleInfo);
			}
		} catch (Exception ex) {
			if (Log.out_debugEnabled) {
				Log.out.debug("############# [ " + ex.getMessage() + " ]");
			}
		}
		return schedules;
	}

	public static ScheduleManager getInstance() {
		if (instance == null) {
			instance = new ScheduleManager();
		}
		return instance;
	}
	
	public void updateTakenStatus(String userId, String hospital, String scheduleId, String prescriptionId,  String takenStatus) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		Savepoint point = connResource.setSavepoint();
		try {
			scheduleHandler.updateTakenStatus(connResource, userId, hospital, scheduleId, prescriptionId,  takenStatus );
			connResource.commit();
		} catch (Exception ex) {
			connResource.rollback(point);
			throw new Exception(ex);
		}finally {				
			connResource.release();
			connResource = null;
		}
	}
}
