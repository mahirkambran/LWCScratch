/**
 * ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――
 * Class Name      : AccountSearchDashboard
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

public class AccountSearchDashboard {

	@AuraEnabled(cacheable = TRUE)
	public static List<Account> accountsdashboard(String accountname){
		return[
			SELECT Id, Name, Industry FROM Account WHERE Name LIKE: ('%'+ accountname +'%') LIMIT 10
		];
	}


	@AuraEnabled(cacheable=true)
	public static List<Case> fetchCases(String selectedContactId){
		return[
			SELECT Id, CaseNumber, Subject, Priority, IsClosed, Description FROM Case WHERE ContactId =: selectedContactId
		];
	}
}