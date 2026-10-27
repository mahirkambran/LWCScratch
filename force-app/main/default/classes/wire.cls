public class wire {
	
    @AuraEnabled(cacheable=true)
    public static list<ACCOUNT> withinpara(string accname){
        List<ACCOUNT> con = [SELECT Id,Name,Industry FROM Account WHERE Name =:accname];
              return con;
            
    }
}