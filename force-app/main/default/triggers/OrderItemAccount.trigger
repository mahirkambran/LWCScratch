trigger OrderItemAccount on Order_Item__c (after insert, after update, after delete, after undelete) {
    
    Set<Id> orderIds = new Set<Id>();
    
    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        for(Order_Item__c orderitem : Trigger.new){
            orderIds.add(orderitem.Order__c);
        }
    }
    
    if(Trigger.isDelete || Trigger.isUpdate){
        for(Order_Item__c orderitem : Trigger.old){
            orderIds.add(orderitem.Order__c);
        }
    }
    
    if(orderIds.isEmpty()){
        return;
    }
    
    List<Order> orders = [SELECT Id, AccountId FROM Order WHERE Id IN : orderIds];
    
    Set<Id> accountIds = new Set<Id>();
    
    for(Order order : orders){
        if(order.AccountId!=null){
            accountIds.add(order.AccountId);
        }
    }
    
    List<AggregateResult> results = [SELECT Order__r.AccountId accountId,Sum(Quantity__c) totalQuantity FROM Order_Item__c WHERE Order__r.AccountId IN : accountIds GROUP BY Order__r.AccountId];
    
    List<Account> accountsupdate = new List<Account>();
    
    for(AggregateResult result : results){
        Account acc = new Account();
        	
        Id accountId = (Id)result.get('accountId');
        acc.Id = accountId;
        acc.Quantity__c = (Decimal)result.get('totalQuantity');
        
        accountsupdate.add(acc);
    }
    
    if(!accountsupdate.isEmpty()){
        update accountsupdate;
    }
    
}