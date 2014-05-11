package kr.re.etri.lifeinfomatics.promes.mgr;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.Set;

import jxl.Workbook;
import jxl.format.Alignment;
import jxl.format.Border;
import jxl.format.BorderLineStyle;
import jxl.format.Colour;
import jxl.format.VerticalAlignment;
import jxl.write.Label;
import jxl.write.WritableCellFormat;
import jxl.write.WritableFont;
import jxl.write.WritableImage;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook;
import kr.re.etri.lifeinfomatics.promes.config.Constants;
import kr.re.etri.lifeinfomatics.promes.data.ChartData;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.ScheduleInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;
import kr.re.etri.lifeinfomatics.promes.util.chart.LineChart;
import kr.re.etri.lifeinfomatics.promes.util.sort.SortComparator;

public class ExcelManager {
	private static ExcelManager instance = null;
	private WritableCellFormat nameFormat = new WritableCellFormat();
	private WritableCellFormat nameFormat2 = new WritableCellFormat();

	private WritableCellFormat dataFormat = new WritableCellFormat();
	private WritableCellFormat dataFormat2 = new WritableCellFormat();

	private ExcelManager() {
		try {
			nameFormat.setBackground(Colour.GREY_25_PERCENT);
			nameFormat.setBorder(Border.TOP, BorderLineStyle.MEDIUM);
			nameFormat.setBorder(Border.LEFT, BorderLineStyle.MEDIUM);
			nameFormat.setBorder(Border.BOTTOM, BorderLineStyle.MEDIUM);
			nameFormat.setBorder(Border.RIGHT, BorderLineStyle.MEDIUM);
			nameFormat.setAlignment(Alignment.CENTRE);
			nameFormat.setVerticalAlignment(VerticalAlignment.CENTRE);

			nameFormat2.setBackground(Colour.YELLOW2);
			nameFormat2.setBorder(Border.TOP, BorderLineStyle.MEDIUM);
			nameFormat2.setBorder(Border.LEFT, BorderLineStyle.MEDIUM);
			nameFormat2.setBorder(Border.BOTTOM, BorderLineStyle.MEDIUM);
			nameFormat2.setBorder(Border.RIGHT, BorderLineStyle.MEDIUM);
			nameFormat2.setAlignment(Alignment.CENTRE);
			nameFormat2.setVerticalAlignment(VerticalAlignment.CENTRE);

			dataFormat.setBorder(Border.TOP, BorderLineStyle.MEDIUM);
			dataFormat.setBorder(Border.LEFT, BorderLineStyle.MEDIUM);
			dataFormat.setBorder(Border.BOTTOM, BorderLineStyle.MEDIUM);
			dataFormat.setBorder(Border.RIGHT, BorderLineStyle.MEDIUM);
			dataFormat.setAlignment(Alignment.CENTRE);
			dataFormat.setVerticalAlignment(VerticalAlignment.CENTRE);

			dataFormat2.setAlignment(Alignment.CENTRE);
			dataFormat2.setVerticalAlignment(VerticalAlignment.CENTRE);
			WritableFont font = new WritableFont(WritableFont.ARIAL, 15, WritableFont.BOLD);
			dataFormat2.setFont(font);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String makeExcel(UserInfo userInfo, PrescriptionInfo prescriptionInfo, ArrayList<ScheduleInfo> schedules) throws Exception {
		String fileName = prescriptionInfo.getId() + ".xls";

		File makeDir = new File(Constants.WEB_PATH + "../chart");
		if (!makeDir.exists()) {
			makeDir.mkdir();
		}

		File file = new File(Constants.WEB_PATH + "../chart", fileName);
		String fileUrl = file.getCanonicalPath();
		System.out.println(fileUrl);
		WritableWorkbook reportWork = Workbook.createWorkbook(file);

		String title = Util.getToday("yyyyMMdd");

		WritableSheet sheet = reportWork.createSheet(title, 0);
		Hashtable<String, Object> chartHash = makeChartData(userInfo, prescriptionInfo, schedules);

		sheet.setRowView(0, 350);
		sheet.setRowView(1, 350);
		sheet.setRowView(2, 350);
		sheet.setRowView(3, 350);
		sheet.setRowView(4, 350);

		for (int i = 0; i <= 20; i++) {
			sheet.setColumnView(i, 10);
		}
		makePrescriptionInfo(sheet, userInfo, prescriptionInfo);

		makeDosage(sheet, (Hashtable<String, String>) chartHash.get("DOSAGEHASH"));
		makeDosageTime(sheet, (Hashtable<String, ChartData>) chartHash.get("TIMETAKENORDER"));
		makeDosageWeek(sheet, (Hashtable<String, ChartData>) chartHash.get("WEEKTAKENORDER"));

		makeChart(sheet, (Hashtable<String, ChartData>) chartHash.get("CHART"), prescriptionInfo.getId());
		makeDosageDay(sheet, prescriptionInfo, schedules);
		reportWork.write();
		reportWork.close();
		return fileName;
	}

	private void makePrescriptionInfo(WritableSheet sheet, UserInfo userInfo, PrescriptionInfo prescriptionInfo) throws Exception {

		for (int i = 0; i < 5; i++) {
			sheet.mergeCells(0, i, 1, i);
			sheet.mergeCells(2, i, 8, i);
		}
		sheet.addCell(new Label(0, 0, "이름", nameFormat));
		sheet.addCell(new Label(2, 0, userInfo.getName(), dataFormat));
		sheet.addCell(new Label(0, 1, "주소", nameFormat));
		sheet.addCell(new Label(2, 1, userInfo.getAddr(), dataFormat));
		sheet.addCell(new Label(0, 2, "처방", nameFormat));
		sheet.addCell(new Label(2, 2, prescriptionInfo.getId(), dataFormat));
		sheet.addCell(new Label(0, 3, "기간", nameFormat));
		sheet.addCell(new Label(2, 3, prescriptionInfo.getStartDateKor() + " ~ " + prescriptionInfo.getEndDateKor(), dataFormat));
		sheet.addCell(new Label(0, 4, "처방내용", nameFormat));
		sheet.addCell(new Label(2, 4, prescriptionInfo.getDisease(), dataFormat));
	}

	private void makeDosage(WritableSheet sheet, Hashtable<String, String> dosageHash) throws Exception {

		sheet.mergeCells(0, 6, 1, 7);
		sheet.addCell(new Label(0, 6, "복용", nameFormat));
		sheet.addCell(new Label(2, 6, "복용", nameFormat));
		sheet.addCell(new Label(2, 7, dosageHash.get("TAKENTOTAL"), dataFormat));
		sheet.addCell(new Label(3, 6, "미복용", nameFormat));
		sheet.addCell(new Label(3, 7, dosageHash.get("UNTAKENTOTAL"), dataFormat));
		sheet.addCell(new Label(4, 6, "외출", nameFormat));
		sheet.addCell(new Label(4, 7, dosageHash.get("OUTTAKENTOTAL"), dataFormat));
		sheet.addCell(new Label(5, 6, "예정", nameFormat));
		sheet.addCell(new Label(5, 7, dosageHash.get("NONETOTAL"), dataFormat));
		sheet.addCell(new Label(6, 6, "전체", nameFormat));
		sheet.addCell(new Label(6, 7, dosageHash.get("TOTAL"), dataFormat));
	}

	private void makeDosageTime(WritableSheet sheet, Hashtable<String, ChartData> takenorderTimeHash) throws Exception {
		sheet.mergeCells(0, 9, 1, 9);
		sheet.mergeCells(0, 10, 1, 10);
		sheet.addCell(new Label(0, 9, "시간대별", nameFormat));
		sheet.addCell(new Label(0, 10, "복용:미복용:외출:예정", nameFormat));

		Set<String> set = takenorderTimeHash.keySet();
		ArrayList<String> keyList = new ArrayList<String>(set);
		Collections.sort(keyList);

		for (int i = 0; i < keyList.size(); i++) {
			String key = keyList.get(i);
			if (key.equals("전체")) {
				sheet.addCell(new Label(i + 2, 9, key, nameFormat));
			}
			else {
				sheet.addCell(new Label(i + 2, 9, key + "회", nameFormat));
			}

			ChartData chartData = takenorderTimeHash.get(key);
			sheet.addCell(new Label(i + 2, 10, chartData.getTaken() + " " + chartData.getUnTaken() + " " + chartData.getOutTaken() + " " + chartData.getNone(), dataFormat));
		}
	}

	private void makeDosageWeek(WritableSheet sheet, Hashtable<String, ChartData> takenorderWeekHash) throws Exception {
		sheet.mergeCells(0, 12, 1, 12);
		sheet.mergeCells(0, 13, 1, 13);
		sheet.addCell(new Label(0, 12, "요일별", nameFormat));
		sheet.addCell(new Label(0, 13, "복용:미복용:외출:예정", nameFormat));

		for (int i = 1; i <= 7; i++) {
			ChartData chartData = takenorderWeekHash.get("" + i);

			sheet.addCell(new Label(i + 1, 12, Define.WEEK_KOR[i - 1], nameFormat));
			sheet.addCell(new Label(i + 1, 13, chartData.getTaken() + " " + chartData.getUnTaken() + " " + chartData.getOutTaken() + " " + chartData.getNone(), dataFormat));
		}
	}

	private void makeChart(WritableSheet sheet, Hashtable<String, ChartData> takenorderWeekHash, String prescriptionId) throws Exception {

		ArrayList<ChartData> list = new ArrayList<ChartData>(takenorderWeekHash.values());
		Collections.sort(list, new SortComparator("str1"));

		LineChart chart1 = new LineChart();
		chart1.setChartData(list, "A");

		File file1 = new File(Constants.WEB_PATH + "../chart", prescriptionId + "1.png");
		chart1.saveChart(file1, 700, 400);
		WritableImage wi = new WritableImage(0, 17, 11, 12, file1);
		sheet.addImage(wi);

		sheet.mergeCells(3, 29, 6, 29);
		sheet.addCell(new Label(3, 29, "<순응률>", dataFormat2));

		File file2 = new File(Constants.WEB_PATH + "../chart", prescriptionId + "2.png");
		LineChart chart2 = new LineChart();
		chart2.setChartData(list, "B");
		chart2.saveChart(file2, 700, 400);
		WritableImage wi2 = new WritableImage(0, 31, 11, 12, file2);
		sheet.addImage(wi2);

		sheet.mergeCells(3, 43, 6, 43);
		sheet.addCell(new Label(3, 43, "<복용현황>", dataFormat2));

	}

	private void makeDosageDay(WritableSheet sheet, PrescriptionInfo prescriptionInfo, ArrayList<ScheduleInfo> schedules) throws Exception {
		int frequency = prescriptionInfo.getFrequency();
		sheet.mergeCells(0, 45, frequency * 3, 45);
		sheet.addCell(new Label(0, 45, "일별 복용 상황", dataFormat2));

		String day = "";
		int row = 47;
		int col = 0;
		for (ScheduleInfo info : schedules) {
			String takenorder = info.getTakenorder();
			String tmpDay = info.getAlarmStart().substring(0, 8);

			if (day.equals("") || !day.equals(tmpDay)) {
				day = tmpDay;
				sheet.addCell(new Label(0, row, "날짜", nameFormat2));
				sheet.mergeCells(1, row, 11, row);
				sheet.addCell(new Label(1, row, tmpDay.substring(0, 4) + ". " + tmpDay.substring(4, 6) + ". " + tmpDay.substring(6, 8), nameFormat2));
				for (int i = 0; i < frequency; i++) {
					sheet.addCell(new Label(i * 3, row + 1, "예정시간", nameFormat));
					sheet.addCell(new Label(i * 3 + 1, row + 1, "", dataFormat));
					sheet.mergeCells(i * 3 + 1, row + 1, i * 3 + 2, row + 1);

					sheet.addCell(new Label(i * 3, row + 2, "상태", nameFormat));
					sheet.addCell(new Label(i * 3 + 1, row + 2, "", dataFormat));
					sheet.mergeCells(i * 3 + 1, row + 2, i * 3 + 2, row + 2);

					sheet.addCell(new Label(i * 3, row + 3, "시간", nameFormat));
					sheet.addCell(new Label(i * 3 + 1, row + 3, "", dataFormat));
					sheet.mergeCells(i * 3 + 1, row + 3, i * 3 + 2, row + 3);
				}
				row += 5;
			}

			sheet.addCell(new Label(Integer.parseInt(takenorder) * 3 - 2, row - 4, info.getTime(), dataFormat));
			sheet.addCell(new Label(Integer.parseInt(takenorder) * 3 - 2, row - 3, info.getTakenStatus(), dataFormat));
			sheet.addCell(new Label(Integer.parseInt(takenorder) * 3 - 2, row - 2, info.getTime(), dataFormat));

		}
	}

	private Hashtable<String, Object> makeChartData(UserInfo userInfo, PrescriptionInfo prescriptionInfo, ArrayList<ScheduleInfo> schedules) throws Exception {
		Hashtable<String, Object> chartHash = new Hashtable<String, Object>();
		Hashtable<String, String> dosageHash = new Hashtable<String, String>();
		Hashtable<String, ChartData> orderTimeHash = new Hashtable<String, ChartData>();
		Hashtable<String, ChartData> weekTimeHash = new Hashtable<String, ChartData>();
		Hashtable<String, ChartData> dayTimeHash = new Hashtable<String, ChartData>();

		int frequency = prescriptionInfo.getFrequency();

		int total = schedules.size();
		dosageHash.put("TOTAL", "" + total);
		int noneTotal = 0;
		int takenTotal = 0;
		int untakenTotal = 0;
		int outtakenTotal = 0;

		ChartData timeTotal = new ChartData("전체");

		for (int i = 1; i <= 7; i++) {
			weekTimeHash.put("" + i, new ChartData());
		}

		String day = "";
		int count = 1;

		for (int i = 0; i < schedules.size(); i++) {
			ScheduleInfo scheduleInfo = schedules.get(i);
			String takenorder = scheduleInfo.getTakenorder();
			String takenStatus = scheduleInfo.getTakenStatus();

			String alarmStart = scheduleInfo.getAlarmStart();
			String tmpDay = alarmStart.substring(0, 8);
			if (day.equals("") || !day.equals(tmpDay)) {
				day = tmpDay;
				ChartData chartData = new ChartData();
				chartData.setTitle(tmpDay);
				chartData.setTotal(frequency);
				chartData.setIndex(count++);
				dayTimeHash.put(tmpDay, chartData);
			}

			ChartData chartData = dayTimeHash.get(tmpDay);
			chartData.setStatusCount(takenStatus);

			if (!orderTimeHash.containsKey(takenorder)) {
				orderTimeHash.put(takenorder, new ChartData(takenorder));
			}
			ChartData timeChartData = orderTimeHash.get(takenorder);
			timeChartData.setStatusCount(takenStatus);
			timeTotal.setStatusCount(takenStatus);

			ChartData weekChartData = weekTimeHash.get("" + Util.getWeek(alarmStart));
			weekChartData.setStatusCount(takenStatus);

			if (takenStatus.equals(Define.TAKEN_SATUS_NONE)) {
				noneTotal++;
			}
			else if (takenStatus.equals(Define.TAKEN_SATUS_PRETAKEN) || takenStatus.equals(Define.TAKEN_SATUS_FINISHTAKEN)) {
				takenTotal++;
			}
			else if (takenStatus.equals(Define.TAKEN_SATUS_UNTAKEN) || takenStatus.equals(Define.TAKEN_SATUS_PREUNTAKEN) || takenStatus.equals(Define.TAKEN_SATUS_FINISHUNTAKEN)) {
				untakenTotal++;
			}
			else if (takenStatus.equals(Define.TAKEN_SATUS_PREOUTTAKEN) || takenStatus.equals(Define.TAKEN_SATUS_FINISHOUTTAKEN) || takenStatus.equals(Define.TAKEN_SATUS_SMSOUTTAKEN)) {
				outtakenTotal++;
			}
			else {
				noneTotal++;
			}
		}

		dosageHash.put("NONETOTAL", "" + noneTotal);
		dosageHash.put("TAKENTOTAL", "" + takenTotal);
		dosageHash.put("UNTAKENTOTAL", "" + untakenTotal);
		dosageHash.put("OUTTAKENTOTAL", "" + outtakenTotal);
		chartHash.put("DOSAGEHASH", dosageHash);

		orderTimeHash.put("전체", timeTotal);
		chartHash.put("TIMETAKENORDER", orderTimeHash);

		chartHash.put("WEEKTAKENORDER", weekTimeHash);

		chartHash.put("CHART", dayTimeHash);

		return chartHash;
	}

	public static void main(String[] args) {
		try {
			Constants.initialize();
			Log.initialize();
			PrescriptionInfo prescriptionInfo = PrescriptionManager.getInstance().getPrescription("1291352045467", "테스트");
			String userId = prescriptionInfo.getMember_id();
			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			ArrayList<ScheduleInfo> schedules = ScheduleManager.getInstance().getSchedules(userId, prescriptionInfo.getId(), prescriptionInfo.getStartDate().replace("-", "") + "0000", prescriptionInfo.getEndDate().replace("-", "") + "2359", prescriptionInfo.getHospital());

			System.err.println(prescriptionInfo.toString());

			ExcelManager.getInstance().makeExcel(userInfo, prescriptionInfo, schedules);
			System.out.println("====> 완료");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static ExcelManager getInstance() {
		if (instance == null) {
			instance = new ExcelManager();
		}
		return instance;
	}

}
