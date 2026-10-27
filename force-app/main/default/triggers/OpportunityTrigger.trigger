trigger OpportunityTrigger on Opportunity (before insert) {
    for(Opportunity opp : Trigger.new){
        
            opp.Description = opp.StageName;
       
    }
}