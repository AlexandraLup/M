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
public class CautareClientForm {

    int flag = 0;

    public InternalWindow getCautareClientForm(Connection connection) {
        InternalWindow result = new InternalWindow();
        GridPane root = new GridPane();
        root.setVgap(4);
        root.setHgap(10);
        root.setPadding(new Insets(5, 5, 5, 5));

        root.add(new Label("Cautare client"), 1, 0);

        TextField nume = new TextField();
        root.add(new Label("Nume: "), 0, 1);
        root.add(nume, 1, 1);
        
        TextField prenume = new TextField();
        root.add(new Label("Prenume: "), 0, 2);
        root.add(prenume, 1, 2);

        Button confirm = new Button();

        confirm.setText("Confirmare");
        confirm.setOnAction(new EventHandler<ActionEvent>() {
            @Override
            public void handle(ActionEvent event) {
                CallableStatement cstmt =null;
                String msg = null;
                if (nume.getText() != null && prenume.getText() != null) {
                    try {
                    cstmt = connection.prepareCall("{? = call operatii_clienti.cautare_nume_prenume(?, ?)}");
                    cstmt.registerOutParameter(1, Types.VARCHAR);
                    cstmt.setString(2, nume.getText());
                    cstmt.setString(3, prenume.getText());
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
                    alert.setTitle("message");
                    alert.setContentText(msg);
                    
                    alert.show();
                
                    }
                else if (nume.getText() != null && prenume.getText() == null) {
                    try {
                    cstmt = connection.prepareCall("{? = call operatii_clienti.cautare_nume(?)}");
                    cstmt.registerOutParameter(1, Types.VARCHAR);
                    cstmt.setString(2, nume.getText());
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
            }
        });
        root.add(confirm, 1, 5);

        result.setRoot(root);
        result.makeDragable(root);
        result.makeResizable(20);
        result.makeFocusable();

        return result;
    }
}
