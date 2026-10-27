public with sharing class AccountParaExample {

    @AuraEnabled(cacheable=true)
    public static List<Account> AccountParaExample(String accountName) {
        return[
            SELECT Id, Name, Rating FROM Account WHERE Name LIKE: ('%' + accountName + '%')
        ];
    }

    @AuraEnabled
    public static List<Contact> contactFetcher(String contactName){
        try {
            return [
                SELECT Id, Name FROM Contact WHERE Name LIKE: ('%'+contactName+'%') LIMIT 10 
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static List<Account> getAccountDetails(String accountName){
        return[
            SELECT Id,Name FROM Account WHERE Name LIKE: ('%' + accountName + '%')
        ];
    }

    @AuraEnabled(cacheable=true)
    public static List<Opportunity> fetchOpportunities(){
        return[
            SELECT Id,Name,OwnerId,AccountId,StageName FROM Opportunity LIMIT 10
        ];
    }
    
}