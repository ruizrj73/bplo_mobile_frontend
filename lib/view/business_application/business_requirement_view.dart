// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/attachment_type.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';
import 'package:lgu_bplo/view/business_application/line_of_business_dialog.dart';
import 'package:lgu_bplo/view/business_application/measure_pax_dialog.dart';

String selectedAppTypeOption = "New";
List<LineOfBusinessModel> lineOfBusiness;
List<MeasurePaxModel> measurePax;

class BusinessRequirementView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessRequirementView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessRequirementViewState createState() => BusinessRequirementViewState();

  static Future<String> businessRequirementEntry() async { 
    return BusinessRequirementViewState().businessRequirementEntry();
  }
}

class BusinessRequirementViewState extends State<BusinessRequirementView> {
  var numericFormatter = NumberFormat('#,###,##0');
  var currencyFormatter = NumberFormat('#,###,##0.00');
  final BusinessApplication _businessApplication = userController.activeBusinessApplication.value;
  
  @override
  void initState() {
    super.initState(); 

    setState(() {
      if (_businessApplication.line_of_business != null) {
        lineOfBusiness = _businessApplication.line_of_business;
      } else {
        lineOfBusiness = [];
      }
      
      if (_businessApplication.line_of_business_measure_pax != null) {
        measurePax = _businessApplication.line_of_business_measure_pax;
      } else {
        measurePax = [];
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
        return;
      },
    );
  }

  Widget buildPage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Line of Business", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
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
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: ThemeColor.primary,
                  minimumSize: Size(MediaQuery.of(context).size.width, 25),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  LineOfBusinessDialog().lineOfBusinessShowDialog(context, null).then((value) {
                    setState(() {
                      if (value != null) {
                        lineOfBusiness.add(value);
                      }
                    });
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MaterialIcons.add_circle, size: 15),
                    SizedBox(width: 4),
                    Text('Add Line of Business', style: TextStyle(fontSize: 12)),
                    SizedBox(width: 4),
                    Text('(Refer to BIR Registration)', style: TextStyle(fontSize: 10)),
                  ],
                )
              ),
              Column(
                children: <Widget>[...(lineOfBusiness ?? []).map((_lineOfBusiness) =>
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ThemeColor.primaryLighter,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Code: ${_lineOfBusiness.code}', style: TextStyle(fontSize: 14, color: ThemeColor.warning)),
                                SizedBox(height: 4),
                                Text('Description:', style: TextStyle(fontSize: 12, color: ThemeColor.success)),
                                SizedBox(height: 4),
                                Text(_lineOfBusiness.line_of_business, style: TextStyle(fontSize: 12, color: ThemeColor.success)),
                                Row(
                                  children: [
                                    Text('Type:', style: TextStyle(fontSize: 10, color: ThemeColor.success, fontWeight: FontWeight.w800)),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Radio(
                                        value: "New",
                                        groupValue: _lineOfBusiness.application_type,
                                        onChanged: (value) {
                                          setState(() {
                                            _lineOfBusiness.application_type = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Text("New", style: TextStyle(fontSize: 10, color: ThemeColor.disabledText)),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Radio(
                                        value: "Renew",
                                        groupValue: _lineOfBusiness.application_type,
                                        onChanged: (value) {
                                          setState(() {
                                            _lineOfBusiness.application_type = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Text("Renew", style: TextStyle(fontSize: 10, color: ThemeColor.disabledText)),
                                    SizedBox(width: 8),
                                    SizedBox(
                                      height: 25,
                                      width: 25,
                                      child: Radio(
                                        value: "None",
                                        groupValue: _lineOfBusiness.application_type,
                                        onChanged: (value) {
                                          setState(() {
                                            _lineOfBusiness.application_type = value;
                                          });
                                        },
                                      ),
                                    ),
                                    Text("None", style: TextStyle(fontSize: 10, color: ThemeColor.disabledText)),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text('Units: ${_lineOfBusiness.units}', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                                SizedBox(height: 4),
                                Text('Capital Investment: PHP ${currencyFormatter.format(_lineOfBusiness.capital_investment)}', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                                SizedBox(height: 4),
                                Text('Gross Essential: PHP ${currencyFormatter.format(_lineOfBusiness.gross_essential)}', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                                SizedBox(height: 4),
                                Text('Gross Non-Essential: PHP ${currencyFormatter.format(_lineOfBusiness.gross_non_essential)}', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                              ],
                            )
                          ),
                        ],
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                LineOfBusinessDialog().lineOfBusinessShowDialog(context, _lineOfBusiness).then((value) {
                                  setState(() {
                                    if (value != null) {
                                      lineOfBusiness.remove(_lineOfBusiness);
                                      lineOfBusiness.add(value);
                                    }
                                  });
                                });
                              }),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: ThemeColor.primaryNavbarBg,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)
                                  ),
                                ),
                                child: Icon(Icons.edit, size: 16, color: ThemeColor.primaryText),
                              ),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: (() {
                                setState(() {
                                  lineOfBusiness.remove(_lineOfBusiness);
                                });
                              }),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: ThemeColor.warning,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)
                                  ),
                                ),
                                child: Icon(Icons.delete, size: 16, color: ThemeColor.primaryText),
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  )
                ).toList()]
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text("Measure and PAX", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(8),
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
              TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  backgroundColor: ThemeColor.primary,
                  minimumSize: Size(MediaQuery.of(context).size.width, 25),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  MeasurePaxDialog().measurePaxShowDialog(context, null, lineOfBusiness).then((value) {
                    setState(() {
                      if (value != null) {
                        measurePax.add(value);
                      }
                    });
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(MaterialIcons.add_circle, size: 15),
                    SizedBox(width: 4),
                    Text('Add Measure & Pax', style: TextStyle(fontSize: 12)),
                  ],
                )
              ),
              Column(
                children: <Widget>[...(_businessApplication.line_of_business_measure_pax ?? []).map((_measurePax) =>
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: ThemeColor.primaryLighter,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(10)
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Line of Business:', style: TextStyle(fontSize: 12, color: ThemeColor.warning)),
                                SizedBox(height: 4),
                                Text(_measurePax.line_of_business, style: TextStyle(fontSize: 12, color: ThemeColor.warning)),
                                SizedBox(height: 4),
                                Text('Description:', style: TextStyle(fontSize: 12, color: ThemeColor.warning)),
                                SizedBox(height: 4),
                                Text(_measurePax.measure_description, style: TextStyle(fontSize: 12, color: ThemeColor.warning)),
                                SizedBox(height: 4),
                                Text('Number of Unit: ${_measurePax.number_of_units}', style: TextStyle(fontSize: 10, color: ThemeColor.success)),
                                SizedBox(height: 4),
                                Text('Capacity: ${_measurePax.capacity}', style: TextStyle(fontSize: 10, color: ThemeColor.success)),
                              ],
                            )
                          ),
                        ],
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        child: Row(
                          children: [
                            InkWell(
                              onTap: (() {
                                MeasurePaxDialog().measurePaxShowDialog(context, _measurePax, lineOfBusiness).then((value) {
                                  setState(() {
                                    if (value != null) {
                                      _businessApplication.line_of_business_measure_pax.remove(_measurePax);
                                      _businessApplication.line_of_business_measure_pax.add(value);
                                    }
                                  });
                                });
                              }),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: ThemeColor.primaryNavbarBg,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)
                                  ),
                                ),
                                child: Icon(Icons.edit, size: 16, color: ThemeColor.primaryText),
                              ),
                            ),
                            SizedBox(width: 8),
                            InkWell(
                              onTap: (() {
                                setState(() {
                                  _businessApplication.line_of_business_measure_pax.remove(_measurePax);
                                });
                              }),
                              child: Container(
                                width: 28,
                                height: 28,
                                decoration: BoxDecoration(
                                  color: ThemeColor.warning,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(5)
                                  ),
                                ),
                                child: Icon(Icons.delete, size: 16, color: ThemeColor.primaryText),
                              ),
                            ),
                          ],
                        )
                      ),
                    ],
                  )
                ).toList()]
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text("Documentary Requirements", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq1 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq1).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq1, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq1);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq2 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq2).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq2, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq2);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq3 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq3).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq3, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq3);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq4 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq4).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq4, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq4);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq5 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq5).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq5, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq5);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq6 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq6).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq6, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq6);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq7 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq7).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq7, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq7);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq8 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq8).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq8, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq8);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq9 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq9).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq9, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq9);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq10 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq10).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq10, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq10);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq11 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq11).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq11, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq11);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq12 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq12).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq12, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq12);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq13 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq13).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq13, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq13);
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == AttachmentType.docReq14 && e.files.isNotEmpty) != null ||
                              (userController.activeBusinessApplication.value.attachment ?? []).where((att) => att.file_description == AttachmentType.docReq14).isNotEmpty,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text(AttachmentType.docReq14, softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: userController.getAttachmentStatus() == "Allowed" ? ThemeColor.primary : ThemeColor.disabled,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  if (userController.getAttachmentStatus() == "Allowed") {
                    attachFile(AttachmentType.docReq14);
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
    );
  }

  attachFile(String fileType) {
    attachFileDialog(context, attachType: fileType).then((value) {
      if (value) {
        List<FileAttachment> fileAttachments = fileController.listFileAttachment.value.fileAttachments ?? [];
        if (fileAttachments.isNotEmpty) {
          fileController.listFileAttachment.value.fileAttachments.removeWhere((e) => e.type == fileType);
        }
        FileAttachment _file = FileAttachment(userController.activeBusinessApplication.value.id, fileType, fileController.fileListTemp.value.fileList, []);
        fileAttachments.add(_file);
        fileController.listFileAttachment.value.fileAttachments = fileAttachments;
        fileController.listFileAttachment.refresh();
        fileController.fileListTemp.value.fileList = [];
      }
    });
  }

  businessRequirementEntry() {
    _businessApplication.line_of_business = lineOfBusiness ?? [];
    _businessApplication.line_of_business_measure_pax = measurePax ?? [];
    List<FileAttachment> fileAttachments = fileController.listFileAttachment.value.fileAttachments ?? [];
    if (fileAttachments.isNotEmpty) {
      fileAttachments.forEach((_att) {
        _att.files.forEach((f) {
          f.readAsBytes().then((value) {
            AttachmentModel _atx = AttachmentModel(
              "",
              f.name.split(".").last,
              f.name,
              _att.type,
              f.path,
              "",
              "",
              value
            );
            _businessApplication.attachment.add(_atx);
          });
        });
      });
    }
  }
}
