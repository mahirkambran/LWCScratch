trigger RollUpSummaryTrriger on Contact (after insert, after update, after delete,after undelete) {

    if(Trigger.isInsert || Trigger.isUpdate || Trigger.isUndelete){
        Set<Id> uniquecontactlist = new Set<Id>();
        for(Contact con : Trigger.new){
            if(con.AccountId!=null){
                uniquecontactlist.add(con.AccountId);   
            }
        list<Account> accId = new list<Account>();
        list<AggregateResult> fetch = [SELECT COUNT(Id) contactcount,AccountId FROM Contact WHERE AccountId IN: uniquecontactlist GROUP BY AccountId];
        
        for(AggregateResult each : fetch){
            Account acc = new Account();
            acc.Id = (Id)each.get('AccountId');
            acc.Total_Contacts__c = (Integer)each.get('contactcount');
            
            accId.add(acc);
        }
        if(!accId.isEmpty()){
            update accId;
        }
    }
    }
    
    if(Trigger.isDelete){
        Set<Id> uniquecontactlist = new Set<Id>();
        for(Contact con : Trigger.old){
            if(con.AccountId!=null){
                uniquecontactlist.add(con.AccountId);   
            }
        }
        
        list<Account> accId = new list<Account>();
        list<AggregateResult> fetch = [SELECT COUNT(Id) contactcount,AccountId FROM Contact WHERE AccountId IN: uniquecontactlist GROUP BY AccountId];
        
        for(AggregateResult each : fetch){
            Account acc = new Account();
            acc.Id = (Id)each.get('AccountId');
            acc.Total_Contacts__c = (Integer)each.get('contactcount');
            
            accId.add(acc);
        }
        if(!accId.isEmpty()){
            update accId;
        }
    }
    
    
}