package kr.re.etri.lifeinfomatics.promes.main;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Enumeration;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;

import kr.re.etri.lifeinfomatics.promes.cmd.AjaxCheckPillBoxCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.CheckIdCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.CheckPillBoxCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.CheckUsePillBoxCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.JoinCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.LoadCalendarCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.LoadChartCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.LoadJoinCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.LoadPillBoxListCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.LoginCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.ModifyScheduleCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.SMSSendMessageCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.SaveReportCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.SearchPostCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.cmd.common.NullCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.AddPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.CheckPrescriptionIdCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.DeletePrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.FinishPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadAddPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadDetailScheduleCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadDosageCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadModifyPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadPatientDosageCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadPrescriptionListCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadPrescriptionListCommand1;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadSearchInchargeCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadSearchPrescriptionCommand;
//TBFREE 파일 전송
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadTBFREE_FileSend;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadTakenImageSrcCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadTakensubmitCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadTodayListCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadTotalListCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.LoadTotalListJQGridCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.ModifyDetailScheduleCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.ModifyErrorCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.ModifyMemoScheduleCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.ModifyPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.SearchPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.prescription.UpdateDetailScheduleCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.AddUserInfoCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.AddUserPharmacistCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.DeleteUserInfoCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.LoadAddUserInfoCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.LoadModifyUserInfoCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.LoadSearchUserInfoListCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.LoadUserListPopupCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.LoadUserModifyPopupCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.ModifyUserInfoCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.SearchUserInfoListCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.UserInfoResultCommand;
import kr.re.etri.lifeinfomatics.promes.cmd.user.modifyUserAndPrescriptionCommand;
import kr.re.etri.lifeinfomatics.promes.config.Constants;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.util.Log;

public class PromesServerServlet extends HttpServlet {

	HttpSession session;

	private String error = "home/error.jsp";
	private String sessionmsg = "sessionmsg.jsp";
	private String jspdir = "/";

	private HashMap<String, Command> commandMap;

	public void init(ServletConfig config) {
		try {
			super.init(config);
			Constants.initialize();
			Log.initialize();
			// DBManager.initialize();
			this.initCommandMap();
		} catch (Exception ex) {
			ex.printStackTrace();

			if (Log.out != null) {
				Log.out.fatal("Startup Failure.");
				Log.out.error(ex, ex);
			}
			else {
				System.out.println("Startup Failure.");
				ex.printStackTrace();
			}
		}
	}

	public void service(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Define.REAL_PATH = req.getSession().getServletContext().getRealPath("");
		String cmd = req.getParameter("cmd");
		
		Log.out.debug("> cmd : " + cmd);
		String next = "";
		try {
			Command command = lookupCommand(cmd.trim());

			if (Log.out_debugEnabled) {
				Log.out.debug("############# [ " + command.getClass().getSimpleName() + " ]");

				Enumeration ea = req.getParameterNames();
				String key;
				while (ea.hasMoreElements()) {
					key = ea.nextElement().toString();
					Log.out.debug(key + " : " + req.getParameter(key));
				}
				Log.out.debug("-----------------------------");
			}

			next = command.execute(req);

			if (Log.out_debugEnabled) {
				Log.out.debug("############# [ " + next + " ]");
			}
		} catch (CommandException e) {
			e.printStackTrace();
			req.setAttribute("javax.servlet.jsp.jspException", e);
			next = error;
		} catch ( Exception e )
		{
			e.printStackTrace();
			req.setAttribute("javax.servlet.jsp.jspException", e);
			// next = error;
		}
		if(req.getSession() == null)
		{
			RequestDispatcher rd = getServletContext().getRequestDispatcher(jspdir + "index.jsp");
			
			rd.forward(req, res);
		
		}else{
    		if ( cmd.equals("searchIncharge") || cmd.equals("loadTotalListJQGrid"))
    		{
    			res.setContentType("text/html;charset=utf-8");
    			PrintWriter out = res.getWriter();			
    			out.println(next.toString());
    			out.flush();
    			out.close();
    		}else if(cmd.indexOf("Ajax") > -1){
    			JSONObject jsonObj = new JSONObject();
    			jsonObj.put("result", next);
    			PrintWriter out = res.getWriter();
    			out.println(jsonObj);
    			out.flush();
    			out.close();
    		}
    		else
    		{
    			RequestDispatcher rd = getServletContext().getRequestDispatcher(jspdir + next);
    
    			rd.forward(req, res);
    		}
		}
	}

	private Command lookupCommand(String cmd) throws CommandException {

		// command가 null 이면 메인화면을 보여준다
		if (cmd == null || cmd.equals("") || cmd.equals("null")) {
			cmd = "LoadMainPage";
		}

		// 비회원 접근가능
		if (commandMap.containsKey(cmd)) {
			Object test = commandMap.get(cmd);
			return commandMap.get(cmd);
		}
		else {
			throw new CommandException("Invalid Command Identifier.");
		}
	}

	/**
	 * 필요한 Pasg를 HashMap commandMap에 저장한다.
	 */
	private void initCommandMap() {
		commandMap = new HashMap<String, Command>();
		if (Log.out_infoEnabled) {
			Log.out.info("=====> Set Command Map End");
		}
		
		commandMap.put("demo_join", new JoinCommand("home/common/result.jsp"));
		
		commandMap.put("loadJoinPage", new LoadJoinCommand("home/common/join.jsp"));
		commandMap.put("loadJoinPopupPage", new LoadJoinCommand("home/common/joinPopup.jsp"));
		commandMap.put("join", new JoinCommand("home/common/result.jsp"));
		commandMap.put("loadCalendarPage", new LoadCalendarCommand("home/common/popup_calendar.jsp"));
		commandMap.put("loadPostPage", new NullCommand("home/common/popup_post.jsp"));
		commandMap.put("searchPost", new SearchPostCommand("home/common/post_result.jsp"));
		commandMap.put("checkId", new CheckIdCommand("home/common/popup_id_check.jsp"));
		commandMap.put("login", new LoginCommand(""));
		commandMap.put("smsSendMessage", new SMSSendMessageCommand("home/common/phone_popup_result.jsp"));

		// 사용자 관련 수정, 추가, 삭제
		commandMap.put("loadSearchUserInfoListPage", new LoadSearchUserInfoListCommand("home/management/searchUser.jsp"));
		commandMap.put("loadAddUserInfoPage", new LoadAddUserInfoCommand("home/management/addUser.jsp"));
		commandMap.put("loadModifyUserInfoPage", new LoadModifyUserInfoCommand(""));
		commandMap.put("modifyUser", new ModifyUserInfoCommand("home/common/resultMessage.jsp"));
		commandMap.put("deleteUser", new DeleteUserInfoCommand("home/common/result.jsp"));
		commandMap.put("addUser", new AddUserInfoCommand("home/common/result.jsp"));
		commandMap.put("searchUserInfoList", new SearchUserInfoListCommand(""));
		commandMap.put("checkPillBox", new CheckPillBoxCommand("home/common/result.jsp"));
		commandMap.put("AjaxcheckPillBox", new AjaxCheckPillBoxCommand(""));
		commandMap.put("checkUsePillBox", new CheckUsePillBoxCommand("home/common/result.jsp"));
		commandMap.put("addUserPharmacist", new AddUserPharmacistCommand("home/management/addUser_pharmacist.jsp"));
		commandMap.put("LoadUserModifyPopupPage", new LoadUserModifyPopupCommand(""));
		commandMap.put("modifyUserAndPrescription", new modifyUserAndPrescriptionCommand("home/common/result.jsp"));

		// 스케쥴 관련
		//ePROMMS 3.0 prescriptionList
		commandMap.put("LoadPrescriptionList", new LoadPrescriptionListCommand1(""));
		
		commandMap.put("userInfoResult", new UserInfoResultCommand("home/user/userInfoResult.jsp"));
		commandMap.put("loadAddPrescriptionPage", new LoadAddPrescriptionCommand("home/prescription/addPrescription.jsp"));
		commandMap.put("loadAddPrescriptionInAddUserPage", new LoadAddPrescriptionCommand("home/management/addPrescription_In_addUser.jsp"));
		commandMap.put("loadSearchPrescriptionPage", new LoadSearchPrescriptionCommand(""));
		commandMap.put("loadTodayListPage", new LoadTodayListCommand(""));
		commandMap.put("loadTotalListPage", new LoadTotalListCommand(""));
		commandMap.put("loadPillBoxListPage", new LoadPillBoxListCommand("home/prescription/pillBoxlist_popup.jsp"));

		commandMap.put("addPrescription", new AddPrescriptionCommand("home/prescription/prescriptionDosage.jsp"));
		commandMap.put("deletePrescription", new DeletePrescriptionCommand("home/common/result.jsp"));
		commandMap.put("modifyPrescription", new ModifyPrescriptionCommand("home/prescription/modifyPrescription.jsp"));
		commandMap.put("searchPrescriptionPage", new SearchPrescriptionCommand(""));
		commandMap.put("loadModifyPrescriptionPage", new LoadModifyPrescriptionCommand(""));
		commandMap.put("loadPrescriptionListPage", new LoadPrescriptionListCommand("home/pharmacist/prescriptionList_popup.jsp"));
		commandMap.put("loadUserListPopupPage", new LoadUserListPopupCommand("home/user/userList_popup.jsp"));
		commandMap.put("loadDetailSchedulePage", new LoadDetailScheduleCommand("home/common/dosageCalendar.jsp"));
		commandMap.put("modifyDetailSchedule", new ModifyDetailScheduleCommand("home/patient/patientDosage.jsp"));
		commandMap.put("loadPatientDosagePage", new LoadPatientDosageCommand("home/patient/patientDosage.jsp"));
		commandMap.put("loadDosagePage", new LoadDosageCommand("home/prescription/prescriptionDosage.jsp"));
		commandMap.put("checkPrescriptionId", new CheckPrescriptionIdCommand("home/common/result.jsp"));
		commandMap.put("finishPrescription", new FinishPrescriptionCommand("home/common/result.jsp"));

		commandMap.put("updateDetailSchedule", new UpdateDetailScheduleCommand("home/common/dosageCalendar.jsp"));
		commandMap.put("loadChartPage", new LoadChartCommand("home/common/dosageChart.jsp"));
		commandMap.put("saveReportPage", new SaveReportCommand(""));
		
		commandMap.put("updateMemo", new ModifyMemoScheduleCommand("home/common/dosageCalendar.jsp"));
		commandMap.put("updateError", new ModifyErrorCommand("home/common/dosageCalendar.jsp"));		
		commandMap.put("loadTakensubmit", new LoadTakensubmitCommand(""));
		commandMap.put("loadTakenImageSrc", new LoadTakenImageSrcCommand(""));
		commandMap.put("searchIncharge", new LoadSearchInchargeCommand(""));
		commandMap.put("loadTotalListJQGrid", new LoadTotalListJQGridCommand(""));
		
		//TBFREE 전송		
		commandMap.put("TBFREE_FileSend", new LoadTBFREE_FileSend(""));
		
		
		
		//commandMap.put("todayPatientList", new LodetodayPatientListCommand("home/common/dosageCalendar.jsp"));
		
		
		//스케쥴 수정애 쓰는 임시 명령
		commandMap.put("addJeyun", new ModifyScheduleCommand(""));
		
		// 장비 관련
		commandMap.put("showDeviceState", null);
	}

	/** @todo Servlet를 종료하기위해서 필요한 과정을 적는 곳 */
	public void destroy() {
	}
}
