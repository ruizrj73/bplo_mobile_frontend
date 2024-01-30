// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_final_fields, prefer_const_literals_to_create_immutables, avoid_function_literals_in_foreach_calls, no_leading_underscores_for_local_identifiers
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:get/get.dart';
import 'package:lgu_bplo/controller/main_controller.dart';
import 'package:lgu_bplo/controller/network_connection_controller.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/popup_dialog.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class TransactionPages {
  int pageNumber;
  String pageTitle;
  bool isExpanded;

  TransactionPages(
    this.pageNumber,
    this.pageTitle,
    this.isExpanded,
  );
}

class BusinessApplicationView extends StatefulWidget {
  // ignore: use_key_in_widget_constructors
  const BusinessApplicationView();
  @override
  BusinessApplicationViewState createState() => BusinessApplicationViewState();
}

class BusinessApplicationViewState extends State<BusinessApplicationView> {
  final MainController mainController = Get.find();
  final NetworkConnectionController networkConnectionController = Get.find();
  String _formTitle = "";
  final _applicationType = Get.arguments;

  List<String> _paymentModeSelection = [];
  List<String> _taxYearSelection = ["2025", "2024", "2023"];
  List<String> _orgTypeSelection = [];

  String selectedAppTypeOption = "New";
  String paymentMode = "";
  String taxYear = "2024";
  String orgType = "";
  bool _req1Attachment = false;
  bool _req2Attachment = false;
  bool _req3Attachment = false;
  final businessName = TextEditingController();
  final businessTinNo = TextEditingController();
  

  List<TransactionPages> transactionPage = [];

  @override
  void initState() {
    super.initState();

    setState(() {
      switch (_applicationType[0]) {
        case "New":
          _formTitle = "New Business Permit Application";
          selectedAppTypeOption = "New";
          break;
        case "Renew":
          selectedAppTypeOption = "Renew";
          _formTitle = "Renew Business Permit Application";
          break;
        default:
          _formTitle = "New Business Permit Application";
          selectedAppTypeOption = "New";
          break;
      }

      transactionPage = [
        TransactionPages(1, "Business Application", true),
        TransactionPages(2, "Business Application2", true),
      ];
      
      mainController.listPaymentMode.forEach((pmode) {
        _paymentModeSelection.add(pmode.payment_type);
      });
      mainController.listBusinessType.forEach((btype) {
        _orgTypeSelection.add(btype.organization_type);
      });

      paymentMode = mainController.listPaymentMode[0].payment_type;
      orgType = mainController.listBusinessType[0].organization_type;
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
            Get.back();
          },
        ),
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
      padding: EdgeInsets.all(16),
      child: page1(),
    );
  }

  Widget page1() {
    return Column(
      children: [
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
              Text("Mode of Payment :", style: TextStyle(fontSize: 12)),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColor.secondary,
                      ),
                      hint: const Text(''),
                      isExpanded: true,
                      value: paymentMode,
                      onChanged: (String newValue) {
                        setState(() {
                          paymentMode = newValue;
                        });
                      },
                      items: _paymentModeSelection.map((String items) {
                        return DropdownMenuItem( 
                          value: items, 
                          child: Text(items, style: TextStyle(fontSize: 12)), 
                        ); 
                      }).toList(), 
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text("Tax Year :", style: TextStyle(fontSize: 12)),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColor.secondary,
                      ),
                      hint: const Text(''),
                      isExpanded: true,
                      value: taxYear,
                      onChanged: (String newValue) {
                        setState(() {
                          taxYear = newValue;
                        });
                      },
                      items: _taxYearSelection.map((String items) {
                        return DropdownMenuItem( 
                          value: items, 
                          child: Text(items, style: TextStyle(fontSize: 12)), 
                        ); 
                      }).toList(), 
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text("Type of Organization :", style: TextStyle(fontSize: 12)),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      style: TextStyle(
                        fontSize: 12,
                        color: ThemeColor.secondary,
                      ),
                      hint: const Text(''),
                      isExpanded: true,
                      value: orgType,
                      onChanged: (String newValue) {
                        setState(() {
                          orgType = newValue;
                        });
                      },
                      items: _orgTypeSelection.map((String items) {
                        return DropdownMenuItem( 
                          value: items, 
                          child: Text(items, style: TextStyle(fontSize: 12)), 
                        ); 
                      }).toList(), 
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text("Business Name :", style: TextStyle(fontSize: 12)),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: TextField(
                    textCapitalization: TextCapitalization.words,
                    controller: businessName,
                    decoration: InputDecoration(
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.only(
                        bottom: 15,
                      ),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text("TIN Number :", style: TextStyle(fontSize: 12)),
              SizedBox(height: 4),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 30,
                child: InputDecorator(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                  ),
                  child: TextField(
                    controller: businessTinNo,
                    decoration: InputDecoration(
                      border: InputBorder.none, 
                      contentPadding: EdgeInsets.only(
                        bottom: 15,
                      ),
                    ),
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
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
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Checkbox(
                            value: _req1Attachment,
                            onChanged: (bool value) {
                            },
                          )
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 190,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('DTI/SEC/CDA (Complete Page & Valid)', style: TextStyle(fontSize: 11)),
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
                        backgroundColor: ThemeColor.primary,
                        fixedSize: Size(80, 30),
                        foregroundColor: ThemeColor.primaryText,
                        shadowColor: Colors.black
                      ),
                      onPressed: () {
                        attachFile1();
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
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Checkbox(
                            value: _req2Attachment,
                            onChanged: (bool value) {
                            },
                          )
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 190,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('Barangay Clearance for Business', style: TextStyle(fontSize: 11)),
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
                        backgroundColor: ThemeColor.primary,
                        fixedSize: Size(80, 30),
                        foregroundColor: ThemeColor.primaryText,
                        shadowColor: Colors.black
                      ),
                      onPressed: () {
                        attachFile2();
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
                        SizedBox(
                          width: 30,
                          height: 30,
                          child: Checkbox(
                            value: _req3Attachment,
                            onChanged: (bool value) {
                            },
                          )
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 190,
                          child: FittedBox(
                            alignment: Alignment.centerLeft,
                            fit: BoxFit.scaleDown,
                            child: Text('Community Tax Certificate for Business', style: TextStyle(fontSize: 11)),
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
                        backgroundColor: ThemeColor.primary,
                        fixedSize: Size(80, 30),
                        foregroundColor: ThemeColor.primaryText,
                        shadowColor: Colors.black
                      ),
                      onPressed: () {
                        attachFile3();
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
        ),
        SizedBox(height: 32),
        TextButton(
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            backgroundColor: ThemeColor.primary,
            minimumSize: Size(MediaQuery.of(context).size.width / 1.5, 50),
            shadowColor: ThemeColor.secondary,
            elevation: 3,
          ),
          onPressed: () async {
            submitP1();
          },
          child: Text(
            'Submit',
            style: TextStyle(
                color: ThemeColor.primaryText,
                fontWeight: FontWeight.w800,
                fontSize: 16),
          ),
        ),
      ],
    );
  }

  attachFile1() { // DTI/SEC/CDA (Complete Page & Valid)
    
  }

  attachFile2() { // Barangay Clearance for Business
    
  }

  attachFile3() { // Community Tax Certificate for Business
    
  }

  submitP1() {
    networkConnectionController.checkConnectionStatus().then((connResult) async {
      if (connResult) {
        EasyLoading.show();
        BusinessApplication _businessApplication = new BusinessApplication(
          "",
          "TXN000000001",
          userController.getId(),
          userController.getFullName(),
          selectedAppTypeOption,
          paymentMode,
          taxYear,
          orgType,
          businessName.text,
          "",
          businessTinNo.text,
          0,
          0,
          0,
          0,
          0,
          "remarks",
          "Waiting List",
          DateTime.now(),
          []
        );

        await saveBusinessApplication(_businessApplication).then((value) {
          EasyLoading.dismiss();
          popupDialog(context, "Success", "We've received you send request. We will notify you for the next step while your account is in verification.").then((value) {
            Get.back();
          });
        });
        
      } else {
        popupDialog(context, "", "Please check your internet connection.");
        return;
      }
    });
  }
}
