package br.edu.ufcg.splab;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;

/**
 * Created by jordaoesa on 21/07/2016.
 */
public class Main extends Application {

    public static void main(String[] args){launch(args);}

    public void start(Stage primaryStage) throws Exception {
        primaryStage.setTitle("VMTestApp");
        AnchorPane root = FXMLLoader.load(getClass().getResource("/view/root.fxml"));
        primaryStage.setScene(new Scene(root));

        primaryStage.show();
    }

}
