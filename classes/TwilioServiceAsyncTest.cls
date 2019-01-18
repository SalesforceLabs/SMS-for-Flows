/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

@isTest
public with sharing class TwilioServiceAsyncTest {
    
    static testmethod void testMethod1() {
        Test.startTest();      
        Test.setMock(HttpCalloutMock.class, new TwilioMockHttpResponse());
        TwilioMessage msg = new TwilioMessage();
        msg.toNumber = '5555555555';
        msg.messageBody = 'The Cat in the Hat';
        List<TwilioMessage> msgs = new List<TwilioMessage>();
        msgs.add(msg);
        List<Id> results = TwilioServiceAsync.sendTwilioMessage(msgs);
        Test.stopTest();
        system.assertEquals(results.isEmpty(), false);

    }
}