package kr.re.etri.lifeinfomatics.promes.data;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import javax.servlet.http.HttpSessionBindingEvent;

import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;
import kr.re.etri.lifeinfomatics.promes.util.sort.SortInterface;

public class PrescriptionInfo implements SortInterface {

	private String id;
	private String member_id;
	private String pillBox_id;
	private String hospital;
	private String pharmacy;
	private int totalDays = 0;
	private int frequency = 0;
	private String disease;
	private String direction;
	private String startDate;
	private String startTakenOrder;
	private String endDate;
	private String endTakenOrder;
	private String takenOrderProperties;
	private String detailSchedule;
	private String status;
	private String lastUpdatedDateOfSchedule = "";
	private ArrayList<TakenOrderProperty> TakenOrderPropertyList = new ArrayList<TakenOrderProperty>();

	private String pillBox_type;
	private String age;
	private String gender;
	private ArrayList<ScheduleInfo> scheduleList;
	private String finishTakenPer;
	private String delayTakenPer;
	private String unTakenPer;
	private String finishTakenCnt;
	private String delayTakenCnt;
	private String unTakenCnt;
	
	

	

	public String getFinishTakenCnt() {
		return finishTakenCnt;
	}

	public void setFinishTakenCnt(String finishTakenCnt) {
		this.finishTakenCnt = finishTakenCnt;
	}

	public String getDelayTakenCnt() {
		return delayTakenCnt;
	}

	public void setDelayTakenCnt(String delayTakenCnt) {
		this.delayTakenCnt = delayTakenCnt;
	}

	public String getUnTakenCnt() {
		return unTakenCnt;
	}

	public void setUnTakenCnt(String unTakenCnt) {
		this.unTakenCnt = unTakenCnt;
	}

	public String getFinishTakenPer() {
		return finishTakenPer;
	}

	public void setFinishTakenPer(String finishTakenPer) {
		this.finishTakenPer = finishTakenPer;
	}

	public String getDelayTakenPer() {
		return delayTakenPer;
	}

	public void setDelayTakenPer(String delayTakenPer) {
		this.delayTakenPer = delayTakenPer;
	}

	public String getUnTakenPer() {
		return unTakenPer;
	}

	public void setUnTakenPer(String unTakenPer) {
		this.unTakenPer = unTakenPer;
	}

	public ArrayList<ScheduleInfo> getScheduleList() {
		return scheduleList;
	}

	public void setScheduleList(ArrayList<ScheduleInfo> scheduleList) {
		this.scheduleList = scheduleList;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	// Web ºä
	private String name;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getMember_id() {
		return member_id;
	}

	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}

	public String getPillBox_id() {
		return pillBox_id;
	}

	public void setPillBox_id(String pillBox_id) {
		this.pillBox_id = pillBox_id;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getPharmacy() {
		return pharmacy;
	}

	public void setPharmacy(String pharmacy) {
		this.pharmacy = pharmacy;
	}

	public int getTotalDays() {
		return totalDays;
	}

	public void setTotalDays(int totalDays) {
		this.totalDays = totalDays;
	}

	public int getFrequency() {
		return frequency;
	}

	public void setFrequency(int frequency) {
		this.frequency = frequency;
	}

	public String getDisease() {
		return disease;
	}

	public void setDisease(String disease) {
		this.disease = disease;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getStartDate() {
		return startDate;
	}

	public String getStartDateKor() {
		if (startDate != null && !startDate.equals("")) {
			return Util.chageDate(startDate);
		}
		else {
			return "";
		}
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getStartTakenOrder() {
		return startTakenOrder;
	}

	public void setStartTakenOrder(String startTakenOrder) {
		this.startTakenOrder = startTakenOrder;
	}

	public String getEndDate() {
		return endDate;
	}

	public String getEndDateKor() {
		return Util.chageDate(endDate);
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getEndTakenOrder() {
		return endTakenOrder;
	}

	public void setEndTakenOrder(String endTakenOrder) {
		this.endTakenOrder = endTakenOrder;
	}

	public String getTakenOrderProperties() {
		return takenOrderProperties;
	}

	public void setTakenOrderProperties(String takenOrderProperties) {
		this.takenOrderProperties = takenOrderProperties;
	}

	public String getStatus() {
		return status;
	}

	public String getStatusKor() {
		return Define.getPrescriptionStatusKor(this.status);
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getLastUpdatedDateOfSchedule() {
		return lastUpdatedDateOfSchedule;
	}

	public void setLastUpdatedDateOfSchedule(String lastUpdatedDateOfSchedule) {
		this.lastUpdatedDateOfSchedule = lastUpdatedDateOfSchedule;
	}

	public String getDetailSchedule() {
		return detailSchedule;
	}

	public void setDetailSchedule(String detailSchedule) {
		this.detailSchedule = detailSchedule;
	}

	public ArrayList<TakenOrderProperty> getTakenOrderPropertyList() {
		return TakenOrderPropertyList;
	}

	public void setTakenOrderPropertyList(ArrayList<TakenOrderProperty> takenOrderPropertyList) {
		TakenOrderPropertyList = takenOrderPropertyList;
	}

	public boolean checkChange() {
		try {
			if (detailSchedule.equals("0")) {
				return true;
			}
			else {
				Calendar todayCal = Calendar.getInstance();
				Date dSaleStrDm = new SimpleDateFormat("yyyy-MM-dd").parse(this.startDate);

				Calendar saleStrDmCal = new GregorianCalendar();
				saleStrDmCal.setTime(dSaleStrDm);
				if (todayCal.getTimeInMillis() < saleStrDmCal.getTimeInMillis()) {
					return true;
				}
				else {
					return false;
				}
			}
		} catch (ParseException e) {
			Log.out.error(e.getMessage());
			return false;
		}
	}

	public String getPillBox_type() {
		return pillBox_type;
	}

	public void setPillBox_type(String pillBox_type) {
		this.pillBox_type = pillBox_type;
	}

	public String getSortKey(String type) {
		String key = "";
		if (type.equals("ID")) {
			key = this.id;
		}
		else if (type.equals("NAME")) {
			key = this.name;
		}
		else if (type.equals("STARTDATE")) {
			key = this.startDate;
			key = key.replaceAll("- ", "");
		}
		else if (type.equals("DISEASE")) {
			key = this.disease;
		}
		else if (type.equals("STATUS")) {
			key = this.status;
		}else if (type.equals("TOTALDAYS")) {
			key = String.valueOf(this.totalDays);
		}else if (type.equals("HOSPITAL")) {
			key = String.valueOf(this.hospital);
		}
		return key;
	}

	public String toString() {
		String str = ""+ "\n";
		str += "===================== Prescription Info =================="+ "\n";
		str += "ID : " + id + "\n";
		str += "MEMBER_ID : " + member_id + "\n";
		str += "PILLBOX_ID : " + pillBox_id + "\n";
		str += "HOSPITAL : " + hospital + "\n";
		str += "PHARMACY : " + pharmacy + "\n";
		str += "TOTALDAYS : " + totalDays + "\n";
		str += "FREQUENCY : " + frequency + "\n";
		str += "DISEASE : " + disease + "\n";
		str += "DIRECTION : " + direction + "\n";
		str += "STARTDATE : " + startDate + "\n";
		str += "STARTTAKENORDER : " + startTakenOrder + "\n";
		str += "ENDDATE : " + endDate + "\n";
		str += "ENDTAKENORDER : " + endTakenOrder + "\n";
		str += "TAKENORDERPROPERTIES : " + takenOrderProperties + "\n";
		str += "ISDETAILSCHEDULE : " + detailSchedule + "\n";
		str += "STATUS : " + status + "\n";
		str += "LASTUPDATED : " + lastUpdatedDateOfSchedule + "\n";
		str += "================================================================";
		return str;
	}

	@Override
	public void valueBound(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void valueUnbound(HttpSessionBindingEvent arg0) {
		// TODO Auto-generated method stub
		
	}
}
