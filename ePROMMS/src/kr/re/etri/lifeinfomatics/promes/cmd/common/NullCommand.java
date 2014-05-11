package kr.re.etri.lifeinfomatics.promes.cmd.common;

import javax.servlet.http.*;


public class NullCommand implements Command {

    private String next;

    public NullCommand(String next) {
        this.next = next;
    }

    public String execute(HttpServletRequest req) throws CommandException {
//        Log.out.debug("[Null Next is] : " + next);
        return next;
    }

}
