public with sharing class CountedAccountFetcherHighValue {
    @AuraEnabled(cacheable=true)
    public static List<Account> getHighRevenueAccountRecordsCounted(Integer count){
        try {
            return [SELECT Id,Name,AnnualRevenue FROM Account ORDER BY AnnualRevenue DESC NULLS LAST LIMIT :count];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}