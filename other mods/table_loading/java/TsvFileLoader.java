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

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.List;

public class TsvFileLoader {
   
   public TsvFile loadTsvFile(File filePath) {
      TsvFile tsvFile = new TsvFile();
      try {
         List<String> lines = Files.readAllLines(filePath.toPath());
         if(isCaTsvFile( lines )) {
            loadCaTsvFIle( tsvFile, lines );
         } else {
            loadTsvFIle( tsvFile, lines );
         }
      } catch (IOException e) {
         e.printStackTrace();
      }
      return tsvFile;
   }

   private void loadTsvFIle( TsvFile tsvFile, List< String > lines ) {
      for(String line : lines) {
         TsvRow tsvRow = convertLineIntoTsvRow(line);
         if(tsvFile.getTsvHeaders() == null) {
            tsvFile.setTsvHeaders(tsvRow);
         } else {
            tsvFile.addTsvRow(tsvRow);
         }
      }
   }

   private void loadCaTsvFIle( TsvFile tsvFile, List< String > lines ) {
      for(int i = 0; i<lines.size(); i++) {
         String line = lines.get( i );
         if(i == 0) {
            tsvFile.setTableName( line );
         } else if(i >= 2) {
            TsvRow tsvRow = convertLineIntoTsvRow(line);
            if(tsvFile.getTsvHeaders() == null) {
               tsvFile.setTsvHeaders(tsvRow);
            } else {
               tsvFile.addTsvRow(tsvRow);
            }
         }
      }
   }

   private TsvRow convertLineIntoTsvRow(String line) {
      String[] linesValues = line.split("\t");
      TsvRow tsvRow = new TsvRow();
      for(String value : linesValues) {
         tsvRow.addTsvValue(value);
      }
      return tsvRow;
   }
   
   private boolean isCaTsvFile(List<String> lines) {
      String secondLine = lines.get( 1 );
      try {
         Integer.parseInt( secondLine.trim() );
         return true;
      } catch ( NumberFormatException e ) {
         return false;
      }
   }
}