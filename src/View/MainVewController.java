package View;

import Interfaces.DBAccess;
import Model.AccessBike;
import Model.Bike;
import Model.BikeUser;
import Model.DBAccessImpl;
import javafx.embed.swing.SwingFXUtils;
import javafx.event.ActionEvent;
import javafx.event.Event;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.*;
import javafx.scene.image.Image;
import javafx.scene.image.ImageView;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.text.Font;
import javafx.scene.text.FontWeight;

import java.net.URL;
import java.util.*;

/**
 * @author Ulrika Goloconda Fahlén
 * @version 1.0
 * @since 2016-09-15
 */
public class MainVewController implements Initializable {
    @FXML
    private TableColumn columCykel;
    @FXML
    private TableView<Bike> tableBikeView;
    @FXML
    private TableColumn<Bike, String> year, status, color, type, model, available;
    @FXML
    private GridPane gridPane;
    @FXML
    private ImageView imageView1, imageView2, imageView3;
    @FXML
    private Label messageLabel;
    @FXML
    private Button executeLoanBtn, netBtn, adminBtn, returnBtn;
    @FXML
    private ComboBox<String> combobox;
    @FXML
    private Label userNameLabel, memberLevelLabel, activeLoanLabel, numberOfLoanedBikesLabel, statLabel;

    private DBAccess dbaccess;
    private Map<Node, Integer> idMap;
    private int selectedFromGrid;
    private ArrayList<Bike> availableBikes;
    private List<Bike> currentListInView;
    private BikeUser currentUser;
    Map<String, Integer> searchMap;
    private Bike selectedBikeSearch;
   private  ArrayList<Bike> usersCurrentBikes;


    private String errorTitle = "Fel i huvidfönster";


    @Override
    public void initialize(URL location, ResourceBundle resources) {
        Main.getSpider().setMainView(this);
        dbaccess = new DBAccessImpl();
        currentUser = Main.getSpider().getLoginView().getCurrentUser();
        populateUserTextInGUI(currentUser);
        executeLoanBtn.setDisable(true);
        netBtn.setDisable(true);
        if (currentUser.getMemberLevel() != 10) {
            adminBtn.setVisible(false);
        }
        combobox.setEditable(true);
        idMap = new HashMap<>();
        returnBtn.setVisible(false);
        currentListInView = new ArrayList<>();
    }

    public void populateUserTextInGUI(BikeUser bikeUser) {
        ArrayList<Integer> bikesInUse = dbaccess.getUsersCurrentBikes(bikeUser.getUserID());
        ArrayList<Integer> totalBikes = dbaccess.getUsersTotalLoan(bikeUser.getUserID());
        userNameLabel.setText(bikeUser.getUserName());
        memberLevelLabel.setText("* " + bikeUser.getMemberLevel() + " *");
        activeLoanLabel.setText("" + bikesInUse.size());
        numberOfLoanedBikesLabel.setText("" + totalBikes.size());
        setStatLabel();

    }

    private void setStatLabel() {
        float free = dbaccess.selectAvailableBikes().size();
        float total = dbaccess.getAllBikes().size();
        System.out.println("free" + " " + free);
        System.out.println("tot: " + total);
        float poc = free / total;
        System.out.println("poc: " + poc);
        poc = poc * 100;
        System.out.println(poc);
        statLabel.setText("" + poc + " %");
    }


    public void searchAvailableBikes(ActionEvent actionEvent) {
        usersCurrentBikes = null;
        selectedBikeSearch = null;
        executeLoanBtn.setDisable(true);
        netBtn.setVisible(false);
        availableBikes = dbaccess.selectAvailableBikes();
        if (availableBikes.size() > 3) {
            currentListInView = availableBikes.subList(0, 3);
            populateGridPane(currentListInView);
        } else {
            populateGridPane(availableBikes);
        }
    }

    public void showAdminView(ActionEvent actionEvent) {
        Main.getSpider().getMain().showAdeminView();
    }

    public boolean populateGridPane(List<Bike> bikeArray) {
        gridPane.getChildren().clear();
        returnBtn.setVisible(false);
        if(availableBikes!=null) {
            if (availableBikes.size() <= 3) {
                netBtn.setVisible(false);
            } else {
                netBtn.setDisable(false);
                netBtn.setVisible(true);
            }
        }
        if(usersCurrentBikes!= null){
            if(usersCurrentBikes.size() <=3){
                netBtn.setVisible(false);
            } else {
                netBtn.setDisable(false);
                netBtn.setVisible(true);
            }
        }
        String[] topList = {"Bild", "Årsmodell", "Färg", "Cykeltyp", "Modell", "Ledig?"};
        ArrayList<String> values = new ArrayList<>();
        for (int i = 0; i < 6; i++) {
            Label l = new Label();
            l.setText(topList[i]);
            l.setFont(Font.font("Verdana", FontWeight.BOLD, 16));
            gridPane.add(l, i, 0);
        }
        int j = 1;
        for (Bike b : bikeArray) {
            values.clear();
            values.add("" + b.getModelYear());
            values.add(b.getColor());
            values.add(b.getType());
            values.add(b.getBrandName());
            values.add("" + b.isAvailable());
            for (int i = 0; i < 6; i++) {
                if (i == 0) {
                    Image image = SwingFXUtils.toFXImage(b.getBufferedImage(), null);
                    ImageView iv = new ImageView();
                    iv.setFitHeight(65);
                    iv.setFitWidth(95);
                    iv.setOnMouseClicked(new EventHandler<MouseEvent>() {

                        @Override
                        public void handle(MouseEvent event) {
                            Node n = (Node) event.getSource();
                            onClickActions(n);
                        }
                    });

                    idMap.put(iv, b.getBikeID());
                    iv.setImage(image);
                    gridPane.add(iv, i, j);
                } else {
                    Label k = new Label();
                    k.setOnMouseClicked(new EventHandler<MouseEvent>() {

                        @Override
                        public void handle(MouseEvent event) {
                            Node n = (Node) event.getSource();
                            onClickActions(n);
                        }
                    });
                    k.setText(values.get(i - 1));
                    Font f = new Font(16);
                    k.setFont(f);
                    idMap.put(k, b.getBikeID());
                    gridPane.add(k, i, j);
                }
            }
            j++;
            if (j > 3) {
                return false;
            }
        }
        return true;
    }

    public boolean populateGridPane(Bike bike) {
/*
        if(bike.isAvailable()){
            executeLoanBtn.setDisable(false);
        }else {
            executeLoanBtn.setDisable(true);
        }
*/
        currentListInView.clear();
        returnBtn.setVisible(false);
        netBtn.setVisible(false);
        gridPane.getChildren().clear();
        String[] topList = {"Bild", "Årsmodell", "Färg", "Cykeltyp", "Modell", "Ledig?"};
        ArrayList<String> values = new ArrayList<>();
        for (int i = 0; i < 6; i++) {
            gridPane.add(new Label(topList[i]), i, 0);
        }
        values.add("" + bike.getModelYear());
        values.add(bike.getColor());
        values.add(bike.getType());
        values.add(bike.getBrandName());
        values.add("" + bike.isAvailable());
        for (int i = 0; i < 6; i++) {
            if (i == 0) {
                Image image = SwingFXUtils.toFXImage(bike.getBufferedImage(), null);
                ImageView iv = new ImageView();
                iv.setFitHeight(65);
                iv.setFitWidth(95);
                iv.setOnMouseClicked(new EventHandler<MouseEvent>() {

                    @Override
                    public void handle(MouseEvent event) {
                        Node n = (Node) event.getSource();
                        onClickActions(n);
                    }
                });
                idMap.put(iv, bike.getBikeID());
                iv.setImage(image);
                gridPane.add(iv, i, 1);
            } else {
                Label k = new Label();
                k.setOnMouseClicked(new EventHandler<MouseEvent>() {

                    @Override
                    public void handle(MouseEvent event) {
                        Node n = (Node) event.getSource();
                        onClickActions(n);
                    }
                });
                k.setText(values.get(i - 1));
                Font f = new Font(16);
                k.setFont(f);
                idMap.put(k, bike.getBikeID());
                gridPane.add(k, i, 1);

            }
        }
        return true;
    }


    public void onClickActions(Node n) {
        if (selectedBikeSearch != null) {
            executeLoanBtn.setVisible(true);
            selectedFromGrid = selectedBikeSearch.getBikeID();
            String available = "";
            if (selectedBikeSearch.isAvailable()) {
                available = "Ja";
                executeLoanBtn.setDisable(false);
            } else {
                available = "Nej";
                executeLoanBtn.setDisable(true);
            }

            String s = "Årsmodell: " + selectedBikeSearch.getModelYear() + " Färg: " + selectedBikeSearch.getColor() + " Cykeltyp: " +
                    selectedBikeSearch.getType() + " Ledig? " + available;
            messageLabel.setText(s);
            executeLoanBtn.setVisible(true);
        } else if (usersCurrentBikes != null) {
            selectedFromGrid = idMap.get(n);
            for(Bike b : usersCurrentBikes) {
                if(b.getBikeID()==selectedFromGrid) {
                    String s = "Årsmodell: " + b.getModelYear() + " Färg: " + b.getColor() + " Cykeltyp: " +
                            b.getType() + " Återlämningsdag: " + b.getDayOfReturn();
                    messageLabel.setText(s);
                    returnBtn.setVisible(true);
                }
            }

        } else {
            selectedFromGrid = idMap.get(n);
            String available = "";
            for (Bike b : availableBikes) {
                if (b.isAvailable()) {
                    available = "Ja";
                    executeLoanBtn.setDisable(false);
                } else {
                    available = "Nej";
                    executeLoanBtn.setDisable(true);
                }
                if (b.getBikeID() == selectedFromGrid) {

                    String s = "Årsmodell: " + b.getModelYear() + " Färg: " + b.getColor() + " Cykeltyp: " +
                            b.getType() + " Ledig? " + available;
                    messageLabel.setText(s);
                }
            }
        }
    }

    public void nextBikesOnList(ActionEvent actionEvent) {
        gridPane.getChildren().clear();
        currentListInView.clear();
        if(availableBikes != null) {
            if (availableBikes.size() >= 3) {
                currentListInView = availableBikes.subList(0, 3);
            } else {
                currentListInView = availableBikes.subList(0, availableBikes.size());
            }
        } else if(usersCurrentBikes != null){
            if (usersCurrentBikes.size() >= 3) {
                currentListInView = usersCurrentBikes.subList(0, 3);
            } else {
                currentListInView = usersCurrentBikes.subList(0, usersCurrentBikes.size());
            }
        }
        populateGridPane(currentListInView);
    }

    public void showChangeUserView(ActionEvent actionEvent) {
        Main.getSpider().getMain().showChangeUserView();
    }

    public void executeBikeLoan(ActionEvent actionEvent) {

        Bike b = AccessBike.getBikeByID(selectedFromGrid);
        if(b.isAvailable()) {
            String message = dbaccess.executeBikeLoan(selectedFromGrid, Main.getSpider().getLoginView().getCurrentUser().getUserID());
            messageLabel.setText(message);
            b.setAvailable(false);
            populateGridPane(b);
            populateUserTextInGUI(currentUser);
            setStatLabel();
        }else {
            messageLabel.setText("Cykeln är tyvärr inte ledig");
        }
    }


    public void popuateComboBox(Event event) {
        searchMap = dbaccess.getSearchValue(combobox.getEditor().getText());
        int count = 0;
        combobox.getItems().clear();
        for (Map.Entry<String, Integer> entry : searchMap.entrySet()) {
            if (count > 10) {
                break;
            }
            combobox.getItems().add(entry.getKey());
            count++;
        }
    }


    public void setSearchResult(ActionEvent actionEvent) {
        usersCurrentBikes = null;
        availableBikes = null;
        if (combobox.getSelectionModel().getSelectedItem().toString() != null) {
            String selected = combobox.getSelectionModel().getSelectedItem().toString();
            if(searchMap.containsKey(selected)) {
                int bikeID = searchMap.get(selected);
                selectedBikeSearch = dbaccess.getBikeByID(bikeID);
                populateGridPane(selectedBikeSearch);
            }
        }
    }

    public void showStatClick(ActionEvent actionEvent) {
        Main.getSpider().getMain().showStatView();
    }

    public void showUsersBikes(ActionEvent actionEvent) {
        availableBikes = null;
        selectedBikeSearch = null;
       usersCurrentBikes = AccessBike.getCurrentBikesByUserID(3);
        if (usersCurrentBikes.size() > 3) {
            currentListInView = usersCurrentBikes.subList(0, 3);
            populateGridPane(currentListInView);
        } else {
            populateGridPane(usersCurrentBikes);
        }
        populateGridPane(usersCurrentBikes);
    }

    public void returnBike(ActionEvent actionEvent) {
        Bike bikeviewGrid = null;
        for(Bike b : usersCurrentBikes){
            if(b.getBikeID()==selectedFromGrid){
                bikeviewGrid = b;
            }
        }
        AccessBike.returnBike(selectedFromGrid, currentUser.getUserID());
        populateUserTextInGUI(currentUser);
        setStatLabel();
        bikeviewGrid.setAvailable(true);
        populateGridPane(bikeviewGrid);
    }
}

