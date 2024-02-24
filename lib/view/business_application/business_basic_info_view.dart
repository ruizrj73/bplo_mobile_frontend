// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/attachment_type.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

// #region Declaration

final businessName = TextEditingController();
final businessTinNo = TextEditingController();
String selectedAppTypeOption = "New";
String paymentMode = "";
String taxYear = DateTime.now().year.toString();
String orgType = "";

// #endregion

class BusinessBasicInfoView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessBasicInfoView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessBasicInfoViewState createState() => BusinessBasicInfoViewState();

  static Future<String> businessBasicInfoEntry() async { 
    return BusinessBasicInfoViewState().businessBasicInfoEntry();
  }
}

class BusinessBasicInfoViewState extends State<BusinessBasicInfoView> {
  List<String> _paymentModeSelection = [];
  List<String> _orgTypeSelection = [];
  List<String> _taxYearSelection = [DateTime.now().year.toString(), (DateTime.now().year + 1).toString()];
  BusinessApplication _businessApplication = userController.activeBusinessApplication.value;
  
  @override
  void initState() {
    super.initState(); 

    setState(() {
      switch (userController.applicationType.value) {
        case "New":
          selectedAppTypeOption = "New";
          break;
        case "Renew":
          selectedAppTypeOption = "Renew";
          break;
        default:
          selectedAppTypeOption = "New";
          break;
      }
      
      for (var pmode in mainController.listPaymentMode) {
        _paymentModeSelection.add(pmode.payment_type);
      }
      for (var btype in mainController.listBusinessType) {
        _orgTypeSelection.add(btype.organization_type);
      }
    });

    setValues();
  }

  setValues() {
    setState(() {
      selectedAppTypeOption = _businessApplication.application_type ?? "New";
      taxYear = _businessApplication.tax_year ?? DateTime.now().year.toString();
      paymentMode = _businessApplication.payment_type ?? mainController.listPaymentMode[0].payment_type;
      orgType = _businessApplication.organization_type ?? mainController.listBusinessType[0].organization_type;
      businessName.text = _businessApplication.business_name ?? "";
      businessTinNo.text = _businessApplication.tin_no ?? "";
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
        return;
      },
    );
  }

  Widget buildPage() {
    return Container(
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width,
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
          Text("Type of Application :", style: TextStyle(fontSize: 12)),
          SizedBox(height: 4),
          Row(
            children: [
              SizedBox(
                height: 30,
                width: 30,
                child: Radio(
                  value: "New",
                  groupValue: selectedAppTypeOption,
                  onChanged: (value) {
                    setState(() {
                      selectedAppTypeOption = value;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedAppTypeOption = "New";
                  });
                },
                child: Text("New", style: TextStyle(fontSize: 12)),
              ),
              SizedBox(width: 16),
              SizedBox(
                height: 30,
                width: 30,
                child: Radio(
                  value: "Renew",
                  groupValue: selectedAppTypeOption,
                  onChanged: (value) {
                    setState(() {
                      selectedAppTypeOption = value;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectedAppTypeOption = "Renew";
                  });
                },
                child: Text("Renew", style: TextStyle(fontSize: 12)),
              ),
            ],
          ),
          SizedBox(height: 8),
          InputControls.selectionFieldInput(
            context, paymentMode,
            ((val) {
              setState(() {
                paymentMode = val;
              });
            }),
            _paymentModeSelection, title: "Mode of Payment"
          ),
          SizedBox(height: 8),
          InputControls.selectionFieldInput(
            context, taxYear,
            ((val) {
              setState(() {
                taxYear = val;
              });
            }),
            _taxYearSelection, title: "Tax Year"
          ),
          SizedBox(height: 8),
          InputControls.selectionFieldInput(
            context, orgType,
            ((val) {
              setState(() {
                orgType = val;
              });
            }),
            _orgTypeSelection, title: "Type of Organization"
          ),
          SizedBox(height: 8),
          InputControls.textFieldInput(context, businessName, title: "Business Name"),
          SizedBox(height: 8),
          InputControls.textFieldInput(context, businessTinNo, title: "TIN Number"),
          SizedBox(height: 8),
          Text("Application Requirements :", style: TextStyle(fontSize: 12)),
          SizedBox(height: 8),
          SizedBox(
            height: 23,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => SizedBox(
                      width: 30,
                      height: 30,
                      child: Checkbox(
                        value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.dtiSecCda && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.dtiSecCda).isNotEmpty,
                        onChanged: (bool value) {
                        },
                      )
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 190,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(AttachmentType.dtiSecCda, style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: userController.activeBusinessApplication.value.id == null ? ThemeColor.primary : ThemeColor.disabled,
                    fixedSize: Size(80, 30),
                    foregroundColor: ThemeColor.primaryText,
                    shadowColor: Colors.black
                  ),
                  onPressed: () {
                    if (userController.activeBusinessApplication.value.id == null) {
                      attachFile(AttachmentType.dtiSecCda);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Attach', style: TextStyle(fontSize: 10)),
                      SizedBox(width: 4),
                      Icon(Feather.file, size: 15),
                    ],
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 23,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => SizedBox(
                      width: 30,
                      height: 30,
                      child: Checkbox(
                        value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.brgyClearance && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.brgyClearance).isNotEmpty,
                        onChanged: (bool value) {
                        },
                      )
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 190,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(AttachmentType.brgyClearance, style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: userController.activeBusinessApplication.value.id == null ? ThemeColor.primary : ThemeColor.disabled,
                    fixedSize: Size(80, 30),
                    foregroundColor: ThemeColor.primaryText,
                    shadowColor: Colors.black
                  ),
                  onPressed: () {
                    if (userController.activeBusinessApplication.value.id == null) {
                      attachFile(AttachmentType.brgyClearance);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Attach', style: TextStyle(fontSize: 10)),
                      SizedBox(width: 4),
                      Icon(Feather.file, size: 15),
                    ],
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 8),
          SizedBox(
            height: 23,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(() => SizedBox(
                      width: 30,
                      height: 30,
                      child: Checkbox(
                        value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.ctc && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.ctc).isNotEmpty,
                        onChanged: (bool value) {
                        },
                      )
                    )),
                    SizedBox(
                      width: MediaQuery.of(context).size.width - 190,
                      child: FittedBox(
                        alignment: Alignment.centerLeft,
                        fit: BoxFit.scaleDown,
                        child: Text(AttachmentType.ctc, style: TextStyle(fontSize: 11)),
                      ),
                    ),
                    SizedBox(width: 8),
                  ],
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: userController.activeBusinessApplication.value.id == null ? ThemeColor.primary : ThemeColor.disabled,
                    fixedSize: Size(80, 30),
                    foregroundColor: ThemeColor.primaryText,
                    shadowColor: Colors.black
                  ),
                  onPressed: () {
                    if (userController.activeBusinessApplication.value.id == null) {
                      attachFile(AttachmentType.ctc);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Attach', style: TextStyle(fontSize: 10)),
                      SizedBox(width: 4),
                      Icon(Feather.file, size: 15),
                    ],
                  )
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  businessBasicInfoEntry() {
    _businessApplication.application_type = selectedAppTypeOption;
    _businessApplication.payment_type = paymentMode;
    _businessApplication.tax_year = taxYear;
    _businessApplication.organization_type = orgType;
    _businessApplication.tin_no = businessTinNo.text;
    _businessApplication.business_name = businessName.text;
  }

  attachFile(String fileType) {
    attachFileDialog(context, attachType: fileType).then((value) {
      if (value) {
        List<FileAttachment> fileAttachments = fileController.listFileAttachment.value.fileAttachments ?? [];
        if (fileAttachments.isNotEmpty) {
          fileController.listFileAttachment.value.fileAttachments.removeWhere((e) => e.type == fileType);
        }
        FileAttachment _file = FileAttachment("", fileType, fileController.fileListTemp.value.fileList, []);
        fileAttachments.add(_file);
        fileController.listFileAttachment.value.fileAttachments = fileAttachments;
        fileController.listFileAttachment.refresh();
        fileController.fileListTemp.value.fileList = [];
      }
    });
  }
}
