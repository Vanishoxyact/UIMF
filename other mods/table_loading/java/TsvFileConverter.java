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
import javafx.collections.FXCollections;
import javafx.event.ActionEvent;
import javafx.event.EventHandler;
import javafx.geometry.Orientation;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.layout.FlowPane;
import javafx.stage.FileChooser;
import javafx.stage.FileChooser.ExtensionFilter;
import javafx.stage.Stage;

import java.io.File;

public class TsvFileConverter extends Application {

   @Override
   public void start(Stage primaryStage) throws Exception {
      System.setProperty("glass.accessible.force", "false");
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
            fileChooser.setInitialDirectory(new File("").getAbsoluteFile());
            fileChooser.getExtensionFilters().add(new ExtensionFilter("Tab Separated Values (.tsv)", "*.tsv"));
            File selectedFile = fileChooser.showOpenDialog(null);
            filePath.setText(selectedFile.getAbsolutePath());
         }
      });
      filePathPane.getChildren().add(fileChooserButton);

      rootPane.getChildren().add(filePathPane);

      Button loadFileButton = new Button("Load TSV file");
      ComboBox<String> columnsComboBox = new ComboBox<>();
      TextField tableNameTextField = new TextField();
      final TsvFile[] tsvFile = new TsvFile[ 1 ];
      loadFileButton.setOnAction(new EventHandler<ActionEvent>() {
         @Override
         public void handle(ActionEvent event) {
            TsvFile returnedFile = new TsvFileLoader().loadTsvFile( new File( filePath.getText() ) );
            tsvFile[ 0 ] = returnedFile;
            columnsComboBox.getItems().clear();
            columnsComboBox.getItems().addAll( returnedFile.getTsvHeaders().getTsvValues() );
            columnsComboBox.getSelectionModel().select( 0 );
            if(returnedFile.getTableName().isPresent()) {
               tableNameTextField.setText( returnedFile.getTableName().get() );
            }
         }
      });
      rootPane.getChildren().add(loadFileButton);

      FlowPane keyColumnPane = new FlowPane(Orientation.HORIZONTAL);
      keyColumnPane.getChildren().add( new Label( "Key Column: " ) );
      keyColumnPane.getChildren().add( columnsComboBox );
      rootPane.getChildren().add( keyColumnPane );

      FlowPane keyTypePane = new FlowPane(Orientation.HORIZONTAL);
      keyTypePane.getChildren().add( new Label( "Key Type: " ) );
      ComboBox< KeyType > keyTypeComboBox = new ComboBox<>( FXCollections.observableArrayList( KeyType.values() ) );
      keyTypePane.getChildren().add( keyTypeComboBox );
      rootPane.getChildren().add( keyTypePane );
      
      FlowPane tableNamePane = new FlowPane( Orientation.HORIZONTAL );
      tableNamePane.getChildren().add( new Label( "Table Name: " ) );
      tableNamePane.getChildren().add( tableNameTextField );
      rootPane.getChildren().add( tableNamePane );

      Button convertButton = new Button("Convert");
      convertButton.setOnAction( new EventHandler< ActionEvent >() {
         @Override
         public void handle( ActionEvent event ) {
            LuaTableConfiguration tableConfiguration = new LuaTableConfiguration();
            tableConfiguration.setTsvFile( tsvFile[0] );
            tableConfiguration.setKeyColumn( columnsComboBox.getValue() );
            tableConfiguration.setKeyType( keyTypeComboBox.getValue() );
            tableConfiguration.setTableName( tableNameTextField.getText() );
            new LuaFileWriter().writeLuaFile( tableConfiguration, new File(tableNameTextField.getText() + ".lua") );
         }
      } );
      rootPane.getChildren().add( convertButton );

      primaryStage.setScene(new Scene(rootPane, 300, 250));
      primaryStage.show();
   }
}