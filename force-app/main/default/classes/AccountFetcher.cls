public with sharing class AccountFetcher {

    @AuraEnabled(cacheable=true)
    public static List<Account> AccountFetcher() {
            return[
                SELECT Id, Name FROM Account lIMIT 10
            ];
    }
}