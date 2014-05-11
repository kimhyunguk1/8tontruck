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

public class ModifyDetailScheduleCommand implements Command {

	private String next = "";

	public ModifyDetailScheduleCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);
			String startDate = req.getParameter("_startDate");
			startDate = Util.toString(startDate);
			startDate = startDate.replaceAll("년 |월 ", "-");
			startDate = startDate.replaceAll("일", "");
			String startTakenOrder = req.getParameter("_startTakenOrder");
			String endDate = req.getParameter("_endDate");
			endDate = Util.toString(endDate);
			endDate = startDate.replaceAll("년 |월 ", "-");
			endDate = endDate.replaceAll("일", "");
			String endTakenOrder = req.getParameter("_endTakenOrder");

			PrescriptionInfo prescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
			prescriptionInfo.setStartDate(startDate);
			prescriptionInfo.setStartTakenOrder(startTakenOrder);
			prescriptionInfo.setEndDate(endDate);
			prescriptionInfo.setEndTakenOrder(endTakenOrder);

			boolean today = false;
			if (startDate != null && !startDate.equals("")) {
				if (Util.getToday("yyyy-MM-dd").equals(startDate)) {
					today = true;
				}
			}

			if (today) {
				prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_READY);
			}
			else {
				prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_READY);
			}

			PrescriptionManager.getInstance().modifyPrescription(prescriptionInfo, true, false, false, "1");

			PrescriptionInfo newPrescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
			// 환자 정보
			String userId = prescriptionInfo.getMember_id();
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);

			ArrayList<PrescriptionInfo> prescriptions = PrescriptionManager.getInstance().getPrescriptionToUserId(userId);

			req.setAttribute("prescriptionInfo", newPrescriptionInfo);
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
