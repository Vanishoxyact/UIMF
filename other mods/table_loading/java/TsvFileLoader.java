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
         for(String line : lines) {
            TsvRow tsvRow = convertLineIntoTsvRow(line);
            if(tsvFile.getTsvHeaders() == null) {
               tsvFile.setTsvHeaders(tsvRow);
            } else {
               tsvFile.addTsvRow(tsvRow);
            }
         }
      } catch (IOException e) {
         e.printStackTrace();
      }
      return tsvFile;
   }
   
   private TsvRow convertLineIntoTsvRow(String line) {
      String[] linesValues = line.split("\t");
      TsvRow tsvRow = new TsvRow();
      for(String value : linesValues) {
         tsvRow.addTsvValue(value);
      }
      return tsvRow;
   }
}