public with sharing class caseDashboard {
    @AuraEnabled(cacheable=true)
    public static List<Case> fetchCases(String caseName) {
        return[
            SELECT Id, CaseNumber, Subject, Reason, Priority, IsClosed, Description, Product__c, ContactPhone, ContactMobile, Status FROM Case WHERE Subject LIKE : ('%' + caseName + '%')
        ];
    }
}