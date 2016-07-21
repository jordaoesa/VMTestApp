package br.edu.ufcg.splab.view;

import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;

import java.net.URL;
import java.util.ResourceBundle;

/**
 * Created by jordaoesa on 21/07/2016.
 */
public class RootController implements Initializable {

    @FXML
    public Button clickButton;

    public RootController(){}

    public void initialize(URL location, ResourceBundle resources) {
        clickButton.setOnAction(new EventHandler<ActionEvent>() {
            public void handle(ActionEvent event) {
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Information Dialog");
                alert.setHeaderText("Look, an Information Dialog");
                alert.setContentText("I have a great message for you!");

                alert.showAndWait();
            }
        });
    }
}
