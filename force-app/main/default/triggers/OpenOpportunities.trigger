trigger OpenOpportunities on Opportunity (after insert, after update, after delete, after undelete) {
    
    Set<Id> uniqueIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Opportunity opp : Trigger.new){
            if(opp.AccountId!=null){
                uniqueIds.add(opp.AccountId);
            }
        }
    }
    
    if(Trigger.isUpdate || Trigger.isDelete){
        for(Opportunity opp : Trigger.old){
            if(opp.AccountId!=null){
                uniqueIds.add(opp.AccountId);
            }
        }
    }
    
    if(uniqueIds.isEmpty()){
        return;
    }
    
    List<AggregateResult> results = [SELECT AccountId,COUNT(Id) openOpportunities FROM Opportunity WHERE IsClosed=false AND AccountId IN : uniqueIds GROUP BY AccountId ];
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    for(Id uniqueId : uniqueIds){
        Account acc = new Account();
        Id accountId = uniqueId;
        
        acc.Id = accountId;
        acc.Open_Opportunities__c = 0;
        
        
        accountMap.put(accountId,acc);
    } 
    
    for(AggregateResult result : results){
        Id accountId = (Id)result.get('AccountId');
        Integer OpenOppo = (Integer)result.get('openOpportunities');
        
        accountMap.get(accountId).Open_Opportunities__c = OpenOppo;
    }
    
    if(!accountMap.isEmpty()){
        update accountMap.values();
    }
}