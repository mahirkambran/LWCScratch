trigger OpportunityAmountValidation on Opportunity (before insert, before update) {
    for(Opportunity opp : Trigger.new){
        if(opp.Amount>1000000 && opp.StageName != 'Proposal/Price Quote' &&
            opp.StageName != 'Negotiation/Review' &&
            opp.StageName != 'Closed Won' &&
            opp.StageName != 'Closed Lost'){
            opp.Amount.addError('Please use amount less than 1000000');
        }
    }
}