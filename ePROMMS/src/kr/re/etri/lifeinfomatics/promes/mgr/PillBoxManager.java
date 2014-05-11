package kr.re.etri.lifeinfomatics.promes.mgr;

import java.util.ArrayList;

import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.handler.PillBoxHandler;
import kr.re.etri.lifeinfomatics.promes.mgr.handler.UserHandler;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class PillBoxManager {
	private static PillBoxManager instance = null;
	private PillBoxHandler pillBoxHandler = new PillBoxHandler();

	/**
	 * ����� ����Ʈ ��ȸ(����� ID, ����� ID List)
	 * 
	 * @param userId
	 * @param pillBoxIdList
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PillBoxInfo> getPillBoxList(String userId, ArrayList<String> pillBoxIdList) throws Exception {
		ArrayList<PillBoxInfo> pillboxs = pillBoxHandler.getPillBoxList(userId, pillBoxIdList);
		return pillboxs;
	}

	/**
	 * ����� ����Ʈ ��ȸ
	 * 
	 * @param userId
	 * @param pillBoxId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PillBoxInfo> getPillBoxList(String userId, String pillBoxId) throws Exception {
		ArrayList<PillBoxInfo> pillboxs = pillBoxHandler.getPillBoxList(userId, pillBoxId);
		return pillboxs;
	}

	/**
	 * �ϳ��� ����� ������ �����´�.
	 * 
	 * @param pillBoxId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PillBoxInfo> getPillBoxList(String pillBoxId) throws Exception {
		ArrayList<String> idList = new ArrayList<String>();
		idList.add(pillBoxId);
		ArrayList<PillBoxInfo> pillboxs = pillBoxHandler.getPillBoxList(idList);
		return pillboxs;
	}

	/**
	 * ����� ID List�� ����� ����� ������ ������
	 * 
	 * @param pillBoxsStr
	 *        ex) Ph0001/Ph0002;
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PillBoxInfo> getPillBoxListToPillBoxStr(String pillBoxsStr) throws Exception {
		ArrayList<String> idList = Util.split("/", pillBoxsStr);
		ArrayList<PillBoxInfo> pillboxs = pillBoxHandler.getPillBoxList(idList);
		return pillboxs;
	}

	/**
	 * ����� �߰�
	 * 
	 * @param connResource
	 * @param pillBoxs
	 * @throws Exception
	 */
	public void addPillBoxs(ConnectionResource connResource, ArrayList<PillBoxInfo> pillBoxs) throws Exception {
		if (connResource == null) {
			connResource = DBManager.getInstance().getConnection();
		}
		pillBoxHandler.addPillBoxInfo(connResource, pillBoxs);
	}

	public void updatePillBoxInfo(ConnectionResource connResource, ArrayList<PillBoxInfo> pillBoxs) throws Exception {
		if (connResource == null) {
			connResource = DBManager.getInstance().getConnection();
		}
		for (PillBoxInfo pillBoxInfo : pillBoxs) {
			pillBoxHandler.updatePillBoxInfo(connResource, pillBoxInfo);
		}
	}

	public void deletePillBoxInfo(ConnectionResource connResource, String pillBoxId) throws Exception {
		if (connResource == null) {
			connResource = DBManager.getInstance().getConnection();
		}
		pillBoxHandler.deletePillBoxInfo(connResource, pillBoxId);
	}

	public void deletePillBoxInfo(ConnectionResource connResource, ArrayList<String> pillBoxs) throws Exception {
		if (connResource == null) {
			connResource = DBManager.getInstance().getConnection();
		}
		if (pillBoxs != null && pillBoxs.size() > 0) {
			pillBoxHandler.deletePillBoxInfo(connResource, pillBoxs);
		}
	}

	public boolean checkUsePillBoxs(ArrayList<String> pillBoxs) throws Exception {
		return pillBoxHandler.checkUsePillBoxs(pillBoxs);
	}
	
	public boolean checkTakePillBoxs(ArrayList<String> pillBoxs) throws Exception {
		return pillBoxHandler.checkTakePillBoxs(pillBoxs);
	}
	public boolean checkPrescription(String userId) throws Exception {
		return pillBoxHandler.checkPrescription(userId);
	}

	public boolean checkUsePillBox(String pillBoxId) throws Exception {
		ArrayList<PillBoxInfo> pillBoxs = this.getPillBoxList(pillBoxId);
		if (pillBoxs.size() > 0) {
			return false;
		}
		else {
			return true;
		}
	}
	
	
	/**
	 * ����� ���� ���� ����Ʈ�� ������ �´�.
	 */
	public ArrayList<UserInfo> getPillBoxStateList()
	{
		return null;
	}

	public static PillBoxManager getInstance() {
		if (instance == null) {
			instance = new PillBoxManager();
		}
		return instance;
	}
}
