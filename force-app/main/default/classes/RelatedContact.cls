/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : RelatedContact
 * Author          : <YourName>
 * Created Date    : Sep 7, 2026
 * Last Modified By: <YourName>
 * Last Modified On: Sep 7, 2026
 * Description     : This class implements for......
 *  
 * Change History  :
 *  Date          │   Author     │   Change
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 *  Sep 7, 2026  │ <YourName>   │ Initial version
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 */

public class RelatedContact {

	@AuraEnabled(cacheable=true)
	public static List<Contact> fetchContacts(String newaccountId) {
		return[ SELECT Id, LastName, FirstName, Name, Phone, Industry__c FROM Contact WHERE AccountId =: newaccountId ] ;
	}

}