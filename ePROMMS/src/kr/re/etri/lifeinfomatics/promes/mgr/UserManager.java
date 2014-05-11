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
	 * ����� ID������� ����� ���� ��
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
	 * ����� ID, PASSWORD ��� ����� ���� ��
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
	 * ����� ���� ��ȸ
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
	 * ����� �̸� ��� ����� ���� ��ȸ(��������)
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
	 * ����� Type�� ���� Count ��ȸ
	 * 
	 * @return
	 * @throws Exception
	 */
	public Hashtable<String, String> getUserCount() throws Exception {
		Hashtable<String, String> userCountHash = userHandler.getUserCount();
		return userCountHash;
	}

	/**
	 * ����� ID�� ������� ȯ�� Count ��
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
	 * ����� ID�� ������� ����ȯ�� Count ��
	 * 
	 * @param userId
	 * @return
	 * @throws Exception
	 */
	public int getTakenPatientCount(String userId) throws Exception {
		return userHandler.getTakenPatientCount(userId);
	}
	
	/**
	 * �ǻ� ��ȸ
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
	 * ����� ���� �߰�
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
			throw new Exception("����� ��Ͽ� ���� �Ͽ����ϴ�.(" + Util.getErrorCode(ex) + ")");
		}
		if (userInfo.getType().equals(Define.USER_PATIENT)) {
			try {
				PillBoxManager.getInstance().addPillBoxs(connResource, userInfo.getPillBoxs());
			} catch (Exception ex) {
				Log.out.error(ex, ex);
				userHandler.delUserInfo(userInfo.getId());
				throw new Exception("����� ��Ͽ� ���� �Ͽ����ϴ�.(" + Util.getErrorCode(ex) + ")");
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
				throw new Exception("����� ���� ������ ���̺� ������ ���� �Ͽ����ϴ�.(" + Util.getErrorCode(ex) + ")");
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
			throw new Exception("new����� ��Ͽ� ���� �Ͽ����ϴ�.(" + Util.getErrorCode(ex) + ")");
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
				throw new Exception("new����� ��Ͽ� ���� �Ͽ����ϴ�.(" + Util.getErrorCode(ex) + ")");
			}finally {				
				connResource.release();
				connResource = null;
			}
		}

	/**
	 * ����� ������ �����Ѵ�.
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
	 * ����� ���� ����
	 * 
	 * <pre>
	 * 1 : �� �������� �����Ѵ�. :: SCHEDULES_USERID 
	 * 2 : �������� �����Ѵ�. :: PERSCRIPTION 
	 * 3 : ����ڸ� �����Ѵ�. :: PILLBOX 
	 * 4 : ����ڸ� �����Ѵ�. :: MEMBER
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
	 * ����� ���� ����
	 * 
	 * <pre>
	 * 1 : �� �������� �����Ѵ�. :: SCHEDULES_USERID 
	 * 2 : ó���� �����Ѵ�. :: PERSCRIPTION 
	 * 3 : ����ڸ� �����Ѵ�. :: PILLBOX 
	 * 4 : ����ڸ� �����Ѵ�. :: MEMBER
	 * 5 : �� ������ Table ����
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
	 * �ټ��� ����� ������ ���� �Ѵ�.
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
			Log.out.error("����� ���� ���� : " + ex.getMessage());
			throw new Exception("����� ���� ���� : " + ex.getMessage());
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
