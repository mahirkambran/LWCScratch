@RestResource(urlmapping='/AccountContactApi')
global class AccountConAPI {
	
    @httpPost
    global static void saveAccContFromExtSys(){
        RestRequest req = RestContext.Request;
        RestResponse res = RestContext.Response;
        
        String body = req.requestBody.toString();
        MyJsonClass myobj = (MyJsonClass)JSON.deserialize(body,MyJsonClass.Class);
        
        System.debug('<---> '+myobj.CustomerName+' - '+myobj.isAccount);
        
        if(myobj.isAccount==true){	
            Account acc = new Account(Name=myobj.CustomerName);
            insert acc;
        }else{
            Contact con = new Contact(lastName=myobj.CustomerName);
            insert  con;
        }
    }
    
}