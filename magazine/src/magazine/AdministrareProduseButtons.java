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
public class AdministrareProduseButtons {

    public FlowPane getAdministrareProdusePane(Connection connection, BorderPane resultPane) {
        FlowPane administrareProduse = new FlowPane();

        Button adaugaProdus = new Button();
        adaugaProdus.setText("Adauga Produs");
        adaugaProdus.setOnAction(new EventHandler<ActionEvent>() {

            @Override
            public void handle(ActionEvent event) {
                resultPane.getChildren().add(new AdaugaProdusForm().getAdaugaProdusForm(connection));
            }
        });

        administrareProduse.getChildren().add(adaugaProdus);

        
        
        return administrareProduse;
    }
}

