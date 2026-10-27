trigger TotalQuoteAmount on Quote (after insert, after update, after delete, after undelete) {
    
    Set<Id> uniqueIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isunDelete){
        for(Quote quot : Trigger.new){
            if(quot.AccountId!=null){
                uniqueIds.add(quot.AccountId);
            }
        }
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Quote quot : Trigger.old){
            if(quot.AccountId!=null){
                uniqueIds.add(quot.AccountId);
            }
        }
    }
    
    if(uniqueIds.isEmpty()){
        return;
    }
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    for(Id uniqueid : uniqueIds){
        Account acc = new Account();
        acc.Id = uniqueid;
        acc.Total_Quotation_Amount__c = 0;
        
        accountMap.put(uniqueid,acc);
    }
    
    List<AggregateResult> results = [SELECT AccountId, SUM(GrandTotal) totalquotation FROM Quote WHERE AccountId IN : uniqueIds GROUP BY AccountId];
    
    for(AggregateResult result : results){
        Account acc = new Account();
        acc.Id = (Id)result.get('AccountId');
        acc.Total_Quotation_Amount__c = (Decimal)result.get('totalquotation');
        
        accountMap.put(acc.Id,acc);
    }
    
    if(!accountMap.isEmpty()){
        update accountMap.values();
    }
    
}