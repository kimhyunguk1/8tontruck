package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import jxl.write.DateTime;

import com.sun.org.apache.xerces.internal.impl.xs.SubstitutionGroupHandler;
import com.sun.security.auth.UserPrincipal;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.db.DBManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadTotalListJQGridCommand implements Command {

	private String next = "";

	public LoadTotalListJQGridCommand(String next) {
		this.next = next;
	}



	public String execute(HttpServletRequest req) throws CommandException {
		try {
			
			String colNames="";
			String colModels="";			
			StringBuffer takenRows =new StringBuffer();
			
			
			
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			String type = req.getParameter("_type");
			String userName = req.getParameter("_userName");
			userName = Util.toString(userName);
			String searchDate = req.getParameter("_date");
			searchDate = Util.toString(searchDate);			

			req.setAttribute("searchDate", searchDate);
			req.setAttribute("userId", userId);
			req.setAttribute("userName", userName);
			req.setAttribute("type", type);

			String sql = "SELECT MEMBER_ID FROM PRESCRIPTION ";
			sql += " WHERE PHARMACY not in ('dhong')";
			sql += " GROUP BY MEMBER_ID ";

			
			Log.out.debug(sql);

			DBManager dbManager = DBManager.getInstance();
			ArrayList<ArrayList<Object>> userlist = dbManager.executeQuery(sql);

			sql = "";

			int count = userlist.size();

			ArrayList<ArrayList<ScheduleInfo>> totalschedule = new ArrayList<ArrayList<ScheduleInfo>>();

			String minalarm = "";
			String maxalarm = "";
			SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
			SimpleDateFormat formatter = new SimpleDateFormat("dd");
			
			//전체인원의 스케줄 중 가장 빠른 시작날짜와 가장느린 종료날짜 찾기
			for (int y = 0; y < count; y++) {
				  
				sql = "SELECT ";
				sql += "(select alarmstart from SCHEDULES_" + userlist.get(y).get(0).toString() + " order by alarmstart limit 0,1), ";						
				sql += "(select alarmend from SCHEDULES_" + userlist.get(y).get(0).toString() + " order by alarmend desc limit 0,1) ";			
				sql += "FROM DUAL";

				Log.out.debug(sql);		
				ArrayList<ArrayList<Object>> maxmindate = dbManager.executeQuery(sql);

				for (ArrayList<Object> rows : maxmindate) {					
					if (minalarm.equals(""))
						minalarm = rows.get(0).toString().substring(0, 8);
					if (maxalarm.equals(""))
						maxalarm = rows.get(1).toString().substring(0, 8);

					Date date1 = format.parse(minalarm, new ParsePosition(0));
					Date date2 = format.parse(rows.get(0).toString().substring(0, 8), new ParsePosition(0));
					if (date2.before(date1))
						minalarm = rows.get(0).toString().substring(0, 8);

					date1 = format.parse(maxalarm, new ParsePosition(0));
					date2 = format.parse(rows.get(1).toString().substring(0, 8), new ParsePosition(0));
					if (date2.after(date1))
						maxalarm = rows.get(1).toString().substring(0, 8);
				}
			}

			colNames="\"colnames\" : [\"이름\", ";
			colModels="\"colmodels\" : [";
			colModels += "{ \"name\":\"name\",\"index\":\"name\",\"frozen\" : true,\"align\":\"center\",\"width\":\"70\"},";			
			//모든스케줄에서 가장빠른스케줄시간
			Date date1 = format.parse(minalarm, new ParsePosition(0));
			Date today = new Date();
			Calendar _today = Calendar.getInstance();
			_today.setTime(today);
			Calendar mindate1 = Calendar.getInstance();
			mindate1.setTime(date1);
			while(_today.after(mindate1)){								
				colNames += "\""+formatter.format(mindate1.getTime())+"\",";
				colModels += "{\"name\":\"a"+format.format(mindate1.getTime())+"\",\"index\":\""+format.format(mindate1.getTime())+"\", \"width\":\"25\",\"align\":\"center\"},";
												
				mindate1.add(Calendar.DATE,1);
			}
			colNames = colNames.substring(0, colNames.length()-1);
			colNames +="],";
			colModels = colModels.substring(0,colModels.length()-1);
			colModels += "],";
			
			
			
			takenRows.append("\"takenRows\" : [");
			for (int y = 0; y < count; y++) {

				sql = "SELECT (SELECT NAME FROM MEMBER WHERE ID = '" + userlist.get(y).get(0).toString() + "'), PRESCRIPTION_ID, PRESCRIPTION_HOSPITAL, ALARMSTART, ALARMEND, TAKENORDER, CONTAINERNO, TAKENSTATUS, TAKENTIME";
				sql += " FROM SCHEDULES_" + userlist.get(y).get(0).toString();
				sql += " WHERE SUBSTR(ALARMSTART,1,8) <= DATE_FORMAT(now(),'%Y%m%d')";
				sql += " ORDER BY ALARMSTART";

				Log.out.debug(sql);

				ArrayList<ScheduleInfo> individualschedule = new ArrayList<ScheduleInfo>();
				ArrayList<ArrayList<Object>> userPrescriptionTotallist = dbManager.executeQuery(sql);

				int count1 = userPrescriptionTotallist.size();
				
				
				if(count1  <= 0){
					continue;
				}					
				String individualminalarm = (String) userPrescriptionTotallist.get(0).get(3).toString();
				takenRows.append("{\"name\":\""+userPrescriptionTotallist.get(0).get(0).toString()+"\",");
				
				
				
	
				Calendar mindate = Calendar.getInstance();
				mindate.setTime(date1);
				for (ArrayList<Object> rows : userPrescriptionTotallist) {		
					
					
					//현재row의 알람시간
					Date date2 = format.parse(rows.get(3).toString().substring(0, 8), new ParsePosition(0));	
					Calendar individual_mindate = Calendar.getInstance();
					
					individual_mindate.setTime(date2); //20111001
					
					
					while (individual_mindate.after(mindate)) {						
						Date dt = mindate.getTime();					
						
						ScheduleInfo scheduleInfo = new ScheduleInfo();
						scheduleInfo.setId("blank");
						scheduleInfo.setUserName(rows.get(0).toString());
						scheduleInfo.setPrescription_id("blank");
						scheduleInfo.setHospital("blank");
						scheduleInfo.setAlarmStart(format.format(dt));
						scheduleInfo.setAlarmEnd("blank");
						scheduleInfo.setTakenorder("blank");
						scheduleInfo.setContainerno("blank");
						scheduleInfo.setTakenStatus("blank");
						scheduleInfo.setTakenTime("blank");
						
						takenRows.append("\"a"+format.format(mindate.getTime())+"\":\" \",");
						// 개개인의 스케줄ArrayList에 추가
						individualschedule.add(scheduleInfo);
						mindate.add(Calendar.DATE,1);
						
					}

					int i = 0;
					ScheduleInfo scheduleInfo = new ScheduleInfo();
					scheduleInfo.setId(userlist.get(y).get(0).toString());
					scheduleInfo.setUserName(rows.get(i++).toString());
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
					if(scheduleInfo.getTakenStatus().equals("NONE")){
						takenRows.append("\"a"+format.format(mindate.getTime())+"\":\" \",");
					}else{
						takenRows.append("\"a"+format.format(mindate.getTime())+"\":\""+scheduleInfo.getTakenStatus()+"\",");
					}

					// 개개인의 스케줄ArrayList에 추가
					individualschedule.add(scheduleInfo);
					mindate.add(Calendar.DATE,1);
				}
				takenRows.setLength(takenRows.length()-1);				
				takenRows.append("},");
				totalschedule.add(individualschedule);
			}			
			takenRows.setLength(takenRows.length()-1);
			takenRows.append("]}");
			
			

			req.setAttribute("maxalarm", maxalarm);
			req.setAttribute("minalarm", minalarm);
			req.setAttribute("totalschedule", totalschedule);
			
			StringBuffer jsonStr = new StringBuffer();			
			
			jsonStr.append("{\"page\" : \"1\",");
			jsonStr.append("\"total\" : 2,");		
			jsonStr.append("\"records\" : \"11\",");
			jsonStr.append(colNames);
			jsonStr.append(colModels);
			jsonStr.append(takenRows.toString());			
			
			return jsonStr.toString();
			
			
			
			
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
