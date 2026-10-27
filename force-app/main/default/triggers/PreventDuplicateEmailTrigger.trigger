trigger PreventDuplicateEmailTrigger on Account (before insert,after insert) {
    
    if(Trigger.isInsert && Trigger.isBefore){
        Set<String> uniqueEmailList = new Set<String>();
    
    for(Account accou : [SELECT Id, Email__c FROM Account]){
        uniqueEmailList.add(accou.Email__c);
    }
    

    //insert uniqueEmailList;
    
    for(Account acc : Trigger.new){
        if(uniqueEmailList.contains(acc.Email__c)){
            acc.Email__c.addError('Its a duplicate mail id');
        }
    }
    }
    
    if(Trigger.isInsert && Trigger.isAfter){
        List<Contact> contactlist = new List<Contact>();
        
        for(Account acc : Trigger.new){
            
            Contact con = new Contact();
            
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            
            contactlist.add(con);
        }
        
        if(!contactlist.isEmpty()){
            insert contactlist;
        }
    }
    
    
    
}