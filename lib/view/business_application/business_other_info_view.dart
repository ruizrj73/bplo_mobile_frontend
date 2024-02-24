// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

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
final tradeName = TextEditingController();
final firstName = TextEditingController();
final middleName = TextEditingController();
final lastName = TextEditingController();
final mobileNumber = TextEditingController();
final telFaxNumber = TextEditingController();
final emailAddress = TextEditingController();
final suffix = TextEditingController();
final dtiRegDate = TextEditingController();
final dtiRegNo = TextEditingController();
String _gender = "";

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
      tradeName.text = _businessApplication.trade_name ?? "";
      dtiRegDate.text = _businessApplication.dtiseccda_registration_date ?? "";
      dtiRegNo.text = _businessApplication.dtiseccda_registration_no ?? "";
      if ((_businessApplication.business_owner_info ?? []).isNotEmpty) {
        firstName.text = (_businessApplication.business_owner_info ?? [])[0].first_name ?? "";
        middleName.text = (_businessApplication.business_owner_info ?? [])[0].middle_name ?? "";
        lastName.text = (_businessApplication.business_owner_info ?? [])[0].last_name ?? "";
        suffix.text = (_businessApplication.business_owner_info ?? [])[0].suffix ?? "";
        _gender = (_businessApplication.business_owner_info ?? [])[0].gender ?? "";
      }
      if ((_businessApplication.business_contact_info ?? []).isNotEmpty) {
        mobileNumber.text = (_businessApplication.business_contact_info ?? [])[0].mobile_number ?? "";
        telFaxNumber.text = (_businessApplication.business_contact_info ?? [])[0].tel_fax_number ?? "";
        emailAddress.text = (_businessApplication.business_contact_info ?? [])[0].email_address ?? "";
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
            ],
          ),
        ),
        SizedBox(height: 8),
        Text("Owner/Tax Payer Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
              InputControls.textFieldInput(context, telFaxNumber, title: "Tel/Fax Number", prefixText: "+632", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, emailAddress, title: "Email Address", keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
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
    _businessApplication.tin_no = businessTinNo.text;
    _businessApplication.trade_name = tradeName.text;
    _businessApplication.dtiseccda_registration_date = dtiRegDate.text;
    _businessApplication.dtiseccda_registration_no = dtiRegNo.text;
    BusinessOwnerInfoModel boi = BusinessOwnerInfoModel(
      id: "",
      first_name: firstName.text,
      middle_name: middleName.text,
      last_name: lastName.text,
      suffix: suffix.text,
      gender: _gender,
      remarks: "remarks"
    );
    _businessApplication.business_owner_info = [boi];
    BusinessContactInfoModel bci = BusinessContactInfoModel(
      id: "",
      mobile_number: mobileNumber.text,
      tel_fax_number: telFaxNumber.text,
      email_address: emailAddress.text,
      remarks: "remarks"
    );
    _businessApplication.business_contact_info = [bci];
  }
}
