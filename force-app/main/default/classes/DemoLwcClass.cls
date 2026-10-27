public class DemoLwcClass {
    
    @auraenabled(cacheable = true)
    public static Contact getAccounts(){
        
        Contact con = [Select Id, lastName, Phone from Contact LIMIT 1];
        return con;
    }

}