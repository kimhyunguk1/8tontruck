package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class DeletePrescriptionCommand implements Command {

	private String next = "";

	public DeletePrescriptionCommand(String next) {
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
			if (name != null && !name.equals("")) {
				name = Util.toString(name.trim());
			}
			String status = req.getParameter("_status");

			PrescriptionManager.getInstance().delPrescription(delPrescriptionId, userId, status, hospital);

//			ArrayList<PrescriptionInfo> prescriptionList = PrescriptionManager.getInstance().getPrescriptionList(id, name, prescriptionId, startDate, endDate, takenSatus, pillBoxId, disease, loginId);
//			req.setAttribute("prescriptionList", prescriptionList);
			
			req.setAttribute("beforePage", "DeletePrescription");
			req.setAttribute("msg", "삭제 되었습니다.");
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

}
