package kr.re.etri.lifeinfomatics.promes.mgr.handler;

import java.util.ArrayList;

import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class PillBoxHandler {
	public PillBoxHandler() {
		super();
	}

	/**
	 * 사용자 ID 기반을 약상자 정보을 다져온다.
	 * 
	 * @param userId
	 * @return
	 */
	public ArrayList<PillBoxInfo> getPillBoxList(String userId, ArrayList<String> pillBoxIdList) throws Exception {
		Log.out.debug("=====> 약상자 정보 조회 시작");
		String sql = "SELECT PI.ID, PI.TYPE, PI.CONTAINERNUMBER, PI.REGDATE, PR.ID, DATE_FORMAT(STR_TO_DATE(PR.STARTDATE, '%Y%m%d'), '%Y-%m-%d'), PR.TOTALDAYS, PR.DIRECTION, PR.TAKENORDERPROPERTIES, PR.STATUS ";
		sql += "FROM MEMBER U, PILLBOX PI LEFT OUTER JOIN PRESCRIPTION PR ON PI.ID = PR.PILLBOX_ID ";
		sql += "WHERE U.ID = " + Util.getSqlString(userId);
		sql += " AND PI.ID IN (";
		for (int i = 0; i < pillBoxIdList.size(); i++) {
			if (i + 1 == pillBoxIdList.size()) {
				sql += Util.getSqlString(pillBoxIdList.get(i));
			}
			else {
				sql += Util.getSqlStringAnd(pillBoxIdList.get(i));
			}
		}
		sql += ")";
		sql += " ORDER BY PI.ID ASC";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<PillBoxInfo> pillBoxList = this.toPillBoxListResultData(list, "prescription");
		Log.out.debug("=====> 약상자 정보 조회 ");
		return pillBoxList;
	}

	/**
	 * 사용자 ID 와 PillBox ID 기반을 약상자 정보을 다져온다.
	 * 
	 * @param userId
	 * @param pillBoxId
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PillBoxInfo> getPillBoxList(String userId, String pillBoxId) throws Exception {
		Log.out.debug("=====> 약상자 정보 조회 시작");
		String sql = "SELECT PI.ID, PI.TYPE, PI.CONTAINERNUMBER, PI.REGDATE, PR.ID, DATE_FORMAT(STR_TO_DATE(PR.STARTDATE, '%Y%m%d'), '%Y-%m-%d'), PR.TOTALDAYS, PR.DIRECTION, PR.TAKENORDERPROPERTIES, PR.STATUS ";
		sql += "FROM MEMBER U, PILLBOX PI LEFT OUTER JOIN PRESCRIPTION PR ON PI.ID = PR.PILLBOX_ID ";
		sql += "WHERE U.ID = " + Util.getSqlString(userId);
		sql += " AND PI.ID = " + Util.getSqlString(pillBoxId);
		sql += " ORDER BY PI.ID ASC";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<PillBoxInfo> pillBoxList = this.toPillBoxListResultData(list, "prescription");
		Log.out.debug("=====> 약상자 정보 조회 ");
		return pillBoxList;
	}

	/**
	 * 약상자 ID List를 기반으로 약상자 정보를 가져온다.
	 * 
	 * @param idList
	 * @return
	 * @throws Exception
	 */
	public ArrayList<PillBoxInfo> getPillBoxList(ArrayList<String> idList) throws Exception {
		Log.out.debug("=====> 약상자 정보 조회 시작");
		String sql = "SELECT ID, TYPE, CONTAINERNUMBER, REGDATE FROM PILLBOX WHERE ";
		sql += "ID IN (";
		for (int i = 0; i < idList.size(); i++) {
			if (i + 1 == idList.size()) {
				sql += Util.getSqlString(idList.get(i));
			}
			else {
				sql += Util.getSqlStringAnd(idList.get(i));
			}
		}
		sql += ")";
		Log.out.debug(sql);
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		ArrayList<PillBoxInfo> pillBoxList = this.toPillBoxListResultData(list, "");
		Log.out.debug("=====> 약상자 정보 조회 ");
		return pillBoxList;
	}

	public void addPillBoxInfo(ConnectionResource connResource, PillBoxInfo pillBox) throws Exception {
		Log.out.debug("=====> 약상자 정보 저장 시작 ");
		String[] cols = this.toColumnValue(pillBox);
		String sql = "INSERT INTO PILLBOX (ID, TYPE, CONTAINERNUMBER, REGDATE) VALUES (";
		for (int i = 0; i < cols.length; i++) {
			sql += cols[i];
		}
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 약상자 정보 저장 끝");
		
		//new
		Log.out.debug("=====> new약상자 정보 저장 시작 ");
		sql = "";
		sql = "INSERT INTO MEDICBOX (Medicbox_no, Type, State) VALUES (";
		sql += cols[0];		
		sql += cols[1];
		sql += "'OFF'";
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> new약상자 정보 저장 끝"); 
	}

	public void addPillBoxInfo(ConnectionResource connResource, ArrayList<PillBoxInfo> pillBoxs) throws Exception {
		for (PillBoxInfo pillBoxInfo : pillBoxs) {
			this.addPillBoxInfo(connResource, pillBoxInfo);
		}
	}

	public void addPillBoxInfo(PillBoxInfo pillBox) throws Exception {
		ConnectionResource connResource = DBManager.getInstance().getConnection();
		this.addPillBoxInfo(connResource, pillBox);
	}

	public void updatePillBoxInfo(ConnectionResource connResource, PillBoxInfo pillBoxInfo) throws Exception {
		Log.out.debug("=====> 약상자 정보 수정 시작");
		String[] cols = this.toColumnValue(pillBoxInfo);
		String sql = "UPDATE PILLBOX SET ";
		int i = 1;
		sql += " TYPE = " + cols[i++];
		sql += " CONTAINERNUMBER = " + cols[i++];
		sql += " REGDATE = " + cols[i++];
		sql += " WHERE ID = " + Util.getSqlString(pillBoxInfo.getId());
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 약상자 정보 수정 끝");
	}

	public void deletePillBoxInfo(ConnectionResource connResource, String pillBoxId) throws Exception {
		Log.out.debug("=====> 약상자 정보 삭제 시작 ");
		String sql = "";
		sql += "DELETE FROM PILLBOX WHERE ";
		sql += "ID = " + Util.getSqlString(pillBoxId);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 약상자 정보 삭제 끝");
		
		//new
		Log.out.debug("=====> new약상자 정보 삭제 시작 ");
		sql = "";
		sql += "DELETE FROM MEDICBOX WHERE ";
		sql += "MEDICBOX_NO = " + Util.getSqlString(pillBoxId);
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> new약상자 정보 삭제 끝");
	}

	public void deletePillBoxInfo(ConnectionResource connResource, ArrayList<String> pillBoxs) throws Exception {
		Log.out.debug("=====> 약상자 정보 삭제 시작 ");
		String sql = "";
		sql += "DELETE FROM PILLBOX WHERE ";
		sql += "ID IN (";
		for (int i = 0; i < pillBoxs.size(); i++) {
			sql += Util.getSqlStringAnd(pillBoxs.get(i));
			if ((i + 1) == pillBoxs.size()) {
				sql += Util.getSqlString(pillBoxs.get(i));
			}
		}
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> 약상자 정보 삭제 끝");
		
		//new
		Log.out.debug("=====> new약상자 정보 삭제 시작 ");
		sql = "";
		sql += "DELETE FROM MEDICBOX WHERE ";
		sql += "MEDICBOX_NO IN (";
		for (int i = 0; i < pillBoxs.size(); i++) {
			sql += Util.getSqlStringAnd(pillBoxs.get(i));
			if ((i + 1) == pillBoxs.size()) {
				sql += Util.getSqlString(pillBoxs.get(i));
			}
		}
		sql += ")";
		Log.out.debug(sql);
		DBManager.getInstance().updateQuery(connResource, sql);
		Log.out.debug("=====> new약상자 정보 삭제 끝");
	}

	public boolean checkUsePillBoxs(ArrayList<String> pillBoxs) throws Exception {
		Log.out.debug("=====> 약상자 사용중 확인 시작 ");
		String sql = "";
		sql += "SELECT ID FROM PRESCRIPTION WHERE PILLBOX_ID IN (";
		for (int i = 0; i < pillBoxs.size(); i++) {
			String pillBoxId = pillBoxs.get(i);
			if ((i + 1) == pillBoxs.size()) {
				sql += Util.getSqlString(pillBoxId);
			}
			else {
				sql += Util.getSqlStringAnd(pillBoxId);
			}
		}
		sql += ")";		
		Log.out.debug(sql);		
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		Log.out.debug("=====> 약상자 사용중 확인  끝");
		if (list.size() > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	public boolean checkTakePillBoxs(ArrayList<String> pillBoxs) throws Exception {
		Log.out.debug("=====> 약상자 사용중 확인 시작 ");
		String sql = "";
		sql += "SELECT ID FROM PRESCRIPTION WHERE PILLBOX_ID IN (";
		for (int i = 0; i < pillBoxs.size(); i++) {
			String pillBoxId = pillBoxs.get(i);
			if ((i + 1) == pillBoxs.size()) {
				sql += Util.getSqlString(pillBoxId);
			}
			else {
				sql += Util.getSqlStringAnd(pillBoxId);
			}
		}
		sql += ")";
		sql += " AND STATUS NOT IN ('FINISH','STOP')";
		Log.out.debug(sql);		
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		Log.out.debug("=====> 약상자 사용중 확인  끝");
		if (list.size() > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	public boolean checkPrescription(String userId) throws Exception {
		Log.out.debug("=====> 스케줄 사용중 확인 시작 ");
		String sql = "";
		sql += "SELECT ID FROM PRESCRIPTION WHERE MEMBER_ID IN (";
		
		sql += Util.getSqlString(userId);
		sql += ")";
		sql += " AND STATUS NOT IN ('FINISH','STOP')";
		Log.out.debug(sql);		
		DBManager dbManager = DBManager.getInstance();
		ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
		Log.out.debug("=====> 스케줄 사용중 확인  끝");
		if (list.size() > 0) {
			return true;
		}
		else {
			return false;
		}
	}
	
	/*******************************************************************************************************************************************************************************************************************************************************************************************************
	 * SQL Data 변환
	 ******************************************************************************************************************************************************************************************************************************************************************************************************/

	public ArrayList<PillBoxInfo> toPillBoxListResultData(ArrayList<ArrayList<Object>> list, String type) {
		ArrayList<PillBoxInfo> pillBoxList = new ArrayList<PillBoxInfo>();;
		if (list.size() > 0) {
			for (ArrayList<Object> rows : list) {
				int i = 0;
				PillBoxInfo pillbox = new PillBoxInfo();
				pillbox.setId(rows.get(i++).toString());
				pillbox.setType(rows.get(i++).toString());
				pillbox.setContainerNumber(Integer.parseInt(rows.get(i++).toString()));
				pillbox.setRegDate(rows.get(i++).toString());
				if (type.equals("prescription")) {
					pillbox.setPrescriptionId(rows.get(i++).toString());
					if (pillbox.getPrescriptionId() != null && !pillbox.getPrescriptionId().equals("")) {
						pillbox.setStrtDate(rows.get(i++).toString());
						pillbox.setTotalDays(Integer.parseInt(rows.get(i++).toString()));
						pillbox.setDirection(rows.get(i++).toString());
						pillbox.setTakenOrderproperties(rows.get(i++).toString());
						pillbox.setStatus(rows.get(i++).toString());
					}
				}
				pillBoxList.add(pillbox);
			}
		}
		return pillBoxList;
	}

	public String[] toColumnValue(PillBoxInfo data) throws Exception {
		ArrayList<String> vList = new ArrayList<String>();
		vList.add(Util.getSqlStringAnd(data.getId()));
		vList.add(Util.getSqlStringAnd(data.getType()));
		vList.add(Util.getSqlIntegerAnd(data.getContainerNumber()));
		vList.add(Util.getSqlString(data.getRegDate()));
		String[] value = new String[vList.size()];
		vList.toArray(value);
		return value;
	}
}
