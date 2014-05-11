package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;

public class LoadAddPrescriptionCommand implements Command {

	private String next = "";

	public LoadAddPrescriptionCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {

			String prescriptionId = "" + System.currentTimeMillis();
			while (!PrescriptionManager.getInstance().checkPrescriptioin(prescriptionId)) {
				prescriptionId = "" + System.currentTimeMillis();
			}

			req.setAttribute("prescriptionId", prescriptionId);
			return next;

		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
