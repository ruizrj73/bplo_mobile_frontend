// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/file_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/attach_file_dialog.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class BusinessRequirementView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessRequirementView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessRequirementViewState createState() => BusinessRequirementViewState();

  static Future<String> businessRequirementEntry(BusinessApplication _businessApplication) async { 
    return BusinessRequirementViewState().businessRequirementEntry(_businessApplication);
  }
}

class BusinessRequirementViewState extends State<BusinessRequirementView> {
  String selectedAppTypeOption = "New";
  
  @override
  void initState() {
    super.initState(); 

    setState(() {
      // TemporaryVariables.patientPartial = widget.xBusinessApplication.patient;
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
                    Text('Code: ________________________', style: TextStyle(fontSize: 14, color: ThemeColor.warning)),
                    SizedBox(height: 4),
                    Text('Description:', style: TextStyle(fontSize: 12, color: ThemeColor.success)),
                    SizedBox(height: 4),
                    Text('________________________________________________', style: TextStyle(fontSize: 12, color: ThemeColor.success)),
                    Row(
                      children: [
                        Text('Type:', style: TextStyle(fontSize: 10, color: ThemeColor.success, fontWeight: FontWeight.w800)),
                        SizedBox(width: 8),
                        SizedBox(
                          height: 25,
                          width: 25,
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
                        Text("New", style: TextStyle(fontSize: 10, color: ThemeColor.disabledText)),
                        SizedBox(width: 8),
                        SizedBox(
                          height: 25,
                          width: 25,
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
                        Text("Renew", style: TextStyle(fontSize: 10, color: ThemeColor.disabledText)),
                      ],
                    ),
                    SizedBox(height: 4),
                    Text('Capital Investment: PHP 0.00', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                    SizedBox(height: 4),
                    Text('Gross Essential: PHP 0.00', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                    SizedBox(height: 4),
                    Text('Gross Non-Essential: PHP 0.00', style: TextStyle(fontSize: 10, color: ThemeColor.disabledText, fontWeight: FontWeight.w800)),
                  ],
                )
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
                    Text('Description:', style: TextStyle(fontSize: 12, color: ThemeColor.warning)),
                    SizedBox(height: 4),
                    Text('________________________________________________', style: TextStyle(fontSize: 12, color: ThemeColor.warning)),
                    SizedBox(height: 4),
                    Text('Number of Unit: 0', style: TextStyle(fontSize: 10, color: ThemeColor.success)),
                    SizedBox(height: 4),
                    Text('Capacity: 0', style: TextStyle(fontSize: 10, color: ThemeColor.success)),
                  ],
                )
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('If Place is Owned (CTC Tax Dec or Affidavit of Consent)', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('If Rented from LGU (Contract of Lease or Rental Clearance)', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('If Rented from Non-LGU (Contract of Lease or Tax Clearance)', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('If Location is Subdivision (Home Owners Consent)', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Sketch Map Location of Business Address', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Updated Tax Declaration of Land', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Updated Tax Declaration of Building', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Updated Tax Map', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Certificate of Occupancy or Annual Inspection', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Health Card Certificate', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Sanitary Permit', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Solid Waste Management Certificate', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Environmental Certificate', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  attachFile("");
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
                      value: (fileController.listFileAttachment.value.fileAttachments ?? []).firstWhereOrNull((e) => e.type == "Attachment1" && e.files.isNotEmpty) != null,
                      onChanged: (bool value) {
                      },
                    )
                  )),
                  SizedBox(
                    width: MediaQuery.of(context).size.width - 155,
                    child: Text('Business Zoning Certificate', softWrap: true, style: TextStyle(fontSize: 11)),
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
                  backgroundColor: ThemeColor.primary,
                  fixedSize: Size(80, 30),
                  foregroundColor: ThemeColor.primaryText,
                  shadowColor: Colors.black
                ),
                onPressed: () {
                  // attachFile("");
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
        FileAttachment _file = FileAttachment("", fileType, fileController.fileListTemp.value.fileList, []);
        fileAttachments.add(_file);
        fileController.listFileAttachment.value.fileAttachments = fileAttachments;
        fileController.listFileAttachment.refresh();
        fileController.fileListTemp.value.fileList = [];
      }
    });
  }

  businessRequirementEntry(BusinessApplication _businessApplication) {

  }
}
