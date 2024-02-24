// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

class BusinessOperationInfoView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessOperationInfoView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessOperationInfoViewState createState() => BusinessOperationInfoViewState();

  static Future<String> businessOperationInfoEntry(BusinessApplication _businessApplication) async { 
    return BusinessOperationInfoViewState().businessOperationInfoEntry(_businessApplication);
  }
}

class BusinessOperationInfoViewState extends State<BusinessOperationInfoView> { 
  List<String> _blankSelection = [""];
  String blankValue = "";
  final blankController = TextEditingController();
  String selectedBlankOption = "No";
  
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
        Text("Business Operation", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
              InputControls.selectionFieldInput(
                context, blankValue,
                ((val) {
                  setState(() {
                    blankValue = val;
                  });
                }),
                _blankSelection, title: "Business Activity"
              ),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Business Area (in sq.m.)", suffixText: "sq.m.", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Total Floor Area", suffixText: "sq.m.", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Number of Male Employee/s", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Number of Female Employee/s", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Total Number of Employees in Establishment", readOnly: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Total Number of Employees Residing within the LGU", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Number of Delivery Vehicles", style: TextStyle(fontSize: 12)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Checkbox(
                          value: false,
                          onChanged: (bool value) {
                          },
                        )
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 120,
                        child: FittedBox(
                          alignment: Alignment.centerRight,
                          fit: BoxFit.scaleDown,
                          child: Text('Check if Not Application', style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              InputControls.textFieldInput(context, blankController, title: "Van Truck", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Motorcycle", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(selectedBlankOption, "Yes", "No", (value) {
                setState(() {
                  selectedBlankOption = value;
                });
              }, title: "If Place is Owned or Rented"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Tax declaration Number"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Property Index Number (PIN)"),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(selectedBlankOption, "Yes", "No", (value) {
                setState(() {
                  selectedBlankOption = value;
                });
              }, title: "Are you enjoying tax incentives from the govt entity?"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, blankController, title: "Community Tax Certificate (CTC)"),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(selectedBlankOption, "Yes", "No", (value) {
                setState(() {
                  selectedBlankOption = value;
                });
              }, title: "Are you Barangay Micro Business Enterprise Registered?"),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(selectedBlankOption, "Yes", "No", (value) {
                setState(() {
                  selectedBlankOption = value;
                });
              }, title: "Are you Bangko Sentral ng Pilipinas Registered?"),
            ],
          ),
        ),
      ],
    );
  }

  businessOperationInfoEntry(BusinessApplication _businessApplication) {

  }
}
