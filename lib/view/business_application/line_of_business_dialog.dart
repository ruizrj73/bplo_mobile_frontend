// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, no_leading_underscores_for_local_identifiers

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';

import '../../utils/snackbar_dialog.dart';
import '../../utils/theme_color.dart';

BusinessApplication _businessApplication = userController.activeBusinessApplication.value;

class LineOfBusinessDialog {
  var numericFormatter = NumberFormat('#,###,##0');
  var currencyFormatter = NumberFormat('#,###,##0.00');
  
  final List<String> _lineBusinessSelection = [];
  final codeController = TextEditingController();
  String selectedLineBusiness = "- Select Line of Business -";
  String applicationType = _businessApplication.application_type;
  final unitsController = TextEditingController();
  final capitalOfInvestmentController = TextEditingController();
  final grossEssentialController = TextEditingController();
  final grossNonEssentialController = TextEditingController();

  Future<LineOfBusinessModel> lineOfBusinessShowDialog(BuildContext context, LineOfBusinessModel lineOfBusiness) {
    _lineBusinessSelection.add("- Select Line of Business -");
    for (var lb in mainController.listLineOfBusiness) {
      _lineBusinessSelection.add("${lb.code} - ${lb.description}");
    }

    if (lineOfBusiness != null) {
      codeController.text = lineOfBusiness.code;
      selectedLineBusiness = "${lineOfBusiness.code} - ${lineOfBusiness.line_of_business}";
      applicationType = lineOfBusiness.application_type;
      unitsController.text = lineOfBusiness.units.toString();
      capitalOfInvestmentController.text = currencyFormatter.format(lineOfBusiness.capital_investment);
      grossEssentialController.text = currencyFormatter.format(lineOfBusiness.gross_essential);
      grossNonEssentialController.text = currencyFormatter.format(lineOfBusiness.gross_non_essential);
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
                  Text("Line of Business", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  InputControls.selectionFieldInput(
                    context, selectedLineBusiness,
                    ((val) {
                      setState(() {
                        selectedLineBusiness = val;
                      });
                    }),
                    _lineBusinessSelection
                  ),
                  SizedBox(height: 4),
                  InputControls.radioButtonSelection(applicationType, "New", "Renew", (value) {
                    setState(() {
                      applicationType = value;
                    });
                  }, title: "Application Type"),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, unitsController, title: "Units", keyboardType: TextInputType.number),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, capitalOfInvestmentController, title: "Capital Investment", keyboardType: TextInputType.number, isCurrency: true),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, grossEssentialController, title: "Gross Essential", keyboardType: TextInputType.number, isCurrency: true),
                  SizedBox(height: 4),
                  InputControls.textFieldInput(context, grossNonEssentialController, title: "Gross Non-Essential", keyboardType: TextInputType.number, isCurrency: true),
                  // applicationType == "New" ? InputControls.textFieldInput(context, capitalOfInvestmentController, title: "Capital Investment", keyboardType: TextInputType.number, isCurrency: true) : Container(),
                  // applicationType == "Renew" ? InputControls.textFieldInput(context, grossEssentialController, title: "Gross Essential", keyboardType: TextInputType.number, isCurrency: true) : Container(),
                  // applicationType == "Renew" ? SizedBox(height: 4) : Container(),
                  // applicationType == "Renew" ? InputControls.textFieldInput(context, grossNonEssentialController, title: "Gross Non-Essential", keyboardType: TextInputType.number, isCurrency: true) : Container(),
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
    if (selectedLineBusiness == "- Select Line of Business -") {
      showSnackbar("Error", "Please select Line of Business");
      return;
    }
    // switch (applicationType) {
    //   case "New":
    //     grossEssentialController.text = "";
    //     grossNonEssentialController.text = "";
    //     break;
    //   case "Renew":
    //     capitalOfInvestmentController.text = "";
    //     break;
    // }
    String _code = selectedLineBusiness.split(" - ")[0];
    LineOfBusinessModel retLineOfBusiness = LineOfBusinessModel(
      id: lineofBusiness == null ? "" : lineofBusiness.id,
      code: _code,
      line_of_business: selectedLineBusiness.substring(_code.length-1),
      application_type: applicationType,
      capital_investment: capitalOfInvestmentController.text == "" ? 0 : double.parse(capitalOfInvestmentController.text.replaceAll(",", "")),
      gross_essential: grossEssentialController.text == "" ? 0 : double.parse(grossEssentialController.text.replaceAll(",", "")),
      gross_non_essential: grossNonEssentialController.text == "" ? 0 : double.parse(grossNonEssentialController.text.replaceAll(",", "")),
      units: unitsController.text == "" ? 0 : int.parse(unitsController.text.replaceAll(",", "")),
      remarks: lineofBusiness == null ? "" : lineofBusiness.remarks,
    );
    Navigator.pop(context, retLineOfBusiness);
  }
}