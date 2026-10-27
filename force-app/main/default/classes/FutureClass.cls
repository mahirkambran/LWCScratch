public class FutureClass {
	@future
    public static void updateAccounts(Set<Id> accountIds){
        List<Account> accounts = [
            SELECT Id, Description FROM Account WHERE Id IN : accountIds
            ];
            for(Account acc : accounts){
                acc.Description = 'Hello,this is update asynchronously';
            }
        update accounts;
         
        
    }
}