// ignore_for_file: avoid_print, prefer_const_constructors, depend_on_referenced_packages, no_leading_underscores_for_local_identifiers

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:lgu_bplo/controller/console_logs_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

import '../controller/account_controller.dart';
import '../controller/user_controller.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");

  // await LocalDB().localFirebaseNotif().then((value) {
  //   LocalDB().deleteFirebaseNotif();
    
  //   dynamic msgNotif = value == "" ? [] : jsonDecode(value);
  //   msgNotif.add(message.data);
  //   LocalDB().insertFirebaseNotif(jsonEncode(msgNotif));
  // });
}

Future<void> handleMessage(dynamic msgData) async {
  final ConsoleLogsController consoleLogsController = Get.find();
  final UserController userController = Get.find();
  final AccountController accountController = Get.find();

  if (!accountController.getIsLoggedIn()) return;

  consoleLogsController.consoleLogs.value.logs.add("Firebase Notification from foreground : ID ${msgData["inboxMessageId"]}");
  consoleLogsController.consoleLogs.value.logs.add("Firebase Notification from foreground : ID ${msgData["transactionId"]}");

  if (msgData["inboxMessageId"] != "") {
    userController.hasNewMessage.value = true;
    userController.hasNewMessage.refresh();
  }

  if (msgData["transactionId"] != "") {
    userController.hasNewTransaction.value = true;
    userController.hasNewTransaction.refresh();
  }

  await getListTransactions().then((res) {
    List<BusinessApplication> businessApplicationTemp = [];
    if (res != null) {
      res.forEach((p) {
        businessApplicationTemp.add(BusinessApplication.fromJson(p));
      });
    }
    userController.listBusinessApplication.value.application = businessApplicationTemp;
    userController.listBusinessApplication.refresh();
  });
}

class FirebaseMessagingHandler extends GetxController{ 
  final ConsoleLogsController consoleLogsController = Get.find();
  final UserController userController = Get.find();
  final AccountController accountController = Get.find();
  RxString mtoken = "".obs;

  @override
  void onInit() {
    super.onInit();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');
      handleMessage(message.data);
    });
  }

  void initBackgroundMessageHandler() {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage initialMessage = await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      handleMessage(initialMessage.data);
    }

    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        print("User granted permission");
        break;
      case AuthorizationStatus.provisional:
        print("User granted provisional permission");
        break;
      case AuthorizationStatus.notDetermined:
        print("Authorization not determined");
        break;
      default:
        print("User declined or has not accepted permission");
        break;
    }
  }

  void getToken() async {
    await FirebaseMessaging.instance.getToken().then((token) {
      mtoken.value = token;
      print("Firebase Token : $mtoken");
    });
  }

  Future<String> getReceiverToken(String userId) async {
    String _token = "";
    await FirebaseFirestore.instance.collection("UserTokens").doc(userId).get().then((value) {
      _token = value['token'];
    });
    print(_token);
    return _token;
  }

  void saveToken() async {
    await FirebaseFirestore.instance.collection("UserTokens").doc(userController.getId().toString()).set({
      "token" : mtoken.value,
    });

    String prevToken = accountController.getFirebaseToken();
    try {
      saveTokenToDB(mtoken.value, prevToken).then((value) {
        accountController.saveFirebaseToken(mtoken.value);
        print("Save Token to DB: $value");
        consoleLogsController.consoleLogs.value.logs.add("Firebase Token : ${mtoken.value}");
      });
    } catch(ex) {
      consoleLogsController.consoleLogs.value.logs.add("Error saving Firebase token");
    }
    
  }

  Future<void> sendPushMessage(String token, String title, String body) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=AAAAl-vmPtI:APA91bG8PHCQtiI7QoP32q1Y_7OdCCVsp8Pn2BM_j8UGwupJfqLQLXU6cusviFH31bNlPdTTb2Kq5b_k68DV_o8Uuvu_ajAVZdIInR5iy3MG_LIFqALQk-KFPkSswh6qBYVAsdWEKOzm'
        },
        body: jsonEncode(
          <String, dynamic> {
            'priority': 'high',
            'data': <String, dynamic> {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'status': 'done',
              'body': body,
              'title': title,
            },
            "notification": <String, dynamic> {
              "title": title,
              "body": body,
              "android_channel_id": "dbfood"
            },
            "to": token
          }
        )
      ).then((value) {
        print(value);
      });
    } catch(ex) {
      print(ex);
    }
  }
  
}