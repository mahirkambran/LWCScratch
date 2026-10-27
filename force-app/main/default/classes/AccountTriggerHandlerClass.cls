public class AccountTriggerHandlerClass {
    public static void updateRating(List <Account> newList){
        for(Account acc : newList){
            if(acc.Industry != null && acc.Industry == 'Media'){
                acc.Rating = 'Hot';
            }
            else
            {
                ///pending..........
            }
    }
    }
    
    public static void createRelatedOppo(List<Account> newList){
        
        List<Opportunity> oppToBeInserted = new List<Opportunity>();
        
        for(Account acc : newList){
            Opportunity opp = new Opportunity();
            opp.name = acc.Name;
            opp.AccountId = acc.Id;
            opp.StageName = 'Prospecting';
            opp.CloseDate = System.today();
            
            oppToBeInserted.add(opp);
        }
        
        if(!oppToBeInserted.isEmpty()){
            insert oppToBeInserted;
        }
    }
    
    public static void updatePhoneDescription(List<account> newList, Map<Id,Account> oldMap){
        
        for(Account acc : newList){
            if(oldMap != null && acc.Phone != oldMap.get(acc.Id).Phone){
                acc.Description = 'Phone is updated on Account';
            }
        }
    }
    
    public static void createRelatedOppPhone(List<account> newList, Map<Id,Account> oldMap){
        
        Map<Id, Account> accIdToAccountMap = new Map<Id, Account>();
        List<Opportunity> oppToBeUpdated = new List<Opportunity>();
        
        for(Account acc : newList){
            if(oldMap != null && acc.Phone != oldMap.get(acc.Id).Phone){
                accIdToAccountMap.put(acc.id,acc);
            }
        }
        
        
        for(Opportunity opp : [SELECT Id, AccountId, Account_Phone__c FROM Opportunity WHERE AccountId IN :accIdToAccountMap.keySet()]){
            
            Opportunity oppor = new Opportunity();
            
            if(accIdToAccountMap.containskey(opp.AccountId)){
                oppor.Id = opp.Id;
                oppor.Account_Phone__c = accIdToAccountMap.get(opp.AccountId).phone;
                oppToBeUpdated.add(oppor);
            }
        }
        
        if(!oppToBeUpdated.isEmpty()){
            update oppToBeUpdated;
        }
    }
}