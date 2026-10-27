trigger OpportunityFinanceApplication on Opportunity (after update) {
    List<Finance_Application__c> finList = new List<Finance_Application__c>();
    for(Opportunity oppInstance : Trigger.new){
        Opportunity OldOppInstance = Trigger.oldMap.get(oppInstance.Id);
        Finance_Application__c financeObject = new Finance_Application__c();
        if(OldOppInstance.StageName != 'Closed Won' && oppInstance.StageName == 'Closed Won'){
            financeObject.Account__c = oppInstance.AccountId;
            financeObject.Opportunity__c = oppInstance.Id;
            financeObject.Loan_Amount__c = oppInstance.Amount;
            financeObject.Status__c = 'Submitted';
            
            finList.add(financeObject);
        }
        
    }
        if (!finList.isEmpty()){
        insert finList;
    	}
}