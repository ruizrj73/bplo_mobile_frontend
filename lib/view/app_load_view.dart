// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/application_status_model.dart';
import 'package:lgu_bplo/model/application_type_model.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/model/business_type_model.dart';
import 'package:lgu_bplo/model/message_model.dart';
import 'package:lgu_bplo/model/payment_mode_model.dart';
import 'package:lgu_bplo/model/setup_line_business_model.dart';
import 'package:lgu_bplo/utils/firebase_messaging_handler.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
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
      initializeUser();
      initSetup();
    });
  }

  initializeUser() {
    bool isLoggedIn = accountController.getIsLoggedIn();

    if (!isLoggedIn) {
      Get.offAllNamed(PageRoutes.Login);
    } else {
      String userId = accountController.getUserId();
      networkConnectionController.checkConnectionStatus().then((connResult) async {
        if (connResult) {
          getUserInfo(userId.toString()).then((value) {
            if (value == "Fail" || userController.getId() == "") {
              userController.clearState();
              accountController.clearStorage();
              showSnackbar("Welcome", "Guest.");
              Get.offAllNamed(PageRoutes.Login);
            } else {
              showSnackbar("Welcome", userController.getFullName());
              firebaseMessagingHandler.saveToken();
              initTransaction();
              initMessages();
              Get.toNamed(PageRoutes.Home);
            }
          });
        } else {
          return;
        }
      });
    }
  }

  initSetup() async {
    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        await getListPaymentMode().then((res) {
          if (res != null) {
            res.forEach((p) {
              mainController.listPaymentMode.add(PaymentModeModel.fromJson(p));
            });
          }
        });
        await getListApplicationStatus().then((res) {
          if (res != null) {
            res.forEach((a) {
              mainController.listApplicationStatus.add(ApplicationStatusModel.fromJson(a));
            });
          }
        });
        await getListApplicationType().then((res) {
          if (res != null) {
            res.forEach((a) {
              mainController.listApplicationType.add(ApplicationTypeModel.fromJson(a));
            });
          }
        });
        await getListBusinessType().then((res) {
          if (res != null) {
            res.forEach((b) {
              mainController.listBusinessType.add(BusinessTypeModel.fromJson(b));
            });
          }
        });
        await getListLineBusiness().then((res) {
          if (res != null) {
            res.forEach((lb) {
              mainController.listLineOfBusiness.add(SetupLineBusiness.fromJson(lb));
            });
          }
        });
        await getListMeasurePax().then((res) {
          if (res != null) {
            res.forEach((lb) {
              mainController.listLineOfBusinessMeasurePax.add(SetupLineBusiness.fromJson(lb));
            });
          }
        });
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }

  initTransaction() async {
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

  initMessages() async {
    await getInbox().then((res) {
      List<MessageModel> inboxTempData = [];
      if (res != null) {
        res.forEach((p) {
          inboxTempData.add(MessageModel.fromJson(p));
        });
      }
      userController.listMessages.value.messages = inboxTempData;
      userController.listMessages.refresh();

      userController.hasNewMessage.value = (userController.listMessages.value.messages ?? []).where((m) => m.messageState == "Unread").isNotEmpty;
      userController.hasNewMessage.refresh();
    });
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
                fit: BoxFit.none,
                image: AssetImage("assets/images/splash.png")
              )
            )
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height / 4,
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
