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

	private static final String USERNAME_Ulrika = "root";
	private static final String PASSWORD_Ulrika = "Forfattare1";
	private static final String CONN_STRING_Ulrika =
			"jdbc:mysql://localhost:3306/bikerentDB";

  private static final String USERNAME_Niklas = "dbuser";
  private static final String PASSWORD_Niklas = "1234";
	private static final String CONN_STRING_Niklas =
			"jdbc:mysql://localhost/bikerentDB";
	
	public static Connection getConnection(DBType dbType) throws SQLException {
    System.out.println("in sample/dbutil" + dbType);
		switch (dbType) {
		case Ulrika:
      return DriverManager.getConnection(CONN_STRING_Ulrika, USERNAME_Ulrika, PASSWORD_Ulrika);
		//	return DriverManager.getConnection(CONN_STRING_Ulrika, USERNAME_Ulrika, PASSWORD_Ulrika);


      case Niklas:
        return DriverManager.getConnection(CONN_STRING_Niklas, USERNAME_Niklas, PASSWORD_Niklas);
		default:
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
