package Model;

import sample.DBType;

import java.sql.*;

/**
 * @author Niklas Karlsson
 * @version 1.0
 * @since 2016-09-15
 */
public class AccessUser {


  public static BikeUser loginUser1(String userName, String passW) throws SQLException {
//  userID fname lname memberlevel email phone username passw memberSince
   /*
DROP FUNCTION IF EXISTS check_password;
DELIMITER //
CREATE FUNCTION check_password(tryusername varchar(50), trypassword varchar(50)) RETURNS smallint(6)
    BEGIN
    DECLARE pw VARBINARY(56);
    SET pw = (SELECT passw FROM bikeuser WHERE userName=tryusername);
    if exists(SELECT * from bikeuser WHERE userName= tryusername AND pw=AES_ENCRYPT(trypassword,'tackforkaffet'))
    THEN
    RETURN 1;
    ELSE
    RETURN 0;
    END IF;
    END//
DELIMITER ;
    */
//'Niklas', 'Karlsson', 0, 'cykeltur@gmail.com', 0703032191 , 'cykeltur' , AES_ENCRYPT('1234','tackforkaffet') , CURDATE());

    //String SQLQueryLogInStage1 = "SELECT * FROM bikeuser WHERE userName = ? AND passw = ?";

    DBType dataBase = null;
    if (helpers.PCRelated.isThisNiklasPC()) {
      dataBase = DBType.Niklas;
    } else {
      dataBase = DBType.Ulrika;

    }
    // boolean isLoginOK = isLoginInfoOK(userName, passW, dataBase);

    //if ( isLoginInfoOK(userName, passW, dataBase) ){
    BikeUser logedInBikeUser = new BikeUser();
    logedInBikeUser = getUserinfo(userName, dataBase);
    System.out.println("accessBike in loginuser");
    System.out.println("logedInBikeUser: " + logedInBikeUser.getEmail());
    return logedInBikeUser;
    //}else{
    //  return null;
    //}

  }

  public static BikeUser loginUser(String userName, String tryPassW)  {
    BikeUser returnUser = new BikeUser();
    int userID = 0;
    DBType dataBase = null;
    if (helpers.PCRelated.isThisNiklasPC()) {
      dataBase = DBType.Niklas;
    } else {
      dataBase = DBType.Ulrika;
    }
    try {
      Connection conn = DBUtil.getConnection(dataBase);
      String sql = "CALL temp_return_password_binary(?,?,?,?,?)";
      CallableStatement cs = conn.prepareCall(sql);
      cs.setString(1, userName);
      cs.setString(2, tryPassW);
      cs.registerOutParameter(3, Types.VARBINARY);
      cs.registerOutParameter(4, Types.VARBINARY);
      cs.registerOutParameter(5,Types.INTEGER);
      cs.executeQuery();
      byte[] passw1 = cs.getBytes(3);
      byte[] passw2 = cs.getBytes(4);
      userID = cs.getInt(5);
      boolean testBol = true;

      if(passw1.length>0) {
        for (int i = 0; i < passw1.length; i++) {
          if (passw1[i] != passw2[i]) {
            testBol = false;
          }
        }
      }else {
        testBol = false;
      }
      if(testBol){
        returnUser = getBikeUserByID(userID);
      } else {
        returnUser.setUserID(-1);
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
    return returnUser;
  }


  public static BikeUser getBikeUserByID(int id) {
    BikeUser returnUser = new BikeUser();
    DBType dataBase = null;
    if (helpers.PCRelated.isThisNiklasPC()) {
      dataBase = DBType.Niklas;
    } else {
      dataBase = DBType.Ulrika;
    }
    try {
      Connection conn = DBUtil.getConnection(dataBase);
      String sql = "SELECT fname,lname,memberlevel,email,phone,username FROM bikeuser WHERE userID=?";
      PreparedStatement ps = conn.prepareStatement(sql);
      ps.setInt(1, id);
      ResultSet rs = ps.executeQuery();
      if (rs.next()) {
        returnUser.setUserName(rs.getString("username"));
        returnUser.setEmail(rs.getString("email"));
        returnUser.setlName(rs.getString("lname"));
        returnUser.setfName(rs.getString("fname"));
        returnUser.setMemberLevel(rs.getInt("memberlevel"));
        returnUser.setPhone(rs.getInt("phone"));
        returnUser.setUserID(id);
      }

    } catch (Exception e) {
      e.printStackTrace();
    }
    return returnUser;
  }


  public static boolean isUserAvalible(String userName) throws SQLException {
    DBType dataBase = null;
    if (helpers.PCRelated.isThisNiklasPC()) {
      dataBase = DBType.Niklas;
    } else {
      dataBase = DBType.Ulrika;
    }
    String SQLQuerygetUserinfo = "{call getUserFromUserName(?)}";
    ResultSet rs = null;
    try ( //only in java 7 and later!!
          Connection conn = DBUtil.getConnection(dataBase); //database_user type like ENUM and get PW :-);
          CallableStatement stmt = conn.prepareCall(SQLQuerygetUserinfo);
    ) {
      stmt.setString(1, userName);
      rs = stmt.executeQuery();
      if (!rs.next()) {
        System.out.println("ledig användare");
        return true;
      } else {
        System.out.println("UPPTAGEN användare");
        return false;
      }
    } finally {
      if (rs != null) rs.close();
    }

  }

  private static BikeUser getUserinfo(String userName, DBType dataBase) throws SQLException {
    BikeUser logedInBikeUser = new BikeUser();
    String SQLQuerygetUserinfo = "{call getUserFromUserName(?)}";
    ResultSet rs = null;
    try ( //only in java 7 and later!!
          Connection conn = DBUtil.getConnection(dataBase); //database_user type like ENUM and get PW :-);
          CallableStatement stmt = conn.prepareCall(SQLQuerygetUserinfo);
    ) {
      stmt.setString(1, userName);
      rs = stmt.executeQuery();
      rs.next();
      logedInBikeUser.setUserID(rs.getInt("userID"));
      logedInBikeUser.setfName(rs.getString("fname"));
      logedInBikeUser.setlName(rs.getString("lname"));
      logedInBikeUser.setEmail(rs.getString("email"));
      logedInBikeUser.setPhone(rs.getInt("phone"));
      logedInBikeUser.setMemberLevel(rs.getInt("memberlevel"));
      logedInBikeUser.setMemberSince(rs.getDate("membersince").toLocalDate());
      logedInBikeUser.setUserName(rs.getString("username"));
    } finally {
      if (rs != null) rs.close();
    }
    return logedInBikeUser;
  }


  private static boolean isLoginInfoOK(String userName, String passW, DBType dataBase) throws SQLException {
    boolean isLoginOK;
    String SQLQueryLogInStage = "{? = call check_password(?, ?)}";
    ResultSet rs = null;
    try ( //only in java 7 and later!!
          Connection conn = DBUtil.getConnection(dataBase); //database_user type like ENUM and get PW :-);
          CallableStatement stmt = conn.prepareCall(SQLQueryLogInStage);
    ) {
      stmt.registerOutParameter(1, Types.BOOLEAN);
      stmt.setString(2, userName);
      stmt.setString(3, passW);
      stmt.execute();
      isLoginOK = stmt.getBoolean(1); //1 or 0....
    } finally {
      if (rs != null) rs.close();
    }
    return isLoginOK;
  }

  public static boolean insertNewUser(String fname, String lname, int memberlevel, String email, int phone, String username, String passw) {
    String SQLInsertUser = "SELECT insert_new_user(?, ?, ?, ?, ?, ?, ?)";
    ResultSet rs = null;
    DBType dataBase = null;
    if (helpers.PCRelated.isThisNiklasPC()) {
      dataBase = DBType.Niklas;
    } else {
      dataBase = DBType.Ulrika;
    }
    try ( //only in java 7 and later!!
          Connection conn = DBUtil.getConnection(dataBase); //database_user type like ENUM and get PW :-);
          PreparedStatement stmt = conn.prepareStatement(SQLInsertUser, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    ) {
      stmt.setString(1, fname);
      stmt.setString(2, lname);
      stmt.setInt(3, memberlevel);
      stmt.setString(4, email);
      stmt.setInt(5, phone);
      stmt.setString(6, username);
      stmt.setString(7, passw);
      rs = stmt.executeQuery();
      int nrFound = 0;
      while (rs.next()) {
        boolean isAddOK = rs.getBoolean(1);
        return isAddOK;
      }

    } catch (SQLException e) {
      DBUtil.processException(e);
      return false;
    } finally {
      if (rs != null) try {
        rs.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }

    return false;
  }


  public static boolean UpdateUser(String fname, String lname, int memberlevel, String email, int phone, String username, String passw) {
    String SQLInsertUser = "SELECT update_user(?, ?, ?, ?, ?, ?, ?)";
    ResultSet rs = null;
    DBType dataBase = null;
    if (helpers.PCRelated.isThisNiklasPC()) {
      dataBase = DBType.Niklas;
    } else {
      dataBase = DBType.Ulrika;
    }
    try ( //only in java 7 and later!!
          Connection conn = DBUtil.getConnection(dataBase); //database_user type like ENUM and get PW :-);
          PreparedStatement stmt = conn.prepareStatement(SQLInsertUser, ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
    ) {
      stmt.setString(1, fname);
      stmt.setString(2, lname);
      stmt.setInt(3, memberlevel);
      stmt.setString(4, email);
      stmt.setInt(5, phone);
      stmt.setString(6, username);
      stmt.setString(7, passw);
      rs = stmt.executeQuery();
      int nrFound = 0;
      while (rs.next()) {
        boolean isAddOK = rs.getBoolean(1);
        return isAddOK;
      }

    } catch (SQLException e) {
      DBUtil.processException(e);
      return false;
    } finally {
      if (rs != null) try {
        rs.close();
      } catch (SQLException e) {
        e.printStackTrace();
      }
    }

    return false;
  }
}

