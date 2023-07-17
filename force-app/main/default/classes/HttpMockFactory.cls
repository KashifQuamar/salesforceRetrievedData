@istest
global class HttpMockFactory implements httpCalloutMock{
    private string contentType;
    private string ContentTypeCode;
    private integer code;
    global HttpMockFactory(string contentType,String ContentTypeCode,Integer code){
        this.contentType=contentType;
        this.ContentTypeCode=ContentTypeCode;
        this.code=code;
    }
  global HttpResponse respond (HttpRequest request)
  {
      HttpResponse response=new HttpResponse();
        response.setHeader(ContentType, ContentTypeCode);
      response.setBody('{"uuid":"7FS8eU46QP6FI9o1TwrEYA==","id":96421135664,"host_id":"RxDjkPVyQKuPnarhb5shOQ","host_email":"kashif.quamar@grazitti.com","topic":"Meeting","type":2,"status":"waiting","start_time":"2023-06-08T13:30:00Z","duration":60,"timezone":"Asia/Calcutta","created_at":"2023-06-08T13:04:37Z","start_url":"https://zoom.us/s/96421135664?zak=eyJ0eXAiOiJKV1QiLCJzdiI6IjAwMDAwMSIsInptX3NrbSI6InptX28ybSIsImFsZyI6IkhTMjU2In0.eyJhdWQiOiJjbGllbnRzbSIsInVpZCI6IlJ4RGprUFZ5UUt1UG5hcmhiNXNoT1EiLCJpc3MiOiJ3ZWIiLCJzayI6IjAiLCJzdHkiOjEsIndjZCI6ImF3MSIsImNsdCI6MCwibW51bSI6Ijk2NDIxMTM1NjY0IiwiZXhwIjoxNjg2MjM2Njc4LCJpYXQiOjE2ODYyMjk0NzgsImFpZCI6IkVHZzV3b0ZZUmRlVXdfZkhuOHUtdEEiLCJjaWQiOiIifQ.0vNncvRPaBNcINs8Pvi6OqNJ8XpbRl5g6cZzjzs3L_Y","join_url":"https://zoom.us/j/96421135664?pwd=T3FJVGlUUzhCa0RabitVdFRYcWkwZz09","password":"Jg60VK","h323_password":"346329","pstn_password":"346329","encrypted_password":"T3FJVGlUUzhCa0RabitVdFRYcWkwZz09","settings":{"host_video":false,"participant_video":false,"cn_meeting":false,"in_meeting":false,"join_before_host":false,"jbh_time":0,"mute_upon_entry":false,"watermark":false,"use_pmi":false,"approval_type":2,"audio":"voip","auto_recording":"none","enforce_login":false,"enforce_login_domains":"","alternative_hosts":"","alternative_host_update_polls":false,"close_registration":false,"show_share_button":false,"allow_multiple_devices":false,"registrants_confirmation_email":true,"waiting_room":false,"request_permission_to_unmute_participants":false,"registrants_email_notification":true,"meeting_authentication":false,"encryption_type":"enhanced_encryption","approved_or_denied_countries_or_regions":{"enable":false},"breakout_room":{"enable":false},"alternative_hosts_email_notification":true,"show_join_info":false,"device_testing":false,"focus_mode":false,"enable_dedicated_group_chat":false,"private_meeting":false,"email_notification":true,"host_save_video_order":false,"sign_language_interpretation":{"enable":false},"email_in_attendee_report":false},"pre_schedule":false}');
     response.setStatusCode(code);   
      return response;
  }
}