trigger OpportunityLineItemTrigger on OpportunityLineItem (after insert, after update, after delete, after undelete) {

    Set<Id> uniqueOppIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(OpportunityLineItem oppline : Trigger.new){
        	uniqueOppIds.add(oppline.OpportunityId);
    	}
    }
    
    if(Trigger.isUpdate || Trigger.isdelete){
        for(OpportunityLineItem oppline : Trigger.old){
        	uniqueOppIds.add(oppline.OpportunityId);
    	}
    }
    
    if(uniqueOppIds.isEmpty()){
        return;
    }
    
    Map<Id,Opportunity> opportunityMap = new Map<Id,Opportunity>();
    
    for(Id oppId : uniqueOppIds){
        Opportunity opp = new Opportunity();
        opp.Id = oppId;
        opp.TotalOpportunityQuantity = 0;
        
        opportunityMap.put(oppId,opp);
    }
    

    
    
    List<AggregateResult> oppresults = [SELECT SUM(Quantity) totalQuantity, OpportunityId FROM OpportunityLineItem WHERE OpportunityId IN : uniqueOppIds GROUP BY OpportunityId];
    
    for(AggregateResult oppresult : oppresults){
        
        Id oppId = (Id)oppresult.get('OpportunityId');
        
        Opportunity opp = opportunityMap.get(oppId);
        
        opp.TotalOpportunityQuantity = (Decimal)oppresult.get('totalQuantity');
        
    }
    
    if(!opportunityMap.isEmpty()){
        update opportunityMap.values();	
    }
    
    Set<Id> accounIdSet = new Set<Id>();
    
    List<Opportunity> oppList = [SELECT Id, AccountId, TotalOpportunityQuantity FROM Opportunity WHERE Id IN : uniqueOppIds];
    
    for(Opportunity opp :  oppList){
        if(opp.AccountId!=null){
            accounIdSet.add(opp.AccountId);
        }
    }
    
	List<AggregateResult> TotalOppValueProductsQuantity = [SELECT AccountId, SUM(Amount) totalAmount,SUM(TotalOpportunityQuantity) totalQuantity  FROM Opportunity WHERE AccountId IN : accounIdSet GROUP BY AccountId];
    List<AggregateResult> TotalClosedWonValue = [SELECT AccountId, SUM(Amount) totalClosedAmount FROM Opportunity WHERE AccountId IN : accounIdSet AND isWon = True GROUP BY AccountId];
    List<AggregateResult> TotalOpenOppCount = [SELECT AccountId, COUNT(Id) totalOpenOppQuantity FROM Opportunity WHERE AccountId IN : accounIdSet AND isClosed = False GROUP BY AccountId];
    
    Map<Id,Account> accountMap = new Map<Id,Account>();
    
    for(Id accId : accounIdSet){
        Account acc = new Account();
        acc.Id = accId;
        acc.Total_Opportunity_Value__c = 0;
        acc.Total_Products_Quantity__c = 0;
        acc.Closed_Won_Value__c = 0;
        acc.Open_Opportunity_Count__c = 0;
        
        accountMap.put(accId,acc);
    }
    
    for(AggregateResult result : TotalOppValueProductsQuantity){
        /*Account acc = new Account();
        acc.Id = (Id)result.get('AccountId');
        acc.Total_Opportunity_Value__c = (Decimal)result.get('totalAmount');
        acc.Total_Products_Quantity__c = (Decimal)result.get('totalQuantity');*/
        
        Account acc = accountMap.get((Id)result.get('AccountId'));
        acc.Total_Opportunity_Value__c = (Decimal)result.get('totalAmount');
        acc.Total_Products_Quantity__c = (Decimal)result.get('totalQuantity');
 
    }
    
    for(AggregateResult result : TotalClosedWonValue){
        
        Account acc = accountMap.get((Id)result.get('AccountId'));
        acc.Closed_Won_Value__c = (Decimal)result.get('totalClosedAmount');
        
    }
    
    for(AggregateResult result : TotalOpenOppCount){
        
        Account acc = accountMap.get((Id)result.get('AccountId'));
        acc.Open_Opportunity_Count__c = (Decimal)result.get('totalOpenOppQuantity');
        
    }
    
    if(!accountMap.isEmpty()){
        update accountMap.values();
    }
    
}