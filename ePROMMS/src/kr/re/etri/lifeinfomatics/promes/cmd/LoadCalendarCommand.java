package kr.re.etri.lifeinfomatics.promes.cmd;

import java.util.Calendar;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.util.Log;

public class LoadCalendarCommand implements Command {

	private String next = "";

	public LoadCalendarCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String type = req.getParameter("type");
			String yearStr = req.getParameter("_year");
			String monthStr = req.getParameter("_month");
			String parentType = req.getParameter("_parentType");
			
			Calendar cal = Calendar.getInstance();
			int year = 0;
			int month = 0;
			int date = 0;
			int firstDay = 0;
			int lastDate = 0;

			int toDayYear = cal.get(Calendar.YEAR);
			int toDayMonth = cal.get(Calendar.MONTH);
			int toDayDate = cal.get(Calendar.DATE);

			boolean isToday = true;

			if (yearStr != null && monthStr != null && !yearStr.equals("") && !monthStr.equals("")) {
				cal.set(Integer.parseInt(yearStr), (Integer.parseInt(monthStr) - 1), 1);
			}
			year = cal.get(Calendar.YEAR);
			month = cal.get(Calendar.MONTH);
			lastDate = cal.getActualMaximum(Calendar.DATE);

			if(lastDate < toDayDate){
				date = lastDate;
			}else{ 
				date = toDayDate;
			}
			cal.set(Calendar.DATE, 1);
			firstDay = cal.get(Calendar.DAY_OF_WEEK);

			if (year != toDayYear || month != toDayMonth) {
				isToday = false;
			}

			req.setAttribute("type", type);
			req.setAttribute("parentType", parentType);
			req.setAttribute("year", String.valueOf(year));
			req.setAttribute("month", String.valueOf(month + 1));
			req.setAttribute("date", String.valueOf(date));
			req.setAttribute("firstDay", String.valueOf(firstDay));
			req.setAttribute("lastDate", String.valueOf(lastDate));
			req.setAttribute("isToday", String.valueOf(isToday));

		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
		return next;
	}
}