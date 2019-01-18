@isTest
public with sharing class TwilioServiceAsyncQueueTest {
    static testmethod void asyncQueueTest() {
        Test.startTest();      
        Test.setMock(HttpCalloutMock.class, new TwilioMockHttpResponse());
        TwilioMessage msg = new TwilioMessage();
        msg.toNumber = '5555555555';
        msg.messageBody = 'The Cat in the Hat';
        List<TwilioMessage> msgs = new List<TwilioMessage>();
        msgs.add(msg);
        ID jobId = System.enqueueJob(new TwilioServiceAsyncQueue(msgs));
        Test.stopTest();
        system.assertEquals(String.isNotEmpty(jobId), true);

    }    
}