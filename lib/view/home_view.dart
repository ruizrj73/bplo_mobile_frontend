// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/application_status_model.dart';
import 'package:lgu_bplo/model/application_type_model.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/model/business_type_model.dart';
import 'package:lgu_bplo/model/payment_mode_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class HomeView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const HomeView();
  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  bool isNewSelected = false;
  bool isRenewSelected = false;
  @override
  void initState() {
    super.initState();
    try {
      mainController.bottomNavIndex.value = 0;
      // ignore: empty_catches
    } catch (ex) {}

    mainController.bottomNavIndex.listen((val) {
      if (val == 0) {
        setState(() {
          isNewSelected = false;
          isRenewSelected = false;
        });
      }
    });
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
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
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
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationView(context),
      body: SafeArea(
        child: bodyView(),
      )
    );
  }

  Widget bodyView() {
    return Column(
      children: [
        Container( // Header
          width: MediaQuery.of(context).size.width,
          height: 150,
          decoration: BoxDecoration(
            color: ThemeColor.primary,
            boxShadow: [
              BoxShadow(
                color: ThemeColor.disabled,
                spreadRadius: 1,
                blurRadius: 1,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 85,
                height: 85,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.center,
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/icons/app-icon.png')
                  )
                )
              ),
              SizedBox(width: 8),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 260,
                      height: 30,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          Env.lguName,
                          style: TextStyle(
                            color: ThemeColor.primaryText,
                            fontSize: 28,
                            fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 260,
                      height: 30,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          Env.lguAddress,
                          style: TextStyle(
                            color: ThemeColor.primaryText,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container( // Body
          padding: EdgeInsets.all(32),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 242,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 80,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Column(
                      children: [
                        Text(
                          "Integrated Business Permit Licensing",
                          style: TextStyle(
                            color: ThemeColor.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Management System",
                          style: TextStyle(
                            color: ThemeColor.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        ),
                      ],
                    )
                  ),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isNewSelected = !isNewSelected;
                        isRenewSelected = false;
                        if (isNewSelected) {
                          List<BusinessApplication> _businessApplication = userController.listBusinessApplication.value.application.where((app) => app.application_status == "Pending Application").toList();
                          if (_businessApplication.isNotEmpty) {
                            popupDialogYesNo(context, NotifHeader.confirm, "Pending Business Permit found. Do you want to continue?").then((res) {
                              if (res == "No") {
                                // userController.applicationType.value = _businessApplication.application_type;
                                // userController.activeBusinessApplication.value = _businessApplication;
                                mainController.bottomNavIndex.value = 2;
                                Get.toNamed(PageRoutes.AccountTransaction, arguments: {"pendingId": _businessApplication.first.id});
                              }
                            });
                          }
                        }
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        color: ThemeColor.primaryBg,
                        border: Border.all(
                          width: 2,
                          color: isNewSelected ? ThemeColor.primaryGlow : isRenewSelected ? ThemeColor.primaryLighter : ThemeColor.primary,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isNewSelected ? ThemeColor.primary : ThemeColor.primaryBg,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],

                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            MaterialIcons.add_circle,
                            size: 70,
                            color: ThemeColor.primary,
                          ),
                          Text(
                            "New Business",
                            style: TextStyle(
                              fontSize: 12, 
                              fontWeight: FontWeight.w800
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isRenewSelected = !isRenewSelected;
                        isNewSelected = false;
                      });
                    },
                    child: Container(
                      width: 120,
                      height: 100,
                      decoration: BoxDecoration(
                        color: ThemeColor.primaryBg,
                        border: Border.all(
                          width: 2,
                          color: isRenewSelected ? ThemeColor.primaryGlow : isNewSelected ? ThemeColor.primaryLighter : ThemeColor.primary,
                        ),
                        borderRadius: BorderRadius.all(
                            Radius.circular(5)
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isRenewSelected ? ThemeColor.primary : ThemeColor.primaryBg,
                            spreadRadius: 1,
                            blurRadius: 4,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(
                            MaterialIcons.check_circle,
                            size: 70,
                            color: ThemeColor.primary,
                          ),
                          Text(
                            "Renew Business",
                            style: TextStyle(
                              fontSize: 12, 
                              fontWeight: FontWeight.w800
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 110),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: isNewSelected || isRenewSelected ? ThemeColor.primary : ThemeColor.disabled,
                    minimumSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
                    shadowColor: ThemeColor.secondary,
                    elevation: 3,
                  ),
                  onPressed: () async {
                    businessApplicationProcess();
                  },
                  child: Text(
                    'Proceed',
                    style: TextStyle(
                        color: ThemeColor.primaryText,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  businessApplicationProcess() {
    if (isNewSelected || isRenewSelected) {
      userController.activeBusinessApplication.value = BusinessApplication();
      userController.applicationType.value = isNewSelected ? "New" : isRenewSelected ? "Renew" : "New";
      Get.toNamed(PageRoutes.BusinessPermitApplication).then((value) {
        setState(() {
          isNewSelected = false;
          isRenewSelected = false;
        });
      });
    }
  }
}
