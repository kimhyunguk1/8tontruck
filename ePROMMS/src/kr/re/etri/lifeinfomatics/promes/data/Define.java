package kr.re.etri.lifeinfomatics.promes.data;

public class Define {
	public static String PILL_BOX_ONE = "1구";
	public static String PILL_BOX_TWO = "2구";
	public static String PILL_BOX_THREE = "3구";
	public static String PILL_BOX_FOUR = "4구";
	public static String PILL_BOX_ROLL = "연속형";
	public static String PILL_BOX_HANDY = "휴대용";
	public static String PILL_BOX_lOADCELL = "로드셀형";	

	public static String[] PILL_BOX = { PILL_BOX_ONE, PILL_BOX_TWO, PILL_BOX_THREE, PILL_BOX_FOUR, PILL_BOX_ROLL, PILL_BOX_HANDY ,PILL_BOX_lOADCELL};
	public static int[] PILL_BOX_CON = { 1, 2, 3, 4, 1, 0, 1 };

	public static String USER_MANAGER = "MANAGER";
	public static String USER_DOCTOR = "DOCTOR";
	public static String USER_PATIENT = "PATIENT";
	public static String USER_PHARMACIST = "PHARMACIST";
	public static String USER_INCHARGE = "INCHARGE";
	public static String USER_ADMIN = "ADMIN";

	public static String PRESCRIPTION_SATUS_NOSCHEDULE = "NOSCHEDULE";
	public static String PRESCRIPTION_SATUS_READY = "READY";
	public static String PRESCRIPTION_SATUS_ON = "ON";
	public static String PRESCRIPTION_SATUS_FINISH = "FINISH";
	public static String PRESCRIPTION_SATUS_STOP = "STOP";
	public static String[] PRESCRIPTION_SATUS_EN = { PRESCRIPTION_SATUS_NOSCHEDULE, PRESCRIPTION_SATUS_READY, PRESCRIPTION_SATUS_ON, PRESCRIPTION_SATUS_FINISH,PRESCRIPTION_SATUS_STOP };
	public static String[] PRESCRIPTION_SATUS_KOR = { "미등록", "알림전", "관리중", "관리완료" ,"관리중단"};

	public static String TAKEN_SATUS_NONE = "NONE";
	// public static String TAKEN_SATUS_TAKEN = "TAKEN";
	public static String TAKEN_SATUS_PRETAKEN = "PRETAKEN";
	public static String TAKEN_SATUS_FINISHTAKEN = "FINISHTAKEN";
	public static String TAKEN_SATUS_UNTAKEN = "UNTAKEN";
	// public static String TAKEN_SATUS_OUTTAKEN = "OUTTAKEN";
	public static String TAKEN_SATUS_PREUNTAKEN = "PREUNTAKEN";
	public static String TAKEN_SATUS_FINISHUNTAKEN = "FINISHUNTAKEN";
	public static String TAKEN_SATUS_PREOUTTAKEN = "PREOUTTAKEN";
	public static String TAKEN_SATUS_FINISHOUTTAKEN = "FINISHOUTTAKEN";
	public static String TAKEN_SATUS_SMSOUTTAKEN = "SMSOUTTAKEN";
	public static String TAKEN_SATUS_DELAYTAKEN = "DELAYTAKEN";

	public static String TAKEN_SATUS_NOPOSSESSION = "NOPOSSESSION";
	public static String TAKEN_SATUS_SIDEEFFECT = "SIDEEFFECT";
	public static String TAKEN_SATUS_TIMEOUT = "TIMEOUT";
	public static String TAKEN_SATUS_NOCONDITION = "NOCONDITION";
	public static String TAKEN_SATUS_ETC = "ETC";

	public static String[] TAKEN_SATUS = { TAKEN_SATUS_NONE, TAKEN_SATUS_PRETAKEN, TAKEN_SATUS_FINISHTAKEN, TAKEN_SATUS_UNTAKEN, TAKEN_SATUS_PREUNTAKEN, TAKEN_SATUS_FINISHUNTAKEN, TAKEN_SATUS_PREOUTTAKEN, TAKEN_SATUS_FINISHOUTTAKEN, TAKEN_SATUS_SMSOUTTAKEN, TAKEN_SATUS_NOPOSSESSION,
			TAKEN_SATUS_SIDEEFFECT, TAKEN_SATUS_TIMEOUT, TAKEN_SATUS_NOCONDITION, TAKEN_SATUS_ETC, TAKEN_SATUS_DELAYTAKEN };

	public static String ISDETAILSCHEDULE_TRUE = "1";
	public static String ISDETAILSCHEDULE_FALSE = "0";

	public static String[] EAT_TIME = { "아침", "점심", "저녁", "취침전", "직접입력" };

	public static String TAKEN_SATUS_NONE_IMAGE = "/PromesService/images/common/dot_05.gif";
	public static String TAKEN_SATUS_TAKEN_IMAGE = "/PromesService/images/common/dot_02.gif";
	public static String TAKEN_SATUS_NOTTAKEN_IMAGE = "/PromesService/images/common/dot_03.gif";
	public static String TAKEN_SATUS_OUTTAKEN_IMAGE = "/PromesService/images/common/dot_04.gif";
//	public static String TAKEN_SATUS_OUTTAKEN_IMAGE = "/PromesService/images/common/";
	public static String TAKEN_SATUS_FINISHOUTTAKEN_IMAGE = "/PromesService/images/common/dot_04.gif";
	public static String TAKEN_SATUS_FINISHUNTAKEN_IMAGE = "/PromesService/images/common/dot_03.gif";
	public static String TAKEN_SATUS_DELAYTAKEN_IMAGE = "/PromesService/images/common/dot_06.gif";
	public static String TAKEN_SATUS_TAKEN_FICKER_IMAGE = "/PromesService/images/common/dot_taken_ficker.gif";
	public static String TAKEN_SATUS_DELAYTAKEN_FICKER_IMAGE = "/PromesService/images/common/dot_delaytaken_ficker.gif";
	public static String REAL_PATH="";

	public static String[] WEEK_KOR = { "일", "월", "화", "수", "목", "금", "토" };

	public static String getPrescriptionStatusKor(String satus) {
		for (int i = 0; i < PRESCRIPTION_SATUS_EN.length; i++) {
			if (PRESCRIPTION_SATUS_EN[i].equals(satus)) {
				return PRESCRIPTION_SATUS_KOR[i];
			}
		}
		return "";
	}

	public static boolean checkTakenSatus(String satus) {
		for (int i = 0; i < TAKEN_SATUS.length; i++) {
			if (satus == null || satus.equals("")) {
				return false;
			}
			else if (TAKEN_SATUS[i].equals(satus)) {
				return true;
			}
		}
		return false;
	}

	public static int getPillBoxContainerNum(String pillBoxType) {
		for (int i = 0; i < PILL_BOX.length; i++) {
			if (PILL_BOX[i].equals(pillBoxType)) {
				return PILL_BOX_CON[i];
			}
		}
		return 0;
	}

}
