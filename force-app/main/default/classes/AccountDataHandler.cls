public with sharing class AccountDataHandler {
    @AuraEnabled(cacheable=true)
    public static List<Account> getaccountsdatatable(){
        try {
            return [
            SELECT Id, Name, Phone, Industry
            FROM Account
        ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}