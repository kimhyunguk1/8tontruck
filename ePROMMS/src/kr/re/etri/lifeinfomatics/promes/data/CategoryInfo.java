package kr.re.etri.lifeinfomatics.promes.data;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import kr.re.etri.lifeinfomatics.promes.util.Log;
import kr.re.etri.lifeinfomatics.promes.util.Util;
import kr.re.etri.lifeinfomatics.promes.util.sort.SortInterface;


/**
 * @author 최재훈
 * 카테고리 정보
 */
public class CategoryInfo {

	private String category_code;			// 카테고리 코드
	private String category_name;			// 카테고리 이름
	
	
	
	public String getCategory_code() {
		return category_code;
	}


	public void setCategory_code(String category_code) {
		this.category_code = category_code;
	}


	public String getCategory_name() {
		return category_name;
	}


	public void setCategory_name(String category_name) {
		this.category_name = category_name;
	}
}
