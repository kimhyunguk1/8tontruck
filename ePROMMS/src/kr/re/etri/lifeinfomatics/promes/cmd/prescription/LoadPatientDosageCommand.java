package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadPatientDosageCommand implements Command {

	private String next = "";

	public LoadPatientDosageCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			ArrayList<PrescriptionInfo> prescriptions = PrescriptionManager.getInstance().getPrescriptionToUserId(userId);
			PrescriptionInfo prescriptionInfo = null;
			if (prescriptions.size() > 0) {
				boolean bool = false;
				for (PrescriptionInfo tmpPrescriptionInfo : prescriptions) {
					if (!bool && tmpPrescriptionInfo.getStatus().equals(Define.PRESCRIPTION_SATUS_ON)) {
						prescriptionInfo = PrescriptionManager.getInstance().getPrescription(tmpPrescriptionInfo.getId(), tmpPrescriptionInfo.getHospital());
						bool = true;
					}
					else {
						if (prescriptionInfo == null) {
							prescriptionInfo = PrescriptionManager.getInstance().getPrescription(tmpPrescriptionInfo.getId(), tmpPrescriptionInfo.getHospital());
						}
					}
				}
			}

			if (prescriptionId != null && !prescriptionId.equals("")) {
				prescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
			}

			// 환자 정보
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			req.setAttribute("prescriptionInfo", prescriptionInfo);
			req.setAttribute("prescriptions", prescriptions);
			req.setAttribute("userInfo", userInfo);
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
