import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class LuaFunctionWriter {
   
   public void writeLuaFunctions( List<LuaFunction> luaFunctions, String targetLocation, List<String> classExclusions ) {
      try {
         BufferedWriter bufferedWriter = new BufferedWriter( new FileWriter( new File( targetLocation ) ) );
         for( LuaFunction luaFunction : luaFunctions ) {
            if(classExclusions.contains( luaFunction.getFunctionClass() )) {
               continue;
            }
            writeLuaFunction( luaFunction, bufferedWriter );
         }
      } catch ( IOException e ) {
         e.printStackTrace();
      }
   }
   
   private void writeLuaFunction(LuaFunction luaFunction, BufferedWriter writer) throws IOException {
      Optional< String > functionString = convertLuaFunctionToString( luaFunction );
      if(functionString.isPresent()) {
         writer.write( functionString.get() );
         writer.newLine();
         writer.flush();
      }
   }
   
   private Optional<String> convertLuaFunctionToString( LuaFunction luaFunction ) {
      StringBuilder stringBuilder = new StringBuilder(  );
      if(luaFunction.getFunctionClass() != null) {
         stringBuilder.append( luaFunction.getFunctionClass() );
      }

      List< String > functionParams = new ArrayList<>( luaFunction.getFunctionParams() );
      boolean method = false;
      if(functionParams.size() > 0 && functionParams.get( 0 ).equals( "self" )) {
         functionParams.remove( 0 );
         method = true;
      }
      
      if(!method && !luaFunction.isReturned()) {
         return Optional.empty();
      }
      
      if(method) {
         stringBuilder.append( ":" );
      } else {
         stringBuilder.append( "." );
      }

      stringBuilder.append( luaFunction.getFunctionName() );

      stringBuilder.append( "(" );
      for( int i = 0; i<functionParams.size(); i++ ) {
         String functionParam = functionParams.get( i );
         stringBuilder.append( functionParam );
         if(i != functionParams.size() - 1) {
            stringBuilder.append( ", " );
         }
      }
      stringBuilder.append( ")" );
      return Optional.of( stringBuilder.toString() );
   }
   
}
