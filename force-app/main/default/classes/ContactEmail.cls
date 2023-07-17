public class ContactEmail {
 public static void Emailhamdler(list<contact> condata)
{
    list<Messaging.Email> emailList= new list<Messaging.Email>();
    for(contact con:condata)
    {
        if(con.email!=null)
        {
            Messaging.SingleEmailMessage emailMsg=new Messaging.SingleEmailMessage();
            string[] toAddress= new String[]{con.Email};
                emailMsg.setBccAddresses(toAddress);
             String emailSubject='Welcome '+Con.lastname;
            emailMsg.setSubject(emailSubject);
            string disname='kashif Quamar';
            emailMsg.setSenderDisplayName(disname);
            string content=' hi' +con.lastname+',<br/><br/>'+
                'welcome to salesforce Ecosystem! <br/><br/>'+
                'Begin your salesforce Admin and Developer journey with kashif Quamar <br/><br/>'+
                'Thank you! <br/><br/>';
            emailMsg.setHtmlBody(content);
            emailList.add(emailMsg);
        }
    }
    Messaging.sendEmail(emailList);
    
    
}
}