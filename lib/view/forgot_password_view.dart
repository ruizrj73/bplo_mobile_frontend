// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import '../utils/popup_dialog.dart';

class ForgotPasswordView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const ForgotPasswordView();
  @override
  ForgotPasswordViewState createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  final _userAccountController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _userAccountController.text = "";
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
            'Forgot Password?',
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
            'Enter your registered mobile number',
            style: TextStyle(
              color: ThemeColor.secondary,
              fontSize: 14,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Container(
            height: 60,
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ThemeColor.primaryBg,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              border: Border.all(
                color: ThemeColor.primary,
                width: 2,
              )
            ),
            child: TextFormField(
              controller: _userAccountController,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                counterText: '',
                contentPadding: EdgeInsets.only(top: 9, bottom: 8),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                hintText: 'Username / Mobile Number / Email Address',
              ),
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            'Kindly enter the mobile number you registered with, we would send an OTP code so that you can setup new password. Click on the button below when you are done entering it.',
            textAlign: TextAlign.justify,
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
              forgotPassword();
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

  forgotPassword() {
    FocusScope.of(context).unfocus();
    networkConnectionController.checkConnectionStatus().then((connResult) {
      if (connResult) {
        EasyLoading.show();
        isAccountAvailable(
          _userAccountController.text.trim(),
          _userAccountController.text.trim(),
          _userAccountController.text.trim(),
        ).then((value) async {
          if (value["mobileNo"] != "") {
            userController.setContactNumber(value["mobileNo"]);
            userController.setId(value["userId"]);
            await requestOtp(value["mobileNo"]).then((value) {
              EasyLoading.dismiss();
              Get.back(result: true);
            });
          } else {
            EasyLoading.dismiss();
            popupDialog(context, '', "Account does not exist.");
          }
        });
      } else {
        EasyLoading.dismiss();
        popupDialog(context, "", "Please check your internet connection.");
        return;
      }
    });
  }
}
