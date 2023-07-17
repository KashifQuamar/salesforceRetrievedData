trigger emailsender on Contact (after insert) {
ContactEmail.Emailhamdler(trigger.new);
}