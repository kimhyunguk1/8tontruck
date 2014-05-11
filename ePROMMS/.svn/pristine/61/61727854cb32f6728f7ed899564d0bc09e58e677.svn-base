package kr.re.etri.lifeinfomatics.promes.mgr;

import java.sql.Savepoint;
import java.util.ArrayList;
import java.util.Hashtable;

import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.PostInfo;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.data.DoctorList;
import kr.re.etri.lifeinfomatics.promes.data.PatientInfo;
import kr.re.etri.lifeinfomatics.promes.data.ManagerInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.handler.UserHandler;
import kr.re.etri.lifeinfomatics.promes.test.TestData;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

/**
 * @author mJeyun
 *
 */
public class UserManager {

	private static UserManager instance = null;
	private UserHandler userHandler = new UserHandler();

	private UserManager() {
	}

	/**
	 * 사용자 ID기반으로 사용자 정보 조
	 * 
	 * @param id
	 * @return
	 * @throws Exception
	 */
	public UserInfo getUserInfo(String id) throws Exception {
		UserInfo userInfo = userHandler.getUserInfo(id);
		return userInfo;
	}

	/**
	 * 사용자 ID, PASSWORD 기반 사용자 정보 조
	 * 
	 * @param id
	 * @param pw
	 * @return
	 * @throws Exception
	 */
	public UserInfo getUserInfo(String id, String pw) throws Exception {
		UserInfo userInfo = userHandler.getUserInfo(id, pw);
		return userInfo;
	}

	/**
	 * 사용자 정보 조회
	 * 
	 * @param type
	 * @param keyType
	 * @param key
	 * @return
	 * @throws Exception
	 */
	public ArrayList<UserInfo> getUserInfoList(String type, String keyType, String key) throws Exception {
		ArrayList<UserInfo> userList = userHandler.getUserInfo(type, keyType, key);
		return userList;
	}

	/**
	 * 사용자 이름 기반 사용자 정보 조회(동명이인)
	 * 
	 * @param name
	 * @return
	 * @throws Exception
	 */
	public ArrayList<UserInfo> getUserInfoToName(String name) throws Exception {
		ArrayList<UserInfo> userList = userHandler.getUserInfoToName(name);
		return userList; 
	}

	/**
	 * 사용자 Type에 따른 Count 조회
	 * 
	 * @return
	 * @throws Exception
	 */
	public Hashtable<String, String> getUserCount() throws Exception {
		Hashtable<String, String> userCountHash = userHandler.getUserCount();
		return userCountHash;
	}

	/**
	 * 사용자 ID를 기반으로 환자 Count 조
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int getPatientCount(String userId) throws Exception {
		return userHandler.getPatientCount(userId);
	}
	


	/**
	 * @Method Name : getTakeCompliteList
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<String> getTakeCompliteList(String userId) throws Exception {
		return userHandler.getTakecompliteList(userId);
	}
	/**
	 * 사용자 ID를 기반으로 복용환자 Count 조
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int getTakenPatientCount(String userId) throws Exception {
		return userHandler.getTakenPatientCount(userId);
	}
	
	/**
	 * 의사 조회
	 * 
	 * @param 
	 * @return
	 * @throws Exception
	 */
	public ArrayList<DoctorList> getDoctorInfoList() throws Exception {
		ArrayList<DoctorList> userList = userHandler.getDoctorInfoList();
		return userList;
	}

	/**
	 * 사용자 정보 추가
	 * 
	 * @param userInfo
	 * @throws Exception
	 */
	public void addUserInfo(UserInfo userInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		Savepoint point = connResource.setSavepoint();
		try {
			userHandler.addUserInfo(connResource, userInfo);
			connResource.commit();
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			throw new Exception("사용자 등록에 실패 하였습니다.(" + Util.getErrorCode(ex) + ")");
		}
		if (userInfo.getType().equals(Define.USER_PATIENT)) {
			try {
				PillBoxManager.getInstance().addPillBoxs(connResource, userInfo.getPillBoxs());
			} catch (Exception ex) {
				Log.out.error(ex, ex);
				userHandler.delUserInfo(userInfo.getId());
				throw new Exception("약상자 등록에 실패 하였습니다.(" + Util.getErrorCode(ex) + ")");
			}
			try {
				ScheduleManager.getInstance().makeUserTable(connResource, userInfo.getId());
			} catch (Exception ex) {
				Log.out.error(ex, ex);
				userHandler.delUserInfo(userInfo.getId());
				ArrayList<PillBoxInfo> pillBoxList = userInfo.getPillBoxs();
				String pillBoxIdStr = "";
				for (int i = 0; i < pillBoxList.size(); i++) {
					PillBoxInfo pillBoxInfo = pillBoxList.get(i);
					pillBoxIdStr += pillBoxInfo.getId();
					if (i != pillBoxList.size() - 1) {
						pillBoxIdStr += "/";
					}
				}
				ArrayList<String> pillBoxs = Util.split("/", pillBoxIdStr);
				PillBoxManager.getInstance().deletePillBoxInfo(connResource, pillBoxs);
				connResource.commit();
				throw new Exception("사용자 세부 스케줄 테이블 생성에 실패 하였습니다.(" + Util.getErrorCode(ex) + ")");
			}
			finally {				
				connResource.release();
				connResource = null;
			}
		}
		
		try
		{
			if (connResource != null)
			{
				connResource.release();
			}
		}
		catch (Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if (connResource != null)
			{
				connResource.release();
				connResource = null;
			}
		}
		
	}
	//new
	public void addPatientInfo(PatientInfo patientInfo) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		//Savepoint point = connResource.setSavepoint();
		try {
			userHandler.addPatientInfo(connResource, patientInfo);
			connResource.commit();
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			throw new Exception("new사용자 등록에 실패 하였습니다.(" + Util.getErrorCode(ex) + ")");
		}finally {				
			connResource.release();
			connResource = null;
		}
	}
	
	//new
		public void addManagerInfo(ManagerInfo managerInfo) throws Exception {
			ConnectionResource connResource = DBManager.getInstance().getConnection(false);
			//Savepoint point = connResource.setSavepoint();
			try {
				userHandler.addManagerInfo(connResource, managerInfo);
				connResource.commit();
			} catch (Exception ex) {
				Log.out.error(ex, ex);
				throw new Exception("new사용자 등록에 실패 하였습니다.(" + Util.getErrorCode(ex) + ")");
			}finally {				
				connResource.release();
				connResource = null;
			}
		}

	/**
	 * 사용자 정보를 수정한다.
	 * 
	 * @param userInfo
	 * @throws Exception
	 */
	public void modifyUserInfo(String oldpillboxId, UserInfo userInfo, Hashtable<String, Object> pillBoxHash) throws Exception 
	{
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		Savepoint point = connResource.setSavepoint();
		boolean takenbool = false;
		
		ArrayList<PrescriptionInfo> prescriptionInfos = PrescriptionManager.getInstance().getPrescriptionToPillboxId(oldpillboxId);
		for(int i=0; i<prescriptionInfos.size(); i++){
			PrescriptionInfo prescriptioninfo = prescriptionInfos.get(i);
			if(prescriptioninfo.getStatus().equals("FINISH"))
				takenbool = true;
		}
		ArrayList<PillBoxInfo> newpillboxInfo = (ArrayList<PillBoxInfo>) pillBoxHash.get("ADD");	
		if(takenbool && oldpillboxId != newpillboxInfo.get(0).getId()){
			if (pillBoxHash.containsKey("ADD")) 
			{
				PillBoxManager.getInstance().addPillBoxs(connResource, (ArrayList<PillBoxInfo>) pillBoxHash.get("ADD"));
				userHandler.modifyUserInfo(connResource, userInfo);
    			connResource.commit();				
			}
			
		}else{
    		try 
    		{
    			if (pillBoxHash.containsKey("DEL")) 
    			{
    				PillBoxManager.getInstance().deletePillBoxInfo(connResource, (ArrayList<String>) pillBoxHash.get("DEL"));
    			}
    			if (pillBoxHash.containsKey("ADD")) 
    			{
    				PillBoxManager.getInstance().addPillBoxs(connResource, (ArrayList<PillBoxInfo>) pillBoxHash.get("ADD"));
    			}
    			if (pillBoxHash.containsKey("UPDATE")) 
    			{
    				PillBoxManager.getInstance().updatePillBoxInfo(connResource, (ArrayList<PillBoxInfo>) pillBoxHash.get("UPDATE"));
    			}
    			userHandler.modifyUserInfo(connResource, userInfo);
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
	


	/**
	 * 사용자 정보 삭제
	 * 
	 * <pre>
	 * 1 : 상세 스케줄을 삭제한다. :: SCHEDULES_USERID 
	 * 2 : 스케줄을 삭제한다. :: PERSCRIPTION 
	 * 3 : 약상자를 삭제한다. :: PILLBOX 
	 * 4 : 사용자를 삭제한다. :: MEMBER
	 * </pre>
	 * 
	 * @param connResource
	 * @param userId
	 * @throws Exception
	 */
	public void deleteUserInfo(ConnectionResource connResource, String userId) throws Exception {
		userHandler.delUserInfo(connResource, userId);
	}

	/**
	 * 사용자 정보 삭제
	 * 
	 * <pre>
	 * 1 : 상세 스케줄을 삭제한다. :: SCHEDULES_USERID 
	 * 2 : 처방전 삭제한다. :: PERSCRIPTION 
	 * 3 : 약상자를 삭제한다. :: PILLBOX 
	 * 4 : 사용자를 삭제한다. :: MEMBER
	 * 5 : 상세 스케줄 Table 삭제
	 * </pre>
	 * 
	 * @param userId
	 * @throws Exception
	 */
	public void deleteUserInfo(String userId) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection(false);
		Savepoint point = connResource.setSavepoint();
		UserInfo userInfo = this.getUserInfo(userId);
		try {
			if (userInfo.getType().equals(Define.USER_PATIENT)) {
				PrescriptionManager.getInstance().delPrescription(connResource, userId);
				ArrayList<String> pillBoxs = Util.split("/", userInfo.getPillBoxsStr());
				PillBoxManager.getInstance().deletePillBoxInfo(connResource, pillBoxs);
			}
			this.deleteUserInfo(connResource, userId);
			connResource.commit();
		} catch (Exception ex) {
			connResource.rollback(point);
			throw new Exception(ex);
		}finally {				
			connResource.release();
			connResource = null;
		}
		if (userInfo.getType().equals(Define.USER_PATIENT)) {
			ScheduleManager.getInstance().dropUserTable(userId);
		}
	}

	/**
	 * 다수의 사용자 정보를 삭제 한다.
	 * 
	 * @param userIdList
	 */
	public ArrayList<String> deleteUserInfo(String type, ArrayList<String> userIdList) throws Exception {
		ArrayList<String> failureIdList = new ArrayList<String>();
		try {
			for (String userInfo : userIdList) {
				String[] userInfoArr = userInfo.split(":");
				String userId = userInfoArr[1];
				String userName = userInfoArr[0];
				boolean delBool = true;
				if (PrescriptionManager.getInstance().checkPrescription(type, userId)) {
					delBool = false;
					failureIdList.add(userName+"(" + userId + ")");
				}
				if (delBool) {
					this.deleteUserInfo(userId);
				}
			}
		} catch (Exception ex) {
			Log.out.error("사용자 삭제 실패 : " + ex.getMessage());
			throw new Exception("사용자 삭제 실패 : " + ex.getMessage());
		}
		return failureIdList;
	}

	public boolean checkUserId(String id) throws Exception {
		return userHandler.checkUserId(id);
	}

	public Hashtable<String, String> searchPost(String key) throws Exception {
		ArrayList<PostInfo> posts = userHandler.searchPost(key);
		Hashtable<String, String> postHash = new Hashtable<String, String>();
		for (PostInfo postInfo : posts) {
			postHash.put(postInfo.getCode(), postInfo.toWebString());
		}
		return postHash;
	}

	public static UserManager getInstance() {
		if (instance == null) {
			instance = new UserManager();
		}
		return instance;
	}
}
