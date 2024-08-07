// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/env.dart';
import 'package:lgu_bplo/utils/local_db.dart';
import 'package:lgu_bplo/utils/notification_header.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:lgu_bplo/view/business_application/business_address_info_view.dart';
import 'package:lgu_bplo/view/business_application/business_basic_info_view.dart';
import 'package:lgu_bplo/view/business_application/business_operation_info_view.dart';
import 'package:lgu_bplo/view/business_application/business_other_info_view.dart';
import 'package:lgu_bplo/view/business_application/business_requirement_view.dart';
import 'package:uuid/uuid.dart';

class BusinessApplicationView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BusinessApplicationView();
  @override
  BusinessApplicationViewState createState() => BusinessApplicationViewState();
}

class BusinessApplicationViewState extends State<BusinessApplicationView> {
  final MainController mainController = Get.find();
  final NetworkConnectionController networkConnectionController = Get.find();
  ScrollController scrollController = ScrollController();
  
  String _formTitle = "";
  int viewedTab = 1;

  @override
  void initState() {
    super.initState();

    setState(() {
      switch (userController.applicationType.value) {
        case "New":
          _formTitle = "New Business Permit Application";
          break;
        case "Renew":
          _formTitle = "Renew Business Permit Application";
          break;
        case "None":
          _formTitle = "No Business Permit";
          break;
        default:
          _formTitle = "New Business Permit Application";
          break;
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
        fileController.listFileAttachment.value.fileAttachments = [];
        fileController.listFileAttachment.refresh();
        Get.back();
        return;
      },
    );
  }

  Widget buildPage() {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: ThemeColor.primary,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ThemeColor.primaryText),
          onPressed: () {
            fileController.listFileAttachment.value.fileAttachments = [];
            fileController.listFileAttachment.refresh();
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.close, color: ThemeColor.primaryText),
            onPressed: () {
              fileController.listFileAttachment.value.fileAttachments = [];
              fileController.listFileAttachment.refresh();
              Get.back();
            },
          ),
        ],
        title: FittedBox(
          alignment: Alignment.centerLeft,
          fit: BoxFit.scaleDown,
          child: Text(
            _formTitle,
            style: TextStyle(
                color: ThemeColor.primaryText,
                fontSize: 14,
                fontWeight: FontWeight.w800
              ),
            textAlign: TextAlign.center
          ),
        ),
      ),
      body: bodyView()
    );
  }

  Widget bodyView() {
    return SingleChildScrollView(
      controller: scrollController,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          viewedTab == 1 ? BusinessBasicInfoView() : Container(),
          viewedTab == 2 ? BusinessOtherInfoView() : Container(),
          viewedTab == 3 ? BusinessAddressInfoView() : Container(),
          viewedTab == 4 ? BusinessOperationInfoView() : Container(),
          viewedTab == 5 ? BusinessRequirementView() : Container(),
          SizedBox(height: 32),
          viewedTab == 1 ? TextButton(
            style: TextButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              backgroundColor: userController.activeBusinessApplication.value.application_status != "Waiting List" ? ThemeColor.primary : ThemeColor.disabled,
              minimumSize: Size(MediaQuery.of(context).size.width / 1.2, 50),
              shadowColor: ThemeColor.secondary,
              elevation: 3,
            ),
            onPressed: () async {
              if (userController.activeBusinessApplication.value.id == null) {
                buttonFn("Submit");
              } else {
                if (userController.activeBusinessApplication.value.application_status != "Waiting List") {
                  buttonFn("Continue");
                }
              }
            },
            child: Text(
              userController.activeBusinessApplication.value.id == null ? "Submit" : "Continue",
              style: TextStyle(
                  color: ThemeColor.primaryText,
                  fontWeight: FontWeight.w800,
                  fontSize: 16),
            ),
          ) :
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
                  ),
                  backgroundColor: viewedTab > 2 ? ThemeColor.primary : ThemeColor.disabled,
                  minimumSize: Size(MediaQuery.of(context).size.width / 4, 50),
                  shadowColor: ThemeColor.secondary,
                  elevation: 3,
                ),
                onPressed: () async {
                  if (viewedTab > 2) {
                    buttonFn("Prev");
                  }
                },
                child: Text(
                  'Prev',
                  style: TextStyle(
                      color: ThemeColor.primaryText,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: ThemeColor.primary,
                  minimumSize: Size(MediaQuery.of(context).size.width / 3, 50),
                  shadowColor: ThemeColor.secondary,
                  elevation: 3,
                ),
                onPressed: () async {
                  buttonFn("Save & Exit");
                },
                child: Text(
                  'Save & Exit',
                  style: TextStyle(
                      color: ThemeColor.primaryText,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
              TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
                  ),
                  backgroundColor: ThemeColor.primary,
                  minimumSize: Size(MediaQuery.of(context).size.width / 4, 50),
                  shadowColor: ThemeColor.secondary,
                  elevation: 3,
                ),
                onPressed: () async {
                  if (viewedTab == 5) {
                    buttonFn("Submit");
                  } else {
                    buttonFn("Next");
                  }
                },
                child: Text(
                  viewedTab == 5 ? 'Submit' : 'Next',
                  style: TextStyle(
                      color: ThemeColor.primaryText,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  buttonFn(String _fn) {
    switch (viewedTab) {
      case 2:
        BusinessOtherInfoView.businessOtherInfoEntry();
        break;
      case 3:
        BusinessAddressInfoView.businessAddressInfoEntry();
        break;
      case 4:
        BusinessOperationInfoView.businessOperationInfoEntry();
        break;
      case 5:
        BusinessRequirementView.businessRequirementEntry();
        break;
    }
    switch (_fn) {
      case "Next":
        setState(() {
          viewedTab += 1;
          scrollController.animateTo(0,
            duration: Duration(milliseconds: 500), 
            curve: Curves.ease
          );
        });
        break;
      case "Prev":
        setState(() {
          viewedTab -= 1;
          scrollController.animateTo(0,
            duration: Duration(milliseconds: 500), 
            curve: Curves.ease
          );
        });
        break;
      case "Submit":
        if (viewedTab == 1) {
          if (userController.activeBusinessApplication.value.application_status == null) {
            BusinessBasicInfoView.businessBasicInfoEntry().then((value) {
              userController.activeBusinessApplication.value.application_status = "Recorded"; //"Waiting List";
              if (userController.getConnectivityStatus() == "Online") {
                submitPreBusinessApplication();
              } else if (userController.getConnectivityStatus() == "Offline") {
                submitPreBusinessApplicationOffline();
              }
            });
          } else {
            BusinessBasicInfoView.businessBasicInfoEntry().then((value) {
              setState(() {
                viewedTab += 1;
                scrollController.animateTo(0,
                  duration: Duration(milliseconds: 500), 
                  curve: Curves.ease
                );
              });
            });
          }
        } else if (viewedTab == 5) {
          if (userController.getConnectivityStatus() == "Online") {
            submitBusinessApplication();
          } else if (userController.getConnectivityStatus() == "Offline") {
            submitBusinessApplicationOffline();
          }
        }
        break;
      case "Save & Exit":
        if (userController.getConnectivityStatus() == "Online") {
          submitBusinessApplication();
        } else if (userController.getConnectivityStatus() == "Offline") {
          submitBusinessApplicationOffline();
        }
        break;
      case "Continue":
        setState(() {
          viewedTab += 1;
          scrollController.animateTo(0,
            duration: Duration(milliseconds: 500), 
            curve: Curves.ease
          );
        });
        break;
      default:
        break;
    }
  }

  submitPreBusinessApplication() {
    if (userController.activeBusinessApplication.value.business_name.trim() == "") {
      popupDialog(context, NotifHeader.error, "Please input Business Name.");
      return;
    }

    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();

        String fileName = "Business/Attachment/${userController.getId()}/BusinessRequirement/${DateTime.now().millisecondsSinceEpoch.toString()}";
        for (var e in (fileController.listFileAttachment.value.fileAttachments ?? [])) {
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
        for (var e in (fileController.listFileAttachment.value.fileAttachments ?? [])) {
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

        userController.activeBusinessApplication.value.attachment = _attachments;
        userController.activeBusinessApplication.value.application_type = userController.applicationType.value;
        userController.activeBusinessApplication.value.user_id = userController.getId();
        userController.activeBusinessApplication.value.user_name = userController.getFullName();
        userController.activeBusinessApplication.value.created_by = Env.projectLocation;
        userController.activeBusinessApplication.value.remarks = ""; // "Documentary  requirements, still waiting for approval.";

        await saveBusinessApplication(userController.activeBusinessApplication.value).then((value) {
          EasyLoading.dismiss();
          popupDialog(context, NotifHeader.success, "Business Survey and Assessment Sheet, Successfully Saved.").then((value) {
            fileController.listFileAttachment.value.fileAttachments = [];
            userController.activeBusinessApplication.value = BusinessApplication();
            Get.back(result: true);
          });
        });
        
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }
  
  submitPreBusinessApplicationOffline() async {
    if (userController.activeBusinessApplication.value.business_name.trim() == "") {
      popupDialog(context, NotifHeader.error, "Please input Business Name.");
      return;
    }

    EasyLoading.show();
    var uuid = Uuid();

    userController.activeBusinessApplication.value.id = uuid.v1();
    userController.activeBusinessApplication.value.attachment = [];
    userController.activeBusinessApplication.value.application_type = userController.applicationType.value;
    userController.activeBusinessApplication.value.user_id = userController.getId();
    userController.activeBusinessApplication.value.user_name = userController.getFullName();
    userController.activeBusinessApplication.value.created_by = Env.projectLocation;
    userController.activeBusinessApplication.value.remarks = ""; // "Documentary  requirements, still waiting for approval.";

    await LocalDB().localInsertBusinessApplication(userController.activeBusinessApplication.value).then((value) {
      EasyLoading.dismiss();
      popupDialog(context, NotifHeader.success, "Business Survey and Assessment Sheet, Successfully Saved.").then((value) {
        fileController.listFileAttachment.value.fileAttachments = [];
        userController.activeBusinessApplication.value = BusinessApplication();
        Get.back(result: true);
      });
    });
  }

  submitBusinessApplication() {
    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();

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

        userController.activeBusinessApplication.value.attachment = _attachments;

        await updateBusinessApplication(userController.activeBusinessApplication.value).then((value) {
          EasyLoading.dismiss();
          popupDialog(context, NotifHeader.success, "Business Survey and Assessment Sheet, Successfully Recorded").then((value) {
            fileController.listFileAttachment.value.fileAttachments = [];
            Get.back(result: true);
          });
        });
        
      } else {
        popupDialog(context, NotifHeader.error, "Please check your internet connection.");
        return;
      }
    });
  }

  submitBusinessApplicationOffline() async {
    EasyLoading.show();

    await LocalDB().localInsertBusinessApplication(userController.activeBusinessApplication.value).then((value) {
      EasyLoading.dismiss();
      popupDialog(context, NotifHeader.success, "Business Survey and Assessment Sheet, Successfully Recorded").then((value) {
        fileController.listFileAttachment.value.fileAttachments = [];
        Get.back(result: true);
      });
    });
  }
}
