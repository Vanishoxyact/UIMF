public class LuaTableConfiguration {
   
   private TsvFile tsvFile;
   private String keyColumn;
   private KeyType keyType;
   private String tableName;

   public TsvFile getTsvFile() {
      return tsvFile;
   }

   public void setTsvFile( TsvFile tsvFile ) {
      this.tsvFile = tsvFile;
   }

   public String getKeyColumn() {
      return keyColumn;
   }

   public void setKeyColumn( String keyColumn ) {
      this.keyColumn = keyColumn;
   }

   public KeyType getKeyType() {
      return keyType;
   }

   public void setKeyType( KeyType keyType ) {
      this.keyType = keyType;
   }

   public String getTableName() {
      return tableName;
   }

   public void setTableName( String tableName ) {
      this.tableName = tableName;
   }
}
