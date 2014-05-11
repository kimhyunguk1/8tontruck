package kr.re.etri.lifeinfomatics.promes.util.sort;

import java.util.Comparator;

public class SortComparator implements Comparator<Object> {

	private String type = "";
	private String course = "UP";

	public SortComparator(String type) {
		this.type = type;
	}

	public SortComparator(String type, String course) {
		this.type = type;
		this.course = course;
	}

	public int compare(Object o1, Object o2) {
		String key1 = ((SortInterface) o1).getSortKey(this.type);
		String key2 = ((SortInterface) o2).getSortKey(this.type);
		if (course.equals("UP")) {
			return key1.compareTo(key2);
		}
		else {
			return key1.compareTo(key2) * -1;
		}
	}
}
