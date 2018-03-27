import java.io.BufferedWriter;
import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.StandardOpenOption;
import java.util.List;

public class LuaFileWriter {
   
   public void writeLuaFile(LuaTableConfiguration tableConfiguration, File outputFile ) {
      try {
         BufferedWriter writer = Files.newBufferedWriter( outputFile.toPath(), StandardOpenOption.CREATE );
         writeTableName(writer, tableConfiguration);
         writer.append( " = {\n" );
         writer.append( "\t" );
         writeSchema( writer, tableConfiguration );
         writer.append( ",\n" );
         writer.append( "\t" );
         writeKey( writer, tableConfiguration );
         writer.append( ",\n" );
         writer.append( "\t" );
         writeData( writer, tableConfiguration );
         writer.append( "\n}" );
         writer.flush();
         writer.close();
      } catch ( IOException e ) {
         e.printStackTrace();
      }
   }
   
   private void writeTableName( BufferedWriter writer, LuaTableConfiguration tableConfiguration) throws IOException {
      writer.append( tableConfiguration.getTableName() );
   }

   private void writeSchema( BufferedWriter writer, LuaTableConfiguration tableConfiguration) throws IOException {
      writer.append( "SCHEMA = {" );
      TsvRow tsvHeaders = tableConfiguration.getTsvFile().getTsvHeaders();
      List< String > headerValues = tsvHeaders.getTsvValues();
      for( int i = 0; i<headerValues.size(); i++ ) {
         String headerValue = headerValues.get( i );
         writer.append( escapeString( headerValue ) );
         if( i != headerValues.size() - 1) {
            writer.append( ", " );
         }
      }
      writer.append( "}" );
   }

   private void writeKey( BufferedWriter writer, LuaTableConfiguration tableConfiguration) throws IOException {
      writer.append( "KEY = {" );
      writer.append( escapeString( tableConfiguration.getKeyColumn() ) );
      writer.append( ", " );
      writer.append( escapeString( tableConfiguration.getKeyType().name() ) );
      writer.append( "}" );
   }

   private void writeData( BufferedWriter writer, LuaTableConfiguration tableConfiguration) throws IOException {
      writer.append( "DATA = {\n" );
      List< TsvRow > tsvRows = tableConfiguration.getTsvFile().getTsvRows();
      for( TsvRow tsvRow : tsvRows ) {
         writer.append( "\t\t{" );
         List<String> tsvRowData = tsvRow.getTsvValues();
         for( int i = 0; i<tsvRowData.size(); i++ ) {
            String dataValue = tsvRowData.get( i );
            writer.append( escapeString( dataValue ) );
            if( i != tsvRowData.size() - 1) {
               writer.append( ", " );
            }
         }
         writer.append( "}" );
         if(!tsvRows.get( tsvRows.size() - 1 ).equals( tsvRow )) {
            writer.append( "," );
         }
         writer.append( "\n" );
      }
      writer.append( "\t}" );
   }
   
   private String escapeString(String string) {
      return "\"" + string.replaceAll( "\"", "\\\"" ) + "\"";
   }
}
