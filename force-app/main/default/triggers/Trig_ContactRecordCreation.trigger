/* Trigger For Class ContactCreationDestinationClass requirement salesforce to salesforce integration
 * Date- 18-02-2021
 * Name -Upendra Singh
 */

trigger Trig_ContactRecordCreation on Contact (after insert) {

     for(Contact Con:Trigger.new)
        
    {
        ContactCreationDestinationClass.createContactRecord(Con.LastName); 
    }
}