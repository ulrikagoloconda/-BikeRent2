package View;

import javafx.scene.control.Alert;
import javafx.scene.control.ButtonType;

import java.util.Optional;

/**
 * @author Niklas Karlsson
 * @version 1.0
 * @since 2016-09-15
 */
public class DialogView {

  public static boolean showSimpleInfo(String title, String header, String content) {
    Alert alert = new Alert(Alert.AlertType.INFORMATION);
    alert.setTitle(title);
    alert.setHeaderText(header);
    alert.setContentText(content);

    alert.showAndWait();
    return true;
  }
  public static boolean showOK_CANCEL_Dialog(String title, String header, String content) {
    Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
    alert.setTitle(title);
    alert.setHeaderText(header);
    alert.setContentText(content);

    Optional<ButtonType> result = alert.showAndWait();
    if (result.get() == ButtonType.OK) {
      return true;
    } else {
      return false;
    }
  }
}
