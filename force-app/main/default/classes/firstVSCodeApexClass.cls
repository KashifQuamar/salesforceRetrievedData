/**
 * @description       : 
 * @author            : ChangeMeIn@UserSettingsUnder.SFDoc
 * @group             : 
 * @last modified on  : 05-17-2023
 * @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class firstVSCodeApexClass {
    public firstVSCodeApexClass() {

    }
    @AuraEnabled(cacheable=true)
    public static list<state__mdt> getdata(){
       return state__mdt.getAll().values();
    }
}