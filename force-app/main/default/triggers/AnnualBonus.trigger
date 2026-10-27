trigger AnnualBonus on Employee__c (before insert) {
    for(Employee__c employee : Trigger.new){
        
        if(employee.Salary__c == null){
            employee.Annual_Bonus__c = 0;
            return;
        }
        
        if(employee.Salary__c > 60000){
            employee.Annual_Bonus__c = employee.Salary__c * 0.15;
        }
        else if(employee.Salary__c <= 60000 && employee.Salary__c >= 30000){
            employee.Annual_Bonus__c = employee.Salary__c * 0.10;
        }
        else{
            employee.Annual_Bonus__c = employee.Salary__c * 0.05;
        }
    }
}