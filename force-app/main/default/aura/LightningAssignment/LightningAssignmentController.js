({
    onSingleSelectChange : function(component, event, helper) {
        var selectCmp = component.find("InputSelectSingle").get("v.value");
        console.log(selectCmp);
        var action =component.get("c.getListViews");
        action.setParams({"obj":selectCmp});
        action.setCallback(this,function(response){
            var state=response.getState();
            console.log(state);
            if(state==="SUCCESS"){
                component.set("v.ListView",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    
    onListViewChange : function(component, event, helper) {
        component.set("v.bShowListView", false);
        var selectCmp1 = component.find("InputSelectSingle").get("v.value");
        var selectlist = event.getSource().get("v.value");
        //   console.log(selectCmp1);
        //   console.log(selectlist);
        var action=component.get("c.getListViewData");
        action.setParams({"obj":selectCmp1,"listView_Name":selectlist});
        action.setCallback(this,function(response){
            var state=response.getState();
            //its giving error
            var result = response.getReturnValue();
            console.log('result2=='+result);
            if(state==="SUCCESS"){
                var displayColumns = result.describeResult.columns.filter( function( column ) { return column.hidden === 'false'; } ).map( function( column ) {
                    return {
                        'label' : column.label,
                        'fieldName' : column.fieldNameOrPath ,
                        'type' : column.type,
                        'editable': true
                    };
                });
                
                component.set( 'v.mycolumns', displayColumns );
                var pageSize = component.get("v.pageSize");
                component.set("v.mydata",result.records);
                component.set("v.bShowListView", true);
                component.set("v.sobject",component.find("InputSelectSingle").get("v.value"));
                component.set("v.iconName",component.get("v.sobject").toLowerCase());
                console.log(component.get("v.iconName"));
                component.set("v.viewName",component.find("InputSelectListView").get("v.value"));
                component.set("v.totalRecords", component.get("v.mydata").length);
                var numberOfRecords=component.get("v.totalRecords");
                console.log(numberOfRecords);
                component.set("v.startPage",0);
                
                component.set("v.endPage",pageSize-1);
                var PaginationList = [];
                for(var i=0; i<pageSize; i++){
                    if(component.get("v.mydata").length> i)
                        PaginationList.push(response.getReturnValue().records[i]);    
                }
                component.set("v.PaginationList", PaginationList);
            }
            else if (state === "INCOMPLETE") {
                console.log('Incomplete state');
            }
                else if (state === "ERROR") {
                    var errors = response.getError();
                    if (errors) {
                        if (errors[0] && errors[0].message) {
                            console.log("Error message: " + 
                                        errors[0].message);
                        }
                    } else {
                        console.log("Unknown error");
                    }
                }
        });
        $A.enqueueAction(action);
    },
    searchKeyChange: function(component, event, helper){
        var searchKey=component.find("searchKey").get("v.value");
        console.log('Search Key Is ########## :'+searchKey);
        var action=component.get('c.fetchRecordsByName');
        action.setParams({
            "searchStr" :searchKey,
            "obj" :component.find("InputSelectSingle").get("v.value")
        });
        action.setCallback(this, function(response){
           var state=response.getState();
            console.log('search key state:'+state);
           if(state==="SUCCESS"){
              component.set('v.PaginationList',response.getReturnValue());      
                
            }
        });
        $A.enqueueAction(action);
        
    },
    onSave: function (component, event, helper) {
        helper.saveDataTable(component, event, helper);       
    },
    
    next: function (component, event, helper) {
        var sObjectList = component.get("v.mydata");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i=end+1; i<end+pageSize+1; i++){
            if(sObjectList.length > i){
                Paginationlist.push(sObjectList[i]);
            }
            counter ++ ;
        }
        start = start + counter;
        end = end + counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
    },
    previous: function (component, event, helper) {
        var sObjectList = component.get("v.mydata");
        var end = component.get("v.endPage");
        var start = component.get("v.startPage");
        var pageSize = component.get("v.pageSize");
        var Paginationlist = [];
        var counter = 0;
        for(var i= start-pageSize; i < start ; i++){
            if(i > -1){
                Paginationlist.push(sObjectList[i]);
                counter ++;
            }else{
                start++;
            }
        }
        start = start - counter;
        end = end - counter;
        component.set("v.startPage",start);
        component.set("v.endPage",end);
        component.set('v.PaginationList', Paginationlist);
    },
    
})