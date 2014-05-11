package kr.re.etri.lifeinfomatics.promes.cmd;

import java.util.ArrayList;
import java.util.Arrays;

import javax.servlet.http.HttpServletRequest;


import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PillBoxManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class AjaxCheckPillBoxCommand implements Command {

	private String next = "";

	public AjaxCheckPillBoxCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String takenBoxId = req.getParameter("_takenBoxId");
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);

			boolean result = PillBoxManager.getInstance().checkUsePillBox(takenBoxId);
			if (!result && userId != null && !userId.equals("")) {
				UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
				ArrayList<String> pillBoxIdList =  new ArrayList<String>(Arrays.asList(userInfo.getPillBoxsStr().split("/")));
				result = pillBoxIdList.contains(takenBoxId);
			}
			
			ArrayList<String> tmpPillBoxs = new ArrayList<String>();
			tmpPillBoxs.add(takenBoxId);
			boolean prescriptionChk = PillBoxManager.getInstance().checkPrescription(userId);
			if(prescriptionChk)
				return "used Schedule";
			boolean takenboxIdchk = PillBoxManager.getInstance().checkTakePillBoxs(tmpPillBoxs);
			if(takenboxIdchk)
				return "used Pillbox";
			
//			req.setAttribute("takenboxIdchk", String.valueOf(takenboxIdchk));
//			req.setAttribute("result", String.valueOf(result));
//			req.setAttribute("beforePage", "AddPillBox");
			
			return String.valueOf(takenboxIdchk);
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
