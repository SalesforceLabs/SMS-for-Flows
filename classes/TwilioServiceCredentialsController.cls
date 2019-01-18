/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
public with sharing class TwilioServiceCredentialsController {
    public String APIKey {get; set;}
    public String APISecret {get; set;}
    public String outboundNumber {get; set;}
    public String accountId {get; set;}

    public TwilioServiceCredentialsController() {
        loadCustomSettings();
    }

    public void loadCustomSettings() {
        TwilioCredentials__c creds = TwilioCredentials__c.getOrgDefaults();
        APIKey = creds.API_Key__c;
        //APISecret = creds.API_Secret__c;
        accountId = creds.Account_Id__c;
        outboundNumber = creds.Outbound_Number__c;
    } 

    public PageReference saveCustomSettings() {
        try {
        TwilioCredentials__c creds = TwilioCredentials__c.getOrgDefaults();
        creds.API_Key__c = APIKey;
        creds.API_Secret__c = APISecret;
        creds.Account_Id__c = accountId;
        creds.Outbound_Number__c = outboundNumber;

        upsert creds;
        }
        catch (exception ex) {
            ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.ERROR, ex.getMessage()));
        }
        ApexPages.addMessage(new ApexPages.Message(ApexPages.SEVERITY.CONFIRM, 'Credentials have been saved.'));
        return null;
    }

    public PageReference cancelCustomSettings() {
         loadCustomSettings();
         return null;
    }
}