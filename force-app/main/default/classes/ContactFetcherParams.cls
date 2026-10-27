public with sharing class ContactFetcherParams {
    @AuraEnabled(cacheable = true)
    public static List<Contact> contactFetcherWithParams(Id accountId){
        try {
            return [SELECT Id, FirstName, LastName, Email
                    FROM Contact    
                    WHERE AccountId =: accountId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}