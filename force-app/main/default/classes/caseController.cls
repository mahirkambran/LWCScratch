public with sharing class caseController {

    @AuraEnabled
    public static List<Case> fetchCases(String searchedText) {
        
        return[
            SELECT Id, CaseNumber, Subject, Reason, Status FROM Case WHERE Subject LIKE: ('%'+ searchedText +'%')
        ];
    }

    @AuraEnabled(cacheable=true)
    public static Case fetchCase(String selectedCaseId){
        try {
            return[
                SELECT Id, CaseNumber, ContactId, AccountId, Subject, Reason, Status, Priority, Description, Product__c FROM Case WHERE Id =: selectedCaseId
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}