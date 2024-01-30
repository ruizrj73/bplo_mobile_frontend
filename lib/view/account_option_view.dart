// import 'package:countdown_flutter/countdown_flutter.dart';
// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/account_controller.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/console_logs_dialog.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:restart_app/restart_app.dart';

import '../utils/app_version_handler.dart';

class AccountOptionView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const AccountOptionView();

  @override
  AccountOptionViewState createState() => AccountOptionViewState();
}

class AccountOptionViewState extends State<AccountOptionView> {
  final AccountController accountController = Get.find();
  final MainController mainController = Get.find();
  final UserController userController = Get.find();
  final AppVersionHandler appVersionHandler = Get.find();
  bool isLoggingOut = false;

  int clickCounter = 0;
  bool isLogsShow = false;

  @override
  void initState() {
    mainController.bottomNavIndex.value = 3;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: buildPage(),
      onWillPop: () {
        mainController.bottomNavIndex.value = 0;
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: ThemeColor.primaryBg,
      bottomSheet: Container(
        color: Env.copyrightBgColor,
        height: 100,
        child: Center(
          child: Text(
            Env.copyrightText,
            style: TextStyle(
              fontFamily: "Poppins",
              color: Env.copyrightColor,
              fontSize: Env.copyrightSize,
            ),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: ThemeColor.primaryBg,
        elevation: 0,
        leading: Container(),
        actions: [
          !isLoggingOut ?
          InkWell(
            onTap: () {
              setState(() {
                isLoggingOut = true;
              });
              Future.delayed(Duration(seconds: 2), () {
                userController.clearState();
                accountController.clearStorage().then((value) {
                  Restart.restartApp();
                });
              });
            },
            child: Container(
              padding: EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Icon(
                    Feather.log_out, 
                    size: 16,
                    color: ThemeColor.warning,
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Logout",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: ThemeColor.warning,
                      fontSize: 14,
                    ),
                  )
                ],
              ),
            )
          ) : Container()
        ],
      ),
      bottomNavigationBar: isLoggingOut ? SizedBox(height: 0) : bottomNavigationView(context),
      body: isLoggingOut ? logoutView() : bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Center(
              child: Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 8,
                      color: Colors.black54,
                      offset: Offset(1,1)
                    ),
                  ],
                  border: Border.all(
                    color: ThemeColor.primary,
                    width: 2
                  ),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage("assets/images/no-image-big.png")
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: FittedBox(
                alignment: Alignment.center,
                fit: BoxFit.scaleDown,
                child: Text(
                  userController.getFullName(),
                  style: TextStyle(
                    color: ThemeColor.secondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w800),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Divider(thickness: 1),
          InkWell(
            onTap: () {
              Get.toNamed(PageRoutes.AccountProfile);
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 40,
                    child: Icon(
                      Feather.user, 
                      size: 20
                    ),
                  ),
                  Text(
                    "My Account",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(thickness: 1),
          InkWell(
            onTap: () {
              Get.toNamed(PageRoutes.PrivacyPolicy);
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 40,
                    child: Icon(
                      Feather.file_text, 
                      size: 20
                    ),
                  ),
                  Text(
                    "Privacy Policy",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            )
          ),
          Divider(thickness: 1),
          InkWell(
            onTap: () {
              Get.toNamed(PageRoutes.TermsOfService);
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 40,
                    child: Icon(
                      Feather.list, 
                      size: 20
                    ),
                  ),
                  Text(
                    "Terms and Conditions",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              )
            )
          ),
          Divider(thickness: 1),
          InkWell(
            onTap: () async {
              Get.toNamed(PageRoutes.HelpCenter);
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 40,
                    child: Icon(
                      Feather.help_circle, 
                      size: 20
                    ),
                  ),
                  Text(
                    "Help Center",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Divider(thickness: 1),
          InkWell(
            onTap: () {
              setState(() {
                clickCounter += 1;
              });
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 40,
                    child: Icon(
                      Feather.code, 
                      size: 20,
                      color: ThemeColor.disabled,
                    ),
                  ),
                  Text(
                    "OBPLS v${appVersionHandler.packageVersion.value}.${appVersionHandler.packageBuildNumber.value}",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: ThemeColor.disabled,
                      fontSize: 14,
                    ),
                  ),
                ]
              ),
            ),
          ),
          Divider(thickness: 1),
          clickCounter >= 10 ?
          InkWell(
            onTap: () async {
              popupDialogConsoleLogs(context);
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  SizedBox(
                    height: 20,
                    width: 40,
                    child: Icon(
                      Feather.alert_circle, 
                      size: 20
                    )
                  ),
                  Text(
                    "Logs",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )
                ],
              )
            )
          ) : Container(),
          clickCounter >= 10 ? Divider(thickness: 1) : Container(),
        ],
      ),
    );
  }

  Widget logoutView() {
    return Container(
      padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height / 2) - 80),
      child: Center(
        child: Column(
          children: [
            SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                )),
            Text(
              "Logging Out",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        )
      )
    );
  }
}
