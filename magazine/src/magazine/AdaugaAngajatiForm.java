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
public class AdaugaAngajatiForm extends InternalWindow {
    int flag = 0;
    public InternalWindow getAdaugaAngajatForm(Connection connection) {
        InternalWindow result = new InternalWindow();
        GridPane root = new GridPane();
        root.add(new Label("Adaugare angajat"), 1, 0);

        TextField id = new TextField();
        root.setVgap(4);
        root.setHgap(10);
        root.setPadding(new Insets(7, 7, 7, 7));
        root.add(new Label("CNP: "), 0, 1);
        root.add(id, 1, 1);

        TextField nume = new TextField();
        root.add(new Label("Nume: "), 0, 2);
        root.add(nume, 1, 2);

        TextField prenume = new TextField();
        root.add(new Label("Prenume: "), 0, 3);
        root.add(prenume, 1, 3);

        TextField functie = new TextField();
        root.add(new Label("Functie: "), 0, 4);
        root.add(functie, 1, 4);
        
        TextField adresa = new TextField();
        root.add(new Label("Adresa: "), 0, 5);
        root.add(adresa, 1, 5);
        
        Button confirm = new Button();
        
        confirm.setText("Confirmare");
        confirm.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                CallableStatement cstmt =null;
                String msg = null;
                    try {
                    cstmt = connection.prepareCall("{? = call operatii_angajati.add_angajat(?, ?, ?, ?, ?)}");
                    cstmt.registerOutParameter(1, Types.VARCHAR);
                    cstmt.setString(2, id.getText());
                    cstmt.setString(3, nume.getText());
                    cstmt.setString(4, prenume.getText());
                    cstmt.setString(5, functie.getText());
                    cstmt.setString(6, adresa.getText());
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
                    alert.setTitle("Succes");
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

