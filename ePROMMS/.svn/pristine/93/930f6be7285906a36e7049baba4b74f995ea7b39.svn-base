package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadPrescriptionListCommand implements Command {

	private String next = "";

	public LoadPrescriptionListCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String loginId = req.getParameter("_loginId");
			String prescriptionId = req.getParameter("_prescriptionId");
			prescriptionId = Util.toString(prescriptionId);

			ArrayList<PrescriptionInfo> prescriptions = PrescriptionManager.getInstance().getPrescriptionList(null, null, prescriptionId, null, null, null, null, null, loginId, null,null);
			req.setAttribute("prescriptions", prescriptions);
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

}
