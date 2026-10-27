trigger OpportunityTrigge on Opportunity (after insert, after update, after delete,after undelete) {
	Set<Id> uniqueAccId = new Set<Id>();
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Opportunity opp : Trigger.new){
        	if(opp.AccountId != null){
            	uniqueAccId.add(opp.AccountId);
        	}
    	}
    }
    
    if( Trigger.isUpdate || Trigger.isDelete){
        for(Opportunity opp : Trigger.old){
        	if(opp.AccountId != null){
            	uniqueAccId.add(opp.AccountId);
        	}
    	}
    }
    
    if(uniqueAccId.isEmpty()){
        return;
    }
    
    Map<Id,Account> AccountMap = new  Map<Id,Account>();
    
    List<AggregateResult> results = [SELECT AccountId,SUM(Amount) Amounts FROM Opportunity WHERE AccountId IN: uniqueAccId GROUP BY AccountId];
    
    for(Id accountId : uniqueAccId){
        Account acc = new Account();
        acc.Id = accountId;
        acc.Total_Opportunity_Amount__c = 0;
        AccountMap.put(accountId,acc);
    }
    
    for(AggregateResult result : results){
        Account acc = new Account();
        Id accId = (Id)result.get(acc.Id);
        AccountMap.get(accId).Total_Opportunity_Amount__c = (Decimal)result.get('Amounts');
        
        AccountMap.put(accId,acc);
    }
    
    if(!AccountMap.isEmpty()){
        update AccountMap.values();
    }
    
}