package TabelsRS;

/**
 * @author Niklas Karlsson
 * @version 1.0
 * @since 2016-09-15
 */

import java.sql.ResultSet;
import java.sql.SQLException;

public class UserLoginTable {
  //userID	fname	lname	memberlevel	email	phone	username	passw	memberSince

  public static void displayData(ResultSet rs) throws SQLException {
    while (rs.next()) {
      StringBuffer buffer = new StringBuffer();

      buffer.append("userID " + rs.getInt("userID") + ": ");
      buffer.append(rs.getString("fname"));

      System.out.println(buffer.toString());

    }
  }

  public static String displayUserID(ResultSet rs) throws SQLException {
    StringBuffer buffer = new StringBuffer();
    while (rs.next()) {

      buffer.append(rs.getInt("userID"));

      System.out.println(buffer.toString());

    }
    return buffer.toString();
  }
  public static String displayPassW(ResultSet rs) throws SQLException {
    StringBuffer buffer = new StringBuffer();
    while (rs.next()) {
      buffer.append( rs.getInt("userID"));
      System.out.println(buffer.toString());
    }
    return buffer.toString();
  }


}
