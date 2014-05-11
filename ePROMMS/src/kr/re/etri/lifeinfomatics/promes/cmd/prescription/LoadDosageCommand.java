package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadDosageCommand implements Command {

	private String next = "";

	public LoadDosageCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			
			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			//hospital = Util.toString(hospital);

			if (prescriptionId != null && !prescriptionId.equals("")) {
				// 스케쥴 정보
				PrescriptionInfo prescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
				// 환자 정보
				String userId = prescriptionInfo.getMember_id();
				UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
				req.setAttribute("prescriptionInfo", prescriptionInfo);
				req.setAttribute("userInfo", userInfo);
			}
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
