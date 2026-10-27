global class AccountContactSOAPApi{
    webservice static String insertAccContact(String customerName, Boolean isAccount){
        if(isAccount==true){
            Account acc = new Account(Name=customerName);
            insert acc;
            return acc.Id;
        }
        else{
            Contact con = new Contact(lastName = customerName);
            insert con;
            return con.Id;
        }
    }
}