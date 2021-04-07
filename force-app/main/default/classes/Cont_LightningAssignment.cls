public with sharing class Cont_LightningAssignment {
    @Auraenabled
    public static list<listview> getListViews(string obj){
        //string str=string.valueof(obj);
        list<listview> allListViews=[select Name from listview where sobjectType=:obj];
        system.debug(allListViews);
        return allListViews;
    }
    @Auraenabled
    public static string getDeveloperName(string obj,string listView_Name){
        if(listView_Name=='None'){
           return null; 
        }
        list<listview> ListViewsDeveloperName=[select id, developername  from listview where sobjectType=:obj AND Name=:listView_Name];
        system.debug(ListViewsDeveloperName);
        return ListViewsDeveloperName[0].developername;
    }
}