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
public class loginVewController implements Initializable{
    @FXML
    private TextField userNameText;
    @FXML
    private PasswordField passwordText;
    @FXML
    private AnchorPane loginPane;
    private JDBCConnection jdbcConnection;
    private DBAccess dbAccess = new DBAccessImpl();
    private BikeUser currentUser ;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
      System.out.println("inne i init login");
    Main.getSpider().setLoginView(this);


    }

    public void logInClick(Event event) {
        String userName = userNameText.getText();
        String password = passwordText.getText();
        System.out.println("logInClick");

      try {
        currentUser = dbAccess.logIn(userName,password);
        System.out.println("after dbAccess.logIn(userName,password)");
        System.out.println(currentUser.getEmail());
        if (currentUser !=null){
          Sound pling = new Sound();
          pling.playSoundInThread(Sound.LEAVE_DICE);
                  showMainGui();
        }
      } catch (SQLException e) {
        Sound pling = new Sound();
        pling.playMp3SoundInThread(Sound.NO);
        processException(e);
        ErrorView.showError("Inloggningsfel", "fel vid inloggning","Kontrollera era uppgifter" ,  e);
      }
    }

  public void showMainGui() {
    if (currentUser == null){
      currentUser = new BikeUser();
      currentUser.setlName("Override");
      currentUser.setfName("Override");
      currentUser.setUserName("Override");
      currentUser.setMemberLevel(1010);
      currentUser.setPhone(101010);
      currentUser.setEmail("Override@Override.com");
    }
      Main.getSpider().getMain().showMainView();
       /* try {

            FXMLLoader MainViewLoader = Main.getSpider().getMain().getMainViewLoader();
            Parent MainViewRoot = (Parent) MainViewLoader.load();
            Scene MainViewScean = new Scene(MainViewRoot);
            Main.getSpider().getMain().getPrimaryStage().setScene(MainViewScean);


        } catch (IOException e) {
            e.printStackTrace();
            ErrorView.showError("Huvudfönster - fel", "fel vid inläsning av data..","Kontrollera er data.." ,  e);

        }*/

    }

  public void newUserClick(ActionEvent actionEvent) {
    System.out.println("clicked on newUserClick");

      Main.getSpider().getMain().showNewUserView();
    /*try {

      FXMLLoader newUserLoader =Main.getSpider().getMain().getNewUserLoader();
      Parent newUserRoot = (Parent) newUserLoader.load();
      Scene newUserScean = new Scene(newUserRoot);
      Main.getSpider().getMain().getPrimaryStage().setScene(newUserScean);

    } catch (IOException e) {
      e.printStackTrace();
      ErrorView.showError("Lägg till användare-fönster - fel", "fel vid inläsning av data..","Kontrollera er data.." ,  e);
    }
    */
  }

  public BikeUser getCurrentUser() {
    return currentUser;

  }



  public void setCurrentUser(BikeUser bikeUser) {
    System.out.println("in setcurentUser!!" + currentUser.getfName());
   currentUser = bikeUser;
    System.out.println("updated bikeuser!!" + currentUser.getfName());
  }
}
