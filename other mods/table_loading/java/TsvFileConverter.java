// *************************************************************
//                         H*E*R*M*E*S
//                   Holistic Environment for
//         Railway Modelling, Evaluation and Simulation
//        Built on Graffica System Development Kit: GSDK
//
//       Copyright: (c) Graffica Ltd (www.graffica.co.uk)
//
// This software is made available under binary licence. Holding 
// source code without the express permission of Graffica Ltd is 
//           not permitted under any circumstances. 
// *************************************************************

import javafx.application.Application;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Orientation;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.scene.layout.BorderPane;
import javafx.scene.layout.FlowPane;
import javafx.scene.layout.StackPane;
import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Stage;

import java.io.File;

public class TsvFileConverter extends Application {

   @Override
   public void start(Stage primaryStage) throws Exception {
      primaryStage.setTitle("TSV File Converter");

      FlowPane rootPane = new FlowPane(Orientation.VERTICAL);
      
      FlowPane filePathPane = new FlowPane(Orientation.HORIZONTAL);
      TextField filePath = new TextField();
      filePathPane.getChildren().add(filePath);
      Button fileChooserButton = new Button("...");
      fileChooserButton.setOnAction(new EventHandler<ActionEvent>() {
         @Override
         public void handle(ActionEvent event) {
            FileChooser fileChooser = new FileChooser();
            fileChooser.setInitialDirectory(new File("/"));
            fileChooser.getExtensionFilters().add(new ExtensionFilter("Tab Separated Values (.tsv)", "*.tsv"));
            File selectedFile = fileChooser.showOpenDialog(null);
            filePath.setText(selectedFile.getAbsolutePath());
         }
      });
      filePathPane.getChildren().add(fileChooserButton);

      rootPane.getChildren().add(filePathPane);

      Button loadFileButton = new Button("Load TSV file");
      loadFileButton.setOnAction(new EventHandler<ActionEvent>() {
         @Override
         public void handle(ActionEvent event) {
            new TsvFileLoader().loadTsvFile(new File(filePath.getText()));
         }
      });
      rootPane.getChildren().add(loadFileButton);
      
      primaryStage.setScene(new Scene(rootPane, 300, 250));
      primaryStage.show();
   }
}