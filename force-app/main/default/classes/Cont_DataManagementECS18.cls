/* Select a single object from a picklist. The object names should appear in a sorted order based on the API
Name. Display only those fields which are query able in vfPage
        27/01/2021 Upendra Singh
*/

public class Cont_DataManagementECS18 {
 public Map <String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
public List <Pair> fields {get; set;}
public List <SelectOption> objectNames {get;set;}
public String selectedObject {get; set;}
    public String selectedFields{get;set;}
    public list<selectoption> fieldNames{get;set;}
// Intialize objectNames and fields

public Cont_DataManagementECS18() {
objectNames = initObjNames();
fields = new List<Pair>();
}

public List<SelectOption> initObjNames() {
List<SelectOption> objNames = new List<SelectOption>();
objNames.add(new selectoption('Select One','Select One'));
List<String> entities = new List<String>(schemaMap.keySet());
entities.sort();
for(String name : entities)
objNames.add(new SelectOption(name,name));
return objNames;
}
// Find the fields for the selected object
public void showFields() {
fields.clear();
Map <String, Schema.SObjectField> fieldMap = schemaMap.get(selectedObject).getDescribe().fields.getMap();
 fieldNames = new List<SelectOption>();
for(Schema.SObjectField sfield :fieldMap.values()){
    schema.describefieldresult dfield = sfield.getDescribe();
    fieldNames.add(new SelectOption(dfield.getLabel(),dfield.getName()));
} 
}

public class Pair {

}
}