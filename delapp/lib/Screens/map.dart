// ignore_for_file: non_constant_identifier_names, unused_import, deprecated_colon_for_default_value, use_function_type_syntax_for_parameters, unused_local_variable, must_be_immutable
import 'dart:convert';
import 'package:mapmyindia_gl/mapmyindia_gl.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

String SDK_Key = '34a95650d0021c926694c0374c44e582';
String Client_ID =
    '33OkryzDZsKG5juTxZiCiPYjsJYiIFMn9OzRnD6nMppo-Wuefwfl6HsYPeQgFvzOb0LNyAF-7ePBlLC-OLincA==';
String Client_Key =
    'lrFxI-iSEg8aDDBhAHDmTTmfoQ0hDQ2GPZC3dLXphavlTR0tJZUR4w79CDG7fpjdfqxZcdaKs_XTNgU1U5nGSVvnOhA5gM-t';

getToken() async {
  var token = await http.post(
      Uri.parse('https://outpost.mapmyindia.com/api/security/oauth/token'),
      body: {
        'grant_type': 'client_credentials',
        'client_id': Client_ID,
        'client_secret': Client_Key
      });
  var jsonData = jsonDecode(token.body);
  var API_KEY = jsonData['access_token'];
  return API_KEY;
}

MapMyIndiaAuth() async {
  var APIKEY = await getToken();
  MapmyIndiaAccountManager.setMapSDKKey(SDK_Key);
  MapmyIndiaAccountManager.setAtlasClientId(Client_ID);
  MapmyIndiaAccountManager.setAtlasClientSecret(Client_Key);
  MapmyIndiaAccountManager.setRestAPIKey(APIKEY.toString());
}
