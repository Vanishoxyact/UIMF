import java.util.List;

public class LuaFunction {
   
   private String functionClass;
   private String functionName;
   private List<String> functionParams;
   private boolean isReturned;

   public LuaFunction( String functionClass, String functionName, List< String > functionParams ) {
      this.functionClass = functionClass;
      this.functionName = functionName;
      this.functionParams = functionParams;
   }

   public String getFunctionClass() {
      return functionClass;
   }

   public String getFunctionName() {
      return functionName;
   }

   public List< String > getFunctionParams() {
      return functionParams;
   }

   public boolean isReturned() {
      return isReturned;
   }

   public void setReturned( boolean returned ) {
      isReturned = returned;
   }
}
