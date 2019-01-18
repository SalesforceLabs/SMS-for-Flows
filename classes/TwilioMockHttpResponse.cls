/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */

@isTest
global with sharing class TwilioMockHttpResponse implements HttpCalloutMock{
    global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        //System.assertEquals('https://api.twilio.com/', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        String responseString = '{"sid":"SM11111110000000xxxxxx", "date_created":"Sat, 11 Aug 2018 15:06:32 +0000",' + 
        '"date_updated":"Sat, 11 Aug 2018 15:06:32 +0000","date_sent":null,"account_sid":"AC11111110000000xxxxxx",' + 
        '"to":"+15555555545", "from":"+15555455545", "messaging_service_sid":null,"body":"Test Text Message Body","status":"queued",' + 
        '"num_segments":"1","num_media":"0","direction":"outbound-api","api_version":"2010-04-01","price":null,' + 
        '"price_unit":"USD", "error_code":null,"error_message":null}';
        // Create a fake respon
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody(responseString);
        res.setStatusCode(201);
        return res;
    }

}