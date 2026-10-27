public with sharing class AccountFetcherWithParameter {

    @AuraEnabled(cacheable=true)
    public static List<Account> AccountFetcherWithParameter(String accountName) {
        return[
            SELECT Id,Name FROM Account WHERE Name LIKE: ('%'+ accountName +'%')
        ];
    }
    
}