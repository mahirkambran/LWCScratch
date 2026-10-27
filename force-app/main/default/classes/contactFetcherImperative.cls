public with sharing class contactFetcherImperative {
        @AuraEnabled
        public static List<Contact> getContacts(Id accountId){
            try {
                return [
                    SELECT Id, FirstName, LastName, Email
                    FROM Contact
                    WHERE AccountId = :accountId
    ];
            } catch (Exception e) {
                throw new AuraHandledException(e.getMessage());
            }
        }
    }