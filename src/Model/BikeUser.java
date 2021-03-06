package Model;

import java.time.LocalDate;

/**
 * @author Ulrika Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-16
 */
public class BikeUser {
  private int userID;
  private String userName;
  private String fName;
  private String lName;
  private int memberLevel;
  private String email;
  private int phone;
  private LocalDate memberSince;

  public BikeUser() {

  }

  public BikeUser(String userName, String fName, String lName, int memberLevel, String email, int phone, LocalDate memberSince) {
    this.userName = userName;
    this.fName = fName;
    this.lName = lName;
    this.memberLevel = memberLevel;
    this.email = email;
    this.phone = phone;
    this.memberSince = memberSince;
  }

  public int getUserID() {
    return userID;
  }

  public void setUserID(int userID) {
    this.userID = userID;
  }

  public String getfName() {
    return fName;
  }

  public void setfName(String fName) {
    this.fName = fName;
  }

  public String getlName() {
    return lName;
  }

  public void setlName(String lName) {
    this.lName = lName;
  }

  public int getMemberLevel() {
    return memberLevel;
  }

  public void setMemberLevel(int memberLevel) {
    this.memberLevel = memberLevel;
  }

  public String getEmail() {
    return email;
  }

  public void setEmail(String email) {
    this.email = email;
  }

  public int getPhone() {
    return phone;
  }

  public void setPhone(int phone) {
    this.phone = phone;
  }

  public LocalDate getMemberSince() {
    return memberSince;
  }

  public void setMemberSince(LocalDate memberSince) {
    this.memberSince = memberSince;
  }

  public String getUserName() {
    return userName;
  }

  public void setUserName(String userName) {
    this.userName = userName;
  }
}

