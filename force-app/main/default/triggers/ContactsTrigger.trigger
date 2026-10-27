trigger ContactsTrigger on Contact (before insert, before update) {
   
    
   	Set<String> emailId = new Set<String>();
    
    for(Contact con : Trigger.new){
        if(con.Email!=null){
            emailId.add(con.Email.toLowerCase());
        }
    }
    
    List<Contact> contacts = [SELECT Id,Email FROM Contact WHERE Email IN:  emailId];
    
    Set<String> uniqueEmails = new Set<String>();
    
    for(Contact con : contacts){
        uniqueEmails.add(con.Email);
    }
    
    for(Contact con : Trigger.new){
        if(con.Email != null && uniqueEmails.contains(con.Email)){
            con.Email.addError('Please provide unique Email');
        }
    }
  
}