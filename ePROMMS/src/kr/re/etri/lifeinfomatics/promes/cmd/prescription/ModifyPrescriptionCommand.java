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

public class ModifyPrescriptionCommand implements Command {

	private String next = "";

	public ModifyPrescriptionCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {

			String prescriptionId = req.getParameter("_prescriptionId");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			String userName = req.getParameter("_userName");
			userName = Util.toString(userName);
			String pillBoxId = req.getParameter("_pillBoxId");
			String pillBoxType = req.getParameter("_pillBoxType");
			pillBoxType = Util.toString(pillBoxType);
			String totalDays = req.getParameter("_totalDays");
			String frequency = req.getParameter("_frequency");
			String disease = req.getParameter("_disease");
			disease = Util.toString(disease.trim());
			String direction = req.getParameter("_direction");
			direction = Util.toString(direction.trim());
			String startDate = req.getParameter("_startDate");
			startDate = Util.toString(startDate);
			if (startDate != null && !startDate.equals("")) {
				startDate = startDate.replaceAll("년 |월 ", "-");
				startDate = startDate.replaceAll("일", "");
			}
			String startTakenOrder = req.getParameter("_startTakenOrder");
			String endDate = req.getParameter("_endDate");
			endDate = Util.toString(endDate);
			if (endDate != null && !endDate.equals("")) {
				endDate = endDate.replaceAll("년 |월 ", "-");
				endDate = endDate.replaceAll("일", "");
			}
			String endTakenOrder = req.getParameter("_endTakenOrder");
			String takenOrderProperties = req.getParameter("_takenOrderProperties");

			PrescriptionInfo oldPrescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);

			PrescriptionInfo prescriptionInfo = new PrescriptionInfo();
			prescriptionInfo.setId(prescriptionId);
			prescriptionInfo.setHospital(hospital);
			prescriptionInfo.setMember_id(userId);
			prescriptionInfo.setPillBox_id(pillBoxId);
			prescriptionInfo.setPharmacy(oldPrescriptionInfo.getPharmacy());
			prescriptionInfo.setTotalDays(Integer.parseInt(totalDays));
			prescriptionInfo.setFrequency(Integer.parseInt(frequency.replace("회", "")));
			prescriptionInfo.setPillBox_type(pillBoxType);
			if (disease != null && !disease.trim().equals("")) {
				prescriptionInfo.setDisease(disease.trim());
			}
			if (direction != null && !direction.trim().equals("")) {
				prescriptionInfo.setDirection(direction.trim());
			}
			prescriptionInfo.setStartDate(startDate);
			prescriptionInfo.setStartTakenOrder(startTakenOrder);
			prescriptionInfo.setEndDate(endDate);
			prescriptionInfo.setEndTakenOrder(endTakenOrder);
			prescriptionInfo.setTakenOrderProperties(takenOrderProperties);
			prescriptionInfo.setStatus(oldPrescriptionInfo.getStatus());
			prescriptionInfo.setDetailSchedule(oldPrescriptionInfo.getDetailSchedule());
			prescriptionInfo.setLastUpdatedDateOfSchedule("");

			boolean today = false;
			boolean makeSchedule = false;
			boolean deleteSchedule = false;
			boolean updateSchedule = false;
			boolean changeStartDate = false;
			String isSchedule = "0";
			if (startDate != null && !startDate.equals("")) {
				if (Util.getToday("yyyy-MM-dd").equals(startDate)) {
					today = true;
				}
			}

			if (oldPrescriptionInfo.getStartDate() == null && !oldPrescriptionInfo.getStartDate().equals("")) {
				// 1. 이전 처방에 시작 날짜가 없을 경우
				// 1-1. 수정 처방에 시작 날짜가 없을 경우(처리 없음)
				// 1-2. 수정 처방에 시작 날짜가 있을 경우
				if (startDate != null && !startDate.equals("")) {
					isSchedule = "1";
					if (today) {
						// 1-2-1. 시작 날짜가 현재 날짜와 같을 경우
						prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_READY);
					}
					else {
						// 1-2-2. 시작 날짜가 미래인 경우
						prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_READY);
						makeSchedule = true;
					}
				}
			}
			else if (oldPrescriptionInfo.checkChange()) {
				// 2. 이전 처방에 시작 날짜가 있지만 미래인 경우
				// 2-1 수정 처방에 시작 날짜가 없을 경우
				deleteSchedule = true;
				if (startDate != null && !startDate.equals("")) {
					isSchedule = "1";
					makeSchedule = true;
					// 2-2 수정 처방에 시작 날짜가 있는 경우
					// 2-2-1 수정 처방에 시작 날짜가 현재 날짜인 경우
					if (today) {
						prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_READY);
					}
					else {
						prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_READY);
					}
				}
				else {
					prescriptionInfo.setStatus(Define.PRESCRIPTION_SATUS_NOSCHEDULE);
				}
			}
			else {
				// 3. 이전 처방에 시작 날짜가 과거 인경우
				isSchedule = "1";
				updateSchedule = true;
			}
			Log.out.debug(prescriptionInfo.toString());

			PrescriptionManager.getInstance().modifyPrescription(prescriptionInfo, makeSchedule, deleteSchedule, updateSchedule, isSchedule);

			// 스케쥴 정보
			PrescriptionInfo newPrescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);
			// 환자 정보
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			// 약상자 정보
			ArrayList<PillBoxInfo> pillBoxs = PillBoxManager.getInstance().getPillBoxList(userId, pillBoxId);
			PillBoxInfo pillBoxInfo = this.useContainerNumber(pillBoxs, prescriptionId);
			// 약복용 시간 정보
			String nweTakenOrderProperties = newPrescriptionInfo.getTakenOrderProperties();
			nweTakenOrderProperties = nweTakenOrderProperties.replace("[", "");
			ArrayList<String> takenOrderPropertysArr = Util.split("]", nweTakenOrderProperties);
			ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(takenOrderPropertysArr);
			takenOrderPropertyList = this.makeTakenOrderProperty(takenOrderPropertyList, userInfo);
			newPrescriptionInfo.setTakenOrderPropertyList(takenOrderPropertyList);
			req.setAttribute("prescriptionInfo", newPrescriptionInfo);
			req.setAttribute("userInfo", userInfo);
			req.setAttribute("pillBoxInfo", pillBoxInfo);
			req.setAttribute("msg", "처방전이 수정 되었습니다.");
			return next;
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
				if(tmpIdx == 7){
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
						takenOrderProperty.setStartAlarm("5");
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

	private PillBoxInfo useContainerNumber(ArrayList<PillBoxInfo> pillBoxs, String prescriptionId) throws Exception {
		PillBoxInfo outPillBox = null;
		for (PillBoxInfo pillBoxInfo : pillBoxs) {
			if (pillBoxInfo.getPrescriptionId() != null && !pillBoxInfo.getPrescriptionId().equals("")) {
				if (!pillBoxInfo.getPrescriptionId().equals(prescriptionId)) {
					String takenOrderProperties = pillBoxInfo.getTakenOrderproperties();
					takenOrderProperties = takenOrderProperties.replace("[", "");
					ArrayList<String> list = Util.split("]", takenOrderProperties);
					ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(list);
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
					if (!pillBoxInfo.getStatus().equals("FINISH")) {
						ArrayList<String> useContainer = outPillBox.getUseContainer();
						for (TakenOrderProperty takenOrderProperty : takenOrderPropertyList) {
							useContainer.remove("" + takenOrderProperty.getContainer());
						}
						outPillBox.setUseContainer(useContainer);
					}
				}
				else {
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
				}
			}
		}
		return outPillBox;
	}
}
