trigger checkingDelete on Contact (before delete,after delete) {
if(trigger.isafter){
for(contact c:trigger.old){
system.debug('this is after delete');
system.debug(c);
system.debug(c.id);
system.debug(c.lastname);
}
}
}