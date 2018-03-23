import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

public class FunctionExtractor {
   
   public List<LuaFunction> extractLuaFunctions(String baseFilePath) {
      File baseLuaPath = new File(baseFilePath);
      List< File > luaFiles = retrieveLuaFiles( baseLuaPath );
      luaFiles.forEach( file -> System.out.println("Found LUA file:" + file.getAbsolutePath()) );
      LuaFileReader luaFileReader = new LuaFileReader();
      
      List<LuaFunction> luaFunctions = new ArrayList<>( );
      for( File luaFile : luaFiles ) {
         luaFunctions.addAll(luaFileReader.locateLuaFunctions( luaFile ));
      }
      return luaFunctions;
   }
   
   private List<File> retrieveLuaFiles(File baseLocation) {
      List<File> allFilesInBaseLocation = recursiveCollectFiles(baseLocation);
      return allFilesInBaseLocation
                   .stream()
                   .filter( file -> file.getName().endsWith( ".lua" ) )
                   .collect( Collectors.toList() );
   }
   
   private List<File> recursiveCollectFiles(File directory) {
      File[] files = directory.listFiles();
      if(files == null) {
         return Collections.emptyList();
      } else {
         List<File> allFiles = new ArrayList<>();
         for( File file : files ) {
            if(file.isDirectory()) {
               allFiles.addAll(recursiveCollectFiles(file));
            } else {
               allFiles.add(file);
            }
         }
         return allFiles;
      }
   }
   
}
