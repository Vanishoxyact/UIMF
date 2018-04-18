import java.util.Arrays;
import java.util.List;

public class FunctionExtraction {

   private static final String BASE_LUA_PATH = "UIMF/uic";
   
   public static void main(String[] args) {
      List< LuaFunction > luaFunctions = new FunctionExtractor().extractLuaFunctions( BASE_LUA_PATH );
      LuaFunctionWriter luaFunctionWriter = new LuaFunctionWriter();
      luaFunctionWriter.writeLuaFunctions( luaFunctions, "uimf_api.txt", Arrays.asList("Components", "Gap") );
   }
}
