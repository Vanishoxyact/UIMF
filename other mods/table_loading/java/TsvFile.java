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

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class TsvFile {
   
   private TsvRow tsvHeaders;
   private List<TsvRow> tsvRows = new ArrayList<>();
   private String tableName;

   public void setTsvHeaders(TsvRow tsvHeaders) {
      this.tsvHeaders = tsvHeaders;
   }
   
   public void addTsvRow(TsvRow tsvRow) {
      this.tsvRows.add(tsvRow);
   }

   public TsvRow getTsvHeaders() {
      return tsvHeaders;
   }

   public List<TsvRow> getTsvRows() {
      return tsvRows;
   }

   public Optional<String> getTableName() {
      return Optional.ofNullable( tableName );
   }

   public void setTableName( String tableName ) {
      this.tableName = tableName;
   }
}