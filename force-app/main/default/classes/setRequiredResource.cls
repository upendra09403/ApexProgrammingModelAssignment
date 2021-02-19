public class setRequiredResource {

    public List<String> serviceAppointmentsAsStringList;
    public List<ServiceAppointment> serviceAppointmentsInPolygon;
    public List<ServiceAppointment> serviceAppointmentsWithParentWorkOrder;
    public Integer numServiceAppointments {get;set;}
    public Integer numParentWorkOrders {get;set;}
    public List<SelectOption> resourceOptions {get;set;}
    public String chosenResource {get;set;}
    public String errorMessage {get;set;}

    public setRequiredResource()
    {   
        String multipleAppointmentParameter = apexpages.currentpage().getparameters().get('services');
        String singleAppointmentParameter = apexpages.currentpage().getparameters().get('id');
        serviceAppointmentsAsStringList = new List<String>();
        if(singleAppointmentParameter!=null){
              serviceAppointmentsAsStringList.add(singleAppointmentParameter);
        }
        else if(multipleAppointmentParameter!=null){
            serviceAppointmentsAsStringList = multipleAppointmentParameter.split(',');
        }
        else{}
        resourceOptions = new list<SelectOption>();
        fetchAppointments();
    }

    public void fetchAppointments(){
        serviceAppointmentsInPolygon = [Select Id from ServiceAppointment where Id in:serviceAppointmentsAsStringList];
        serviceAppointmentsWithParentWorkOrder = [Select Id, ParentRecordType, ParentRecordId from ServiceAppointment where Id in:serviceAppointmentsAsStringList and ParentRecordType='WorkOrder'];
           if(!serviceAppointmentsInPolygon.isEmpty()&&!serviceAppointmentsWithParentWorkOrder.isEmpty()){
               List<ServiceResource> resources = new List<ServiceResource>();
               resources = [Select Id, Name from ServiceResource];
            for(ServiceResource sr : resources){
               resourceOptions.add(new selectOption(sr.Id, sr.Name));
            }         
            numServiceAppointments = serviceAppointmentsInPolygon.size();
            numParentWorkOrders = serviceAppointmentsWithParentWorkOrder.size();
        }
        else if(!serviceAppointmentsInPolygon.isEmpty()&&serviceAppointmentsWithParentWorkOrder.isEmpty()){
            errorMessage = 'No Service Appointments found with Work Order as parent.';
        }
        else{errorMessage = 'No appointments found within polygon!';}
    }

    public void createResourcePreferences(){
        List<ResourcePreference> resourcePreferencesToCreate = new List<ResourcePreference>();
        Set<Id> preferenceRecords = new Set<Id>();
        for(ResourcePreference rp:[Select RelatedRecordId from ResourcePreference where ServiceResourceId =: chosenResource]){
            preferenceRecords.add(rp.RelatedRecordId);
        }
        for(ServiceAppointment sa : serviceAppointmentsWithParentWorkOrder){
            if(!preferenceRecords.contains(sa.ParentRecordId)){
                ResourcePreference rp = new ResourcePreference();
                rp.PreferenceType = 'Required';
                rp.ServiceResourceId = chosenResource;
                rp.RelatedRecordId = sa.ParentRecordId;
                resourcePreferencesToCreate.add(rp);
            }
            else{}
        }
        if(!resourcePreferencesToCreate.isEmpty()){
            insert resourcePreferencesToCreate;
        }
        else{//errorMessage = 'No resource preference records to create!';
            }
    }

    public list<SelectOption> getOpenOptions(){
        return resourceOptions;
    }
}