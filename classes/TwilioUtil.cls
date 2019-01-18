/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

public with sharing class TwilioUtil {
    public static String boundary;

     /* Method: getTwilioEndpoint
     * Params: String cmdt
     * Return: TwilioLabs__mdt
     * Description: Gets the API Version and Endpoint
     */
    public static TwilioLabs__mdt getTwilioEndpoint(String cmdt) {
        List<TwilioLabs__mdt> theLIst = new List<TwilioLabs__mdt>();
        TwilioLabs__mdt twilioEndpoint = new TwilioLabs__mdt();
        theList = [select Endpoint__c, API_Version__c from TwilioLabs__mdt where DeveloperName = :cmdt limit 1];
        if (!theList.isEmpty())
        {
            twilioEndpoint = theList[0];
        }
        return twilioEndpoint;
    }

     /* Method: getTwilioCredentials
     * Params: 
     * Return: TwilioCredentials__c
     * Description: returns the custom setting that stores api key, api secret and from phone number
     *              Since it's hierarchy custom setting, can set user and profile level allowing different phone numbers for different users
     */
    public static TwilioCredentials__c getTwilioCredentials() {
        TwilioCredentials__c creds = TwilioCredentials__c.getInstance();
        return creds;
    }

     /* Method: buildMessageText
     * Params: TwilioMessage msg, TwilioCredentials__c twilioCredentials
     * Return: String
     * Description: Builds the message body including the boundary to be able to submit multi-form/data in apex 
     */
    public static String buildMessageText(TwilioMessage msg, TwilioCredentials__c twilioCredentials) {

       
        String messageText = '--' + getBoundary() + '\r\n';
        messageText += 'Content-Disposition: form-data; name="From"\r\n\n';
        messageText += twilioCredentials.Outbound_Number__c + '\r\n';
        messageText += '--' + boundary + '\r\n';
        messageText += 'Content-Disposition: form-data; name="To"\r\n\n';
        messageText += msg.toNumber + '\r\n';
        messageText += '--' + boundary + '\r\n';
        messageText += 'Content-Disposition: form-data; name="Body"\r\n\n';
        messageText += msg.messageBody + '\r\n';
        messageText += '--' + getBoundary() + '--';

        return messageText;
    }

     /* Method: getBoundary
     * Params: 
     * Return: String
     * Description: returns Boundary
     */
    public static String getBoundary() {
        if (String.isEmpty(boundary)) {
            buildBoundary();
        }
        return boundary;
    }

     /* Method: buildBoundary
     * Params: 
     * Return: 
     * Description: Builds the boundary
     */
    public static void buildBoundary() {
        boundary = '----------------------------' + String.valueOf(DateTime.now().getTime());
    }

}