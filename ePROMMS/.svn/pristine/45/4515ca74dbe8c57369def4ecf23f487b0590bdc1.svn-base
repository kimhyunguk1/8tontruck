package kr.re.etri.lifeinfomatics.promes.cmd.prescription;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.TakenOrderProperty;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PillBoxManager;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadModifyPrescriptionCommand implements Command {

	private String next = "";

	public LoadModifyPrescriptionCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String type = req.getParameter("_type");
			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);

			// 스케쥴 정보
			PrescriptionInfo prescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
			// 환자 정보
			String userId = prescriptionInfo.getMember_id();
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			// 약상자 정보
			String pillBoxId = prescriptionInfo.getPillBox_id();
			ArrayList<PillBoxInfo> pillBoxs = PillBoxManager.getInstance().getPillBoxList(userId, pillBoxId);
			PillBoxInfo pillBoxInfo = this.useContainerNumber(pillBoxs, prescriptionId, prescriptionInfo.getStatus());
			// 약복용 시간 정보
			String takenOrderProperties = prescriptionInfo.getTakenOrderProperties();
			takenOrderProperties = takenOrderProperties.replace("[", "");
			ArrayList<String> takenOrderPropertysArr = Util.split("]", takenOrderProperties);
			ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(takenOrderPropertysArr);
			takenOrderPropertyList = this.makeTakenOrderProperty(takenOrderPropertyList, userInfo);
			prescriptionInfo.setTakenOrderPropertyList(takenOrderPropertyList);
			req.setAttribute("prescriptionInfo", prescriptionInfo);
			req.setAttribute("userInfo", userInfo);
			req.setAttribute("pillBoxInfo", pillBoxInfo);
			if (type.equals(Define.USER_PATIENT)) {
				return "home/patient/detailSchedules.jsp";
			}
			else {
				return "home/prescription/modifyPrescription.jsp";
			}
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

	private ArrayList<TakenOrderProperty> makeTakenOrderProperty(ArrayList<TakenOrderProperty> takenOrderPropertyList, UserInfo userInfo) throws Exception {
		ArrayList<TakenOrderProperty> newTakenOrderPropertyList = new ArrayList<TakenOrderProperty>();
		ArrayList<String> timeList = new ArrayList<String>();
		timeList.add(userInfo.getMorningStart().replace(":", ""));
		timeList.add(userInfo.getMorningEnd().replace(":", ""));
		timeList.add(userInfo.getNoonStart().replace(":", ""));
		timeList.add(userInfo.getNoonEnd().replace(":", ""));
		timeList.add(userInfo.getEveningStart().replace(":", ""));
		timeList.add(userInfo.getEveningEnd().replace(":", ""));
		timeList.add(userInfo.getNightStart().replace(":", ""));
		timeList.add(userInfo.getNightEnd().replace(":", ""));

		for (int i = 0; i < takenOrderPropertyList.size(); i++) {
			TakenOrderProperty takenOrderProperty = takenOrderPropertyList.get(i);
			String startTime = takenOrderProperty.getStartTime();
			int tmpIdx = timeList.indexOf(startTime);
			if (tmpIdx > -1) {
				if (tmpIdx % 2 == 0) {
					takenOrderProperty.setStartAlarm("1");
				}
				else {
					takenOrderProperty.setStartAlarm("3");
				}
				if(tmpIdx == 7 ){
					takenOrderProperty.setEatTime("4");
				}else{
					takenOrderProperty.setEatTime("" + (tmpIdx / 2));
				}
			}
			else {
				String tmpTime = Util.addMinute(startTime, 30);
				tmpIdx = timeList.indexOf(tmpTime);

				if (tmpIdx > -1 && tmpIdx % 2 == 0) {
					takenOrderProperty.setStartAlarm("0");
					takenOrderProperty.setEatTime("" + (tmpIdx / 2));
				}
				else {
					tmpTime = Util.addMinute(startTime, -30);
					tmpIdx = timeList.indexOf(tmpTime);
					if (tmpIdx > -1 && tmpIdx % 2 == 1 && tmpIdx != 7) {
						takenOrderProperty.setStartAlarm("4");
						takenOrderProperty.setEatTime("" + (tmpIdx / 2));
					}
					else {
						takenOrderProperty.setEatTime("4");
					}
				}
			}
			newTakenOrderPropertyList.add(takenOrderProperty);
		}
		return newTakenOrderPropertyList;
	}

	private PillBoxInfo useContainerNumber(ArrayList<PillBoxInfo> pillBoxs, String prescriptionId, String status) throws Exception {
		PillBoxInfo outPillBox = null;
		for (PillBoxInfo pillBoxInfo : pillBoxs) {
			if (pillBoxInfo.getPrescriptionId() != null && !pillBoxInfo.getPrescriptionId().equals("")) {
				if (outPillBox == null) {
					outPillBox = new PillBoxInfo();
					outPillBox.setId(pillBoxInfo.getId());
					outPillBox.setType(pillBoxInfo.getType());
					outPillBox.setContainerNumber(pillBoxInfo.getContainerNumber());
					ArrayList<String> useContainer = new ArrayList<String>();
					for (int i = 1; i <= outPillBox.getContainerNumber(); i++) {
						useContainer.add("" + i);
					}
					outPillBox.setUseContainer(useContainer);
				}
				if (!status.equals(Define.PRESCRIPTION_SATUS_FINISH)) {
					if (!pillBoxInfo.getPrescriptionId().equals(prescriptionId)) {
						String takenOrderProperties = pillBoxInfo.getTakenOrderproperties();
						takenOrderProperties = takenOrderProperties.replace("[", "");
						ArrayList<String> list = Util.split("]", takenOrderProperties);
						ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(list);

						if (!pillBoxInfo.getStatus().equals(Define.PRESCRIPTION_SATUS_FINISH)) {
							ArrayList<String> useContainer = outPillBox.getUseContainer();
							for (TakenOrderProperty takenOrderProperty : takenOrderPropertyList) {
								useContainer.remove("" + takenOrderProperty.getContainer());
							}
							outPillBox.setUseContainer(useContainer);
						}
					}
				}
			}
		}
		return outPillBox;
	}
}
