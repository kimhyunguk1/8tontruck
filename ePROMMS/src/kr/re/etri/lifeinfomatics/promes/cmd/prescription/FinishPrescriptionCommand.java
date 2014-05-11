package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class FinishPrescriptionCommand implements Command {

	private String next = "";

	public FinishPrescriptionCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String delPrescriptionId = req.getParameter("_delPrescriptionId");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);
			String loginId = req.getParameter("_loginId");
			loginId = Util.toString(loginId);
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			String name = req.getParameter("_name");
			if (name != null && !name.equals("")) {
				name = Util.toString(name.trim());
			}
			String startDate = req.getParameter("_startDate");
			if (startDate != null && !startDate.equals("")) {
				startDate = Util.toString(startDate);
			}
			String status = req.getParameter("_status");
			if(status.equals("STOP")){
				PrescriptionManager.getInstance().stopPrescription(delPrescriptionId, userId, status, hospital);
				req.setAttribute("msg", "Stopped.");
			}else{
				PrescriptionManager.getInstance().finishPrescription(delPrescriptionId, userId, status, hospital);
				req.setAttribute("msg", "Finished.");
			}			

			req.setAttribute("beforePage", "FinishPrescription");
			
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
