/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package magazine;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Types;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Insets;
import javafx.scene.control.Alert;
import javafx.scene.control.Button;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.GridPane;

/**
 *
 * @author Alexandra
 */
public class AdaugaProdusForm extends InternalWindow {


    public InternalWindow getAdaugaProdusForm(Connection connection) {
        InternalWindow result = new InternalWindow();
        GridPane root = new GridPane();
        root.add(new Label("Adaugare produs"), 1, 0);

        TextField denumire = new TextField();
        root.setVgap(4);
        root.setHgap(10);
        root.setPadding(new Insets(5, 5, 5, 5));
        root.add(new Label("Denumire: "), 0, 1);
        root.add(denumire, 1, 1);

        TextField categorie = new TextField();
        root.add(new Label("Categorie: "), 0, 2);
        root.add(categorie, 1, 2);

        TextField model = new TextField();
        root.add(new Label("Model produs: "), 0, 3);
        root.add(model, 1, 3);

        TextField pret = new TextField();
        root.add(new Label("Pret: "), 0, 4);
        root.add(pret, 1, 4);
        
        TextField culoare = new TextField();
        root.add(new Label("Culoare: "), 0, 5);
        root.add(culoare, 1, 5);

        Button confirm = new Button();
        confirm.setText("Confirmare");
        confirm.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                CallableStatement cstmt = null;
                String msg = null;
                try {
                    cstmt = connection.prepareCall("{? = call administrare_produse.adauga_produs(?, ?, ?, ?, ?)}");
                    cstmt.registerOutParameter(1, Types.VARCHAR);
                    cstmt.setString(2, categorie.getText());
                    cstmt.setString(3, denumire.getText());
                    cstmt.setString(4, model.getText());
                    cstmt.setString(5, pret.getText());
                    cstmt.setString(6, culoare.getText());
                    cstmt.executeQuery();
                    msg = cstmt.getString(1);
                } catch (SQLException e) {
                    System.out.println("Exceptie" + e);
                } finally {
                    if (cstmt != null) {
                        try {
                            cstmt.close();

                        } catch (SQLException ex) {
                            Logger.getLogger(AdaugaProdusForm.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
                Alert alert = new Alert(Alert.AlertType.INFORMATION);
                alert.setTitle("Message");
                alert.setContentText(msg);
                alert.show();
            }
        });
        root.add(confirm, 1, 6);
        result.setRoot(root);
        result.makeDragable(root);
        result.makeResizable(20);
        result.makeFocusable();
        return result;
    }
}
