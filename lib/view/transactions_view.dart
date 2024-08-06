// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers, avoid_function_literals_in_foreach_calls
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/attachment_type.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/local_db.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/pre_backend_call.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

import '../utils/notification_header.dart';

class TransactionsView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TransactionsView();
  @override
  TransactionsViewState createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
  final NetworkConnectionController networkConnectionController = Get.find();
  bool isLoadingData = false;
  List<BusinessApplication> businessApplication = [];
  Map<String, bool> viewApplicationShow = {"": false};
  final arg = Get.arguments;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    setState(() {
      isLoadingData = true;
      if (arg != null && arg["pendingId"] != null) {
        viewApplicationShow = {arg["pendingId"]: true};
      } else {
        viewApplicationShow = {"": false};
      }
    });
    Future.delayed(Duration(seconds: 1)).then((value) async {
      await PreBackendCall().pregetListTransaction().then((res) {
        if (res != null) {
          if (mounted) {
            setState(() {
              businessApplication = res;
              isLoadingData = false;
            });

            userController.hasNewTransaction.value = false;
            userController.hasNewTransaction.refresh();
          }
        }
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
        mainController.bottomNavIndex.value = 0;
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: bottomNavigationView(context),
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        elevation: 1,
        leading: Container(),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
              width: 15,
              child: Icon(
                MaterialIcons.description, 
                size: 15,
                color: ThemeColor.primaryText,
              )
            ),
            SizedBox(width: 8),
            Text(
              "${userController.getConnectivityStatus() == "Offline" ? "Offline " : ""}Transaction",
              style: TextStyle(
                  color: ThemeColor.primaryText,
                  fontSize: 14,
                  fontWeight: FontWeight.w300
                ),
              textAlign: TextAlign.center
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.upload, color: ThemeColor.primaryText),
            onPressed: () {
              popupUploadMenu(context);
            },
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          displacement: 10,
          backgroundColor: ThemeColor.primary,
          color: ThemeColor.primaryText,
          onRefresh: loadData,
          child: isLoadingData ? loadingBodyView() : bodyView()
        ),
      )
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: ConstrainedBox(
        constraints: new BoxConstraints(
          minHeight: 300,
        ),
        child: (businessApplication ?? []).isEmpty ?
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: (MediaQuery.of(context).size.height - 450) / 2
              ),
              SizedBox(
                width: 200,
                height: 200,
                child: SvgPicture.asset('assets/images/no-records.svg'),
              ),
              Text(
                "No Records Found",
                style: TextStyle(
                    color: ThemeColor.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w500
                  ),
                textAlign: TextAlign.center
              ),
              SizedBox(height: 8),
              Text(
                "When you use our services, you'll see them here.",
                style: TextStyle(
                    color: ThemeColor.disabled,
                    fontSize: 12,
                  ),
                textAlign: TextAlign.center
              )
            ],
          ),
        ) :
        Column(
          children: <Widget>[...(businessApplication ?? []).map((businessApp) =>
            GestureDetector(
              onTap: () {
                setState(() {
                  viewApplicationShow = {"": false};
                });
              },
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        width: MediaQuery.of(context).size.width,
                        height: 80,
                        decoration: BoxDecoration(
                          color: ThemeColor.primaryBg,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          border: Border.all(
                            width: .5,
                            color: ThemeColor.disabled,
                          ),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0, 1),
                              blurRadius: 4,
                              color: ThemeColor.secondary.withOpacity(0.3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container( // Transaction Status
                              width: 50,
                              height: 50,
                              decoration: new BoxDecoration(
                                color: getStatusColor(businessApp.application_status),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  getStatus(businessApp.application_status).substring(0, 1),
                                  style: TextStyle(
                                    color: ThemeColor.primaryText,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w800
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width - 100,
                              padding: EdgeInsets.fromLTRB(8, 8, 0, 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "BIN: ${businessApp.transaction_no ?? ''}", 
                                        style: TextStyle(
                                          fontSize: 14, 
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          popupMenu(context, businessApp);
                                          // setState(() {
                                          //   if (viewApplicationShow[businessApp.id] != true) {
                                          //     viewApplicationShow = {"": false};
                                          //     viewApplicationShow[businessApp.id] = true;
                                          //   } else {
                                          //     viewApplicationShow = {"": false};
                                          //   }
                                          // });
                                        },
                                        child: Container(
                                          width: 75,
                                          height: 18,
                                          decoration: new BoxDecoration(
                                            color: getStatusColor(businessApp.application_status),
                                            shape: BoxShape.rectangle,
                                            borderRadius: BorderRadius.all(Radius.circular(6))
                                          ),
                                          child: Center(
                                            child: Text(
                                              getStatus(businessApp.application_status),
                                              style: TextStyle(
                                                color: ThemeColor.primaryText,
                                                fontSize: 10,
                                                fontWeight: FontWeight.w800
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    businessApp.business_name, 
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12, 
                                      fontWeight: FontWeight.w800,
                                      color: ThemeColor.disabledText
                                    ),
                                  ),
                                  Text(
                                    businessApp.remarks ?? "", 
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 10, 
                                      color: ThemeColor.disabledText
                                    ),
                                  ),
                                  RichText(
                                    textAlign: TextAlign.left,
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "You are marked as ",
                                          style: TextStyle(
                                            color: ThemeColor.secondary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        TextSpan(
                                          text: businessApp.application_status,
                                          style: TextStyle(
                                            color: ThemeColor.warning,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      viewApplicationShow[businessApp.id] == true ?
                      Positioned(
                        top: 30,
                        right: 8,
                        child: InkWell(
                          onTap: () {
                            viewApplication(businessApp);
                          },
                          child: Container(
                            width: 90,
                            height: 18,
                            decoration: new BoxDecoration(
                              color: ThemeColor.primaryBg,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.all(Radius.circular(6)),
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2,
                                  color: ThemeColor.disabled,
                                  offset: Offset(1,1)
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                "View Application",
                                style: TextStyle(
                                  color: ThemeColor.disabledText,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800
                                ),
                              ),
                            ),
                          ),
                        ),
                      ) : Container(),
                    ],
                  ),
                  SizedBox(height: 8),
                ],
              ),
            )
          ).toList()]
        ),
      ),
    );
  }

  Widget loadingBodyView() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.all(16),
      child: Shimmer.fromColors(
        baseColor: Color(0xffEFEFF4),
        highlightColor: Colors.white,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffEFEFF4),
          ),
        ),
      ),
    );
  }
  
  String getStatus(String status) {
    switch (status) {
      case "Recorded":
        return "Recorded";
        break;
      case "Waiting List":
        return "Wait List";
        break;
      case "Pending Application":
        return "Pending";
        break;
      case "For Verification":
        return "Verification";
        break;
      case "For Endorsement":
        return "Endorsement";
        break;
      case "For Payment":
        return "Payment";
        break;
      case "Paid":
        return "Paid";
        break;
      case "For Approval":
        return "Approval";
        break;
      case "For Issuance":
        return "Issuance";
        break;
      case "License Issued":
        return "Issued";
        break;
      case "License Declined":
        return "Declined";
        break;
      case "Cancel Application":
        return "Cancelled";
        break;
      default:
        return "";
        break;
    }
  }

  Color getStatusColor(String status) {
    switch (status) {
      case "Recorded":
        return ThemeColor.warning;
        break;
      case "Waiting List":
        return ThemeColor.warning;
        break;
      case "Pending Application":
        return Colors.amber;
        break;
      case "For Verification":
        return ThemeColor.primary;
        break;
      case "For Endorsement":
        return ThemeColor.primary;
        break;
      case "For Payment":
        return ThemeColor.primary;
        break;
      case "Paid":
        return ThemeColor.primary;
        break;
      case "For Approval":
        return ThemeColor.primary;
        break;
      case "For Issuance":
        return ThemeColor.primary;
        break;
      case "License Issued":
        return ThemeColor.primary;
        break;
      case "License Declined":
        return ThemeColor.primary;
        break;
      case "Cancel Application":
        return ThemeColor.primary;
        break;
      default:
        return ThemeColor.primary;
        break;
    }
  }

  Future<String> popupMenu(BuildContext context, BusinessApplication businessApp) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        title: Container(
          padding: EdgeInsets.all(8),
          decoration: new BoxDecoration(
            color: ThemeColor.primary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: ThemeColor.disabled,
                offset: Offset(1,1)
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "BIN: ${businessApp.transaction_no}", 
                style: TextStyle(
                  fontSize: 10, 
                  fontWeight: FontWeight.w800
                ),
              ),
              SizedBox(height: 4),
              Text(
                businessApp.business_name, 
                style: TextStyle(
                  fontSize: 14, 
                  fontWeight: FontWeight.w800
                ),
              ),
            ],
          ),
        ),
        content: SizedBox(
          width: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      viewApplication(businessApp);
                    },
                    child: Container(
                      width: 115,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: ThemeColor.primaryBg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: ThemeColor.disabled,
                            offset: Offset(1,1)
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialIcons.description, size: 50, color: ThemeColor.primary),
                            SizedBox(width: 8),
                            Text(
                              "View Assessment",
                              style: TextStyle(
                                color: ThemeColor.disabledText,
                                fontSize: 10,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      if (userController.getAttachmentStatus() == "Allowed") {
                        Navigator.pop(context);
                        addImage(businessApp);
                      }
                    },
                    child: Container(
                      width: 115,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: ThemeColor.primaryBg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: ThemeColor.disabled,
                            offset: Offset(1,1)
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialIcons.image, size: 50, color: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled),
                            SizedBox(width: 8),
                            Text(
                              "Add/View Image",
                              style: TextStyle(
                                color: ThemeColor.disabledText,
                                fontSize: 10,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      addFindings(businessApp);
                    },
                    child: Container(
                      width: 115,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: ThemeColor.primaryBg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: ThemeColor.disabled,
                            offset: Offset(1,1)
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialIcons.view_list, size: 50, color: ThemeColor.primary),
                            SizedBox(width: 8),
                            Text(
                              "Add Findings",
                              style: TextStyle(
                                color: ThemeColor.disabledText,
                                fontSize: 10,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      addNoticeToComply(businessApp);
                    },
                    child: Container(
                      width: 115,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: ThemeColor.primaryBg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: ThemeColor.disabled,
                            offset: Offset(1,1)
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialIcons.error_outline, size: 50, color: ThemeColor.primary),
                            SizedBox(width: 8),
                            Text(
                              "Notice to Comply",
                              style: TextStyle(
                                color: ThemeColor.disabledText,
                                fontSize: 10,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      addRemarks(businessApp);
                    },
                    child: Container(
                      width: 115,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: ThemeColor.primaryBg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: ThemeColor.disabled,
                            offset: Offset(1,1)
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialIcons.assignment, size: 50, color: ThemeColor.primary),
                            SizedBox(width: 8),
                            Text(
                              "Add Remarks",
                              style: TextStyle(
                                color: ThemeColor.disabledText,
                                fontSize: 10,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      addCoordinates(businessApp);
                    },
                    child: Container(
                      width: 115,
                      height: 80,
                      decoration: new BoxDecoration(
                        color: ThemeColor.primaryBg,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 2,
                            color: ThemeColor.disabled,
                            offset: Offset(1,1)
                          ),
                        ],
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(MaterialIcons.pin_drop, size: 50, color: ThemeColor.primary),
                            SizedBox(width: 8),
                            Text(
                              "Add Coordinates",
                              style: TextStyle(
                                color: ThemeColor.disabledText,
                                fontSize: 10,
                                fontWeight: FontWeight.w800
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: new BoxDecoration(
                    color: ThemeColor.warning,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: ThemeColor.disabled,
                        offset: Offset(1,1)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MaterialIcons.cancel, size: 20, color: ThemeColor.primaryText),
                        SizedBox(width: 8),
                        Text(
                          "Close",
                          style: TextStyle(
                            color: ThemeColor.primaryText,
                            fontSize: 10,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[],
      ),
    );
  }
  
  Future<String> popupUploadMenu(BuildContext context) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        actionsPadding: EdgeInsets.all(0),
        titlePadding: EdgeInsets.all(0),
        contentPadding: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16))
        ),
        title: Container(
          padding: EdgeInsets.all(12),
          decoration: new BoxDecoration(
            color: ThemeColor.primary,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            boxShadow: [
              BoxShadow(
                blurRadius: 2,
                color: ThemeColor.disabled,
                offset: Offset(1,1)
              ),
            ],
          ),
          child: Text(
            "Offline Transaction", 
            style: TextStyle(
              fontSize: 12, 
              fontWeight: FontWeight.w800
            ),
          ),
        ),
        content: SizedBox(
          width: 160,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (businessApplication.isEmpty) {
                    popupDialog(context, NotifHeader.information, "No Offline Records found.");
                  } else {
                    popupDialogYesNo(context, "Upload Offline Records", "Are you sure do you want to upload offline records?", additionalHeader: "Warning!", additionalMessage: "Uploading offline records will remove the data from your device and will just be available when you're online.").then((value) {
                      if (value == "Yes") {
                        networkConnectionController.checkConnectionStatus().then((connResult) async {
                          if (connResult) {
                            EasyLoading.show();
                            await Future.forEach(businessApplication, (businessApp) async {
                              await saveBusinessApplication(businessApp);
                            }).then((value) {
                              setState(() {
                                businessApplication = [];
                              });
                              LocalDB().deleteAllBusinessApplication();
                              EasyLoading.dismiss();
                              popupDialog(context, NotifHeader.success, "Offline Records successfully uploaded.");
                            });
                          } else {
                            popupDialog(context, NotifHeader.error, "Please check your internet connection.");
                            return;
                          }
                        });
                      }
                    });
                  }
                },
                child: Container(
                  width: 150,
                  height: 80,
                  decoration: new BoxDecoration(
                    color: businessApplication.isNotEmpty ? ThemeColor.primaryBg : ThemeColor.disabled,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: ThemeColor.disabled,
                        offset: Offset(1,1)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MaterialIcons.cloud_upload, size: 50, color: businessApplication.isNotEmpty ? ThemeColor.primary : ThemeColor.disabledText),
                        SizedBox(width: 8),
                        Text(
                          "Upload Offline Records",
                          style: TextStyle(
                            color: ThemeColor.disabledText,
                            fontSize: 10,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 30,
                  decoration: new BoxDecoration(
                    color: ThemeColor.warning,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.all(Radius.circular(6)),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2,
                        color: ThemeColor.disabled,
                        offset: Offset(1,1)
                      ),
                    ],
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(MaterialIcons.cancel, size: 20, color: ThemeColor.primaryText),
                        SizedBox(width: 8),
                        Text(
                          "Close",
                          style: TextStyle(
                            color: ThemeColor.primaryText,
                            fontSize: 10,
                            fontWeight: FontWeight.w800
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: <Widget>[],
      ),
    );
  }

  Future<String> popupFindings(BuildContext context, BusinessApplication businessApp) {
    final _remarksController = TextEditingController();

    List<BusinessFindingsModel> tempFindings = [];
    (businessApp.business_findings ?? []).forEach((f) {
      tempFindings.add(f);
    });

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
                  Text('Findings', style: TextStyle(fontWeight: FontWeight.w800, color: ThemeColor.primaryText, fontSize: 14)),
                ],
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BIN: ${businessApp.transaction_no}", 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Text(
                        businessApp.business_name, 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      color: ThemeColor.primaryBg,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: .5,
                        color: ThemeColor.disabled,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          color: ThemeColor.secondary.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextField(
                            controller: _remarksController,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_remarksController.text == "") return;
                            setState(() {
                              tempFindings.add(new BusinessFindingsModel(
                                id: "",
                                remarks: _remarksController.text,
                              ));
                              _remarksController.text = "";
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 80,
                            decoration: new BoxDecoration(
                              color: ThemeColor.primary,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              )
                            ),
                            child: Center(
                              child: Icon(
                                MaterialIcons.add,
                                color: ThemeColor.primaryText,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[...(tempFindings ?? []).map((ba) =>
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: ThemeColor.primaryBg,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                    width: .5,
                                    color: ThemeColor.disabled,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 4,
                                      color: ThemeColor.secondary.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width - 150,
                                      child: Text(
                                        ba.remarks,
                                        style: TextStyle(
                                          fontSize: 11, 
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          tempFindings.remove(ba);
                                        });
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 80,
                                        decoration: new BoxDecoration(
                                          color: ThemeColor.warning,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6),
                                          )
                                        ),
                                        child: Center(
                                          child: Icon(
                                            MaterialIcons.delete,
                                            color: ThemeColor.primaryText,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          )
                        ).toList()],
                      ),
                    ),
                  )
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
                        if (_remarksController.text.trim() != "") {
                          setState(() {
                            tempFindings.add(new BusinessFindingsModel(
                              id: "",
                              remarks: _remarksController.text,
                            ));
                            _remarksController.text = "";
                          });
                        }

                        businessApp.business_findings = tempFindings;

                        if (userController.getConnectivityStatus() == "Online") {
                          EasyLoading.show();
                          
                          await updateBusinessApplication(businessApp).then((value) {
                            EasyLoading.dismiss();
                            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
                              Navigator.pop(context);
                            });
                          });
                        } else if (userController.getConnectivityStatus() == "Offline") {
                          EasyLoading.show();

                          await LocalDB().localInsertBusinessApplication(businessApp).then((value) {
                            EasyLoading.dismiss();
                            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
                              Navigator.pop(context);
                            });
                          });
                        }
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

  Future<String> popupNoticeToComply(BuildContext context, BusinessApplication businessApp) {
    final _remarksController = TextEditingController();

    List<BusinessNoticeToComplyModel> tempNoticeToComply = [];
    (businessApp.business_notice_to_comply ?? []).forEach((f) {
      tempNoticeToComply.add(f);
    });

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
                  Text('Notice To Comply', style: TextStyle(fontWeight: FontWeight.w800, color: ThemeColor.primaryText, fontSize: 14)),
                ],
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BIN: ${businessApp.transaction_no}", 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Text(
                        businessApp.business_name, 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 80,
                    decoration: BoxDecoration(
                      color: ThemeColor.primaryBg,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: .5,
                        color: ThemeColor.disabled,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          color: ThemeColor.secondary.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          width: MediaQuery.of(context).size.width - 150,
                          child: TextField(
                            controller: _remarksController,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            if (_remarksController.text == "") return;
                            setState(() {
                              tempNoticeToComply.add(new BusinessNoticeToComplyModel(
                                id: "",
                                remarks: _remarksController.text,
                              ));
                              _remarksController.text = "";
                            });
                          },
                          child: Container(
                            width: 30,
                            height: 80,
                            decoration: new BoxDecoration(
                              color: ThemeColor.primary,
                              shape: BoxShape.rectangle,
                              borderRadius: BorderRadius.only(
                                topRight: Radius.circular(6),
                                bottomRight: Radius.circular(6),
                              )
                            ),
                            child: Center(
                              child: Icon(
                                MaterialIcons.add,
                                color: ThemeColor.primaryText,
                                size: 25,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/4,
                    child: SingleChildScrollView(
                      reverse: true,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[...(tempNoticeToComply ?? []).map((ba) =>
                          Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: ThemeColor.primaryBg,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  border: Border.all(
                                    width: .5,
                                    color: ThemeColor.disabled,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 1),
                                      blurRadius: 4,
                                      color: ThemeColor.secondary.withOpacity(0.3),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(8),
                                      width: MediaQuery.of(context).size.width - 150,
                                      child: Text(
                                        ba.remarks,
                                        style: TextStyle(
                                          fontSize: 11, 
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          tempNoticeToComply.remove(ba);
                                        });
                                      },
                                      child: Container(
                                        width: 30,
                                        height: 80,
                                        decoration: new BoxDecoration(
                                          color: ThemeColor.warning,
                                          shape: BoxShape.rectangle,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(6),
                                            bottomRight: Radius.circular(6),
                                          )
                                        ),
                                        child: Center(
                                          child: Icon(
                                            MaterialIcons.delete,
                                            color: ThemeColor.primaryText,
                                            size: 25,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          )
                        ).toList()],
                      ),
                    ),
                  )
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
                        if (_remarksController.text.trim() != "") {
                          setState(() {
                            tempNoticeToComply.add(new BusinessNoticeToComplyModel(
                              id: "",
                              remarks: _remarksController.text,
                            ));
                            _remarksController.text = "";
                          });
                        }

                        businessApp.business_notice_to_comply = tempNoticeToComply;

                        if (userController.getConnectivityStatus() == "Online") {
                          EasyLoading.show();
                          
                          await updateBusinessApplication(businessApp).then((value) {
                            EasyLoading.dismiss();
                            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
                              Navigator.pop(context);
                            });
                          });
                        } else if (userController.getConnectivityStatus() == "Offline") {
                          EasyLoading.show();

                          await LocalDB().localInsertBusinessApplication(businessApp).then((value) {
                            EasyLoading.dismiss();
                            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
                              Navigator.pop(context);
                            });
                          });
                        }
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

  Future<String> popupRemarks(BuildContext context, BusinessApplication businessApp) {
    final _remarksController = TextEditingController();

    _remarksController.text = businessApp.business_remarks?.remarks ?? "";

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
                  Text('Remarks', style: TextStyle(fontWeight: FontWeight.w800, color: ThemeColor.primaryText, fontSize: 14)),
                ],
              ),
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BIN: ${businessApp.transaction_no}", 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w800
                        ),
                      ),
                      Text(
                        businessApp.business_name, 
                        style: TextStyle(
                          fontSize: 12, 
                          fontWeight: FontWeight.w800
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 120,
                    decoration: BoxDecoration(
                      color: ThemeColor.primaryBg,
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      border: Border.all(
                        width: .5,
                        color: ThemeColor.disabled,
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 1),
                          blurRadius: 4,
                          color: ThemeColor.secondary.withOpacity(0.3),
                        ),
                      ],
                    ),
                    child: Container(
                      padding: EdgeInsets.all(8),
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _remarksController,
                        style: TextStyle(fontSize: 11),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
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
                        businessApp.business_remarks = new BusinessRemarksModel(
                          id: "",
                          remarks: _remarksController.text,
                        );

                        if (userController.getConnectivityStatus() == "Online") {
                          EasyLoading.show();
                          
                          await updateBusinessApplication(businessApp).then((value) {
                            EasyLoading.dismiss();
                            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
                              Navigator.pop(context);
                            });
                          });
                        } else if (userController.getConnectivityStatus() == "Offline") {
                          EasyLoading.show();

                          await LocalDB().localInsertBusinessApplication(businessApp).then((value) {
                            EasyLoading.dismiss();
                            popupDialog(context, NotifHeader.success, "Successfully Saved!").then((value) {
                              Navigator.pop(context);
                            });
                          });
                        }
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

  viewApplication(BusinessApplication businessApp) async {
    userController.applicationType.value = businessApp.application_type;
    userController.activeBusinessApplication.value = BusinessApplication.fromJson(businessApp.toJson());
    userController.selectedBusinessApplication.value = businessApp;
    Get.toNamed(PageRoutes.BusinessPermitApplication).then((value) {
      if (value != null) {
        loadData();
      }
    });
  }

  addImage(BusinessApplication businessApp) {
    // To Do: remove Images that are deleted in this line
    if (userController.getConnectivityStatus() == "Online") {
      attachFileDialog(context).then((value) async {
        if (value) {
          EasyLoading.show();

          List<FileAttachment> fileAttachments = fileController.listFileAttachment.value.fileAttachments ?? [];
          if (fileAttachments.isNotEmpty) {
            fileController.listFileAttachment.value.fileAttachments.removeWhere((e) => e.type == AttachmentType.businessImage);
          }
          FileAttachment _file = FileAttachment("", AttachmentType.businessImage, fileController.fileListTemp.value.fileList, []);
          fileAttachments.add(_file);
          fileController.listFileAttachment.value.fileAttachments = fileAttachments;
          fileController.listFileAttachment.refresh();
          fileController.fileListTemp.value.fileList = [];

          String fileName = "Business/Attachment/${userController.getId()}/BusinessRequirement/${DateTime.now().millisecondsSinceEpoch.toString()}";
          
          for (var e in (fileController.listFileAttachment?.value?.fileAttachments ?? [])) {
            if (e.files.isNotEmpty) {
              await fileController.uploadFile(e.files, fileName).then((_imageUrls) async {
                if (_imageUrls.isNotEmpty) {
                  e.url = _imageUrls;
                } else {
                  e.url = [];
                }
              });
            }
          }

          List<AttachmentModel> _attachments = [];
          for (var e in (fileController.listFileAttachment?.value?.fileAttachments ?? [])) {
            if (e.url.isNotEmpty) {
              for (var u in e.url) {
                AttachmentModel _att = AttachmentModel(
                  "",
                  u.split(".").last,
                  u.split("/").last,
                  e.type,
                  u,
                  "",
                  "",
                  null
                );
                _attachments.add(_att);
              }
            }
          }

          businessApp.attachment.addAll(_attachments);

          await updateBusinessApplication(businessApp).then((value) {
            EasyLoading.dismiss();
            popupDialog(context, NotifHeader.success, "Image uploaded successfully!").then((value) {
              fileController.listFileAttachment.value.fileAttachments = [];
            });
          });
        }
      });
    } else if (userController.getConnectivityStatus() == "Offline") {
      popupDialog(context, NotifHeader.information, "Unable to attach image while the status is offline!");
    }
  }
  
  addFindings(BusinessApplication businessApp) {
    popupFindings(context, businessApp);
  }
  
  addNoticeToComply(BusinessApplication businessApp) {
    popupNoticeToComply(context, businessApp);
  }
  
  addRemarks(BusinessApplication businessApp) {
    popupRemarks(context, businessApp);
  }

  addCoordinates(BusinessApplication businessApp) {
    userController.activeBusinessApplication.value = BusinessApplication.fromJson(businessApp.toJson());
    Get.toNamed(PageRoutes.GoogleMap).then((value) {
    });
  }
}
