package kr.re.etri.lifeinfomatics.promes.data;



/**
 * @author 김형욱
 * 로드셀스케쥴
 */

public class LoadCellInfo {
	private String userId;             //환자 id
	private String schedule_Id;        //등록된 스케줄의 id
	private String priscription_Id;    //처방전 id
	private String medicbox_Id;        //약상자 id
	
	
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getSchedule_Id() {
		return schedule_Id;
	}
	public void setSchedule_Id(String schedule_Id) {
		this.schedule_Id = schedule_Id;
	}
	public String getPriscription_Id() {
		return priscription_Id;
	}
	public void setPriscription_Id(String priscription_Id) {
		this.priscription_Id = priscription_Id;
	}
	public String getMedicbox_Id() {
		return medicbox_Id;
	}
	public void setMedicbox_Id(String medicbox_Id) {
		this.medicbox_Id = medicbox_Id;
	}

}
