// ignore_for_file: prefer_typing_uninitialized_variables, no_leading_underscores_for_local_identifiers, prefer_interpolation_to_compose_strings

import 'dart:convert';

import 'package:get/get.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/model/user_info.dart';
import 'package:lgu_bplo/utils/request/http_request.dart';
import 'package:lgu_bplo/utils/request/request_method.dart';
import 'package:lgu_bplo/utils/request/request_routes.dart';

RequestMethod requestMethod = RequestMethod();
UserController userController = Get.find();

Future<String> registerUser(UserInfo userInfo) async {
  var response;
  String url = apiUrl + register;
  String _body;

  _body = jsonEncode(userInfo.toJson());

  await sendRequest(requestMethod.post, url, body: _body, isTokenRequired: false).then((value) {
    response = value;
  });

  return response["resultEnum"];
}

Future<dynamic> requestOtp(String mobileNumber) async {
  var response;
  String url = apiUrl + sendotp;
  url = url + "/" + mobileNumber;

  await sendRequest(requestMethod.post, url, isTokenRequired: false).then((value) {
    response = value;
  });

  return response["resultObject"];
}

Future<dynamic> verifyCode(String mobileNumber, String code) async {
  var response;
  String url = apiUrl + verifyotp;
  url = url + "/" + mobileNumber;
  url = url + "/" + code;

  await sendRequest(requestMethod.post, url, isTokenRequired: false).then((value) {
    response = value;
  });

  return response["resultObject"];
}

Future<bool> isLoginValid(String username, String password) async {
  var response;
  String url = apiUrl + login;
  String _body = "";

  _body = jsonEncode(<String, Object>{
    "username": username,
    "password": password,
  });

  await sendRequest(requestMethod.post, url, body: _body, isTokenRequired: false).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success" && response["resultObject"]["isMobileUserValid"]) {
    UserInfo resUserInfo = UserInfo.fromJson(response["resultObject"]);
    userController.setUserInfo(resUserInfo);
    userController.setId(resUserInfo.id);
    userController.setUsername(resUserInfo.username);
    userController.setEmpId(resUserInfo.empId);
    userController.setFirstName(resUserInfo.firstname);
    userController.setMiddleName(resUserInfo.middlename);
    userController.setLastName(resUserInfo.lastname);
    userController.setSuffix(resUserInfo.suffix);
    userController.setEmail(resUserInfo.email);
    userController.setContactNumber(resUserInfo.contactnumber);
    userController.setUserType(resUserInfo.userType);
    userController.setTypeId(resUserInfo.typeId);
    userController.setTypeName(resUserInfo.typeName);
    userController.setAllowOffline(resUserInfo.allowOffline);
    userController.setAllowAttach(resUserInfo.allowAttach);
  }

  return response["resultObject"]["isMobileUserValid"];
}

Future<String> resetPassword(String userId, String password) async {
  var response;
  String url = apiUrl + resetPw;
  String _body = "";

  _body = jsonEncode(<String, Object>{
    "userId": userId,
    "password": password,
  });

  await sendRequest(requestMethod.post, url, body: _body, isTokenRequired: false).then((value) {
    response = value;
  });

  return response["resultEnum"];
}

Future<Map<String, dynamic>> isAccountAvailable(String username, String email, String mobileNo) async {
  var response;
  String url = apiUrl + accountavailability;
  url = url + "/" + username;
  url = url + "/" + email;
  url = url + "/" + mobileNo;

  Map<String, dynamic> retVal = {
    "resultSuccess": false,
    "usernameAvailable": false,
    "emailAvailable": false,
    "mobileNoAvailable": false,
    "userId": false,
    "mobileNo": false,
  };

  await sendRequest(requestMethod.post, url, isTokenRequired: false).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    retVal = {
      "resultSuccess": true,
      "usernameAvailable": response["resultObject"]["usernameAvailable"],
      "emailAvailable": response["resultObject"]["emailAvailable"],
      "mobileNoAvailable": response["resultObject"]["mobileNoAvailable"],
      "userId": response["resultObject"]["userId"],
      "mobileNo": response["resultObject"]["mobileNo"],
    };
  } else {
    retVal = {
      "resultSuccess": false,
      "usernameAvailable": false,
      "emailAvailable": false,
      "mobileNoAvailable": false,
      "userId": "",
      "mobileNo": "",
    };
  }

  return retVal;
}

Future<Map<String, bool>> isEmailMobileNoAvailable(String email, String mobileNo) async {
  var response;
  String url = apiUrl + emailmobileavailability;
  url = url + "/" + email;
  url = url + "/" + mobileNo;

  Map<String, bool> retVal = {
    "resultSuccess": false,
    "emailAvailable": false,
    "mobileNoAvailable": false,
  };

  await sendRequest(requestMethod.post, url, isTokenRequired: false).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    retVal = {
      "resultSuccess": true,
      "emailAvailable": response["resultObject"]["emailAvailable"],
      "mobileNoAvailable": response["resultObject"]["mobileNoAvailable"],
    };
  } else {
    retVal = {
      "resultSuccess": false,
      "emailAvailable": false,
      "mobileNoAvailable": false,
    };
  }

  return retVal;
}

Future<Map<String, bool>> isUsernameAvailable(String username) async {
  var response;
  String url = apiUrl + usernameavailability;
  url = url + "/" + username;

  Map<String, bool> retVal = {
    "resultSuccess": false,
    "usernameAvailable": false,
  };

  await sendRequest(requestMethod.post, url, isTokenRequired: false).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    retVal = {
      "resultSuccess": true,
      "usernameAvailable": response["resultObject"]["usernameAvailable"],
    };
  } else {
    retVal = {
      "resultSuccess": false,
      "usernameAvailable": false,
    };
  }

  return retVal;
}

Future<String> getUserInfo(String userId) async {
  var response;
  String url = apiUrl + user;
  url = url + "/" + userId;

  await sendRequest(requestMethod.get, url, isTokenRequired: false).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    UserInfo resUserInfo = UserInfo.fromJson(response["resultObject"]);
    userController.setUserInfo(resUserInfo);
    userController.setId(resUserInfo.id);
    userController.setUsername(resUserInfo.username);
    userController.setEmpId(resUserInfo.empId);
    userController.setFirstName(resUserInfo.firstname);
    userController.setMiddleName(resUserInfo.middlename);
    userController.setLastName(resUserInfo.lastname);
    userController.setSuffix(resUserInfo.suffix);
    userController.setEmail(resUserInfo.email);
    userController.setContactNumber(resUserInfo.contactnumber);
    userController.setUserType(resUserInfo.userType);
    userController.setTypeId(resUserInfo.typeId);
    userController.setTypeName(resUserInfo.typeName);
    userController.setAllowOffline(resUserInfo.allowOffline);
    userController.setAllowAttach(resUserInfo.allowAttach);
  }

  return response["resultEnum"];
}

Future<String> saveTokenToDB(String _token, String _oldToken) async {
  var response;
  String url = apiUrl + fToken;
  String _body = "";

  _body = jsonEncode(<String, Object>{
    "userId": userController.getId().toString(),
    "firebaseToken": _token,
  });

  await sendRequest(requestMethod.post, url, body: _body, isTokenRequired: true).then((value) {
    response = value;
  });

  return response["resultEnum"];
}

Future<dynamic> getListPaymentMode() async {
  var response;
  String url = apiUrl + paymentmode;

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getListApplicationStatus() async {
  var response;
  String url = apiUrl + applicationstatus;

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getListApplicationType() async {
  var response;
  String url = apiUrl + applicationtype;

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getListBusinessType() async {
  var response;
  String url = apiUrl + businesstype;

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getListLineBusiness() async {
  var response;
  String url = apiUrl + linebusiness;

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getListMeasurePax() async {
  var response;
  String url = apiUrl + measurepax;

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getListTransactions() async {
  var response;
  String url = apiUrl + businessapplication;
  url = url + "/by-user/" + accountController.getUserId();

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> saveBusinessApplication(BusinessApplication _businessApplication) async {
  var response;
  String url = apiUrl + businessapplication;

  String _body = "";

  _body = jsonEncode(_businessApplication.toJson());

  await sendRequest(requestMethod.post, url, body: _body, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> updateBusinessApplication(BusinessApplication _businessApplication) async {
  var response;
  String url = apiUrl + businessapplication;
  url = url + "/" + _businessApplication.id;

  String _body = "";

  _body = jsonEncode(_businessApplication.toJson());

  await sendRequest(requestMethod.patch, url, body: _body, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> getInbox() async {
  var response;
  String url = apiUrl + inbox;
  url = url + "/by-user/" + userController.getId();

  await sendRequest(requestMethod.get, url, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> deleteMessage(String msgId) async {
  var response;
  String url = apiUrl + inbox;
  url = url + "/" + msgId;

  await sendRequest(requestMethod.delete, url, isTokenRequired: true).then((value) {
    response = value;
  });

  return response["resultEnum"];
}

Future<dynamic> markAsReadMessage(String msgId) async {
  var response;
  String url = apiUrl + inbox;
  url = url + "/" + msgId;

  String _body = "";

  _body = jsonEncode(<String, Object>{
    "id": msgId,
    "messageState": "Read",
  });

  await sendRequest(requestMethod.patch, url, body: _body, isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}

Future<dynamic> updateBusinessLocation(String id, String longitude, String latitude, String locStr) async {
  var response;
  String url = apiUrl + businessapplication;
  url = url + "/businessLocation/update";
  url = url + "?id=" + id;
  url = url + "&longitude=" + longitude;
  url = url + "&latitude=" + latitude;
  url = url + "&actual_address=" + locStr;

  await sendRequest(requestMethod.patch, url, body: "", isTokenRequired: true).then((value) {
    response = value;
  });

  if (response["resultEnum"] == "Success") {
    return response["resultObject"];
  }

  return response["resultEnum"];
}
