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

public class TsvRow {
   
   private List<String> tsvValues = new ArrayList<>();

   public List<String> getTsvValues() {
      return tsvValues;
   }
   
   public void addTsvValue(String value) {
      tsvValues.add(value);
   }
}