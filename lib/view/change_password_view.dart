// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/account_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/controller/user_controller.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

import '../utils/env.dart';
import '../utils/popup_dialog.dart';
import '../utils/theme_color.dart';

class ChangePasswordView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ChangePasswordView();
  @override
  ChangePasswordViewState createState() => ChangePasswordViewState();
}

class ChangePasswordViewState extends State<ChangePasswordView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  final UserController userController = Get.find();
  final AccountController accountController = Get.find();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _oldPasswordVisible = false;
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();  }

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: bodyView());
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Text(
            'Change Password?',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 24,
              fontWeight: FontWeight.w500
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Enter your old password',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: _oldPasswordController,
            obscureText: !_oldPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(MaterialIcons.lock),
              hintText: 'Enter Old Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _oldPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _oldPasswordVisible = !_oldPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ThemeColor.success),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Enter your new password',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: _newPasswordController,
            obscureText: !_newPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(MaterialIcons.lock),
              hintText: 'Enter New Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _newPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _newPasswordVisible = !_newPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ThemeColor.success),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: _confirmPasswordController,
            obscureText: !_confirmPasswordVisible,
            decoration: InputDecoration(
              prefixIcon: Icon(MaterialIcons.lock),
              hintText: 'Confirm Password',
              suffixIcon: IconButton(
                icon: Icon(
                  _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                ),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
              border: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ThemeColor.success),
                borderRadius: BorderRadius.circular(20),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(width: 2, color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(20),
              )
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Text(
            '* At least 8 Characters',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '* Lowercase Letters',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '* Uppercase Letters',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            '* Special Characters',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              backgroundColor: ThemeColor.primaryNavbarBg,
              minimumSize: Size(MediaQuery.of(context).size.width, 55),
            ),
            onPressed: () async {
              changePassword();
            },
            child: Text(
              'CONTINUE',
              style: TextStyle(
                  color: ThemeColor.primaryText,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  changePassword() {
    FocusScope.of(context).unfocus();
    if (_oldPasswordController.text != accountController.getPassword()) {
      popupDialog(context, NotifHeader.error, 'Old password is incorrect.');
      return;
    }
    if (_newPasswordController.text != _confirmPasswordController.text) {
      popupDialog(context, NotifHeader.error, 'New password did not match.');
      return;
    }
    if (_newPasswordController.text.length < 8) {
      popupDialog(context, NotifHeader.error, "Password must be at least 8 characters.");
      return;
    }
    if (!_newPasswordController.text.contains(new RegExp('[a-z]'))) {
      popupDialog(context, NotifHeader.error, "Password must contain lowercase letters.");
      return;
    }
    if (!_newPasswordController.text.contains(new RegExp('[A-Z]'))) {
      popupDialog(context, NotifHeader.error, "Password must contain uppercase letters.");
      return;
    }
    if (!_newPasswordController.text.contains(new RegExp(r'[~!@#$%^&*()_+`{}|<>?;:./,=\-\[\]]'))) {
      popupDialog(context, NotifHeader.error, "Password must contain special characters.");
      return;
    }
    networkConnectionController.checkConnectionStatus().then((connResult) {
      if (connResult) {
        EasyLoading.show();
        resetPassword(userController.getId(), _newPasswordController.text).then((value) {
          if (value == "Success") {
            popupDialog(context, NotifHeader.success, 'Password successfuly changed!').then((value) {
              userController.setPassword(_newPasswordController.text);
              Get.back();
            });
          } else {
            popupDialog(context, NotifHeader.error, 'Error occurred while changing your password. Please try again later.');
          }
          EasyLoading.dismiss();
        });
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }
}
