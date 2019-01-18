/*
 * Copyright (c) 2018, salesforce.com, inc.
 * All rights reserved.
 * SPDX-License-Identifier: BSD-3-Clause
 * For full license text, see the LICENSE file in the repo root or https://opensource.org/licenses/BSD-3-Clause
 */
 
global with sharing class TwilioMessageResponse {
    @InvocableVariable
    global String sid;
    @InvocableVariable
    global String errorCode;
    @InvocableVariable
    global String errorMessage;
    @InvocableVariable
    global String status;
}