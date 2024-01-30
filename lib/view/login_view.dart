// ignore_for_file: prefer_const_constructors, unnecessary_new, avoid_print, prefer_interpolation_to_compose_strings, no_leading_underscores_for_local_identifiers

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/device_info_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

import '../controller/account_controller.dart';
import '../utils/app_version_handler.dart';

class LoginView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const LoginView();
  @override
  LoginViewState createState() => LoginViewState();
}

class LoginViewState extends State<LoginView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  final AppVersionHandler appVersionHandler = Get.find();
  final DeviceInfoController deviceInfoController = Get.find();
  final AccountController accountController = Get.find();
  final _usernameController = new TextEditingController();
  final _userPasswordController = new TextEditingController();
  double lng = 0;
  double lat = 0;
  bool _passwordVisible = false;

  @override
  void initState() {
    super.initState();

    _passwordVisible = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: buildPage(),
      onWillPop: () {
        popupDialogYesNo(context, "", "Do you want to close the app?").then((value) {
          if (value == "Yes") {
            exit(0);
          }
        });
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: ThemeColor.primaryBg,
      // bottomNavigationBar: bottomNavBar(),
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      reverse: true,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * .13),
            SizedBox(
              child: Column(
                children: [
                  Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width * .5),
                      height: MediaQuery.of(context).size.width -
                        (MediaQuery.of(context).size.width * .5),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          alignment: Alignment.center,
                          fit: BoxFit.fitWidth,
                          image: AssetImage('assets/icons/app-icon.png')
                        )
                      )
                    )
                  ),
                  SizedBox(height: 24),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 50,
                      child: FittedBox(
                        alignment: Alignment.topCenter,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          Env.lguName,
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                color: ThemeColor.primary
              ),
              child: Column(
                children: [
                  Text(
                    "Enter your username and password to enter",
                    style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _usernameController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Icon(MaterialIcons.person),
                        hintText: 'Username',
                        filled: true,
                        fillColor: ThemeColor.primaryBg,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: ThemeColor.primaryBg),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: ThemeColor.primaryBg),
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: _userPasswordController,
                      obscureText: !_passwordVisible,
                      onSubmitted: ((value) => login()),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        prefixIcon: Icon(MaterialIcons.lock),
                        hintText: 'Enter Password',
                        filled: true,
                        fillColor: ThemeColor.primaryBg,
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: ThemeColor.success),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 2, color: ThemeColor.primary),
                          borderRadius: BorderRadius.circular(12),
                        )
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      onTap: () {
                        viewPage("ForgotPassword");
                      },
                      child: Text(
                        "Forgot Password",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: ThemeColor.warning,
                            fontSize: 14,
                            fontWeight: FontWeight.w800),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  TextButton(
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      backgroundColor: ThemeColor.secondary,
                      minimumSize: Size(MediaQuery.of(context).size.width, 35),
                    ),
                    onPressed: () async {
                      login();
                    },
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                          color: ThemeColor.primaryText,
                          fontWeight: FontWeight.w800,
                          fontSize: 16),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: ThemeColor.primaryText
                        ),
                      ),
                      SizedBox(width: 8),
                      TextButton(
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: ThemeColor.warning,
                          minimumSize: Size(50, 12),
                        ),
                        onPressed: () async {
                          viewPage("CreateAccount");
                        },
                        child: Text(
                          'Register',
                          style: TextStyle(
                              color: ThemeColor.primaryText,
                              fontWeight: FontWeight.w800,
                              fontSize: 10),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomNavBar() {
    return SizedBox(
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: Column(
              children: [
                Text(
                  'Copyright © 2022 ResponsivCode.com',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                ),
                Text(
                  Env.projectName + " v" + appVersionHandler.packageVersion.value,
                  style: TextStyle(
                    fontFamily: "Poppins",
                    color: Colors.black54,
                    fontSize: 12,
                  ),
                )
              ],
            )
        )
    );
  }

  login() async {
    FocusScope.of(context).unfocus();
    if (_usernameController.text == "") {
      popupDialog(context, '', 'Please enter username.');
      return;
    }
    if (_userPasswordController.text == "") {
      popupDialog(context, '', 'Please enter password.');
      return;
    }
    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();

        isLoginValid(_usernameController.text, _userPasswordController.text).then((value) {
          if (value) {
            userController.setPassword(_userPasswordController.text);
            accountController.setIsLoggedIn(true);
            accountController.saveUserId(userController.getId());
            accountController.savePassword(_userPasswordController.text);

            Get.toNamed(PageRoutes.Home);
          } else {
            popupDialog(context, '', 'Username/Password is incorrect.');
          }
          EasyLoading.dismiss();
        });
      } else {
        popupDialog(context, "", "Please check your internet connection.");
        return;
      }
    });
  }

  viewPage(String pageName) {
    switch (pageName) {
      case "CreateAccount":
        Get.toNamed(PageRoutes.CreateAccount).then((_create) {
          if (_create != null) {
            viewPage("UserProfile");
          } else {
            userController.clearState();
          }
        });
        break;
      case "UserProfile":
        Get.toNamed(PageRoutes.UserProfile).then((_profile) {
          if (_profile != null) {
            viewPage("OtpRegister");
          } else {
            viewPage("CreateAccount");
          }
        });
        break;
      case "OtpRegister":
        Get.toNamed(PageRoutes.Otp).then((_otp) async {
          if (_otp != null) {
            await registerUser(userController.getUserInfo()).then((value) {
              if (value == "Success") {
                userController.clearState();
              } else {
                popupDialog(context, "", "There's a problem in registering account.");
              }
            });
          } else {
            viewPage("UserProfile");
          }
        });
        break;
      case "ForgotPassword":
        Get.toNamed(PageRoutes.ForgotPassword).then((_forgotPw) {
          if (_forgotPw != null) {
            viewPage("OtpForgotPw");
          } else {
            userController.clearState();
          }
        });
        break;
      case "OtpForgotPw":
        Get.toNamed(PageRoutes.Otp).then((_otp) {
          if (_otp != null) {
            viewPage("ResetPassword");
          } else {
            viewPage("ForgotPassword");
          }
        });
        break;
      case "ResetPassword":
        Get.toNamed(PageRoutes.ResetPassword).then((_resetPw) {
          if (_resetPw != null) {
            userController.clearState();
          } else {
            viewPage("ForgotPassword");
          }
        });
        break;
      default:
        break;
    }
  }
}
