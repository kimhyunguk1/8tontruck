package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.CategoryInfo;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.db.ConnectionResource;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.ScheduleManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class ModifyMemolScheduleCommand implements Command {

	private String next = "";

	public ModifyMemolScheduleCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String prescriptionId = req.getParameter("_prescriptionId");
			String day = req.getParameter("_day");
			day = Util.toString(day);
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);
			String memoId = req.getParameter("_memoId");
			String userId = req.getParameter("_userId");
			String memoContent = req.getParameter("_memoContent");
			memoContent = Util.toString(memoContent);
			String takenStatus = req.getParameter("_takenStatus");
			
			ScheduleManager.getInstance().updateTakenStatus(userId, hospital, memoId, prescriptionId, takenStatus);
			
			if (memoContent == null)
			{
				memoContent = "";
			}
			
			if (memoId.length() == 1)
			{
				memoId = "00" + memoId;
			}
			else if (memoId.length() == 2)
			{
				memoId = "0" + memoId;
			}
			
			String memoCategory = req.getParameter("_memoCategory");
			
//			ConnectionResource connResource = DBManager.getInstance().getConnection();
			
			String sql = "SELECT COUNT(*) FROM MEMO ";
			sql += " WHERE PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
			sql += " AND ID = " + Util.getSqlString(memoId);
			sql += " AND USER_ID = " + Util.getSqlString(userId);
			Log.out.debug(sql);
			
			DBManager dbManager = DBManager.getInstance();
			ArrayList<ArrayList<Object>> list = dbManager.executeQuery(sql);
			int count = Integer.parseInt(list.get(0).get(0).toString());
			
			sql = "";
			
			if (count > 0)
			{
    			sql = "UPDATE MEMO SET";
    			sql += " MEMO_CONTENT = '" + memoContent + "', CATEGORY = '" + memoCategory + "'";
    			sql += " WHERE PRESCRIPTION_ID = " + Util.getSqlString(prescriptionId);
    			sql += " AND ID = " + Util.getSqlString(memoId);
    			Log.out.debug(sql);
//    			DBManager.getInstance().updateQuery(connResource, sql);
    			DBManager.getInstance().updateQuery(sql);
			}
			else 
			{
				sql = "INSERT INTO MEMO (ID, PRESCRIPTION_ID, USER_ID, MEMO_CONTENT, CATEGORY) ";
				sql += "VALUES (" + Util.getSqlString(memoId) + ", " + Util.getSqlString(prescriptionId) + ", " + Util.getSqlString(userId) + ", " + Util.getSqlString(memoContent) + ", " + Util.getSqlString(memoCategory) + ")";
				Log.out.debug(sql);
//				DBManager.getInstance().updateQuery(connResource, sql);
				DBManager.getInstance().updateQuery(sql);
			}
			
			if (day != null && !day.equals("")) {
				day = day.replaceAll("³â |¿ù ", "-");
				day = day.replaceAll("ÀÏ", "");
			}
			
			String[] dateArr = day.split("-");
			String yearStr = dateArr[0];
			String monthStr = dateArr[1];
			String dateStr = dateArr[2];
			
			int year = 0;
			int month = 0;
			int date = 0;
			int firstWeek = 0;
			int lastDate = 0;

			Calendar cal = Calendar.getInstance();
			cal.set(Integer.parseInt(yearStr), (Integer.parseInt(monthStr) - 1), Integer.parseInt(dateStr));

			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH);
			date = cal.get(Calendar.DATE);
			lastDate = cal.getActualMaximum(Calendar.DATE);
			cal.set(Calendar.DATE, 1);
			firstWeek = cal.get(Calendar.DAY_OF_WEEK);
			if (userId != null & prescriptionId != null) {
				if (!userId.equals("") & !prescriptionId.equals("")) {
					String tmpMonth = "";
					if (month < 9) {
						tmpMonth += "0";
					}
					tmpMonth += (month + 1);
					String startDate = "" + year + tmpMonth + "01 0000";
					String endDate = "" + year + tmpMonth + lastDate + " 2359";
					ArrayList<ScheduleInfo> schedules = ScheduleManager.getInstance().getSchedules(userId, prescriptionId, startDate, endDate, hospital);
					Hashtable<String, ArrayList<ScheduleInfo>> scheduleHash = this.makeDetailScheduleInfo(schedules);
					req.setAttribute("scheduleHash", scheduleHash);
				}
			}
			
			sql = "";
			sql += "SELECT * FROM CATEGORY_TYPE";
			Log.out.debug(sql);
			ArrayList<ArrayList<Object>> categorylist = DBManager.getInstance().executeQuery(sql);
			
			ArrayList<CategoryInfo> categoryInfoList = new ArrayList<CategoryInfo>();;
			for (ArrayList<Object> rows : categorylist) 
			{
				int i = 0;
				CategoryInfo categoryInfo = new CategoryInfo();
				categoryInfo.setCategory_code(rows.get(i++).toString());
				categoryInfo.setCategory_name(rows.get(i++).toString());
				
				categoryInfoList.add(categoryInfo);
			}

			req.setAttribute("category", categoryInfoList);
			req.setAttribute("year", String.valueOf(year));
			req.setAttribute("month", String.valueOf(month + 1));
			req.setAttribute("date", String.valueOf(date));
			req.setAttribute("firstDay", String.valueOf(firstWeek));
			req.setAttribute("lastDate", String.valueOf(lastDate));
			
    			
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
	
	public Hashtable<String, ArrayList<ScheduleInfo>> makeDetailScheduleInfo(ArrayList<ScheduleInfo> schedules) {
		Hashtable<String, ArrayList<ScheduleInfo>> scheduleHash = new Hashtable<String, ArrayList<ScheduleInfo>>();
		for (int i = 0; i < schedules.size(); i++) {
			ScheduleInfo scheduleInfo = schedules.get(i);
			SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd HHmm");
			SimpleDateFormat formatter2 = new SimpleDateFormat("d");
			ParsePosition pos = new ParsePosition(0);
			Date frmTime = formatter1.parse(scheduleInfo.getAlarmStart(), pos);
			String day = formatter2.format(frmTime);
			if (!scheduleHash.containsKey(day)) {
				ArrayList<ScheduleInfo> tmpSchedules = new ArrayList<ScheduleInfo>();
				scheduleHash.put(day, tmpSchedules);
			}

			ArrayList<ScheduleInfo> tmpSchedules = scheduleHash.get(day);
			tmpSchedules.add(scheduleInfo);
			scheduleHash.put(day, tmpSchedules);
		}
		return scheduleHash;
	}
}
