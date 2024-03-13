// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/local_db.dart';
import 'package:lgu_bplo/utils/page_routes.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:shimmer/shimmer.dart';

class TransactionsView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const TransactionsView();
  @override
  TransactionsViewState createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
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
    Future.delayed(Duration(seconds: 2)).then((value) async {
      await getListTransactions().then((res) {
        List<BusinessApplication> businessApplicationTemp = [];
        if (res != null) {
          res.forEach((p) {
            businessApplicationTemp.add(BusinessApplication.fromJson(p));
          });
        }
        if (mounted) {
          setState(() {
            businessApplication = businessApplicationTemp;
            isLoadingData = false;
          });

          userController.hasNewTransaction.value = false;
          userController.hasNewTransaction.refresh();
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
        title: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 0, 50, 0),
            child: Row(
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
                  "Transaction",
                  style: TextStyle(
                      color: ThemeColor.primaryText,
                      fontSize: 14,
                      fontWeight: FontWeight.w300
                    ),
                  textAlign: TextAlign.center
                ),
              ],
            )
          )
        ),
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
                                        "BIN: ${businessApp.transaction_no}", 
                                        style: TextStyle(
                                          fontSize: 14, 
                                          fontWeight: FontWeight.w800
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            if (viewApplicationShow[businessApp.id] != true) {
                                              viewApplicationShow = {"": false};
                                              viewApplicationShow[businessApp.id] = true;
                                            } else {
                                              viewApplicationShow = {"": false};
                                            }
                                          });
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

  viewApplication(BusinessApplication businessApp) async {
    return await LocalDB().localBusinessApplication(baId: businessApp.id).then((data) async {
      if (data.isNotEmpty) {
        popupDialogYesNo(context, "Draft Application", "You have a draft application saved. Do you want to load it?", additionalHeader: "Warning!", additionalMessage: "Pressing 'No' will remove draft application.").then((value) {
          if (value == "Yes") {
            userController.applicationType.value = data[0].application_type;
            userController.activeBusinessApplication.value = data[0];
            userController.selectedBusinessApplication.value = data[0];
            Get.toNamed(PageRoutes.BusinessPermitApplication);
          } else if (value == "No") {
            LocalDB().deleteBusinessApplication(data[0]);
            userController.applicationType.value = businessApp.application_type;
            userController.activeBusinessApplication.value = BusinessApplication.fromJson(businessApp.toJson());
            userController.selectedBusinessApplication.value = businessApp;
            fileController.listFileAttachment.value.fileAttachments.removeWhere((_f) => _f.applicationId == businessApp.id);
            Get.toNamed(PageRoutes.BusinessPermitApplication);
          }
        });
      } else {
        userController.applicationType.value = businessApp.application_type;
        userController.activeBusinessApplication.value = BusinessApplication.fromJson(businessApp.toJson());
        userController.selectedBusinessApplication.value = businessApp;
        Get.toNamed(PageRoutes.BusinessPermitApplication);
      }
    });
  }

}
