// import 'package:countdown_flutter/countdown_flutter.dart';
// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/account_controller.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/model/app_status.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/console_logs_dialog.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/local_db.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:restart_app/restart_app.dart';

import '../utils/app_version_handler.dart';
import '../utils/request/backend_request.dart';

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
  final NetworkConnectionController networkConnectionController = Get.find();
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
                width: MediaQuery.of(context).size.width/5,
                height: MediaQuery.of(context).size.width/5,
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
          InkWell(
            onTap: () async {
              popupStatus(context);
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
                    "Connectivity & Attachment Status",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  )
                ],
              )
            )
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

  Future<String> popupStatus(BuildContext context) {
    String connectivityStatus = userController.getConnectivityStatus();
    String attachmentStatus = userController.getAttachmentStatus();
    bool allowOffline = userController.getAllowOffline();
    bool allowAttach = userController.allowAttach();

    return showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.all(0),
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16))
            ),
            title: Container(
              height: 30,
              padding: EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: ThemeColor.warning,
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16), 
                    bottom: Radius.circular(0)
                  )
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Connectivity & Attachment Status', style: TextStyle(fontWeight: FontWeight.w800, color: ThemeColor.primaryText, fontSize: 14)),
                ],
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 180,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Connectivity Status:", 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Offline", 
                            style: TextStyle(
                              fontSize: connectivityStatus == "Offline" ? 16 : 14, 
                              fontWeight: connectivityStatus == "Offline" ? FontWeight.w800 : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                      Switch(
                        value: connectivityStatus == "Online",
                        activeColor: !allowOffline ? ThemeColor.disabled : ThemeColor.primary,
                        inactiveThumbColor: !allowOffline ? ThemeColor.disabled : ThemeColor.warning,
                        onChanged: (bool value) {
                          if (allowOffline) {
                            setState(() {
                              connectivityStatus = connectivityStatus == "Online" ? "Offline" : "Online";
                            });
                          }
                        },
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          "Online", 
                          style: TextStyle(
                            fontSize: connectivityStatus == "Online" ? 16 : 14, 
                            fontWeight: connectivityStatus == "Online" ? FontWeight.w800 : FontWeight.normal
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "File Attach Status:", 
                    style: TextStyle(
                      fontSize: 14, 
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: 100,
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "Not Allowed", 
                            style: TextStyle(
                              fontSize: attachmentStatus == "Not Allowed" ? 16 : 14, 
                              fontWeight: attachmentStatus == "Not Allowed" ? FontWeight.w800 : FontWeight.normal
                            ),
                          ),
                        ),
                      ),
                      Switch(
                        value: attachmentStatus == "Allowed",
                        activeColor: !allowAttach ? ThemeColor.disabled : ThemeColor.primary,
                        inactiveThumbColor: !allowAttach ? ThemeColor.disabled : ThemeColor.warning,
                        onChanged: (bool value) {
                          if (allowAttach) {
                            setState(() {
                              attachmentStatus = attachmentStatus == "Allowed" ? "Not Allowed" : "Allowed";
                            });
                          }
                        },
                      ),
                      SizedBox(
                        width: 100,
                        child: Text(
                          "Allowed",
                          style: TextStyle(
                            fontSize: attachmentStatus == "Allowed" ? 16 : 14, 
                            fontWeight: attachmentStatus == "Allowed" ? FontWeight.w800 : FontWeight.normal
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: ThemeColor.primaryBg,
                        fixedSize: Size(130, 30),
                        foregroundColor: Colors.black,
                        shadowColor: Colors.black
                      ),
                      onPressed: () => Navigator.pop(context, 'Cancel'),
                      child: const Text('Close', style: TextStyle(fontWeight: FontWeight.w800))
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        backgroundColor: ThemeColor.primary,
                        fixedSize: Size(130, 30),
                        foregroundColor: ThemeColor.primaryText,
                        shadowColor: Colors.black
                      ),
                      onPressed:() async {
                        preSaveStatus(connectivityStatus, attachmentStatus);
                      },
                      child: const Text('Save', style: TextStyle(fontWeight: FontWeight.w800))
                    )
                  ],
                ),
              )
            ],
          );
        }));
      }
    );
  }

  preSaveStatus(String connectivityStatus, String attachmentStatus) async {
    if (connectivityStatus == "Online") {
      await LocalDB().localBusinessApplication().then((data) async {
        if (data.isNotEmpty) {
          popupDialogYesNo(context, "Offline Records", "You have an offline transaction saved. Do you want to upload it?", additionalHeader: "Warning!", additionalMessage: "Pressing 'No' will remove all offline transaction.").then((value) {
            if (value == "Yes") {
              networkConnectionController.checkConnectionStatus().then((connResult) async {
                if (connResult) {
                  EasyLoading.show();

                  await Future.forEach(data, (businessApp) async {
                    await saveBusinessApplication(businessApp);
                  }).then((value) {
                    LocalDB().deleteAllBusinessApplication();
                    EasyLoading.dismiss();
                    saveStatus(connectivityStatus, attachmentStatus);
                  });
                } else {
                  popupDialog(context, NotifHeader.error, "Please check your internet connection.");
                  return;
                }
              });
            } else if (value == "No") {
              LocalDB().deleteAllBusinessApplication();
              saveStatus(connectivityStatus, attachmentStatus);
            }
          });
        } else {
          saveStatus(connectivityStatus, attachmentStatus);
        }
      });
    } else {
      saveStatus(connectivityStatus, attachmentStatus);
    }
  }

  saveStatus(String connectivityStatus, String attachmentStatus) {
    userController.setConnectivityStatus(connectivityStatus);
    userController.setAttachmentStatus(attachmentStatus);
    LocalDB().localInsertAppStatus(AppStatus("", connectivityStatus, attachmentStatus)).then((value) {
      popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
        Navigator.pop(context);
      });
    });
  }
}
