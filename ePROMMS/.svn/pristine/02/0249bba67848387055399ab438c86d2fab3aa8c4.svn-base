package kr.re.etri.lifeinfomatics.promes.data;

import java.util.ArrayList;
import java.util.Calendar;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class TakenOrderProperty {
	private int no = -1;
	private int container = -1;
	private String startTime;
	private String endTime;
	private String eatTime;
	private String startAlarm;
	private String endAlarm;

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getContainer() {
		return container;
	}

	public void setContainer(int container) {
		this.container = container;
	}

	public String getStartTime() {
		return startTime;
	}

	public String[] getStartTimeArr() {
		return Util.changeIntToTime(startTime).split(":");
	}

	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public String[] getEndTimeArr() {
		return Util.changeIntToTime(endTime).split(":");
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getEatTime() {
		return eatTime;
	}

	public void setEatTime(String eatTime) {
		this.eatTime = eatTime;
	}

	public String getStartAlarm() {
		return startAlarm;
	}

	public void setStartAlarm(String startAlarm) {
		this.startAlarm = startAlarm;
	}

	public String getEndAlarm() {
		return endAlarm;
	}

	public void setEndAlarm(String endAlarm) {
		this.endAlarm = endAlarm;
	}

	public static TakenOrderProperty split(String str) {
		TakenOrderProperty takenOrderProperty = new TakenOrderProperty();
		String[] strArr = str.split("/");
		takenOrderProperty.setNo(Integer.parseInt(strArr[0]));
		takenOrderProperty.setContainer(Integer.parseInt(strArr[1]));
		takenOrderProperty.setStartTime(strArr[2]);
		takenOrderProperty.setEndTime(strArr[3]);

		int startTime = Integer.parseInt(takenOrderProperty.getStartTime());
		Calendar cal1 = Calendar.getInstance();
		cal1.set(cal1.get(Calendar.YEAR), cal1.get(Calendar.MONTH), cal1.get(Calendar.DAY_OF_WEEK), startTime / 100, startTime % 100, 0);
		int endTime = Integer.parseInt(takenOrderProperty.getEndTime());
		Calendar cal2 = Calendar.getInstance();
		cal2.set(cal2.get(Calendar.YEAR), cal2.get(Calendar.MONTH), cal2.get(Calendar.DAY_OF_WEEK), endTime / 100, endTime % 100, 0);

		long endMin = cal2.getTime().getTime() - cal1.getTime().getTime();

		endMin = endMin / 60000;
		takenOrderProperty.setEndAlarm("" + endMin);
		return takenOrderProperty;
	}

	public static ArrayList<TakenOrderProperty> split(String[] strArr) {
		ArrayList<TakenOrderProperty> takenOrderProperties = new ArrayList<TakenOrderProperty>();
		for (int i = 0; i < strArr.length; i++) {
			TakenOrderProperty takenOrderProperty = TakenOrderProperty.split(strArr[i]);
			takenOrderProperties.add(takenOrderProperty);
		}
		return takenOrderProperties;
	}

	public static ArrayList<TakenOrderProperty> split(ArrayList<String> strList) {
		ArrayList<TakenOrderProperty> takenOrderProperties = new ArrayList<TakenOrderProperty>();
		for (int i = 0; i < strList.size(); i++) {
			TakenOrderProperty takenOrderProperty = TakenOrderProperty.split(strList.get(i));
			takenOrderProperties.add(takenOrderProperty);
		}
		return takenOrderProperties;
	}
}
