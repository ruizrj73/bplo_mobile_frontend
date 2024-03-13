// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

import '../../utils/theme_color.dart';

BusinessApplication _businessApplication = userController.activeBusinessApplication.value;

class LineOfBusinessDialog {
  var numericFormatter = NumberFormat('#,###,##0');
  var currencyFormatter = NumberFormat('#,###,##0.00');
  
  final lineOfBusinessController = TextEditingController();
  String applicationType = _businessApplication.application_type;
  final capitalOfInvestmentController = TextEditingController();
  final grossEssentialController = TextEditingController();
  final grossNonEssentialController = TextEditingController();
  final measureDescriptionController = TextEditingController();
  final numberOfUnitsController = TextEditingController();
  final capacityController = TextEditingController();

  Future<LineOfBusinessModel> lineOfBusinessShowDialog(BuildContext context, LineOfBusinessModel lineOfBusiness) {
    if (lineOfBusiness != null) {
      lineOfBusinessController.text = lineOfBusiness.line_of_business;
      applicationType = lineOfBusiness.application_type;
      capitalOfInvestmentController.text = currencyFormatter.format(lineOfBusiness.capital_investment);
      grossEssentialController.text = currencyFormatter.format(lineOfBusiness.gross_essential);
      grossNonEssentialController.text = currencyFormatter.format(lineOfBusiness.gross_non_essential);
      measureDescriptionController.text = lineOfBusiness.measure_description;
      numberOfUnitsController.text = numericFormatter.format(lineOfBusiness.number_of_units);
      capacityController.text = numericFormatter.format(lineOfBusiness.capacity);
    }
    return showDialog<LineOfBusinessModel>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(builder: ((context, setState) {
          return AlertDialog(
            titlePadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.all(16),
            shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
            title: Container(),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  InputControls.textFieldInput(context, lineOfBusinessController, title: "Line of Business"),
                  SizedBox(height: 8),
                  InputControls.radioButtonSelection(applicationType, "New", "Renew", (value) {
                    setState(() {
                      applicationType = value;
                    });
                  }, title: "Application Type"),
                  SizedBox(height: 4),
                  applicationType == "New" ? InputControls.textFieldInput(context, capitalOfInvestmentController, title: "Capital Investment", keyboardType: TextInputType.number, isCurrency: true) : Container(),
                  applicationType == "Renew" ? InputControls.textFieldInput(context, grossEssentialController, title: "Gross Essential", keyboardType: TextInputType.number, isCurrency: true) : Container(),
                  applicationType == "Renew" ? SizedBox(height: 4) : Container(),
                  applicationType == "Renew" ? InputControls.textFieldInput(context, grossNonEssentialController, title: "Gross Non-Essential", keyboardType: TextInputType.number, isCurrency: true) : Container(),
                  SizedBox(height: 8),
                  Text("Measure and Pax", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, measureDescriptionController, title: "Description"),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, numberOfUnitsController, title: "Number of Units", keyboardType: TextInputType.number, isNumeric: true),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, capacityController, title: "Capacity", keyboardType: TextInputType.number, isNumeric: true),
                ],
              ),
            ),
            actions: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.only(right: 16, bottom: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => Navigator.pop(context, null),
                        child: Text(
                          "Cancel", 
                          style: TextStyle(
                            color: ThemeColor.warning, 
                            fontWeight: FontWeight.w800, 
                            decoration: TextDecoration.underline
                          )
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Container(
                    padding: EdgeInsets.only(right: 16, bottom: 8),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: InkWell(
                        onTap: () => saveLineOfBusiness(context, lineOfBusiness),
                        child: Text(
                          "OK", 
                          style: TextStyle(
                            color: ThemeColor.primary, 
                            fontWeight: FontWeight.w800, 
                            decoration: TextDecoration.underline
                          )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        }));
      }
    );
  }

  saveLineOfBusiness(BuildContext context, LineOfBusinessModel lineofBusiness) {
    switch (applicationType) {
      case "New":
        grossEssentialController.text = "";
        grossNonEssentialController.text = "";
        break;
      case "Renew":
        capitalOfInvestmentController.text = "";
        break;
    }
    LineOfBusinessModel retLineOfBusiness = LineOfBusinessModel(
      id: lineofBusiness == null ? "" : lineofBusiness.id,
      line_of_business: lineOfBusinessController.text,
      application_type: applicationType,
      capital_investment: capitalOfInvestmentController.text == "" ? 0 : double.parse(capitalOfInvestmentController.text.replaceAll(",", "")),
      gross_essential: grossEssentialController.text == "" ? 0 : double.parse(grossEssentialController.text.replaceAll(",", "")),
      gross_non_essential: grossNonEssentialController.text == "" ? 0 : double.parse(grossNonEssentialController.text.replaceAll(",", "")),
      measure_description: measureDescriptionController.text,
      number_of_units: numberOfUnitsController.text == "" ? 0 : int.parse(numberOfUnitsController.text.replaceAll(",", "")),
      capacity: capacityController.text == "" ? 0 : int.parse(capacityController.text.replaceAll(",", "")),
      remarks: lineofBusiness == null ? "" : lineofBusiness.remarks,
    );
    Navigator.pop(context, retLineOfBusiness);
  }
}