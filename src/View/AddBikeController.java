package View;

import Interfaces.DBAccess;
import Model.AccessBike;
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
import javafx.stage.FileChooser;
import org.apache.commons.io.FileUtils;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.IOException;
import java.net.URL;
import java.util.ResourceBundle;

/**
 * @author Ulrika Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-19
 */
public class AddBikeController implements Initializable {
    private Bike newBike;
    private loginVewController loginView;
    private DBAccess dbAccess = new DBAccessImpl();
   private BikeUser currentUser;
    private loginVewController loginVew;
    @FXML
    private Label urlLabel,messageLabel;
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
        Main.getSpider().setAddBikeView(this);
        currentUser = Main.getSpider().getLoginView().getCurrentUser();
    }

    public void showDeleteView(ActionEvent actionEvent) {
        Main.getSpider().getLoginView().showMainGui();
    }


    public void addBike(ActionEvent actionEvent) {
        if (newBike.equals(null)) {
            newBike = new Bike();
        } else {
            if (brandText.getText().length() > 0) {
                newBike.setBrandName(brandText.getText());
            }
            if (modelYearText.getText().length() == 4) {
                String s = modelYearText.getText();
                for (int i = 0; i < 4; i++) {
                    if (!Character.isDigit(s.charAt(i))) {
                        modelYearText.setText("");
                        break;
                    } else {
                        int yearInt = Integer.valueOf(s);

                        newBike.setModelYear(yearInt);
                    }
                }
            }
            if (colorText.getText().length() > 0) {
                newBike.setColor(colorText.getText());
            }
            if (typeText.getText().length() > 0) {
                newBike.setType(typeText.getText());
            }

            if (sizeText.getText().length() <= 2) {
                String s = sizeText.getText();
                if (Character.isDigit(s.charAt(0)) && Character.isDigit(s.charAt(1))) {
                    int i = Integer.valueOf(s);
                    newBike.setSize(i);
                }
            }
        }
        AccessBike.insertNewBike(newBike);
        brandText.setText("");
        modelYearText.setText("");
        colorText.setText("");
        typeText.setText("");
        sizeText.setText("");
        messageLabel.setText("Cykeln har lagts till");
        urlLabel.setText("");
    }

    public void addPicture(ActionEvent actionEvent) {
        if (newBike == null) {
            newBike = new Bike();
        }
        FileChooser fc = new FileChooser();
        File selected = fc.showOpenDialog(null);
        urlLabel.setText(selected.getName());
        if (selected != null) {
            try {
                ByteArrayInputStream in = new ByteArrayInputStream(FileUtils.readFileToByteArray(selected));
                newBike.setImageStream(in);
                newBike.setCreatedBy(currentUser);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public void showMainGui(ActionEvent actionEvent) {
        Main.getSpider().getLoginView().showMainGui();

    }
}
