package kr.re.etri.lifeinfomatics.promes.cmd;

import javax.servlet.http.HttpServletRequest;

import kr.re.etri.lifeinfomatics.promes.cmd.common.Command;
import kr.re.etri.lifeinfomatics.promes.cmd.common.CommandException;

public class LoadJoinCommand implements Command {

	private String next = "";

	public LoadJoinCommand(String next) {
		this.next = next;
	}

	public String execute(HttpServletRequest req) throws CommandException {

		req.getSession().removeAttribute("userInfo");

		return next;
	}

}
