trigger AccountTrigger on Account (before insert, after insert, before update, after update) {
    if(Trigger.isInsert){
        if(Trigger.isBefore){
            AccountTriggerHandlerClass.updateRating(trigger.new);
        }
        else if(Trigger.isAfter){
            AccountTriggerHandlerClass.createRelatedOppo(trigger.new);
        }
        
    }
    if(Trigger.isUpdate){
        if(Trigger.isBefore){
            AccountTriggerHandlerClass.updatePhoneDescription(trigger.new, trigger.oldMap);
        }
        else if(Trigger.isAfter){
            AccountTriggerHandlerClass.createRelatedOppPhone(trigger.new,  trigger.oldMap);
        }
    }
}