public class EmailSender {
    public static void sendBulkEmails() {
        List<Messaging.SingleEmailMessage> emailList = new List<Messaging.SingleEmailMessage>();
        
        for (Integer i = 0; i < 20; i++) {
            Messaging.SingleEmailMessage email = new Messaging.SingleEmailMessage();
            email.setSubject('Bulk Email');
            email.setPlainTextBody('This is a bulk email message.');
            email.setToAddresses(new List<String>{ 'kashif.quamar'+i+'@grazitti.com' });
            emailList.add(email);
        }
        
        List<Messaging.SendEmailResult> sendResults = Messaging.sendEmail(emailList);
        
        for (Messaging.SendEmailResult result : sendResults) {
            if (result.isSuccess()) {
                System.debug('Email sent successfully.');
            } else {
                System.debug('Email failed to send. Error: ' + result.getErrors()[0].getMessage());
            }
        }
    }
}