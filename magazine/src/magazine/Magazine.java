/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package magazine;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import javafx.application.Application;
import static javafx.application.Application.launch;
import static javafx.geometry.Orientation.HORIZONTAL;
import static javafx.geometry.Orientation.VERTICAL;
import javafx.scene.Scene;
import javafx.scene.control.SplitPane;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import javafx.stage.Stage;

/**
 *
 * @author Alexandra
 */
public class Magazine extends Application {

    @Override
    public void start(Stage primaryStage) {

        Connection connection = new NewConnection().getConnection();

        BorderPane resultPane = new BorderPane();
        FlowPane administrarePersoane = new AdministrarePersoane().getAdministrarePersoanePane(connection, resultPane);

        FlowPane administrareProduse = new AdministrareProduseButtons().getAdministrareProdusePane(connection, resultPane);
        SplitPane administrare = new SplitPane();
        administrare.setOrientation(HORIZONTAL);
        administrare.getItems().addAll(administrarePersoane, administrareProduse);
        administrare.setDividerPositions(0.5f);

        SplitPane root = new SplitPane();
        root.setOrientation(VERTICAL);
        root.getItems().addAll(administrare, resultPane);
        root.setDividerPositions(0.11f);

        Scene scene = new Scene(root, 1200, 700);

        primaryStage.setTitle("Magazine");
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    public static void main(String[] args) {
        launch(args);
    }

}
