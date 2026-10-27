trigger TotalClosedWonAmount on Opportunity (after insert, after update, after delete, after unDelete) {
    
    Set<Id> uniqueIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isunDelete){
        for(Opportunity opp : Trigger.new){
            if(opp.AccountId!=null){
                uniqueIds.add(opp.AccountId);
            }
        }
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Opportunity opp : Trigger.new){
            if(opp.AccountId!=null){
                uniqueIds.add(opp.AccountId);
            }
        }
    }
    
    if(uniqueIds.isEmpty()){
        return;
    }
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    for(Id uniqueId : uniqueIds){
        
        Account acc = new Account();
        acc.Id = uniqueId;
        acc.Total_Closed_Won_Amount__c = 0;
        
        accountMap.put(uniqueId,acc);
    }
    
    List<AggregateResult> results = [SELECT AccountId, SUM(Amount) totalAmount FROM Opportunity WHERE AccountId IN : uniqueIds AND IsWon = TRUE GROUP BY AccountId];
    
    for(AggregateResult result : results){
        Account acc = new Account();
        acc.Id = (Id)result.get('AccountId');
        acc.Total_Closed_Won_Amount__c = (Decimal)result.get('totalAmount');
        
        accountMap.put(acc.Id,acc);
    }
    
    if(!accountMap.isEmpty()){
        update accountMap.values();
    }
}