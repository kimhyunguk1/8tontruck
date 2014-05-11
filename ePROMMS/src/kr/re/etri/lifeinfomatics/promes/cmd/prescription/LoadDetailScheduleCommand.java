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
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.mgr.ScheduleManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadDetailScheduleCommand implements Command {

	private String next = "";

	public LoadDetailScheduleCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String userId = req.getParameter("_userId");
			//userId = Util.toString(userId);
			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			//hospital = Util.toString(hospital);
			String yearStr = req.getParameter("_year");
			String monthStr = req.getParameter("_month");
			Calendar cal = Calendar.getInstance();
			int year = 0;
			int month = 0;
			int date = 0;
			int firstWeek = 0;
			int lastDate = 0;
			int toDayDate = cal.get(Calendar.DATE);
			if (yearStr != null && monthStr != null && !yearStr.equals("") && !monthStr.equals("")) {
				cal.set(Integer.parseInt(yearStr), (Integer.parseInt(monthStr) - 1), 1);
			}
			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH);
			lastDate = cal.getActualMaximum(Calendar.DATE);
			if(lastDate < toDayDate){
				date = lastDate;
			}else{
				date = cal.get(Calendar.DATE);
			}
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
			
			String sql = "";
			sql += "SELECT * FROM CATEGORY_TYPE";
			Log.out.debug(sql);
			ArrayList<ArrayList<Object>> list = DBManager.getInstance().executeQuery(sql);
			
			ArrayList<CategoryInfo> categoryInfoList = new ArrayList<CategoryInfo>();;
			for (ArrayList<Object> rows : list) 
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
