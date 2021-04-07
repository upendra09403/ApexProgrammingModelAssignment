({
    saveDataTable : function(component, event, helper) {
        var draftValues = event.getParam('draftValues');
        //   var editedRecords =  component.find("acctTable").get("v.draftValues");
        var totalRecordEdited = draftValues.length;
        console.log(draftValues);
        console.log(totalRecordEdited);
        var action = component.get("c.updateRecord");
        action.setParams({
            "editedList":draftValues
        });
        action.setCallback(this,function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //if update is successful
                if(response.getReturnValue() === true){
                    helper.showToast({
                        "title": "Record Update",
                        "type": "success",
                        "message": totalRecordEdited+" Record Updated"
                    });
                    helper.reloadDataTable();
                    //   $A.get('e.force:refreshView').fire();
                } else{ //if update got failed
                    helper.showToast({
                        "title": "Error!!",
                        "type": "error",
                        "message": "Error in update"
                    });
                }
            }
        });
        $A.enqueueAction(action);
    },
    
    /*
     * Show toast with provided params
     * */
    showToast : function(params){
        var toastEvent = $A.get("e.force:showToast");
        if(toastEvent){
            toastEvent.setParams(params);
            toastEvent.fire();
        } else{
            alert(params.message);
        }
    },
    
    /*
     * reload data table
     * */
    reloadDataTable : function(){
        var refreshEvent = $A.get("e.force:refreshView");
        if(refreshEvent){
            refreshEvent.fire();
        }
    },   
})