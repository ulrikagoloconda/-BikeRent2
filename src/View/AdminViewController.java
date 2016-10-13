package View;

import Interfaces.DBAccess;
import Model.Bike;
import Model.BikeUser;
import Model.DBAccessImpl;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.GridPane;
import javafx.scene.layout.Pane;

import java.net.URL;
import java.util.ResourceBundle;

/**
 * @author Ulrika Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-17
 */
public class AdminViewController implements Initializable {
    private Bike newBike;
    private BikeUser currentUser;
    //private loginVewController loginView;
    private DBAccess dbAccess = new DBAccessImpl();
    @FXML
    private Label urlLabel;
    @FXML
    private TextField brandText, modelYearText, colorText, typeText, sizeText;
    @FXML
    private GridPane gridDelBike;
    @FXML
    private AnchorPane deletePane,addBikePane;
    @FXML
    private Pane editPane;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        Main.getSpider().setAdminView(this);
    }

    public void showDeleteView(ActionEvent actionEvent) {
       Main.getSpider().getMain().showDeleteView();
    }

    public void showAddView(ActionEvent actionEvent) {
        Main.getSpider().getMain().showAddBikeView();
    }
}
