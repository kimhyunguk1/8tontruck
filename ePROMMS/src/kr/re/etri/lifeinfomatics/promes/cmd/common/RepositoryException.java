package kr.re.etri.lifeinfomatics.promes.cmd.common;

import java.sql.*;

public class RepositoryException extends Exception {
    public RepositoryException() {

        super();
    }

    public RepositoryException(String msg) {
        super(msg);

    }

    public RepositoryException(SQLException e) {
        System.out.println("SQLState : " + e.getSQLState());
        System.out.println("Error Code : " + e.getErrorCode());
        System.out.println("Message : " + e.getMessage());
    }

    public void DSMRepositoryException(SQLException e) {
        System.out.println("SQLState : " + e.getSQLState());
        System.out.println("Error Code : " + e.getErrorCode());
        System.out.println("Message : " + e.getMessage());
    }
}
