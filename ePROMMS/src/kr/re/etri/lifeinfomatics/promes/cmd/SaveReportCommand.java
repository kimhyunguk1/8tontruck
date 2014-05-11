package kr.re.etri.lifeinfomatics.promes.cmd;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.ExcelManager;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.ScheduleManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class SaveReportCommand implements Command {

	private String next = "";

	public SaveReportCommand(String next) {
		this.next = next;
	}

	@Override
	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			String prescriptionId = Util.toLowerCase(req.getParameter("_prescriptionId"));
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);

			PrescriptionInfo prescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			ArrayList<ScheduleInfo> schedules = ScheduleManager.getInstance().getSchedules(userId, prescriptionInfo.getId(), prescriptionInfo.getStartDate().replace("-", "") + "0000", prescriptionInfo.getEndDate().replace("-", "") + "2359", prescriptionInfo.getHospital());

			String fileName = ExcelManager.getInstance().makeExcel(userInfo, prescriptionInfo, schedules);
			return "chart/" + fileName;
		} catch (Exception e) {
			Log.out.error(e, e);
			req.setAttribute("message", e.getMessage());
			return "home/error.jsp";
		}
	}

}
