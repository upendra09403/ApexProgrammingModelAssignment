trigger Trig_ContactRecordCreation on Contact (after insert) {

     for(Contact Con:Trigger.new)
        
    {
        ContactCreationDestinationClass.createContactRecord(Con.LastName); 
    }
}