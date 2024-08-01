// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

// #region Declaration

String selectedAppTypeOption = "New";
String paymentMode = "";
String taxYear = DateTime.now().year.toString();
String orgType = "";
final businessName = TextEditingController();
final businessTinNo = TextEditingController();
final businessStartDate = TextEditingController();
final businessPermitNo = TextEditingController();
final businessDateIssued = TextEditingController();
final birPermitNo = TextEditingController();
final birDateIssued = TextEditingController();
final tradeName = TextEditingController();
final firstName = TextEditingController();
final middleName = TextEditingController();
final lastName = TextEditingController();
final suffix = TextEditingController();
String _gender = "";
String isWithManager = "No";
String isSame = "No";
final corp_firstName = TextEditingController();
final corp_middleName = TextEditingController();
final corp_lastName = TextEditingController();
final corp_suffix = TextEditingController();
String corp_gender = "";
final mobileNumber = TextEditingController();
final telFaxNumber = TextEditingController();
final emailAddress = TextEditingController();
final businessMobileNumber = TextEditingController();
final businessTelFaxNumber = TextEditingController();
final businessEmailAddress = TextEditingController();
final dtiRegDate = TextEditingController();
final dtiRegNo = TextEditingController();
final ctcNo = TextEditingController();
final ctcDateIssued = TextEditingController();
final businessPlateNo = TextEditingController();
final signageName = TextEditingController();

// #endregion

class BusinessOtherInfoView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessOtherInfoView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessOtherInfoViewState createState() => BusinessOtherInfoViewState();

  static Future<String> businessOtherInfoEntry() async { 
    return BusinessOtherInfoViewState().businessOtherInfoEntry();
  }
}

class BusinessOtherInfoViewState extends State<BusinessOtherInfoView> {
  List<String> _genderSelection = ["", "Male", "Female"];
  List<String> _orgTypeSelection = [];
  List<String> _paymentModeSelection = [];
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
        case "None":
          selectedAppTypeOption = "None";
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

      paymentMode = mainController.listPaymentMode[0].payment_type;
      orgType = mainController.listBusinessType[0].organization_type;
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
      businessStartDate.text = _businessApplication.business_started_date ?? "";
      businessPermitNo.text = _businessApplication.business_permit_no ?? "";
      businessDateIssued.text = _businessApplication.business_permit_issued_date ?? "";
      birPermitNo.text = _businessApplication.bir_permit_no ?? "";
      birDateIssued.text = _businessApplication.bir_issued_date ?? "";
      tradeName.text = _businessApplication.trade_name ?? "";
      dtiRegDate.text = _businessApplication.dtiseccda_registration_date ?? "";
      dtiRegNo.text = _businessApplication.dtiseccda_registration_no ?? "";
      ctcNo.text = _businessApplication.ctc_no ?? "";
      ctcDateIssued.text = _businessApplication.ctc_issued_date ?? "";
      businessPlateNo.text = _businessApplication.plate_no ?? "";
      signageName.text = _businessApplication.signage_name ?? "";
      if ((_businessApplication.business_owner_info ?? []).isNotEmpty) {
        firstName.text = (_businessApplication.business_owner_info ?? [])[0].first_name ?? "";
        middleName.text = (_businessApplication.business_owner_info ?? [])[0].middle_name ?? "";
        lastName.text = (_businessApplication.business_owner_info ?? [])[0].last_name ?? "";
        suffix.text = (_businessApplication.business_owner_info ?? [])[0].suffix ?? "";
        _gender = (_businessApplication.business_owner_info ?? [])[0].gender ?? "";
        isWithManager = ((_businessApplication.business_owner_info ?? [])[0].has_manager ?? false) ? "Yes" : "No";
        isSame = ((_businessApplication.business_owner_info ?? [])[0].is_same ?? false) ? "Yes" : "No";
        corp_firstName.text = (_businessApplication.business_owner_info ?? [])[0].corp_first_name ?? "";
        corp_middleName.text = (_businessApplication.business_owner_info ?? [])[0].corp_middle_name ?? "";
        corp_lastName.text = (_businessApplication.business_owner_info ?? [])[0].corp_last_name ?? "";
        corp_suffix.text = (_businessApplication.business_owner_info ?? [])[0].corp_suffix ?? "";
        corp_gender = (_businessApplication.business_owner_info ?? [])[0].corp_gender ?? "";
      } else {
        firstName.text = "";
        middleName.text = "";
        lastName.text = "";
        suffix.text = "";
        _gender = "";
        isWithManager = "No";
        corp_firstName.text = "";
        corp_middleName.text = "";
        corp_lastName.text = "";
        corp_suffix.text = "";
        corp_gender = "";
      }
      if ((_businessApplication.business_contact_info ?? []).isNotEmpty) {
        mobileNumber.text = (_businessApplication.business_contact_info ?? [])[0].mobile_number ?? "";
        telFaxNumber.text = (_businessApplication.business_contact_info ?? [])[0].tel_fax_number ?? "";
        emailAddress.text = (_businessApplication.business_contact_info ?? [])[0].email_address ?? "";
        businessMobileNumber.text = (_businessApplication.business_contact_info ?? [])[0].business_mobile_number ?? "";
        businessTelFaxNumber.text = (_businessApplication.business_contact_info ?? [])[0].business_tel_fax_number ?? "";
        businessEmailAddress.text = (_businessApplication.business_contact_info ?? [])[0].business_email_address ?? "";
      } else {
        mobileNumber.text = "";
        telFaxNumber.text = "";
        emailAddress.text = "";
        businessMobileNumber.text = "";
        businessTelFaxNumber.text = "";
        businessEmailAddress.text = "";
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
        Text("Application Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Container(
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
              Text("Type of Application", style: TextStyle(fontSize: 12)),
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
                  SizedBox(width: 16),
                  SizedBox(
                    height: 30,
                    width: 30,
                    child: Radio(
                      value: "None",
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
                        selectedAppTypeOption = "None";
                      });
                    },
                    child: Text("None", style: TextStyle(fontSize: 12)),
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
            ],
          ),
        ),
        SizedBox(height: 8),
        Text("Business Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Container(
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
              InputControls.textFieldInput(context, businessName, title: "Business Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessStartDate, title: "Date Business Started", isDate: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessPermitNo, title: "Business Permit No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessDateIssued, title: "Date Issued", isDate: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, birPermitNo, title: "BIR Permit No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, birDateIssued, title: "Date Issued", isDate: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, tradeName, title: "Trade Name / Franchise"),
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
              InputControls.textFieldInput(context, businessTinNo, title: "TIN Number"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, dtiRegDate, title: "DTI/SEC/CDA Registration Date", isDate: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, dtiRegNo, title: "DTI/SEC/CDA Registration No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ctcNo, title: "CTC No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ctcDateIssued, title: "CTC Date Issued", isDate: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessPlateNo, title: "Plate No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, signageName, title: "Signage Name"),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Owner/Tax Payer Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: isWithManager == "Yes",
                    onChanged: (bool value) {
                      setState(() {
                        isWithManager = value ? "Yes" : "No";
                      });
                    },
                  )
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 130,
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text('With Officer/Manager/President/Treasurer?', style: TextStyle(fontSize: 11)),
                  ),
                ),
                SizedBox(width: 8),
              ],
            ),
          ],
        ),
        SizedBox(height: 8),
        Container(
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
              InputControls.textFieldInput(context, lastName, title: "Last Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, firstName, title: "First Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, middleName, title: "Middle Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, suffix, title: "Suffix"),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, _gender,
                ((val) {
                  setState(() {
                    _gender = val;
                  });
                }),
                _genderSelection, title: "Gender"
              ),
            ],
          ),
        ),
        isWithManager == "Yes" ? SizedBox(height: 8) : Container(),
        isWithManager == "Yes" ? Text("Officer/Manager/President/Treasurer Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)) : Container(),
        isWithManager == "Yes" ? SizedBox(height: 8) : Container(),
        isWithManager == "Yes" ? Container(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      value: isSame == "Yes",
                      onChanged: (bool value) {
                        setState(() {
                          isSame = value ? "Yes" : "No";
                          if (value) {
                            corp_firstName.text = firstName.text;
                            corp_middleName.text = middleName.text;
                            corp_lastName.text = lastName.text;
                            corp_suffix.text = suffix.text;
                            corp_gender = _gender;
                          } else {
                            corp_firstName.text = "";
                            corp_middleName.text = "";
                            corp_lastName.text = "";
                            corp_suffix.text = "";
                            corp_gender = "";
                          }
                        });
                      },
                    )
                  ),
                  SizedBox(width: 8),
                  SizedBox(
                    width: 130,
                    child: FittedBox(
                      alignment: Alignment.centerRight,
                      fit: BoxFit.scaleDown,
                      child: Text('Same as Owner/Tax Payer', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  SizedBox(width: 8),
                ],
              ),
              InputControls.textFieldInput(context, corp_lastName, title: "Last Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, corp_firstName, title: "First Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, corp_middleName, title: "Middle Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, corp_suffix, title: "Suffix"),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, corp_gender,
                ((val) {
                  setState(() {
                    corp_gender = val;
                  });
                }),
                _genderSelection, title: "Gender"
              ),
            ],
          ),
        ): Container(),
        SizedBox(height: 8),
        Text("Contact Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        SizedBox(height: 8),
        Container(
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
              InputControls.textFieldInput(context, mobileNumber, title: "Mobile Number", prefixText: "+639", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, telFaxNumber, title: "Tel/Fax Number", prefixText: "+6332", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, emailAddress, title: "Email Address", keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessMobileNumber, title: "Business Mobile Number", prefixText: "+639", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessTelFaxNumber, title: "Business Tel/Fax Number", prefixText: "+6332", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessEmailAddress, title: "Business Email Address", keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
            ],
          ),
        ),
      ],
    );
  }

  businessOtherInfoEntry() {
    _businessApplication.application_type = selectedAppTypeOption;
    _businessApplication.tax_year = taxYear;
    _businessApplication.payment_type = paymentMode;
    _businessApplication.organization_type = orgType;
    _businessApplication.business_name = businessName.text;
    _businessApplication.business_started_date = businessStartDate.text;
    _businessApplication.business_permit_no = businessPermitNo.text;
    _businessApplication.business_permit_issued_date = businessDateIssued.text;
    _businessApplication.bir_permit_no = birPermitNo.text;
    _businessApplication.bir_issued_date = birDateIssued.text;
    _businessApplication.tin_no = businessTinNo.text;
    _businessApplication.trade_name = tradeName.text;
    _businessApplication.dtiseccda_registration_date = dtiRegDate.text;
    _businessApplication.dtiseccda_registration_no = dtiRegNo.text;
    _businessApplication.ctc_no = ctcNo.text;
    _businessApplication.ctc_issued_date = ctcDateIssued.text;
    _businessApplication.plate_no = businessPlateNo.text;
    _businessApplication.signage_name = signageName.text;
    BusinessOwnerInfoModel boi = BusinessOwnerInfoModel(
      id: "",
      first_name: firstName.text,
      middle_name: middleName.text,
      last_name: lastName.text,
      suffix: suffix.text,
      gender: _gender,
      has_manager: isWithManager == "Yes" ? true : false,
      is_same: isSame == "Yes" ? true : false,
      corp_first_name: firstName.text,
      corp_middle_name: middleName.text,
      corp_last_name: lastName.text,
      corp_suffix: suffix.text,
      corp_gender: _gender,
      remarks: "remarks"
    );
    _businessApplication.business_owner_info = [boi];
    BusinessContactInfoModel bci = BusinessContactInfoModel(
      id: "",
      mobile_number: mobileNumber.text,
      tel_fax_number: telFaxNumber.text,
      email_address: emailAddress.text,
      business_mobile_number: businessMobileNumber.text,
      business_tel_fax_number: businessTelFaxNumber.text,
      business_email_address: businessEmailAddress.text,
      remarks: "remarks"
    );
    _businessApplication.business_contact_info = [bci];
  }
}
