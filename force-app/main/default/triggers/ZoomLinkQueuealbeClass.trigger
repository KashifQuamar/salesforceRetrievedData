trigger ZoomLinkQueuealbeClass on Event (after insert) {
  if(trigger.isinsert && trigger.isafter){
   ZoomIntegrationQueueableClass  queJob=new ZoomIntegrationQueueableClass(trigger.new);

      id jobid=System.enqueueJob(queJob);
  }
}