/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

public with sharing class TwilioServiceAsyncQueue implements Queueable, Database.AllowsCallouts {
    
    private List<TwilioMessage> twilioMessages;
    
     /* Method: TwilioServiceAsyncQueue
     * Params: List<TwilioMessage>
     * Return: 
     * Description: Constructor for class, sets the messages for queueing callout
     */
    public TwilioServiceAsyncQueue(List<TwilioMessage> messages) {
        this.twilioMessages = messages;
    }


     /* Method: execute
     * Params: QueueableContext
     * Return: 
     * Description: Executes job in queueable
     */
    public void execute(QueueableContext context) {

         for (TwilioMessage msg : twilioMessages) {
            TwilioMessageResponse status = TwilioHttp.twilioMessage(msg);
           
        }
    }
}