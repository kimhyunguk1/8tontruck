package kr.re.etri.lifeinfomatics.promes.mgr;

import java.sql.Savepoint;
import java.util.ArrayList;
import java.util.Hashtable;

import com.sun.xml.internal.bind.v2.TODO;

import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.RecvPill;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.handler.PillBoxHandler;
import kr.re.etri.lifeinfomatics.promes.mgr.handler.PrescriptionHandler;
import kr.re.etri.lifeinfomatics.promes.test.TestData;

/**
 * 
 * Title: PROMES 2.0 Web
 * 
 * Description: ������ ����
 * 
 * Copyright: Copyright (c) 2009
 * 
 * Company: Metabiz
 * 
 * @author Roh is-deuk
 * @version 1.0
 */
public class PrescriptionManager {
	private static PrescriptionManager instance = null;
	private PrescriptionHandler prescriptionHandler = new PrescriptionHandler();

	private PrescriptionManager() {
	}

	/**
	 * ó���� ������ ��ȸ�Ѵ�.(Table ���)
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
	public ArrayList<PrescriptionInfo> getPrescriptionList(String userId, String name, String prescriptionId, String startDate, String endDate, String takenSatus, String pillBoxId, String disease, String loginId ,String boxtype, String searchDate) throws Exception {
		return prescriptionHandler.getPrescriptions(userId, name, prescriptionId, startDate, endDate, takenSatus, pillBoxId, disease, loginId,boxtype,searchDate);
	}
	public ArrayList<PrescriptionInfo> getPrescriptionListNew(String userId, String name, String prescriptionId, String startDate, String endDate, String takenSatus, String pillBoxId, String disease, String loginId ,String boxtype, String searchDate,String sortName,String sortType,String startPoint,String offset) throws Exception {
		return prescriptionHandler.getPrescriptionsNew(userId, name, prescriptionId, startDate, endDate, takenSatus, pillBoxId, disease, loginId,boxtype,searchDate, sortName,sortType, startPoint, offset);
	}
	public String getPrescriptionListTotalCnt(String userId, String name, String prescriptionId, String startDate, String endDate, String takenSatus, String pillBoxId, String disease, String loginId ,String boxtype, String searchDate,String sortName,String sortType) throws Exception {
		return prescriptionHandler.getPrescriptionsTotalCnt(userId, name, prescriptionId, startDate, endDate, takenSatus, pillBoxId, disease, loginId,boxtype,searchDate, sortName,sortType);
	}

	/**
	 * ó�������� ��ȸ �Ѵ�.
	 * 
	 * @param prescriptionId
	 * @return
	 * @throws Exception
	 */
	public PrescriptionInfo getPrescription(String prescriptionId, String hospital) throws Exception {
		return prescriptionHandler.getPrescription(prescriptionId, hospital);
	}

	public ArrayList<PrescriptionInfo> getPrescriptionToUserId(String userId) throws Exception {
		return prescriptionHandler.getPrescriptions(userId, null, null, null, null, null, null, null, null, null,null);
	}
	
	public ArrayList<PrescriptionInfo> getPrescriptionToPillboxId(String pillboxId) throws Exception {
		return prescriptionHandler.getPrescriptions(null, null, null, null, null, null, pillboxId, null, null, null,null);
	}

	public int getPharmacistPrescriptionCount(String userId) throws Exception {
		return prescriptionHandler.getPharmacistPrescriptionCount(userId);
	}

	public Hashtable<String, String> getPatientPrescriptionCount(String userId) throws Exception {
		Hashtable<String, String> countHash = prescriptionHandler.getPatientPrescriptionCount(userId);
		int total = 0;
		if (countHash.containsKey("1")) {
			total += Integer.parseInt(countHash.get("1"));
		}
		if (countHash.containsKey("0")) {
			total += Integer.parseInt(countHash.get("0"));
		}
		countHash.put("total", String.valueOf(total));
		return countHash;
	}

	
	/**
	 * ó�� �Է�
	 * @param prescriptionInfo
	 * @throws Exception
	 */
	public void addPrescription(PrescriptionInfo prescriptionInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		// ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		// Savepoint point = connResource.setSavepoint();
		try {
			prescriptionHandler.addPrescription(connResource, prescriptionInfo);
			if (prescriptionInfo.getStartDate() != null && !prescriptionInfo.getStartDate().equals("")) {
				ScheduleManager.getInstance().addSchedule(connResource, prescriptionInfo);
				// connResource.commit();
				prescriptionHandler.updateDetailPrescription(connResource, Define.ISDETAILSCHEDULE_TRUE, prescriptionInfo.getId(), prescriptionInfo.getHospital());
			}
			// connResource.commit();
		} catch (Exception ex) {
			// connResource.rollback(point);
			throw new Exception(ex);
		}
	}
	
	/**
	 * ������� �Է�
	 * @param prescriptionInfo
	 * @throws Exception
	 */
	public void addPrescriptionm(RecvPill recvpill) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		// ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		// Savepoint point = connResource.setSavepoint();
		try {
			prescriptionHandler.addPrescriptionm(connResource, recvpill);
			// connResource.commit();
		} catch (Exception ex) {
			// connResource.rollback(point);
			throw new Exception(ex);
		}
	}
	
	
	/*
	 * ȯ���� ����ڰ� ����� ó������ ��ϵ� ����ڱ��� �Բ� ����	 * 
	 */	
	public void modifyPrescriptionPillBoxId(String userId , String oldpillboxId,ArrayList<PillBoxInfo> newpillboxs) throws Exception
	{
		String newpillboxId="";
		for(int i=0; i<newpillboxs.size(); i++){
			PillBoxInfo newpillbox = newpillboxs.get(0);
			newpillboxId = newpillbox.getId();
		}
		
		try {
			ArrayList<PrescriptionInfo> prescriptionInfoList = this.getPrescriptionToUserId(userId);
			for(int i=0; i<prescriptionInfoList.size(); i++){	
				PrescriptionInfo prescriptionInfo = prescriptionInfoList.get(i);
				if(prescriptionInfo.getStatus().equals("ON") || prescriptionInfo.getStatus().equals("READY")){
					if(prescriptionInfo.getPillBox_id().equals(oldpillboxId) && oldpillboxId != newpillboxId){
						prescriptionHandler.updatePrescriptionPillboxId(prescriptionInfo.getId(), oldpillboxId, newpillboxId);
					}
				}
			}
			
		} catch (Exception ex) {
			// TODO Auto-generated catch block
			throw new Exception(ex);
		}
		
		
		
	}
	
	

	/**
	 * ó������ �����Ѵ�.
	 * 
	 * <pre>
	 * makeSchedule : ���� ������ ����  
	 * deleteSchedule : ���� ������ ����
	 * updateSchedule : ���� ������ �ð� ������Ʈ ����
	 * isSchedule : Table���� ����Ʈ ����
	 * </pre>
	 * 
	 * @param prescriptionInfo
	 * @param makeSchedule
	 * @param deleteSchedule
	 * @param updateSchedule
	 * @param isSchedule
	 * @throws Exception
	 */
	public void modifyPrescription(PrescriptionInfo prescriptionInfo, boolean makeSchedule, boolean deleteSchedule, boolean updateSchedule, String isSchedule) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		// ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		// Savepoint point = connResource.setSavepoint();
		try {
			if (updateSchedule) {
				ScheduleManager.getInstance().updateSchedules(connResource, prescriptionInfo);
			}
			else {
				if (deleteSchedule && makeSchedule) {
					// ���ð� ���� ���� ������ ���� �� �߰�
					ScheduleManager.getInstance().deleteSchedules(connResource, prescriptionInfo.getId(), prescriptionInfo.getMember_id(), prescriptionInfo.getHospital(), false);
					ScheduleManager.getInstance().addSchedule(connResource, prescriptionInfo);
				}
				else if (!deleteSchedule && makeSchedule) {
					// ���� ������ �߰�
					ScheduleManager.getInstance().addSchedule(connResource, prescriptionInfo);
				}
				else if (deleteSchedule && !makeSchedule) {
					// ������ ������ ���� ����
					ScheduleManager.getInstance().deleteSchedules(connResource, prescriptionInfo.getId(), prescriptionInfo.getMember_id(), prescriptionInfo.getHospital(), false);
				}
				else if (updateSchedule) {
					// ������ ������ ������Ʈ
					ScheduleManager.getInstance().updateSchedules(connResource, prescriptionInfo);
				}
			}
			// connResource.commit();
			prescriptionHandler.modifyPrescription(connResource, prescriptionInfo);
			// connResource.commit();
			prescriptionHandler.updateDetailPrescription(connResource, isSchedule, prescriptionInfo.getId(), prescriptionInfo.getHospital());
			// connResource.commit();
			connResource.release();
		} catch (Exception ex) {
			// connResource.rollback(point);
			throw new Exception(ex);
		}
	}

	/**
	 * ó������ �����Ѵ�.
	 * 
	 * <pre>
	 * 1. ���� �������� �����Ѵ�. 
	 * 2. ó������ �����Ѵ�.
	 * </pre>
	 * 
	 * @param prescriptionId
	 * @throws Exception
	 */
	public void delPrescription(String prescriptionId, String userId, String status, String hospital) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		// ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		// Savepoint point = connResource.setSavepoint();
		try {
			ScheduleManager.getInstance().deleteSchedules(connResource, prescriptionId, userId, hospital, false);
			// connResource.commit();
			prescriptionHandler.delPrescriptionToPrescriptionId(connResource, prescriptionId, hospital);
			prescriptionHandler.delPrescriptionToPrescriptionIdm(connResource, prescriptionId, hospital);
			// connResource.commit();
		} catch (Exception ex) {
			// connResource.rollback(point);
			throw new Exception(ex);
		}
	}

	/**
	 * ó������ �����Ѵ�.
	 * 
	 * <pre>
	 * 1. ���� �������� �����Ѵ�. 
	 * 2. ó������ �����Ѵ�.
	 * </pre>
	 * 
	 * @param prescriptionId
	 * @throws Exception
	 */
	public void delPrescription(ConnectionResource connResource, String userId) throws Exception {
		ScheduleManager.getInstance().deleteSchedules(connResource, userId);
		connResource.commit();
		prescriptionHandler.delPrescriptionToUserId(connResource, userId);
		connResource.commit();
	}

	public void finishPrescription(String prescriptionId, String userId, String status, String hospital) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		// ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		// Savepoint point = connResource.setSavepoint();
		try {
			ScheduleManager.getInstance().deleteSchedules(connResource, prescriptionId, userId, hospital, true);
			// connResource.commit();
			prescriptionHandler.updatePrescriptionStatus(connResource, prescriptionId, status,hospital);
			// connResource.commit();
		} catch (Exception ex) {
			// connResource.rollback(point);
			throw new Exception(ex);
		}
	}
	
	public void stopPrescription(String prescriptionId, String userId, String status, String hospital) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		// ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		// Savepoint point = connResource.setSavepoint();
		try {
			prescriptionHandler.updatePrescriptionStatus(connResource, prescriptionId, status,hospital);
			// connResource.commit();
		} catch (Exception ex) {
			// connResource.rollback(point);
			throw new Exception(ex);
		}
	}

	public void updateDetailPrescription(ConnectionResource connResource, String isDetailSchedule, String prescription, String hospital) throws Exception {
		prescriptionHandler.updateDetailPrescription(connResource, isDetailSchedule, prescription, hospital);
	}

	/**
	 * ����ڿ� ��ϵ� ó������ �ִ��� Ȯ���Ѵ�.(FINISH ������)
	 * 
	 * @param userId
	 */
	public boolean checkPrescription(String type, String userId) throws Exception {
		ArrayList<String> idList = prescriptionHandler.getPrescriptionExceptFinish(type, userId);
		if (idList.size() > 0) {
			return true;
		}
		return false;
	}

	public boolean checkPrescriptioin(String prescriptionId, String hospital) throws Exception {
		if (prescriptionHandler.checkPrescriptioin(prescriptionId, hospital) == 0) {
			return true;
		}
		else {
			return false;
		}
	}

	public boolean checkPrescriptioin(String prescriptionId) throws Exception {
		if (prescriptionHandler.checkPrescriptioin(prescriptionId) == 0) {
			return true;
		}
		else {
			return false;
		}
	}

	public static PrescriptionManager getInstance() {
		if (instance == null) {
			instance = new PrescriptionManager();
		}
		return instance;
	}
}