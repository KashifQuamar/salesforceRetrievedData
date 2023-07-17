trigger gettingZoomLink on Event (after insert){
  if(trigger.isinsert){
      if(trigger.isafter)
      {
      ZoomAccountLevelIntegration ZAl=new ZoomAccountLevelIntegration(trigger.new);
     
     ///////////////////////////
        String day = string.valueOf(system.now().day());
        String month = string.valueOf(system.now().month());
        String hour = string.valueOf(system.now().hour());
        String minute = string.valueOf(system.now().minute() + 1);
        String second = string.valueOf(system.now().second());
        String year = string.valueOf(system.now().year());
        
        String strJobName = 'Job-' + second + '_' + minute + '_' + hour + '_' + day + '_' + month + '_' + year;
        String strSchedule = '0 ' + minute + ' ' + hour + ' ' + day + ' ' + month + ' ?' + ' ' + year;
        System.schedule(strJobName, strSchedule, ZAl);
     
     /////////////////////
        }
     }


}