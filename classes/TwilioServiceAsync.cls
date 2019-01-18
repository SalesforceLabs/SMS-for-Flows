/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

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