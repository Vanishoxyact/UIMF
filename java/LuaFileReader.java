import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

public class LuaFileReader {
   
   public List<LuaFunction> locateLuaFunctions( File luaFile ) {
      List< String > luaLines = readLuaFileIntoLines( luaFile );
      List<LuaFunction> luaFunctions = new ArrayList<>(  );
      for( String luaLine : luaLines ) {
         if(isLineLuaFunction( luaLine )) {
            luaFunctions.add( constructLuaFunctionFromLine( luaLine ) );
         }
      }
      List< String > returnedFunctions = calculateReturnedFunctions( calculateReturnLines( luaLines ) );
      for( String returnedFunction : returnedFunctions ) {
         Optional< LuaFunction > luaFunction = luaFunctions
                                                     .stream()
                                                     .filter( func -> func.getFunctionName().equals( returnedFunction ) )
                                                     .findAny();
         luaFunction.ifPresent( luaFunction1 -> luaFunction1.setReturned( true ) );
      }
      return luaFunctions;
   }
   
   private List<String> readLuaFileIntoLines(File luaFile) {
      BufferedReader fileReader;
      try {
         fileReader = new BufferedReader( new FileReader( luaFile ) );
         return fileReader.lines().collect( Collectors.toList() );
      } catch ( FileNotFoundException e ) {
         e.printStackTrace();
         return Collections.emptyList();
      }
   }
   
   private boolean isLineLuaFunction(String line) {
      return line.startsWith( "function " );
   }
   
   private LuaFunction constructLuaFunctionFromLine(String line) {
      String functionClass;
      String functionName;
      if(line.contains( "." )) {
         functionClass = line.substring( line.indexOf( " " ) + 1, line.indexOf( "." ) );
         functionName = line.substring( line.indexOf( "." ) + 1, line.indexOf( "(" ) );
      } else {
         functionClass = null;
         functionName = line.substring( line.indexOf( " " ), line.indexOf( "(" ) );
      }
      String paramList = line.substring( line.indexOf( "(" ) + 1, line.indexOf( ")" ) );
      List< String > functionParams = Arrays.asList( paramList.split( ", " ) );
      return new LuaFunction( functionClass, functionName, functionParams );
   }
   
   private List<String> calculateReturnLines(List<String> luaLines) {
      boolean returnFound = false;
      List<String> returnLines = new ArrayList<>(  );
      for( String luaLine : luaLines ) {
         if(isReturnLine( luaLine )) {
            returnFound = true;
         }
         if(returnFound) {
            returnLines.add( luaLine );
         }
      }
      return returnLines;
   }
   
   private boolean isReturnLine(String line) {
      return line.startsWith( "return {" );
   }
   
   private List<String> calculateReturnedFunctions(List<String> returnLines) {
      List<String> returnedFunctions = new ArrayList<>(  );
      for( String returnLine : returnLines ) {
         if(returnLine.contains( "=" )) {
            String functionWithWhiteSpace = returnLine.substring( 0, returnLine.indexOf( "=" ) );
            returnedFunctions.add( functionWithWhiteSpace.replace( " ", "" ) );
         }
      }
      return returnedFunctions;
   }
}