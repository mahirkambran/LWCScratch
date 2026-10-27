trigger TotalOpportunityAmountinAccount on Opportunity (after insert, after update, after delete, after undelete) {
    
    Set<Id> uniqueIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isunDelete){
        for(Opportunity oppo : Trigger.new){
            if(oppo.AccountId != null){
                uniqueIds.add(oppo.AccountId);
            }
        }
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Opportunity oppo : Trigger.old){
            if(oppo.AccountId != null){
                uniqueIds.add(oppo.AccountId);
            }
        }
    }
    
    if(uniqueIds.isEmpty()){
        return;
    }
    
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    for(Id accountId : uniqueIds){
        Account acc = new Account();
        acc.Id = accountId;
        acc.Opportunity_sum__c = 0;
        
        accountMap.put(accountId,acc);
        
    }
    
    List<AggregateResult> results = [SELECT AccountId,SUM(Amount) totalAmount FROM Opportunity WHERE AccountId IN: uniqueIds GROUP BY AccountId];
    
    for(AggregateResult result : results){
        Id AccountId = (Id)result.get('AccountId');
        Decimal totalAmount = (Decimal)result.get('totalAmount');
        
        accountMap.get(AccountId).Opportunity_sum__c = totalAmount;
    }
    
    if(!accountMap.isEmpty()){
        update accountMap.values();
    }

}