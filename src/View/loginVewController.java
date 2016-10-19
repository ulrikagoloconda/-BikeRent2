package View;

import Interfaces.DBAccess;
import Model.BikeUser;
import Model.DBAccessImpl;
import Model.JDBCConnection;
import helpers.Sound;
import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.PasswordField;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;

import java.net.URL;
import java.sql.SQLException;
import java.util.ResourceBundle;

import static Model.DBUtil.processException;

/**
 * @author Niklas Karlsson
 * @version 1.0
 * @since 2016-09-15
 */
public class LoginVewController implements Initializable {
    @FXML
    private TextField userNameText;
    @FXML
    private PasswordField passwordText;
    @FXML
    private AnchorPane loginPane;
    private JDBCConnection jdbcConnection;
    private DBAccess dbAccess = new DBAccessImpl();
    private BikeUser currentUser;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        Main.getSpider().setLoginView(this);
  }

    public void logInClick(Event event) {
        String userName = userNameText.getText();
        String password = passwordText.getText();

        try {
            currentUser = dbAccess.logIn(userName, password);
            if (currentUser.getUserID() > 0) {
                Sound pling = new Sound();
                pling.playSoundInThread(Sound.LEAVE_DICE);
                showMainGui();

            } else {
                System.out.println("Fel lösenord eller användarnam");
              String errorTitle = "Fel lösenord eller användarnam";
              ErrorView.showError(errorTitle, "fel vid inläsning", "Kontrollera era uppgifter", 0, new Exception("Fel lösenord eller användarnam"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            Sound pling = new Sound();
            pling.playMp3SoundInThread(Sound.NO);
            processException(e);
            //TODO nedanstående rad får felmeddelande som jag inte förstår
          //  ErrorView.showError("Inloggningsfel", "fel vid inloggning", "Kontrollera era uppgifter", e);

        }
  }
    public void showMainGui() {
        if (currentUser == null) {
            currentUser = new BikeUser();
            currentUser.setlName("Override");
            currentUser.setfName("Override");
            currentUser.setUserName("Override");
            currentUser.setMemberLevel(1010);
            currentUser.setPhone(101010);
            currentUser.setEmail("Override@Override.com");
        }
        Main.getSpider().getMain().showMainView();
    }

    public void newUserClick(ActionEvent actionEvent) {
        Main.getSpider().getMain().showNewUserView();
    }

    public BikeUser getCurrentUser() {
        return currentUser;
    }
}
