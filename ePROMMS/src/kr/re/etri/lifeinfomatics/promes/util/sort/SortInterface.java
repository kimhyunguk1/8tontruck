package kr.re.etri.lifeinfomatics.promes.util.sort;

import javax.servlet.http.HttpSessionBindingListener;

public interface SortInterface extends HttpSessionBindingListener{
	public String getSortKey(String type);
}
