package Model;
/**
 * @author Niklas Karlsson
 * @version 1.0
 * @since 2016-09-15
 */
import sample.DBType;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

  private static final String USERNAME_Ulrika = "root";
  private static final String PASSWORD_Ulrika = "Forfattare1";
  private static final String CONN_STRING_Ulrika =
      "jdbc:mysql://localhost:3306/bikerentDB";

  private static final String USERNAME_Niklas = "dbuser";
  private static final String PASSWORD_Niklas = "1234";
  private static final String CONN_STRING_Niklas ="jdbc:mysql://localhost/bikerent";


  public static Connection getConnection(DBType dbType) throws SQLException {
    System.out.println("in model/dbutil");
    if(helpers.PCRelated.isThisNiklasPC()){
      dbType = DBType.Niklas;
    }else{
      dbType = DBType.Ulrika;
    }
    switch (dbType) {
      case Ulrika:
        System.out.println("Ulrikas inloggning");
       /* try {
        //  Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
          e.printStackTrace();
        }*/
        return DriverManager.getConnection(CONN_STRING_Ulrika, USERNAME_Ulrika, PASSWORD_Ulrika);
			//return DriverManager.getConnection(CONN_STRING, USERNAME, PASSWORD);

      case Niklas:
        System.out.println("Niklas inloggning");
        return DriverManager.getConnection(CONN_STRING_Niklas, USERNAME_Niklas, PASSWORD_Niklas);
      default:
        System.out.println("No database user...");
        return null;
    }
  }

  /*
  To use example:
  try {
       DriverManager.getConnection(CONN_STRING_GAME, USERNAME, PASSWORD);
       } catch (SQLException e) {
         processException(e);
       }
   */
  public static void processException(SQLException e) { //catch SQL fault :-)
    System.err.println("\n-------------------------------------------------------------------------------");
    System.err.println("error message: " +e.getMessage());
    System.err.println("error codee: " +e.getErrorCode());
    System.err.println("SQL state: " +e.getSQLState());
    System.err.println("-------------------------------------------------------------------------------\n");

  }
}
