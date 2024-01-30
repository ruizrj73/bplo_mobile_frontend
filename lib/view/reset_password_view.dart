// ignore_for_file: prefer_const_constructors, unnecessary_new
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

import '../utils/popup_dialog.dart';
import '../utils/theme_color.dart';

class ResetPasswordView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ResetPasswordView();
  @override
  ResetPasswordViewState createState() => ResetPasswordViewState();
}

class ResetPasswordViewState extends State<ResetPasswordView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _newPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
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
      backgroundColor: ThemeColor.primaryBg,
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
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * .05),
          Text(
            'Set New Password?',
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
            'Enter a new one to reset your password. Go for at least 8 characters',
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
                borderSide: BorderSide(width: 2, color: ThemeColor.success),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(15),
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
                borderSide: BorderSide(width: 2, color: ThemeColor.success),
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: ThemeColor.primary),
                borderRadius: BorderRadius.circular(15),
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
            height: 50,
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
              'RESET PASSWORD',
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
    if (_newPasswordController.text != _confirmPasswordController.text) {
      popupDialog(context, '', 'New password did not match.');
      return;
    }
    if (_newPasswordController.text.length < 8) {
      popupDialog(context, '', "Password must be at least 8 characters.");
      return;
    }
    if (!_newPasswordController.text.contains(new RegExp('[a-z]'))) {
      popupDialog(context, '', "Password must contain lowercase letters.");
      return;
    }
    if (!_newPasswordController.text.contains(new RegExp('[A-Z]'))) {
      popupDialog(context, '', "Password must contain uppercase letters.");
      return;
    }
    if (!_newPasswordController.text.contains(new RegExp(r'[~!@#$%^&*()_+`{}|<>?;:./,=\-\[\]]'))) {
      popupDialog(context, '', "Password must contain special characters.");
      return;
    }
    networkConnectionController.checkConnectionStatus().then((connResult) {
      if (connResult) {
        EasyLoading.show();
        resetPassword(userController.getId(), _newPasswordController.text).then((value) {
          if (value == "Success") {
            EasyLoading.dismiss();
            popupDialog(context, '', 'Your password has been successfully updated!').then((value) {
              Get.back(result: true);
            });
          } else {
            EasyLoading.dismiss();
            popupDialog(context, '', 'Error occurred while updating your password. Please try again.');
          }
        });
      } else {
        popupDialog(context, "", "Please check your internet connection.");
        return;
      }
    });
  }
}
