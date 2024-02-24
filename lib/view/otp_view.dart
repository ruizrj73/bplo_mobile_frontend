// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';

class OtpView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const OtpView();
  @override
  OtpViewState createState() => OtpViewState();
}

class OtpViewState extends State<OtpView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  CountdownTimerController cdtcController;
  final otpController = TextEditingController();
  String contactNumber = "";
  bool hasError = false;
  bool enableResendOtp = false;
  int endTime;

  @override
  void initState() {
    super.initState();
    setEndTime();
    startListeningSms();

    contactNumber = userController.getContactNumber();
  }

  @override
  void dispose() {
    super.dispose();
  }
  
  setEndTime() {
    setState(() {
      endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 120;
      cdtcController = CountdownTimerController(
        endTime: endTime,
        onEnd: () {
          if (mounted) {
            setState(() {
              enableResendOtp = true;
            });
            SmsVerification.stopListening();
          }
        }
      );
    });
  }

  startListeningSms()  {
    SmsVerification.startListeningSms().then((message) {
      var otp = RegExp(r'\b\d{6}\b').firstMatch(message);
      otpController.text = otp[0];
    });
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
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 32),
          Text(
            "Enter OTP",
            style: TextStyle(
              fontSize: 20, 
              fontWeight: FontWeight.w800, 
              color: ThemeColor.primary
            )
          ),
          SizedBox(height: 8),
          Flexible(
            child: RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                children: [
                  TextSpan(
                    text:
                        'Enter the OTP Code from the one we have just sent you. ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                  TextSpan(
                    text:
                        '*******' + contactNumber.substring(7, 11),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 32),
          PinCodeTextField(
            controller: otpController,
            appContext: context,
            keyboardType: TextInputType.number,
            length: 6,
            onCompleted: (String value) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (String value) {},
            pinTheme: PinTheme(
              activeColor: const Color(0xffEFEFF4),
              selectedColor: const Color(0xffEFEFF4),
              inactiveColor: const Color(0xffEFEFF4),
              selectedFillColor: Colors.white,
              shape: PinCodeFieldShape.box,
              fieldHeight: 50,
              fieldWidth: 50,
              activeFillColor: const Color(0xffEFEFF4),
            ),
          ),
          hasError ? 
          Text(
            "Incorrect code inputted",
            style: TextStyle(fontSize: 12, color: ThemeColor.warning),
          )
          : Container(),
          SizedBox(height: 18),
          Row(
            children: [
              Text(
                "Didn't receive SMS?",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
              SizedBox(width: 8),
              enableResendOtp ? InkWell(
                onTap: () async {
                  resendOtp();
                },
                child: Text(
                  'Resend Code',
                  style: TextStyle(
                    color: ThemeColor.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  )
                )
              ) :
              Text(
                'Resend Code',
                style: TextStyle(
                  color: ThemeColor.disabled,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                )
              ),
              SizedBox(width: 8),
              CountdownTimer(
                controller: cdtcController,
                widgetBuilder: (_, CurrentRemainingTime time) {
                  Widget retWidget;
                  if (time == null) {
                    retWidget = Container();
                  } else {
                    retWidget = Text(
                      (time.min != null ? time.sec + (60 * time.min) : time.sec).toString() + "sec",
                      style: TextStyle(
                        color: Color(0xff00939D),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      )
                    );
                  }
                  return retWidget;
                }
              )
            ],
          ),
          SizedBox(height: 32),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                backgroundColor: ThemeColor.primary,
                minimumSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
                shadowColor: ThemeColor.secondary,
                elevation: 3,
              ),
              onPressed: () async {
                verifyOtp();
              },
              child: Text(
                'Verify',
                style: TextStyle(
                    color: ThemeColor.primaryText,
                    fontWeight: FontWeight.w800,
                    fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  resendOtp() async {
    EasyLoading.show();
    enableResendOtp = false;
    setEndTime();
    startListeningSms();
    await requestOtp(userController.getContactNumber()).then((value) {
      EasyLoading.dismiss();
    });
  }

  verifyOtp() {
    if (otpController.text == "") {
      popupDialog(context, NotifHeader.error, "Please input OTP.");
      return;
    }
    if (otpController.text.length != 6) {
      popupDialog(context, NotifHeader.error, "Invalid Code.");
      return;
    }
    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();
        await verifyCode(userController.getContactNumber(), otpController.text).then((value) async {
          if (value["code"] != "Invalid Code") {
            EasyLoading.dismiss();
            Get.back(result: true);
          } else {
            EasyLoading.dismiss();
            popupDialog(context, NotifHeader.error, value["code"]);
          }
        });
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }
}
