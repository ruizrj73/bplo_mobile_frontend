// ignore_for_file: prefer_typing_uninitialized_variables, prefer_interpolation_to_compose_strings, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lgu_bplo/controller/account_controller.dart';
import 'package:lgu_bplo/controller/console_logs_controller.dart';
import 'package:lgu_bplo/utils/env.dart';

AccountController accountController = Get.find();
ConsoleLogsController consoleLogsController = Get.find();

Future<Map<String, dynamic>> sendRequest(String _method, String _url, {String body = "", bool isTokenRequired = true}) async {
  Map<String, dynamic> retVal;
  Map<String, String> _header = {};
  // bool _isTokenValid = false;
  var jsonResponse;
  var response;

  if (isTokenRequired) {
    _header = <String, String>{
      'Content-Type': 'application/json',
      "Authorization": "Bearer " + accountController.getAccessToken(),
    };

    // await isTokenValid().then((value) {
    //   _isTokenValid = value;
    // });

    // if (!_isTokenValid) {
    //   await refreshToken().then((value) {
    //     _accessToken = "Bearer " + value;
    //   });
    // }
  } else {
    _header = <String, String>{
      'Content-Type': 'application/json',
      'api-key': Env.apiKey,
    };
  }

  switch (_method) {
    case "Post":
      await postRequest(_url,
          headers: _header,
          body: body).then((value) {
            response = value;
          });
      break;
    case "Put":
      await putRequest(_url,
          headers: _header,
          body: body).then((value) {
            response = value;
          });
      break;
    case "Patch":
      await patchRequest(_url,
          headers: _header,
          body: body).then((value) {
            response = value;
          });
      break;
    case "Delete":
      await deleteRequest(_url,
          headers: _header).then((value) {
            response = value;
          });
      break;
    case "Get":
      await getRequest(_url,
          headers: _header).then((value) {
            response = value;
          });
      break;
  }

  if (response == null) {
    retVal = {"resultEnum": "Fail",
            "resultMessage": "Request failed."};
  } else if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 400) {
    jsonResponse = json.decode(response.body);
    retVal = {"resultEnum": "Success",
            "resultMessage": jsonResponse["message"],
            "resultObject": jsonResponse["data"]};
  } else if (response.statusCode == 404) {
    retVal = {"resultEnum": "Fail",
            "resultMessage": "Data Not Found"};
  } else {
    retVal = {"resultEnum": "Fail",
            "resultMessage": "Request failed."};
  }

  return retVal;
}

Future<http.Response> postRequest(String url, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
  var response;

  await http.post(
    Uri.parse(url),
    headers: headers,
    body: body,
    encoding: encoding
  ).then((value) {
    response = value;
  }).catchError((err) {
    consoleLogsController.consoleLogs.value.logs.add(err.message);
    consoleLogsController.consoleLogs.value.logs.add("-- PST - " + url);
  });

  return response;
}

Future<http.Response> getRequest(String url, {Map<String, String> headers}) async {
  var response;

  await http.get(
    Uri.parse(url),
    headers: headers
  ).then((value) {
    response = value;
  }).catchError((err) {
    consoleLogsController.consoleLogs.value.logs.add(err.message);
    consoleLogsController.consoleLogs.value.logs.add("-- GT - " + err.uri.path);
  });

  return response;
}

Future<http.Response> patchRequest(String url, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
  var response;

  await http.patch(
    Uri.parse(url),
    headers: headers,
    body: body,
    encoding: encoding
  ).then((value) {
    response = value;
  }).catchError((err) {
    consoleLogsController.consoleLogs.value.logs.add(err.message);
    consoleLogsController.consoleLogs.value.logs.add("-- PCH - " + err.uri.path);
  });

  return response;
}

Future<http.Response> deleteRequest(String url, {Map<String, String> headers}) async {
  var response;

  await http.delete(
    Uri.parse(url),
    headers: headers,
  ).then((value) {
    response = value;
  }).catchError((err) {
    consoleLogsController.consoleLogs.value.logs.add(err.message);
    consoleLogsController.consoleLogs.value.logs.add("-- DLT - " + err.uri.path);
  });

  return response;
}

Future<http.Response> putRequest(String url, {Map<String, String> headers, dynamic body, Encoding encoding}) async {
  var response;

  await http.put(
    Uri.parse(url),
    headers: headers,
    body: body,
    encoding: encoding
  ).then((value) {
    response = value;
  }).catchError((err) {
    consoleLogsController.consoleLogs.value.logs.add(err.message);
    consoleLogsController.consoleLogs.value.logs.add("-- PT - " + err.uri.path);
  });

  return response;
}