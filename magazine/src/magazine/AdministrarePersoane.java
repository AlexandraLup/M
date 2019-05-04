/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package magazine;

import java.sql.Connection;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.scene.control.Button;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;

/**
 *
 * @author Alexandra
 */
public class AdministrarePersoane {

    public FlowPane getAdministrarePersoanePane(Connection connection, BorderPane resultPane) {
        FlowPane administrarePersoane = new FlowPane();

        Button adaugaClient = new Button();
        adaugaClient.setText("   Adauga Client     ");
        adaugaClient.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new AdaugaClientForm().getAdaugaClientForm(connection));
            }
        });
        administrarePersoane.getChildren().add(adaugaClient);

        Button updateClient = new Button();
        updateClient.setText(" Actualizare Client   ");
        updateClient.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new ActualizareClientForm().getActualizareClientForm(connection));
            }
        });
        administrarePersoane.getChildren().add(updateClient);

        Button stergeClient = new Button();
        stergeClient.setText("  Stergere Client ");
        stergeClient.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new StergereClientForm().getStergereClientForm(connection));
            }
        });
        administrarePersoane.getChildren().add(stergeClient);

        Button informatiiClient = new Button();
        informatiiClient.setText("Informatii Client   ");
        informatiiClient.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new InformatiiClientForm().getInformatiiClientForm(connection));
            }
        });
        administrarePersoane.getChildren().add(informatiiClient);

        Button cautareNumeClient = new Button();
        cautareNumeClient.setText("Cautare Client");
        cautareNumeClient.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new CautareClientForm().getCautareClientForm(connection));
            }
        });
        administrarePersoane.getChildren().add(cautareNumeClient);

        Button adaugaAngajat = new Button();
        adaugaAngajat.setText("   Adauga Angajat  ");
        adaugaAngajat.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new AdaugaAngajatiForm().getAdaugaAngajatForm(connection));
            }
        });
        administrarePersoane.getChildren().add(adaugaAngajat);

        Button updateAngajat = new Button();
        updateAngajat.setText("Actualizare Angajat");
        updateAngajat.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new ActualizareAngajatForm().getActualizareAngajatForm(connection));
            }
        });
        administrarePersoane.getChildren().add(updateAngajat);

        Button stergeAngajat = new Button();
        stergeAngajat.setText("Stergere Angajat");
        stergeAngajat.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new StergereAngajatForm().getStergereAngajatForm(connection));
            }
        });
        administrarePersoane.getChildren().add(stergeAngajat);

        Button informatiiAngajat = new Button();
        informatiiAngajat.setText("Informatii Angajat");
        informatiiAngajat.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new InformatiiAngajatForm().getInformatiiAngajatForm(connection));
            }
        });
        administrarePersoane.getChildren().add(informatiiAngajat);

        Button cautareNumeAngajat = new Button();
        cautareNumeAngajat.setText("Cautare Angajat");
        cautareNumeAngajat.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new CautareAngajatForm().getCautareAngajatForm(connection));
            }
        });
        administrarePersoane.getChildren().add(cautareNumeAngajat);

        return administrarePersoane;
    }
}
