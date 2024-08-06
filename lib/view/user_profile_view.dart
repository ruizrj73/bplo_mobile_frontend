// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/user_info.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

import '../utils/theme_color.dart';

class UserProfileView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const UserProfileView();
  @override
  UserProfileViewState createState() => UserProfileViewState();
}

class UserProfileViewState extends State<UserProfileView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool isAgree = false;
  bool isShowPassword = false;
  bool isShowConfirmPassword = false;

  @override
  void initState() {
    super.initState();

    _usernameController.text = userController.getUsername();
    _passwordController.text = userController.getPassword();
    _confirmPasswordController.text = userController.getPassword();
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
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: ThemeColor.primary,
                ),
                borderRadius: BorderRadius.all(
                    Radius.circular(10)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "User Profile",
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Username :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _usernameController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        LengthLimitingTextInputFormatter(12),
                      ],
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Password :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _passwordController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        LengthLimitingTextInputFormatter(12),
                      ],
                      obscureText: !isShowPassword,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerRight,
                          iconSize: 20,
                          icon: Icon(
                            isShowPassword ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text("Confirm Password :", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
                  SizedBox(
                    height: 30,
                    child: TextField(
                      controller: _confirmPasswordController,
                      inputFormatters: [
                        FilteringTextInputFormatter.deny(RegExp(r'\s')),
                        LengthLimitingTextInputFormatter(12),
                      ],
                      obscureText: !isShowConfirmPassword,
                      style: TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          padding: EdgeInsets.all(0),
                          alignment: Alignment.centerRight,
                          iconSize: 20,
                          icon: Icon(
                            isShowConfirmPassword ? Icons.visibility : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowConfirmPassword = !isShowConfirmPassword;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 25,
                        height: 20,
                        child: Checkbox(
                          value: isAgree,
                          onChanged: (bool value) {
                            setState(() {
                              isAgree = value ?? false;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 8),
                      Flexible(
                        child: RichText(
                          textAlign: TextAlign.left,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text:
                                    'By proceeding to create your account, you agree to our ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Text(
                                    'Terms & Conditions',
                                    style: TextStyle(
                                      color: ThemeColor.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                              WidgetSpan(
                                  child: Text(
                                ' and ',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              )),
                              WidgetSpan(
                                child: GestureDetector(
                                  onTap: () {
                                    
                                  },
                                  child: Text(
                                    'Privacy Policy',
                                    style: TextStyle(
                                      color: ThemeColor.primary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Registration", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1.", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text("The information provided is certified as true and correct.", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("2.", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text("Registrant should validate their account by entering the OTP sent to the registered mobile number.", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("3.", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text("Registrant should not create multiple false accounts.", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("4.", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text("Registrant should keep their account credentials and will not share to anyone.", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Disclaimer", style: TextStyle(fontWeight: FontWeight.w500)),
                  SizedBox(height: 8),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("1.", style: TextStyle(fontSize: 12)),
                      SizedBox(width: 4),
                      Flexible(
                        child: Text("In accordance to R.A. 10173, or Data Privacy Act, all collected information will be treated with utmost confidentiality and will not be subjected to public disclosure.", style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: isAgree ? ThemeColor.primary : ThemeColor.disabled,
                minimumSize: Size(MediaQuery.of(context).size.width, 50),
                shadowColor: ThemeColor.secondary,
                elevation: 3,
              ),
              onPressed: () async {
                if (isAgree) {
                  registerAccount();
                }
              },
              child: Text(
                'Agree and Continue',
                style: TextStyle(
                    color: ThemeColor.primaryText,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ],
        ),
      )
    );
  }

  registerAccount() {
    FocusScope.of(context).unfocus();
    if (_passwordController.text != _confirmPasswordController.text) {
      popupDialog(context, NotifHeader.error, "Password did not match.");
      return;
    }
    if (_passwordController.text.length < 8) {
      popupDialog(context, NotifHeader.error, "Password must be at least 8 characters.");
      return;
    }
    // if (!_passwordController.text.contains(new RegExp('[a-z]'))) {
    //   popupDialog(context, NotifHeader.error, "Password must contain lowercase letters.");
    //   return;
    // }
    // if (!_passwordController.text.contains(new RegExp('[A-Z]'))) {
    //   popupDialog(context, NotifHeader.error, "Password must contain uppercase letters.");
    //   return;
    // }
    // if (!_passwordController.text.contains(new RegExp(r'[~!@#$%^&*()_+`{}|<>?;:./,=\-\[\]]'))) {
    //   popupDialog(context, NotifHeader.error, "Password must contain special characters.");
    //   return;
    // }
    if (_usernameController.text.trim() == "") {
      popupDialog(context, NotifHeader.error, "Username is invalid.");
      return;
    }
    if (_usernameController.text.trim().length < 8) {
      popupDialog(context, NotifHeader.error, "Username must be at least 8 characters.");
      return;
    }
    if (_usernameController.text.contains(new RegExp(r'[~!@#$%^&*()_+`{}|<>?;:./,=\-\[\]]'))) {
      popupDialog(context, NotifHeader.error, "Username must not contain special characters.");
      return;
    }

    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();
        isUsernameAvailable(_usernameController.text.trim()).then((value) async {
          if (value["resultSuccess"]) {
            if (!value["usernameAvailable"]) {
              EasyLoading.dismiss();
              popupDialog(context, NotifHeader.error, "Username already exist.");
              return;
            } else {
              userController.setUsername(_usernameController.text);
              userController.setPassword(_passwordController.text);
              UserInfo userInfo = new UserInfo(
                "",
                userController.getUsername(),
                userController.getPassword(),
                "",
                userController.getFirstName(),
                userController.getMiddleName(),
                userController.getLastName(),
                userController.getSuffix(),
                userController.getEmail(),
                userController.getContactNumber(),
                userController.getClusterGroup(),
                Env.projectLocation,
                "",
                "",
                false,
                true
              );

              userController.setUserInfo(userInfo);

              await requestOtp(userController.getContactNumber()).then((value) {
                EasyLoading.dismiss();
                Get.back(result: true);
              });
            }
          } else {
            EasyLoading.dismiss();
            popupDialog(context, NotifHeader.error, "There is a problem in checking account availability. Please try again.");
          }
        });
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }
}
