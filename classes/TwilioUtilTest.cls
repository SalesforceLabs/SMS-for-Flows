/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
@isTest
public with sharing class TwilioUtilTest {
    static testMethod void mdtTest() {
        //createTestData();
        TwilioLabs__mdt twilioEndpoint = TwilioUtil.getTwilioEndpoint('Twilio');
        system.assertEquals(twilioEndpoint.Endpoint__c, 'https://api.twilio.com');
        system.assertEquals(twilioEndpoint.API_Version__c, '2010-04-01');
    }

    static testMethod void credentialsMethod() {
        TwilioCredentials__c creds = TwilioUtil.getTwilioCredentials();
        system.assertEquals('ASFDAFAFAFAFDA', creds.API_Key__c);
    }

    static testMethod void buildMessageTests() {
        TwilioCredentials__c creds = TwilioUtil.getTwilioCredentials();
        Test.startTest();
        TwilioMessage msg = new TwilioMessage();
        msg.toNumber = '5555555555';
        msg.messageBody = 'Test Message';
        String testMessage = TwilioUtil.buildMessageText(msg, creds);
        system.assertEquals(String.isNotEmpty(testMessage),true);
        TwilioUtil.buildBoundary();
        String boundary = TwilioUtil.getBoundary();
        system.assertEquals(String.isNotEmpty(boundary),true);
        Test.stopTest();

    }

    @TestSetup static void createTestData() {
        TwilioCredentials__c creds = new TwilioCredentials__c();
        creds.API_Key__c = 'ASFDAFAFAFAFDA';
        creds.API_Secret__c = 'AFSDAFDASFAFDAFDA';
        insert creds;
      
    }

}