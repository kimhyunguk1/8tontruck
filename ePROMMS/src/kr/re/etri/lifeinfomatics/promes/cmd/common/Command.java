package kr.re.etri.lifeinfomatics.promes.cmd.common;

import javax.servlet.http.*;

/**
 * Command ����� �ϴ� �������̽�.
 *
 * @since 2004.06
 */
public interface Command {

    /**
     * Command ����� �����ϴ� Method.
     *
     * @param req HttpServletRequest: req
     * @exception CommandException
     */
	
        public String execute(HttpServletRequest req) throws CommandException;
}
