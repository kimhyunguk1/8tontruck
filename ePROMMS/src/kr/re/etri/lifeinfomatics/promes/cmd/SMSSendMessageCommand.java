package kr.re.etri.lifeinfomatics.promes.cmd;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.config.Constants;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.SMSClient;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class SMSSendMessageCommand implements Command {

	private String next = "";

	public SMSSendMessageCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {

			String msg = req.getParameter("_msg");
			msg = Util.toString(msg.trim());
			String phLIst = req.getParameter("_phList");
			String callBack = req.getParameter("_callBack");

			UserInfo userInfo = UserManager.getInstance().getUserInfo(Constants.ADMIN_ID);

			if(callBack == null || callBack.equals("")){
				callBack = userInfo.getHp();
			}
			
			callBack = callBack.replaceAll("-", "");
			
			SMSClient smsClient = new SMSClient();
			try {
				smsClient.connect();
			} catch (Exception e) {
				throw new Exception("SMS Server과 연결에 실패했습니다.");
			}

			ArrayList<String> failList = new ArrayList<String>();
			String[] phArr = phLIst.split(",");
			for (int i = 0; i < phArr.length; i++) {
				String tmp = phArr[i];
				if (tmp != null && !tmp.equals("")) {
					String[] tmpArr = tmp.split(":");
					if (tmpArr.length == 2) {
						try {
							String tmpPh = tmpArr[1];
							tmpPh = tmpPh.replaceAll("-", "");
							Log.out.debug(msg);
							String rslt = smsClient.sendMsg(tmpPh, callBack, userInfo.getName(), Util.en(msg));
							if (!rslt.substring(0, 2).equals("00")) {
								failList.add(tmp.replaceAll(":", " "));
							}
						} catch (Exception e) {
							Log.out.error(e, e);
							failList.add(tmp.replaceAll(":", " "));
						}
					}
					else {
						failList.add(tmp.replaceAll(":", " "));
					}
				}
			}
			smsClient.disconnect();
			
			String resultMsg = "";
			
			if(failList.size() == 0){
				resultMsg = "문자가 전송되었습니다.";
			}
			
			
			req.setAttribute("failList", failList);
			req.setAttribute("resultMsg", resultMsg);

			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}

}
