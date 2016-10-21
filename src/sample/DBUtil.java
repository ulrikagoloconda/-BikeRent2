package sample;
/**
 * @author Niklas Karlsson
 * @version 1.0
 * @since 2016-09-15
 */

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

  private static String USERNAME_Ulrika;
  private static String PASSWORD_Ulrika;
  private static String CONN_STRING_Ulrika;


  private static String USERNAME_Niklas;
  private static String PASSWORD_Niklas;
  private static String CONN_STRING_Niklas;

  public static Connection getConnection(DBType dbType) throws SQLException {
    System.out.println("in sample/dbutil" + dbType);
    switch (dbType) {
      case Ulrika:
        return DriverManager.getConnection(CONN_STRING_Ulrika, USERNAME_Ulrika, PASSWORD_Ulrika);
      case Niklas:
        return DriverManager.getConnection(CONN_STRING_Niklas, USERNAME_Niklas, PASSWORD_Niklas);
      default:
        return null;
    }
  }

  public static void processException(SQLException e) { //catch SQL fault :-)
    System.err.println("\n-------------------------------------------------------------------------------");
    System.err.println("error message: " + e.getMessage());
    System.err.println("error codee: " + e.getErrorCode());
    System.err.println("SQL state: " + e.getSQLState());
    System.err.println("-------------------------------------------------------------------------------\n");

  }
}
