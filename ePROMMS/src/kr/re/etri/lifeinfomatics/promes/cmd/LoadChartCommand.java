package kr.re.etri.lifeinfomatics.promes.cmd;

import java.awt.Color;
import java.awt.Font;
import java.awt.GradientPaint;
import java.awt.Paint;
import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.ChartRenderingInfo;
import org.jfree.chart.ChartUtilities;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.entity.StandardEntityCollection;
import org.jfree.chart.labels.StandardCategoryItemLabelGenerator;
import org.jfree.chart.plot.CategoryPlot;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.chart.renderer.category.BarRenderer;
import org.jfree.chart.title.LegendTitle;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;
import kr.re.etri.lifeinfomatics.promes.config.Constants;
import kr.re.etri.lifeinfomatics.promes.data.ChartData;
import kr.re.etri.lifeinfomatics.promes.data.Define;
import kr.re.etri.lifeinfomatics.promes.data.PrescriptionInfo;
import kr.re.etri.lifeinfomatics.promes.data.UserInfo;
import kr.re.etri.lifeinfomatics.promes.mgr.PrescriptionManager;
import kr.re.etri.lifeinfomatics.promes.mgr.ScheduleManager;
import kr.re.etri.lifeinfomatics.promes.mgr.UserManager;
import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;

public class LoadChartCommand implements Command {

	private String next = "";

	public LoadChartCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {
		try {
			String userId = req.getParameter("_userId");
			userId = Util.toString(userId);
			String prescriptionId = Util.toLowerCase(req.getParameter("_prescriptionId"));
			String type = req.getParameter("_type");
			String hospital = req.getParameter("_hospital");
			hospital = Util.toString(hospital);
			String startDate = req.getParameter("_startDate");
			startDate = Util.toString(startDate);
			String endDate = req.getParameter("_endDate");
			endDate = Util.toString(endDate);

			UserInfo userInfo = UserManager.getInstance().getUserInfo(userId);
			PrescriptionInfo prescriptionInfo = PrescriptionManager.getInstance().getPrescription(prescriptionId, hospital);

			if (startDate == null || startDate.equals("")) {
				startDate = prescriptionInfo.getStartDateKor();
			}
			String tmpStartDate = "";
			if (startDate != null && !startDate.equals("")) {
				tmpStartDate = startDate.replaceAll("³â |¿ù |ÀÏ", "");
				tmpStartDate += " 0000";
			}

			if (endDate == null || endDate.equals("")) {
				endDate = prescriptionInfo.getEndDateKor();
			}
			String tmpEndDate = "";
			if (endDate != null && !endDate.equals("")) {
				tmpEndDate = endDate.replaceAll("³â |¿ù |ÀÏ", "");
				tmpEndDate += " 2359";
			}

			int totalNone = 0;
			int totalTaken = 0;
			int totalUnTaken = 0;
			int totalOutTaken = 0;

			Hashtable<String, ChartData> chartHash = ScheduleManager.getInstance().getChartData(userId, prescriptionId, hospital, tmpStartDate, tmpEndDate);
			Set<String> set = chartHash.keySet();
			Iterator<String> ite = set.iterator();

			ArrayList<String> keyList = new ArrayList<String>(set);

			Collections.sort(keyList);

			DefaultCategoryDataset dataset = new DefaultCategoryDataset();

			for (int i = 0; i < keyList.size(); i++) {
				String key = keyList.get(i);
				ChartData chartData = chartHash.get(key);
				int none = chartData.getNone();
				int taken = chartData.getTaken();
				int unTaken = chartData.getUnTaken();
				int outTaken = chartData.getOutTaken();
//				int finishOutTaken = chartData.getFinishOutTaken();
//				int finishUnTaken = chartData.getFinishUnTaken();

				dataset.addValue(taken, "º¹¿ë", key + " th");
//				dataset.addValue(unTaken + finishUnTaken, "¹Ìº¹¿ë", key + " th");
//				dataset.addValue(outTaken + finishOutTaken, "¿ÜÃâ", key + " th");
				dataset.addValue(unTaken, "¹Ìº¹¿ë", key + " th");
				dataset.addValue(outTaken, "¿ÜÃâ", key + " th");
				dataset.addValue(none, "¹Ì¾Ë¸²", key + " th");

				totalNone += none;
				totalTaken += taken;
//				totalOutTaken += finishOutTaken;
				totalUnTaken += unTaken;
//				totalUnTaken += finishUnTaken;
				totalOutTaken += outTaken;
			}

			int maxCount = 40;
			JFreeChart dosageChart = ChartFactory.createBarChart(null, null, "ÃÑ È¸¼ö", dataset, PlotOrientation.VERTICAL, false, false, false);
			dosageChart.setBackgroundPaint(Color.white);
			CategoryPlot plot = dosageChart.getCategoryPlot();
			// plot.getRenderer().setSeriesItemLabelFont(arg0, arg1)setBaseItemLabelFont(new java.awt.Font("¸¼Àº °íµñ", Font.PLAIN,23));
			plot.getRangeAxis().setRange(0, maxCount * 1.2);

			plot.getRangeAxis().setLabelFont(new Font("¸¼Àº °íµñ", Font.PLAIN, 13));
			plot.getDomainAxis().setTickLabelFont(new Font("¸¼Àº °íµñ", Font.PLAIN, 13));
			plot.setRangeGridlinesVisible(false);

			// LegendTitle legend = (LegendTitle)dosageChart.getLegend();
			// legend.setItemFont(new Font("¸¼Àº °íµñ", Font.PLAIN, 13));

			BarRenderer ren = new BarRenderer();
			ren.setItemLabelGenerator(new StandardCategoryItemLabelGenerator());
			ren.setItemLabelsVisible(true);
			ren.setItemLabelFont(new java.awt.Font("¸¼Àº °íµñ", Font.PLAIN, 13));

			GradientPaint gp0 = null;
			GradientPaint gp1 = null;
			GradientPaint gp2 = null;
			GradientPaint gp3 = null;

			gp0 = new GradientPaint(0.0f, 0.0f, new Color(206, 228, 255), 0.0f, 280.0f, new Color(71, 139, 198));
			gp1 = new GradientPaint(0.0f, 0.0f, new Color(248, 226, 226), 0.0f, 280.0f, new Color(237, 109, 109));
			gp2 = new GradientPaint(0.0f, 0.0f, new Color(254, 248, 214), 0.0f, 280.0f, new Color(252, 207, 82));
			gp3 = new GradientPaint(0.0f, 0.0f, new Color(232, 232, 232), 0.0f, 280.0f, new Color(150, 150, 150));

			ren.setSeriesPaint(0, gp0);
			ren.setSeriesPaint(1, gp1);
			ren.setSeriesPaint(2, gp2);
			ren.setSeriesPaint(3, gp3);

			plot.setRenderer(ren);

			String fileName = Util.getFileName(prescriptionInfo.getPillBox_id(), prescriptionId);

			FileOutputStream fos = new FileOutputStream(new File(Constants.WEB_PATH + "../chart", fileName));
			ChartUtilities.writeChartAsPNG(fos, dosageChart, 519, 205);
			fos.close();

			Hashtable<String, String> outHash = new Hashtable<String, String>();
			outHash.put("userId", userInfo.getId());
			outHash.put("userName", userInfo.getName());
			outHash.put("pillBoxId", prescriptionInfo.getPillBox_id());
			int total = totalNone + totalTaken + totalUnTaken + totalOutTaken;
			outHash.put("total", String.valueOf(total));
			outHash.put(Define.TAKEN_SATUS_NONE, String.valueOf(totalNone));
			outHash.put(Define.TAKEN_SATUS_PRETAKEN, String.valueOf(totalTaken));
			outHash.put(Define.TAKEN_SATUS_UNTAKEN, String.valueOf(totalUnTaken));
			outHash.put(Define.TAKEN_SATUS_SMSOUTTAKEN, String.valueOf(totalOutTaken));

			req.setAttribute("startDate", startDate);
			req.setAttribute("endDate", endDate);
			req.setAttribute("outHash", outHash);
			req.setAttribute("type", type);
			req.setAttribute("fileName", fileName);
			return next;
		} catch (Exception ex) {
			Log.out.error(ex, ex);
			req.setAttribute("message", ex.getMessage());
			return "home/error.jsp";
		}
	}
}
