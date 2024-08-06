// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/utils/firebase_messaging_handler.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/pre_backend_call.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../controller/account_controller.dart';
import '../utils/snackbar_dialog.dart';

class AppLoadView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AppLoadView();
  @override
  AppLoadViewState createState() => AppLoadViewState();
}

class AppLoadViewState extends State<AppLoadView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  final FirebaseMessagingHandler firebaseMessagingHandler = Get.find();
  final AccountController accountController = Get.find();
  final MainController mainController = Get.find();

  @override
  void initState() {
    loadApp();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  loadApp() {
    Future.delayed(Duration(seconds: 5), () {
      initSetup();
      initializeUser();
    });
  }

  initializeUser() {
    bool isLoggedIn = accountController.getIsLoggedIn();

    if (!isLoggedIn) {
      Get.offAllNamed(PageRoutes.Login);
    } else {
      String userId = accountController.getUserId();
      PreBackendCall().pregetUserInfo(userId.toString()).then((value) {
        if (value) {
          showSnackbar("Welcome", userController.getFullName());
          initTransaction();
          initMessages();
          Get.toNamed(PageRoutes.Home);
        } else {
          userController.clearState();
          accountController.clearStorage();
          showSnackbar("Welcome", "Guest.");
          Get.offAllNamed(PageRoutes.Login);
        }
      });
    }
  }

  initSetup() async {
    await PreBackendCall().pregetAppStatus().then((res) async {
      await PreBackendCall().pregetListPaymentMode().then((res) {
        mainController.listPaymentMode = res;
      });
      await PreBackendCall().pregetListApplicationStatus().then((res) {
        mainController.listApplicationStatus = res;
      });
      await PreBackendCall().pregetListApplicationType().then((res) {
        mainController.listApplicationType = res;
      });
      await PreBackendCall().pregetListBusinessType().then((res) {
        mainController.listBusinessType = res;
      });
      await PreBackendCall().pregetListLineBusiness().then((res) {
        mainController.listLineOfBusiness = res;
      });
      await PreBackendCall().pregetListMeasurePax().then((res) {
        mainController.listLineOfBusinessMeasurePax = res;
      });
    });
  }

  initTransaction() async {
    // await getListTransactions().then((res) {
    //   List<BusinessApplication> businessApplicationTemp = [];
    //   if (res != null) {
    //     res.forEach((p) {
    //       businessApplicationTemp.add(BusinessApplication.fromJson(p));
    //     });
    //   }
    //   userController.listBusinessApplication.value.application = businessApplicationTemp;
    //   userController.listBusinessApplication.refresh();
    // });
  }

  initMessages() async {
    // await getInbox().then((res) {
    //   List<MessageModel> inboxTempData = [];
    //   if (res != null) {
    //     res.forEach((p) {
    //       inboxTempData.add(MessageModel.fromJson(p));
    //     });
    //   }
    //   userController.listMessages.value.messages = inboxTempData;
    //   userController.listMessages.refresh();

    //   userController.hasNewMessage.value = (userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").isNotEmpty;
    //   userController.hasNewMessage.refresh();
    // });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: buildPage(),
      onWillPop: () {
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: ThemeColor.primaryBg,
      appBar: null,
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                fit: BoxFit.contain,
                image: AssetImage("assets/images/splash.png")
              )
            )
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 5,
            child: Center(
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 80,
                animation: true,
                lineHeight: 3.0,
                animationDuration: 5000,
                percent: 1,
                progressColor: ThemeColor.primary,
                curve: Curves.easeIn,
              ),
            ),
          ),
        ],
      )
    );
  }
}
