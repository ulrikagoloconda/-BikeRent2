package View;

import Interfaces.DBAccess;
import Model.Bike;
import Model.DBAccessImpl;
import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.GridPane;

import java.net.URL;
import java.util.*;

/**
 * @author Ulrika Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-19
 */
public class DeleteBikeViewController implements Initializable{
    @FXML
    private GridPane gridDelBike;
    @FXML
    private Label deleteLabel;
    @FXML
    private Button deleteBikeBtn, forwardBtn, backToMain;
    @FXML
    private AnchorPane deletePane;
    private DBAccess dbAccess;
    private Map<Node, Integer> idMap;
    private static ArrayList<Bike> allBikes;
    private Bike selected = null;
    private int bikeIdDel;
    private int lastIndex;
    private loginVewController loginVew;

    @Override
    public void initialize(URL location, ResourceBundle resources) {
        Main.getSpider().setDeleteView(this);
        idMap = new HashMap<>();
        dbAccess = new DBAccessImpl();
        System.out.println("Körs inte init ? " + dbAccess);
        deleteBikeBtn.setVisible(false);
        backToMain.setVisible(true);
        initDeleteView();
    }


    public void initDeleteView() {

        allBikes = dbAccess.getAllBikes();
        System.out.println("i init Del, storleken " + allBikes.size());
        if (allBikes.size() > 10){
            List<Bike> shortList = allBikes.subList(0, 9);
            populateDeleteGrid(shortList);
            forwardBtn.setDisable(false);
        } else {
            populateDeleteGrid(allBikes);
            forwardBtn.setDisable(true);

        }
    }

    public void populateDeleteGrid(List<Bike> bikeList) {
        gridDelBike.getChildren().clear();
        ArrayList<String> columnNames = new ArrayList<>();
        columnNames.add("CykelID");
        columnNames.add("Modell");
        columnNames.add("Årsmodell");
        columnNames.add("Storlek");
        columnNames.add("Färg");
        columnNames.add("Cykeltyp");
        ArrayList<String> values = new ArrayList<>();
        int j = 0;
        for (Bike b : bikeList) {
            values.clear();
            values.add("" + b.getBikeID());
            values.add(b.getBrandName());
            values.add(""+b.getModelYear());
            values.add(""+b.getSize());
            values.add( b.getColor());
            values.add(b.getType());

            for (int i = 0; i < 6; i++) {
                if (j == 0) {
                    gridDelBike.add(new Label(columnNames.get(i)), i, j);
                } else {
                    Label k = new Label(values.get(i));
                    k.setOnMouseClicked(new EventHandler<MouseEvent>() {
                        @Override
                        public void handle(MouseEvent event) {
                            Label l = (Label) event.getSource();
                            bikeIdDel = idMap.get(l);

                            for (Bike b : allBikes) {
                                if (b.getBikeID() == bikeIdDel) {
                                    selected = b;
                                    break;
                                }
                            }
                            String s = selected.getBikeID() + " " + selected.getBrandName() + " " + selected.getModelYear() +
                                    " " + selected.getSize() + " " + selected.getColor() + " " + selected.getType();
                            deleteLabel.setText(s);
                            deleteBikeBtn.setVisible(true);
                        }
                    });

                    idMap.put(k, b.getBikeID());
                    gridDelBike.add(k, i, j);
                    lastIndex= idMap.get(k);
                }
            }
            j++;
        }
    }


    public void deleteBike(Event event) {
      boolean b =  dbAccess.deleteBike(bikeIdDel);
        if(b){
            deletePane.setVisible(false);

        }
    }

    public void nextView(ActionEvent actionEvent) {
            if (allBikes.size() > 10) {
                List<Bike> smallList = allBikes.subList(0, 10);
                populateDeleteGrid(smallList);
            } else {
                List<Bike> smallList = allBikes.subList(0, allBikes.size() - 1);
                populateDeleteGrid(smallList);
                forwardBtn.setDisable(true);
            }
    }

    public void showMainView(ActionEvent actionEvent) {
       Main.getSpider().getLoginView().showMainGui();
    }
}
