trigger getdata on Event (after insert) {
list<id> conid=new list<id>();
map<id,map<string,string>> eventmap=new map<id,map<string,string>>();
map<string,string> conmap=new map<string,string>();
if(trigger.isafter){
for(event e:trigger.new){

system.debug(e.WhoId);
conid.add(e.id);

}
List<Event> events = [SELECT Id, Subject, WhatId,whoid FROM Event WHERE id in:conid]; 
system.debug(events);
Set<Id> contactIds = new Set<Id>();
for (Event event : events) {
    if (event.Whoid.getSObjectType() == Contact.SObjectType) {
        contactIds.add(event.Whoid);
    }
}
system.debug(contactIds);
List<Contact> contacts = [SELECT Id, Name, Email FROM Contact WHERE Id IN :contactIds];
system.debug(contacts);
// You can now access the contact information for each event
for (Event event : events) {
    if (event.Whoid.getSObjectType() == Contact.SObjectType) {
        for (Contact contact : contacts) {
            if (contact.Id == event.Whoid) {
                // Access contact information
                String contactName = contact.Name;
                String contactEmail = contact.Email;
                // Do something with the contact information
                system.debug(contactName);
                system.debug(contactEmail);
              
                conmap.put(contact.Email,contact.Name);
                eventmap.put(event.id,conmap);
                break;
            }
        }
    }
    system.debug(conmap);
    system.debug(eventmap);
    
}

}
}