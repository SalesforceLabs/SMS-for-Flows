/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

public with sharing class TwilioHttp {

    /* Method: twilioRequest
     * Params: String Url, Strin methodType, String authorizationHeader, String messageText
     * Return: httpResponse
     * Description: Sends HttpRequest
     */

    public static HttpResponse twilioRequest(String url, String methodType, String authorizationHeader, String messageText) {
        //Define http
        Http h = new Http();
        //Define httprequest
        HttpRequest req = new HttpRequest();
        req.setEndpoint(url);
        req.setMethod(methodType);
        req.setHeader('Authorization', authorizationHeader);
        req.setHeader('Content-Type', 'multipart/form-data; boundary=' + TwilioUtil.getBoundary());
        req.setHeader('Content-Length', String.valueof(messageText.length()));
        req.setBody(messageText);
        //Send http request
        HttpResponse res = h.send(req);
        //Return http response
        return res;
    }

    /* Method: twilioMessage
     * Params: TwilioMessage
     * Return: TwilioMessageResponse
     * Description: Builds the message body, 
     */
    public static TwilioMessageResponse twilioMessage(TwilioMessage msg) {
        
        String url;
        String methodType = 'POST';
        //Define response
        TwilioMessageResponse msgResponse = new TwilioMessageResponse();
        //Get the boundary for 
        String boundary = TwilioUtil.getBoundary();
        //Get Twilio Endpoint information
        TwilioLabs__mdt twilioEndpoint = TwilioUtil.getTwilioEndpoint('Twilio');
        //Get Twilio Credentials and PhoneNumber from custom setting
        TwilioCredentials__c twilioCredentials = TwilioUtil.getTwilioCredentials();
        //Build url of API endpoint
        url = twilioEndpoint.Endpoint__c + '/' + twilioEndpoint.API_Version__c + '/Accounts/' + twilioCredentials.Account_Id__c + '/Messages.json';
        //Build the API key and secret for header
        Blob headerValue = Blob.valueOf(twilioCredentials.API_Key__c + ':' + twilioCredentials.API_Secret__c);
        //Build authorization header 
        String authorizationHeader = 'BASIC ' + EncodingUtil.base64Encode(headerValue);
        //Build Text Message
        String messageText = TwilioUtil.buildMessageText(msg, twilioCredentials);
        
        //Make API Request
        HttpResponse response = twilioRequest(url, methodType, authorizationHeader, messageText);
        //Process Response
        if (response.getStatusCode() == 201) {
            Map<String, Object> m = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            msgResponse.sid = String.valueOf(m.get('sid'));
            msgResponse.errorCode = String.valueOf(m.get('error_code'));
            msgResponse.errorMessage = String.valueOf(m.get('error_message'));
            msgResponse.status = String.valueOf(m.get('status'));
        }
        else {
            msgResponse.errorCode = String.valueOf(response.getStatusCode());
            msgResponse.errorMessage = response.getStatus();
            msgResponse.status = 'failed';
        }

        return msgResponse;
    }
}