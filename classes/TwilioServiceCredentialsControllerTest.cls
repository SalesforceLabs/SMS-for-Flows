/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
@IsTest
public with sharing class TwilioServiceCredentialsControllerTest {
    
    static testmethod void controllerTestMethod() {
        
        
        PageReference pageRef = Page.TwilioServiceCredentials;
        Test.setCurrentPage(pageRef);
        Test.startTest();
        TwilioServiceCredentialsController controller = new TwilioServiceCredentialsController();
        controller.APIKey = 'ABC123';
        controller.APISecret = 'ABC123';
        controller.outboundNumber = '5555555555';
        controller.accountId = 'ABCDEF';

        controller.saveCustomSettings();
        TwilioCredentials__c creds = TwilioCredentials__c.getOrgDefaults();
        system.assertEquals('ABC123', creds.API_Key__c);
        system.assertEquals('ABCDEF', creds.Account_Id__c);
        controller.cancelCustomSettings();
        Test.stopTest();




    }
}