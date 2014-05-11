package kr.re.etri.lifeinfomatics.promes.data;

import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;

import kr.re.etri.lifeinfomatics.promes.util.Log;

public class ScheduleInfo {
	private String id;
	private String userName;
	private String prescription_id;
	private String alarmStart;
	private String alarmEnd;
	private String takenorder;
	private String containerno;
	private String takenStatus;
	private String takenTime;
	private String hospital;
	private String memoContent;
	private String category;
	private String errorContent;
	private String takencheck;
	private String pillboxId;
	private String gifImage;		// 사용자가 약을 먹을때 사진을 페이지 로딩시 넘거줌



	public String getGifImage() {
		return gifImage;
	}

	public void setGifImage(String gifImage) {
		this.gifImage = gifImage;
	}

	public String getPillboxId() {
		return pillboxId;
	}

	public void setPillboxId(String pillboxId) {
		this.pillboxId = pillboxId;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPrescription_id() {
		return prescription_id;
	}

	public void setPrescription_id(String prescription_id) {
		this.prescription_id = prescription_id;
	}

	public String getAlarmStart() {
		return alarmStart;
	}

	public String getAlarmStartTime() {
		String[] date = alarmStart.split(" ");
		return date[1];
	}

	public void setAlarmStart(String alarmStart) {
		this.alarmStart = alarmStart;
	}

	public String getAlarmEnd() {
		return alarmEnd;
	}

	public String getAlarmEndTime() {
		String[] date = alarmEnd.split(" ");
		return date[1];
	}

	public void setAlarmEnd(String alarmEnd) {
		this.alarmEnd = alarmEnd;
	}

	public String getTakenorder() {
		return takenorder;
	}

	public void setTakenorder(String takenorder) {
		this.takenorder = takenorder;
	}

	public String getContainerno() {
		return containerno;
	}

	public void setContainerno(String containerno) {
		this.containerno = containerno;
	}

	public String getTakenStatus() {
		return takenStatus;
	}

	public void setTakenStatus(String takenStatus) {
		this.takenStatus = takenStatus;
	}

	public String getTakenTime() {
		return takenTime;
	}

	public void setTakenTime(String takenTime) {
		this.takenTime = takenTime;
	}

	public String getFormatTime(int type)
	{
		String tmpTime = "";
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd HHmm");
		SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat formatter3 = new SimpleDateFormat("MM/dd HH:mm");
		
		ParsePosition pos = new ParsePosition(0);
		Date frmTime;
		if (type == 1)
		{
			frmTime = formatter1.parse(alarmStart, pos);
			tmpTime += formatter2.format(frmTime);
		}
		else if (type == 2)
		{
			frmTime = formatter1.parse(alarmEnd, pos);
			tmpTime += formatter2.format(frmTime);
		}
		else if (type == 3)
		{
			if (takenTime != null && !takenTime.equals("")) 
			{
				frmTime = formatter1.parse(takenTime, pos);
				tmpTime += formatter3.format(frmTime);
			}
			else
			{
				tmpTime = "";
			}
		}
		
		return tmpTime;
	}
	
	public String getTime() 
	{
		String tmpTime = "";
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd HHmm");
		SimpleDateFormat formatter2 = new SimpleDateFormat("HH:mm");
		SimpleDateFormat formatter3 = new SimpleDateFormat("yy.MM.dd HH:mm");
		SimpleDateFormat formatter4 = new SimpleDateFormat("yyyyMMdd");

		if (takenTime != null && !takenTime.equals("")) 
		{
			ParsePosition pos = new ParsePosition(0);
			Date alarmStartDate = formatter1.parse(this.alarmStart, pos);
			pos.setIndex(0);
			Date takenDate = formatter1.parse(this.takenTime, pos);

			String tmpAlarmStartDate = formatter4.format(alarmStartDate);
			String tmpTakenDate = formatter4.format(takenDate);
			Log.out.debug(tmpTakenDate + " : " + tmpAlarmStartDate);
			if (!tmpTakenDate.equals(tmpAlarmStartDate)) 
			{
				tmpTime += formatter3.format(takenDate);
			}
			else {
				if (takenStatus.equals(Define.TAKEN_SATUS_SMSOUTTAKEN) || takenStatus.equals(Define.TAKEN_SATUS_PREOUTTAKEN)|| takenStatus.equals(Define.TAKEN_SATUS_FINISHOUTTAKEN)) {
					tmpTime += formatter3.format(takenDate);
				}
				else {
					tmpTime += formatter2.format(takenDate);
				}
			}
		}
		else 
		{
			ParsePosition pos = new ParsePosition(0);
			Date frmTime = formatter1.parse(alarmStart, pos);
			tmpTime += formatter2.format(frmTime) + " ~ ";
			pos.setIndex(0);
			frmTime = formatter1.parse(alarmEnd, pos);
			tmpTime += formatter2.format(frmTime);
		}
		return tmpTime;
	}
	
	public String getImage() 
	{
		SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMdd HHmm");
		
		Date alarmEndDate;
		Date takenDate = null;
		ParsePosition pos = new ParsePosition(0);
		alarmEndDate = formatter1.parse(this.alarmEnd, pos);
		
		if (takenTime != null && !takenTime.equals(""))
		{
			pos.setIndex(0);
			takenDate = formatter1.parse(this.takenTime, pos);
		}
		
		if (takenStatus.equals(Define.TAKEN_SATUS_NONE)) 
		{
			return "";
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_PRETAKEN)) 
		{
			return Define.TAKEN_SATUS_TAKEN_FICKER_IMAGE;
			
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_FINISHTAKEN)) 
		{
			return Define.TAKEN_SATUS_TAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_UNTAKEN)) 
		{
			return Define.TAKEN_SATUS_NOTTAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_PREUNTAKEN)) 
		{
			return Define.TAKEN_SATUS_NOTTAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_FINISHUNTAKEN)) 
		{
			return Define.TAKEN_SATUS_NOTTAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_PREOUTTAKEN)) 
		{
			return Define.TAKEN_SATUS_OUTTAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_FINISHOUTTAKEN)) 
		{
			return Define.TAKEN_SATUS_OUTTAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_SMSOUTTAKEN)) 
		{
			return Define.TAKEN_SATUS_OUTTAKEN_IMAGE;
		}
		else if (takenStatus.equals(Define.TAKEN_SATUS_DELAYTAKEN)) 
		{
			return Define.TAKEN_SATUS_DELAYTAKEN_IMAGE;
		}
		else 
		{
			return Define.TAKEN_SATUS_NOTTAKEN_IMAGE;
		}
	}

	public String getTableString() {
		String str = "";
		str += this.getImage() + "/TAB/" + this.getTime();
		return str;
	}

	public String getHospital() {
		return hospital;
	}

	public void setHospital(String hospital) {
		this.hospital = hospital;
	}

	public String getMemoContent() {
		//return memoContent.replace("\r\n", "<br>");
		return memoContent;
	}

	public void setMemoContent(String memoContent) {
		this.memoContent = memoContent;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getErrorContent() {
		return errorContent;
	}

	public void setErrorContent(String errorContent) {
		this.errorContent = errorContent;
	}
	public String getTakencheck() {
		return takencheck;
	}

	public void setTakencheck(String Takencheck) {
		this.takencheck = Takencheck;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
}
