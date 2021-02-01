@istest
public class Test_SOAP_LeadManipulationCls {
    @istest static void leadManipulationTest(){
        lead ld=new lead();
        ld.FirstName='Demo Soap';
        ld.LastName='Soap';
        ld.Company='Test';
        ld.Email='test@gmail.com';
        ld.Phone='121212';
       // insert ld;
        test.startTest();
        SOAP_LeadManipulationCls.createLead(ld.FirstName,ld.LastName,ld.Email,ld.Phone);
        lead[] led=[select id from lead where firstname='Demo Soap'];
        system.assertEquals(led.size(), 1);
        SOAP_LeadManipulationCls.UpdateLead('Demo Soap','Soap','demo@gmail.com','222222');
        lead[] leadupdated=[select id,email,phone from lead where firstname='Demo Soap'];
        system.assertEquals(leadupdated[0].Email, 'demo@gmail.com');
        SOAP_LeadManipulationCls.DeleteLead('Demo Soap','Soap','demo@gmail.com','222222');
        lead[] ledtoDelete=[select id from lead where firstname='Demo Soap'];
        system.assertEquals(ledtoDelete.size(), 0);
        test.stopTest();
    }
}