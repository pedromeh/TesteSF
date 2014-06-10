trigger AccContactPartnerUpdate on Contact (before insert, before update) {
	    
    List<Contact> accContactToUpdate = new List<Contact>();
    RecordType rt = [SELECT Id,Name FROM RecordType r WHERE r.Name='Partner Contact'
                                    LIMIT 1];

    Set<Id> resourceIds = new Set<Id>();
        
	for (Contact contact : Trigger.new) {
		if(contact.RecordTypeId == rt.Id) {           
			resourceIds.add(contact.Id);       
		}     
	}
	
	 if (!resourceIds.isEmpty()) {
	 	
	 	Account a = [SELECT Id,Name FROM Account WHERE Name='Partner Account' LIMIT 1];
	 	
	    for (Contact c : Trigger.new) {
	        if (c.RecordTypeId== rt.Id)
	        {
	       		c.AccountId=a.Id
	        }
	    }
	}
}
