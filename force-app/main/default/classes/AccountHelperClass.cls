public with sharing class AccountHelperClass {
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(Id accId){
        try {
            return [SELECT Id, Name, Phone FROM Account WHERE Id =: accId];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}