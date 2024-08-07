// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/pre_backend_call.dart';
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
  bool isOldSelected = false;
  bool isNoSelected = false;
  bool isListSelected = false;
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
          isOldSelected = false;
          isNoSelected = false;
          isListSelected = false;
        });
      }
    });
  }

  initSetup() async {
    await PreBackendCall().pregetAppStatus().then((res) async {
      await PreBackendCall().pregetListPaymentMode().then((res) {
        mainController.listPaymentMode = res;
      });
      await PreBackendCall().pregetListApplicationStatus().then((res) {
        mainController.listApplicationStatus = res;
      });
      await PreBackendCall().pregetListApplicationType().then((res) {
        mainController.listApplicationType = res;
      });
      await PreBackendCall().pregetListBusinessType().then((res) {
        mainController.listBusinessType = res;
      });
      await PreBackendCall().pregetListLineBusiness().then((res) {
        mainController.listLineOfBusiness = res;
      });
      await PreBackendCall().pregetListMeasurePax().then((res) {
        mainController.listLineOfBusinessMeasurePax = res;
      });
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
            color: ThemeColor.primaryBg,
            boxShadow: [
              BoxShadow(
                color: ThemeColor.primary,
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
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      width: 260,
                      height: 40,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(
                          Env.lguName,
                          style: TextStyle(
                            color: ThemeColor.secondary,
                            fontSize: 28,
                            fontWeight: FontWeight.w800),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: SizedBox(
                      width: 260,
                      height: 40,
                      child: Text(
                        Env.lguAddress,
                        style: TextStyle(
                          color: ThemeColor.secondary,
                          fontStyle: FontStyle.italic,
                          fontSize: 13,
                          fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Container( // Body
          padding: EdgeInsets.symmetric(horizontal: 32),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 230,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Align(
                alignment: Alignment.center,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 50,
                  child: FittedBox(
                    alignment: Alignment.center,
                    fit: BoxFit.scaleDown,
                    child: Column(
                      children: [
                        Text(
                          "Business Survey and Assessment",
                          style: TextStyle(
                            color: ThemeColor.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Sheet",
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
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isNewSelected = !isNewSelected;
                            isOldSelected = false;
                            isNoSelected = false;
                            isListSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 120,
                          height: 100,
                          decoration: BoxDecoration(
                            color: ThemeColor.primaryBg,
                            border: Border.all(
                              width: 2,
                              color: isNewSelected ? ThemeColor.primaryGlow : (isOldSelected || isNoSelected || isListSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
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
                                color: (isNoSelected || isOldSelected || isListSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                              ),
                              FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "New Business",
                                  style: TextStyle(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.w800,
                                    color: (isNoSelected || isOldSelected || isListSelected) ? ThemeColor.disabledText : ThemeColor.secondary,
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isOldSelected = !isOldSelected;
                            isNewSelected = false;
                            isNoSelected = false;
                            isListSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 120,
                          height: 100,
                          decoration: BoxDecoration(
                            color: ThemeColor.primaryBg,
                            border: Border.all(
                              width: 2,
                              color: isOldSelected ? ThemeColor.primaryGlow : (isNoSelected || isNewSelected || isListSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isOldSelected ? ThemeColor.primary : ThemeColor.primaryBg,
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
                                color: (isNoSelected || isNewSelected || isListSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                              ),
                              FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "Old Business",
                                  style: TextStyle(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.w800,
                                    color: (isNoSelected || isNewSelected || isListSelected) ? ThemeColor.disabledText : ThemeColor.secondary,
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isNoSelected = !isNoSelected;
                            isNewSelected = false;
                            isOldSelected = false;
                            isListSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 120,
                          height: 100,
                          decoration: BoxDecoration(
                            color: ThemeColor.primaryBg,
                            border: Border.all(
                              width: 2,
                              color: isNoSelected ? ThemeColor.primaryGlow : (isOldSelected || isNewSelected || isListSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isNoSelected ? ThemeColor.primary : ThemeColor.primaryBg,
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
                                MaterialIcons.cancel,
                                size: 70,
                                color: (isOldSelected || isNewSelected || isListSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                              ),
                              FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "No Business Permit",
                                  style: TextStyle(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.w800,
                                    color: (isOldSelected || isNewSelected || isListSelected) ? ThemeColor.disabledText : ThemeColor.secondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isListSelected = !isListSelected;
                            isNoSelected = false;
                            isNewSelected = false;
                            isOldSelected = false;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          width: 120,
                          height: 100,
                          decoration: BoxDecoration(
                            color: ThemeColor.primaryBg,
                            border: Border.all(
                              width: 2,
                              color: isListSelected ? ThemeColor.primaryGlow : (isOldSelected || isNewSelected || isNoSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                            ),
                            borderRadius: BorderRadius.all(
                                Radius.circular(5)
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: isListSelected ? ThemeColor.primary : ThemeColor.primaryBg,
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
                                MaterialIcons.view_list,
                                size: 70,
                                color: (isOldSelected || isNewSelected || isNoSelected) ? ThemeColor.primaryLighter : ThemeColor.primary,
                              ),
                              FittedBox(
                                alignment: Alignment.centerLeft,
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "List of Business",
                                  style: TextStyle(
                                    fontSize: 12, 
                                    fontWeight: FontWeight.w800,
                                    color: (isOldSelected || isNewSelected || isNoSelected) ? ThemeColor.disabledText : ThemeColor.secondary,
                                  )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Center(
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: (isNewSelected || isOldSelected || isNoSelected || isListSelected) ? ThemeColor.primary : ThemeColor.disabled,
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
    if (isNewSelected || isOldSelected || isNoSelected) {
      userController.applicationType.value = isNewSelected ? "New" : isOldSelected ? "Renew" : isNoSelected ? "None" : "New";
      userController.activeBusinessApplication.value = BusinessApplication(application_type: userController.applicationType.value);
      Get.toNamed(PageRoutes.BusinessPermitApplication).then((value) {
        setState(() {
          isNewSelected = false;
          isOldSelected = false;
          isNoSelected = false;
        });
      });
    } else if (isListSelected) {
      navigationItemSelection(2, context);
    }
  }
}
