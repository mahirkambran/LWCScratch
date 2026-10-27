trigger TotalOpportunityAmount on Opportunity (after insert, after update, after delete, after undelete) {
    
    Set<Id> uniqueIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Opportunity opp : Trigger.new){
            uniqueIds.add(opp.AccountId);
        }
    }
    
    if(Trigger.isDelete || Trigger.isUpdate){
        for(Opportunity opp : Trigger.old){
            uniqueIds.add(opp.AccountId);
        }
    }
    
    if(uniqueIds.isEmpty()){
        return;
    }
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    for(Id uniqueId : uniqueIds){
        Account acc = new Account();
        acc.id = uniqueId;
        acc.Opportunity_sum__c = 0;
        
        accountMap.put(uniqueId,acc);
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