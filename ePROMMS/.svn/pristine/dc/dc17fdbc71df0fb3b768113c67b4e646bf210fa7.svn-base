package kr.re.etri.lifeinfomatics.promes.cmd;

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

public class ModifyScheduleCommand implements Command {

	private String next = "";

	public ModifyScheduleCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			
//			ConnectionResource connResource = DBManager.getInstance().getConnection();
			
			String sql = "";
			
			DBManager dbManager = DBManager.getInstance();
			int a = 20111023;
			for (int i = 30 ; i < 1000 ; i++)
			{
				String s = "";
				if (i < 10)
				{
					s = "00" + i;
				}
				else if (i < 100)
				{
					s = "0" + i;
				}
				else
				{
					s = i + "";
				}
				
				if (a == 20111032)
				{
					a = 20111101;
				}
				
				if (a == 20111131)
				{
					a = 20111201;
				}
				
				if (a == 20111232)
				{
					a = 20120101;
				}
				
				if (a == 20120132)
				{
					a = 20120201;
				}
				
				if (a == 20120230)
				{
					return "";
				}
				
    			sql = "INSERT INTO SCHEDULES_bjg (ID, PRESCRIPTION_ID, PRESCRIPTION_HOSPITAL, ALARMSTART, ALARMEND, TAKENORDER, CONTAINERNO, TAKENSTATUS) ";
    			sql += "VALUES (" + Util.getSqlString(s) + ", '1316601856218', '동국대경주병원', " + Util.getSqlString(a + " 0640") + ", " + Util.getSqlString(a + " 0700") + ", '1', '1', 'NONE')";
    			Log.out.debug(sql);
    			a++;
//    			DBManager.getInstance().updateQuery(connResource, sql);
    			DBManager.getInstance().updateQuery(sql);
			}
    			
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
