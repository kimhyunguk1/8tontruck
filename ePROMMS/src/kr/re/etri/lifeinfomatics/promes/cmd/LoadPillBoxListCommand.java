package kr.re.etri.lifeinfomatics.promes.cmd;

import java.util.ArrayList;
import java.util.Hashtable;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.data.PillBoxInfo;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.TakenOrderProperty;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PillBoxManager;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadPillBoxListCommand implements Command {

	private String next = "";

	public LoadPillBoxListCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			String pageIdx = req.getParameter("_pageIdx");
			String sortType = req.getParameter("_sortType");
			String sortCourse = req.getParameter("_sortCourse");

			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);

			ArrayList<String> pillBoxIdList = Util.split("/", userInfo.getPillBoxsStr());

			ArrayList<PillBoxInfo> tmpPillBoxs = PillBoxManager.getInstance().getPillBoxList(userId, pillBoxIdList);
			Hashtable<String, PillBoxInfo> pillBoxHash = this.usePillBoxList(tmpPillBoxs);
			if (pageIdx == null || pageIdx.equals("")) {
				pageIdx = "1";
			}
			int pageNum = Integer.parseInt(pageIdx);

			ArrayList<PillBoxInfo> pillBoxs = new ArrayList<PillBoxInfo>();
			int count = 0;
			for (PillBoxInfo pillBoxInfo : tmpPillBoxs) {
				String key = pillBoxInfo.getId();
				if (pillBoxHash.containsKey(key)) {
					pillBoxs.add(count++, pillBoxHash.get(key));
					pillBoxHash.remove(key);
				}
				if (pillBoxInfo.getPrescriptionId() == null || pillBoxInfo.getPrescriptionId().equals("")) {
					pillBoxs.add(count++, pillBoxInfo);
				}
				else {
					if (pillBoxInfo.getStatus() != null && !pillBoxInfo.getStatus().equals("FINISH")) {
						pillBoxs.add(pillBoxs.size(), pillBoxInfo);
					}
				}
			}

			ArrayList<Object> objList = new ArrayList<Object>();
			if (sortType != null && !sortType.equals("")) {
				objList = Util.sort(pillBoxs, sortType, sortCourse);
			}
			else {
				for (PillBoxInfo pillBoxInfo : pillBoxs) {
					objList.add(pillBoxInfo);
				}
			}

			int maxPageIdx = (objList.size() / 5) + 1;
			ArrayList<PillBoxInfo> outputPillBoxs = new ArrayList<PillBoxInfo>();

			int num = (pageNum - 1) * 5;
			int maxNum = 0;
			if (maxPageIdx > pageNum) {
				maxNum = num + 5;
			}
			else {
				maxNum = objList.size();
			}

			for (int i = num; i < maxNum; i++) {
				outputPillBoxs.add((PillBoxInfo) objList.get(i));
			}

			req.setAttribute("userId", userId);
			req.setAttribute("pillBoxs", outputPillBoxs);
			req.setAttribute("pageIdx", pageIdx);
			req.setAttribute("maxPageIdx", String.valueOf(maxPageIdx));
			req.setAttribute("sortType", sortType);
			req.setAttribute("sortCourse", sortCourse);
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("msg", "약상자 조회 실패");
			return next;
		}
	}

	private Hashtable<String, PillBoxInfo> usePillBoxList(ArrayList<PillBoxInfo> pillBoxs) throws Exception {
		Hashtable<String, PillBoxInfo> hashPillBox = new Hashtable<String, PillBoxInfo>();
		for (PillBoxInfo pillBoxInfo : pillBoxs) {
			if (pillBoxInfo.getPrescriptionId() != null && !pillBoxInfo.getPrescriptionId().equals("")) {
				String pillBoxId = pillBoxInfo.getId();

				// 복용 일정 ex:[1/1/0700/0730][2/2/1130/1200][3/3/1730/1800][4/1/2130/2200]
				String takenOrderProperties = pillBoxInfo.getTakenOrderproperties();
				takenOrderProperties = takenOrderProperties.replace("[", "");
				ArrayList<String> list = Util.split("]", takenOrderProperties);
				ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(list);

				PillBoxInfo tmpPillBox = new PillBoxInfo();

				if (!hashPillBox.containsKey(pillBoxId)) {
					tmpPillBox = new PillBoxInfo();
					tmpPillBox.setId(pillBoxInfo.getId());
					tmpPillBox.setType(pillBoxInfo.getType());
					tmpPillBox.setRegDate(pillBoxInfo.getRegDate());
					tmpPillBox.setContainerNumber(pillBoxInfo.getContainerNumber());
					ArrayList<String> useContainer = new ArrayList<String>();
					for (int i = 1; i <= tmpPillBox.getContainerNumber(); i++) {
						useContainer.add("" + i);
					}
					tmpPillBox.setUseContainer(useContainer);
					hashPillBox.put(pillBoxId, tmpPillBox);
				}
				tmpPillBox = hashPillBox.get(pillBoxId);
				if (!pillBoxInfo.getStatus().equals("FINISH")) {
					ArrayList<String> useContainer = tmpPillBox.getUseContainer();
					for (TakenOrderProperty takenOrderProperty : takenOrderPropertyList) {
						useContainer.remove("" + takenOrderProperty.getContainer());
					}
					tmpPillBox.setUseContainer(useContainer);
				}

				if (tmpPillBox.getUseContainer().size() == 0) {
					hashPillBox.remove(pillBoxId);
				}
				else {
					hashPillBox.put(pillBoxId, tmpPillBox);
				}

				ArrayList<String> useContainer = new ArrayList<String>();
				for (TakenOrderProperty takenOrderProperty : takenOrderPropertyList) {
					String container = "" + takenOrderProperty.getContainer();
					if (!useContainer.contains(container)) {
						useContainer.add(container);
					}
				}
				pillBoxInfo.setUseContainer(useContainer);
			}
			else {
				ArrayList<String> useContainer = new ArrayList<String>();
				for (int i = 1; i <= pillBoxInfo.getContainerNumber(); i++) {
					useContainer.add("" + i);
				}
				pillBoxInfo.setUseContainer(useContainer);
			}
		}
		return hashPillBox;
	}
	// private Hashtable<String, PillBoxInfo> usePillBoxList(ArrayList<PillBoxInfo> pillBoxs) throws Exception {
	// Hashtable<String, PillBoxInfo> hashPillBox = new Hashtable<String, PillBoxInfo>();
	// for (PillBoxInfo pillBoxInfo : pillBoxs) {
	// if (pillBoxInfo.getPrescriptionId() != null && !pillBoxInfo.getPrescriptionId().equals("")) {
	// String takenOrderProperties = pillBoxInfo.getTakenOrderproperties();
	// takenOrderProperties = takenOrderProperties.replace("[", "");
	// ArrayList<String> list = Util.split("]", takenOrderProperties);
	// ArrayList<TakenOrderProperty> takenOrderPropertyList = TakenOrderProperty.split(list);
	// if (pillBoxInfo.getContainerNumber() > 1) {
	// PillBoxInfo tmpPillBoxInfo = new PillBoxInfo();
	// if (!hashPillBox.containsKey(pillBoxInfo.getId())) {
	// tmpPillBoxInfo.setId(pillBoxInfo.getId());
	// tmpPillBoxInfo.setType(pillBoxInfo.getType());
	// tmpPillBoxInfo.setRegDate(pillBoxInfo.getRegDate());
	// tmpPillBoxInfo.setContainerNumber(pillBoxInfo.getContainerNumber());
	// ArrayList<String> useContainer = new ArrayList<String>();
	// for (int i = 1; i <= tmpPillBoxInfo.getContainerNumber(); i++) {
	// useContainer.add("" + i);
	// }
	// tmpPillBoxInfo.setUseContainer(useContainer);
	// hashPillBox.put(pillBoxInfo.getId(), tmpPillBoxInfo);
	// }
	// tmpPillBoxInfo = hashPillBox.get(pillBoxInfo.getId());
	// if (!pillBoxInfo.getStatus().equals("FINISH")) {
	// ArrayList<String> useContainer = tmpPillBoxInfo.getUseContainer();
	// for (TakenOrderProperty takenOrderProperty : takenOrderPropertyList) {
	// useContainer.remove("" + takenOrderProperty.getContainer());
	// }
	// tmpPillBoxInfo.setUseContainer(useContainer);
	// }
	// if (tmpPillBoxInfo.getUseContainer().size() == 0) {
	// hashPillBox.remove(pillBoxInfo.getId());
	// }
	// else {
	// hashPillBox.put(tmpPillBoxInfo.getId(), tmpPillBoxInfo);
	// }
	// }
	//
	// ArrayList<String> useContainer = new ArrayList<String>();
	// for (TakenOrderProperty takenOrderProperty : takenOrderPropertyList) {
	// useContainer.add("" + takenOrderProperty.getContainer());
	// }
	// pillBoxInfo.setUseContainer(useContainer);
	// }
	// else {
	// ArrayList<String> useContainer = new ArrayList<String>();
	// for (int i = 1; i <= pillBoxInfo.getContainerNumber(); i++) {
	// useContainer.add("" + i);
	// }
	// pillBoxInfo.setUseContainer(useContainer);
	// }
	// }
	// return hashPillBox;
	// }
}
