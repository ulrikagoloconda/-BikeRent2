package View;
//nej inte denna..
import Interfaces.DBAccess;
import Model.BikeUser;
import Model.DBAccessImpl;
import Model.JDBCConnection;
import helpers.EmailValidator;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.input.KeyEvent;
import javafx.scene.paint.Color;

import java.io.IOException;
import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

/**
 * @author Ulrika, Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-19
 */
public class ChangeUserTry implements Initializable {
    @FXML
    private TextField userNameText;
    @FXML
    private TextField fNameText;
    @FXML
    private TextField lNameText;
    @FXML
    private TextField mailText;
    @FXML
    private TextField phoneText;
    @FXML
    private TextField passwordText;
    @FXML
    private TextField passwordCheckerText;

    @FXML
    private Label uniqeTextIdLabel;
    @FXML
    private JDBCConnection jdbcConnection;
    private DBAccess dbAccess = new DBAccessImpl();
    public BikeUser currentUser;
    private String errorTitle = "fel i uppdatera användare";

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        Main.getSpider().setChangeUserTry(this);
    }
    public ChangeUserTry() {
        ;
    }


    public void showLoginGui() {
        Main.getSpider().getMain().showNewUserView();
       /* try {
            FXMLLoader loginViewLoader = Main.getSpider().getMain().getNewUserLoader();
            System.out.println("fel fönster laddas i denna version..");
            Parent loginViewRoot = (Parent) loginViewLoader.load();
            Scene loginViewScean = new Scene(loginViewRoot);
            Main.getSpider().getMain().getPrimaryStage().setScene(loginViewScean);
          currentUser = (Main.getSpider().getLoginView().getCurrentUser());
          System.out.println("test i change user" + currentUser.getEmail());
          */
          populateText();

      /*  } catch (IOException e) {
          e.printStackTrace();
          ErrorView.showError("Huvudfönster - fel", "fel vid inläsning av data..", "Kontrollera er data..", e);
        }
        */

    }


  private void populateText() {
    userNameText.setText(currentUser.getUserName());
    fNameText.setText(currentUser.getfName());
    lNameText.setText(currentUser.getlName());
    mailText.setText(currentUser.getEmail());
    phoneText.setText(Integer.toString(currentUser.getPhone()));
    passwordText.setText("");
    passwordCheckerText.setText("");

    System.out.println("test i populate user" + currentUser.getEmail());
  }



    public void newUserClick(ActionEvent actionEvent) {
        System.out.println("clicked on newUserClick");
        String userName = userNameText.getText();
        String fName = fNameText.getText();
        String lName = lNameText.getText();
        String email = mailText.getText();
        String phoneString = phoneText.getText();
        String password = passwordText.getText();
        String passwordChecker = passwordCheckerText.getText();
        phoneString.replace("-", "");
        phoneString.replace("+", "");


        try {
            if (userName.length() < 5) {
                System.out.println("username to short");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("username is to short!"));
            } else if (!dbAccess.isUserAvalible(userName)) {
                System.out.println("username not free");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("username is allready taken!"));
            } else if (password.length() < 1) {
                System.out.println("password is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("password is to short!"));
            } else if (!password.equals(passwordChecker)) {
                System.out.println("passw not same");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("password is to not the same!"));
            } else if (!EmailValidator.validate(email)) {
                System.out.println("email not ok format!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("email not ok format!"));
            } else if (phoneString.length() < 2) {
                System.out.println("phone is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("phone is to short!"));
            } else if (fName.length() < 1) {
                System.out.println("fName is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("First Name is to short!"));
            } else if (lName.length() < 1) {
                System.out.println("phone is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("Last Name is to short!"));
            } else if (phoneString.length() < 2) {
                System.out.println("phone is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("phone is to short!"));
            } else {
                int phone = Integer.parseInt(phoneString);
                System.out.println("we can now add some info");
                //insert_new_user(in_fname varchar(50),in_lname varchar(50),in_memberlevel varchar(50),in_email varchar(50),in_phone varchar(50),in_username varchar(50), in_passw varchar(50)) RETURNS smallint(6)
                int in_memberlevel = 1;
                boolean isAddUserOK = dbAccess.InsertNewUser(fName, lName, in_memberlevel, email, phone, userName, password);
                if (!isAddUserOK) {
                    ErrorView.showError(errorTitle, "fel vid inläsning", "Kontrollera era uppgifter", new IOException(" :-( kunde inte lägga till användare"));
                }
                if (isAddUserOK) {
                    boolean d = DialogView.showSimpleInfo("Ny användare upplaggd", "Lyckades", "Ny användare är nu upplagd");
                   Main.getSpider().getMain().showLoginView();
                    /*try {
                        FXMLLoader loginLoader = Main.getSpider().getMain().getLoginViewLoader();
                        Parent loginRoot = (Parent) loginLoader.load();
                        Scene loginScean = new Scene(loginRoot);
                        Main.getSpider().getMain().getPrimaryStage().setScene(loginScean);

                    } catch (IOException e) {
                        e.printStackTrace();
                        ErrorView.showError(errorTitle, "fel vid inläsning av data..", "Kontrollera er data..", e);
                    }*/

                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            ErrorView.showError(errorTitle, "fel vid lägg till användare", "Kontrollera era uppgifter", e);
        }

//      ErrorView.showError("Inloggningsfel", "fel vid inloggning","Kontrollera era uppgifter" ,  e);
    }


    public void checkUserName(KeyEvent keyEvent) {
        System.out.println("entering get username");
        String userName = userNameText.getText();
        if (userName.length() <= 5) {
            uniqeTextIdLabel.setText("Måste vara längre än 5 tecken");
            uniqeTextIdLabel.setTextFill(Color.RED);
        } else {
            //userName
 /*     try {
        if (!dbAccess.isUserAvalible(userName)){
          uniqeTextIdLabel.setText("Ej unikt..");
          uniqeTextIdLabel.setTextFill(Color.RED);
        }
        else{
          System.out.println("Ok username");
          uniqeTextIdLabel.setText("Användarnamn OK..");
          uniqeTextIdLabel.setTextFill(Color.GREEN);
        }
      } catch (SQLException e) {
        processException(e);
        uniqeTextIdLabel.setText("Ej unikt..");
        uniqeTextIdLabel.setTextFill(Color.RED);
        ErrorView.showError("Inloggningsfel", "fel vid inloggning","Kontrollera era uppgifter" ,  e);
      }
*/
        }

    }

    public void updateUserClick(ActionEvent actionEvent) {
        System.out.println("clicked on updateUserClick");
        String userName = userNameText.getText();
        String fName = fNameText.getText();
        String lName = lNameText.getText();
        String email = mailText.getText();
        String phoneString = phoneText.getText();
        String password = passwordText.getText();
        String passwordChecker = passwordCheckerText.getText();
        phoneString.replace("-", "");
        phoneString.replace("+", "");


        try {
            if (userName.length() < 1) {
                System.out.println("username to short");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("username is to short!"));
                //}else if (!dbAccess.isUserAvalible(userName)) {
                // System.out.println("username not free");
                // ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("username is allready taken!") );
            } else if (password.length() < 1) {
                System.out.println("password is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("password is to short!"));
            } else if (!password.equals(passwordChecker)) {
                System.out.println("passw not same");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("password is to not the same!"));
            } else if (!EmailValidator.validate(email)) {
                System.out.println("email not ok format!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("email not ok format!"));
            } else if (phoneString.length() < 2) {
                System.out.println("phone is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("phone is to short!"));
            } else if (fName.length() < 1) {
                System.out.println("fName is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("First Name is to short!"));
            } else if (lName.length() < 1) {
                System.out.println("phone is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("Last Name is to short!"));
            } else if (phoneString.length() < 2) {
                System.out.println("phone is to short!");
                ErrorView.showError(errorTitle, "fel vid uppdatering", "Kontrollera era uppgifter", new IOException("phone is to short!"));
            } else {
                int phone = Integer.parseInt(phoneString);
                System.out.println("we can now add some info");
                //insert_new_user(in_fname varchar(50),in_lname varchar(50),in_memberlevel varchar(50),in_email varchar(50),in_phone varchar(50),in_username varchar(50), in_passw varchar(50)) RETURNS smallint(6)
                int in_memberlevel = currentUser.getMemberLevel();
                boolean isUpdateUserOK = dbAccess.UpdateUser(fName, lName, in_memberlevel, email, phone, userName, password);
                if (!isUpdateUserOK) {
                    ErrorView.showError(errorTitle, "fel vid inläsning", "Kontrollera era uppgifter", new IOException(" :-( kunde inte uppdatera uppgifter"));
                }
                if (isUpdateUserOK) {
                    boolean d = DialogView.showSimpleInfo("Uppdaterat", "Lyckades", "Ny är detta uppdaterat");

                 Main.getSpider().getMain().showLoginView();
                   /* try {
                        FXMLLoader loginLoader = Main.getSpider().getMain().getLoginViewLoader();
                        Parent loginRoot = (Parent) loginLoader.load();
                        Scene loginScean = new Scene(loginRoot);
                        Main.getSpider().getMain().getPrimaryStage().setScene(loginScean);

                    } catch (IOException e) {
                        e.printStackTrace();
                        ErrorView.showError(errorTitle, "fel vid inläsning av data..", "Kontrollera er data..", e);
                    }*/

                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            ErrorView.showError(errorTitle, "fel vid lägg till användare", "Kontrollera era uppgifter", e);
        }

//      ErrorView.showError("Inloggningsfel", "fel vid inloggning","Kontrollera era uppgifter" ,  e);
    }

    public void abortClick(ActionEvent actionEvent) {
        Main.getSpider().getMain().showLoginView();
      /*  try {
            FXMLLoader loginLoader = Main.getSpider().getMain().getLoginViewLoader();
            Parent loginRoot = (Parent) loginLoader.load();
            Scene loginScean = new Scene(loginRoot);
            Main.getSpider().getMain().getPrimaryStage().setScene(loginScean);

        } catch (IOException e) {
            e.printStackTrace();
            ErrorView.showError(errorTitle, "fel vid Öppnining av data..", "starta om denna session..", e);
        }*/

    }


    public void dissableClick(ActionEvent actionEvent) {

        userNameText.setText(currentUser.getUserName());
        int in_memberlevel = 0;
        boolean isUpdateUserOK = false;
        try {
            isUpdateUserOK = dbAccess.UpdateUser(currentUser.getfName(), currentUser.getlName(), in_memberlevel, currentUser.getEmail(), currentUser.getPhone(), currentUser.getUserName(), "1234");
        } catch (SQLException e) {
            e.printStackTrace();
            ErrorView.showError(errorTitle, "fel vid dissable account..", "starta om denna session.. pw 1234", e);
        }
        if (!isUpdateUserOK) {
            ErrorView.showError(errorTitle, "fel vid inläsning", "Kontrollera era uppgifter", new IOException(" :-( kunde inte uppdatera uppgifter"));
        }
        if (isUpdateUserOK) {
            boolean d = DialogView.showSimpleInfo("kontot har blivid av-aktiverat", "Lyckades", "Nu ärkonott avaktiverat med lösenord: 1234");
         Main.getSpider().getMain().showLoginView();
          /*  try {
                FXMLLoader loginLoader = Main.getSpider().getMain().getLoginViewLoader();
                Parent loginRoot = (Parent) loginLoader.load();
                Scene loginScean = new Scene(loginRoot);
                Main.getSpider().getMain().getPrimaryStage().setScene(loginScean);

            } catch (IOException e) {
                e.printStackTrace();
                ErrorView.showError(errorTitle, "fel vid inläsning av data..", "Kontrollera er data..", e);
            }
            */
        }
    }

}
