package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class CheckPrescriptionIdCommand implements Command {

	private String next = "";

	public CheckPrescriptionIdCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);

			boolean result = PrescriptionManager.getInstance().checkPrescriptioin(prescriptionId, hospital);
			if (!result) {
				req.setAttribute("result", String.valueOf(result));
				req.setAttribute("beforePage", "checkPrescriptionId");
				req.setAttribute("msg", hospital + "���� " + prescriptionId + "ó���ȣ�� ������Դϴ�.");
			}
			return next;
		} catch (Exception ex) {
			req.setAttribute("beforePage", "checkPrescriptionId");
			req.setAttribute("msg", "ó�� ��ȣ�� Ȯ�� �� �� �����ϴ�.");
		}
		return next;

	}

}
