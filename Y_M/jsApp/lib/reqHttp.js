'use strict';
import React, { Component } from 'react';
import {
    ToastAndroid,
    Alert,
    NativeModules
} from 'react-native';

var requestParams = NativeModules.RequestParamsController;

/**
 * [setServiceParams description]
 * @param {[type]} settings [interfaceName, readableMap, flagSign, actionCallback]
 */
var setServiceParams = function(settings) {
	var interfaceName = settings['interfaceName'];
	var flagSign = settings['flagSign'];
    requestParams.setCPSServiceParams(interfaceName, settings['readableMap'], flagSign ,settings.actionCallback);
};

/**
 * [callHttpService description]
 * @param  {[type]} settings [Url, Params, Success, Error, ShowLoading, Method]
 * @return {[type]}          [description]
 */
var callHttpService = function(settings) {

    //  request url
    var Url = settings['Url'];
    console.log("callHttpService Url:" + Url);
    if (Url == "" || Url == null) {
        console.log(" The settings 'Url' existence error ");
        return { "code": "001", "content": "The settings 'Url' existence error !" }
    }

    //  request method type
    var MethodStr = settings['Method'];
    if (MethodStr == "" || MethodStr == null) {
        MethodStr = "POST";
    }

    // request parameter
    var parame = settings['Params'];
    if (parame == "" || parame == null) {
        console.log(" The settings 'Params' existence error ");
        return { "code": "002", "content": "The settings 'Params' existence error !" }
    }

    // response success callback
    var SuccessCallBack = function(params) {
        var json = JSON.parse(params);
        console.log(params);

        settings.Success(json);
 
    };

    // response error callback
    var EerrorCallBack = function(params) {
        if (settings.Error !== null && typeof settings.Error == 'function') {
            settings.Error(params);
        }
        console.warn(params);
    };

    // start fetch request
    var FetchObj = fetch(Url, {
        method: MethodStr,
        headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json',
        },
        body: parame
    }).then((response) => response.text()).then((responseText) => {
        SuccessCallBack(responseText);
    }).catch((error) => {
        EerrorCallBack(error);
    })

}


var reqHttp = {
    setServiceParams: setServiceParams,
    callHttpService: callHttpService
};


module.exports = reqHttp;
