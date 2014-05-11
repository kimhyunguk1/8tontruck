package kr.re.etri.lifeinfomatics.promes.cmd.common;

/**
 * Command의 예외를 처리하는 Exception.
 *
 * @since 2004.06
 * @see Command클래스
 */
public class CommandException extends Exception {

    /**
     * CommandException 생성자로 부모 생성자를 호출.
     */
    public CommandException() {
        super();
    }

    /**
     * 예외발생 메세지를 가져와 메세지를 처리한다.
     *
     * @param msg 예외발생 메세지: msg
     */
    public CommandException(String msg) {
        super(msg);
    }
}
