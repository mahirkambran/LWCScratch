@RestResource(urlMapping='/getDataFromOurSystem/*')
global class exposinLearn {

    @httpget
    global static List<Contact> getContactData(){
        RestRequest req = RestContext.request;
        Map<String,String> mapOfData = req.params;
        String myRecId = mapOfData.get('sfId');
        String email = mapOfData.get('email');
        
        System.debug('Check passed record Id '+myRecId);
        System.debug('Check passed record Id '+email);
        
        List<Contact> conList = [SELECT Id, Name FROM Contact WHERE Id =: myRecId AND Email =: email];
        
        return conList;
    }
    
}