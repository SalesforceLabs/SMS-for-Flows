global with sharing class TwilioServiceAsync {

     /* Method: sendTwilioMessage
     * Params: List<TwilioMessage>
     * Return: List<TwilioMessageResponse>
     * Description: Invocable Method to send SMS messages via Twilio
     */
    @InvocableMethod
    global static List<Id>  sendTwilioMessage(List<TwilioMessage> twilioMessages) {
        List<Id> queueIds = new List<Id>();
        TwilioServiceAsyncQueue messageQueue = new TwilioServiceAsyncQueue(twilioMessages);

        ID jobId = System.enqueueJob(messageQueue);
        if (jobId != null)
        {
            queueIds.add(jobId);
        }
        
        return queueIds;
    }
    
}