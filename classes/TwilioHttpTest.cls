/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
@isTest
public with sharing class TwilioHttpTest {
    static testMethod void successfulTest() {
        Test.startTest();
        TwilioMessage msg = new TwilioMessage();
        msg.toNumber = '5555555555';
        msg.messageBody = 'Test Message';
        Test.setMock(HttpCalloutMock.class, new TwilioMockHttpResponse());
        
        TwilioMessageResponse response = TwilioHttp.twilioMessage(msg);
        system.assertEquals('queued', response.status);
        Test.stopTest();
    }

    static testMethod void failTest() {
        Test.startTest();
        TwilioMessage msg = new TwilioMessage();
        msg.toNumber = '5555555555';
        msg.messageBody = 'Test Message';
        Test.setMock(HttpCalloutMock.class, new TwilioMockBadHttpResponse());
        
        TwilioMessageResponse response = TwilioHttp.twilioMessage(msg);
        system.assertEquals('failed', response.status);
        Test.stopTest();
    }
    @TestSetup static void createTestData() {
        TwilioCredentials__c creds = new TwilioCredentials__c();
        creds.API_Key__c = 'ASFDAFAFAFAFDA';
        creds.API_Secret__c = 'AFSDAFDASFAFDAFDA';
        insert creds;
    }
}