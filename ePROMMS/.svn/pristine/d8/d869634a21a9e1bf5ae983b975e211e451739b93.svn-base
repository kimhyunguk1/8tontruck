package kr.re.etri.lifeinfomatics.promes.cmd.user;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;

public class LoadAddUserInfoCommand implements Command{
	private String next = "";

	public LoadAddUserInfoCommand(String next) {
		this.next = next;
	}
	public String execute(HttpServletRequest req) throws CommandException {
		
		req.getSession().removeAttribute("userInfo");
		
		return next;
	}
}
