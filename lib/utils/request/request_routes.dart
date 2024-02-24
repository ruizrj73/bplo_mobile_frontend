// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:lgu_bplo/utils/env.dart';

String baseUrl = "http://" + (Env.env == "dev" ? Env.devIP : Env.liveIP);
String apiUrl = baseUrl + ":" + (Env.env == "dev" ? Env.devPort : Env.livePort) + "/api/" + Env.apiVersion + "/";

String user = "user";
String register = "user/register";
String sendotp = "user/send-otp";
String verifyotp = "user/verify-otp";
String login = "user/login";
String accountavailability = "user/check/account";
String emailmobileavailability = "user/check/emailmobile";
String usernameavailability = "user/check/username";
String resetPw = "user/resetpassword";

String paymentmode = "setup/paymentmode";
String applicationstatus = "setup/applicationstatus";
String applicationtype = "setup/applicationtype";
String businesstype = "setup/businesstype";

String businessapplication = "business-application";
String inbox = "mobile-inbox";

String appVersion = "version";
String device = "user/device-info";
String changeMobileReq = "user/request/change-mobile";
String changeMobile = "user/change-mobile";
String forgotPw = "user/forgot/password";
String changePass = "user/change-password";
String fToken = "user/setfirebasetoken";
String location = "location-update";
String responder = "responder";
String team = "team";
String emergency = "emergency-request";
String request = "request";
String ticket = "ticket";
String eqrt = "eqrt-detail";
String rhu = "rhu-detail";
String ambulanceReport = "ambulance-report";
String patient = "patient";
String involvePerson = "involve-person";
String involveVehicle = "involve-vehicle";
String facility = "facility";
String responderActivity = "responder-activity";