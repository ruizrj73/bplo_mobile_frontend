// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/bottom_navigation_bar.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/snackbar_dialog.dart';

import '../../utils/theme_color.dart';

class MeasurePaxDialog {
  var numericFormatter = NumberFormat('#,###,##0');
  
  String selectedLineOfBusiness = "- Select Line of Business -";
  String selectedMeasurePax = "- Select Measure & Pax -";
  final List<String> _lineOfBusinessSelection = [];
  final List<String> _measurePaxSelection = [];
  final numberOfUnitsController = TextEditingController();
  final capacityController = TextEditingController();

  Future<MeasurePaxModel> measurePaxShowDialog(BuildContext context, MeasurePaxModel measurePax, List<LineOfBusinessModel> lineOfBusinessList) {
    _lineOfBusinessSelection.add("- Select Line of Business -");
    for (var lb in lineOfBusinessList) {
      _lineOfBusinessSelection.add(lb.line_of_business);
    }
    _measurePaxSelection.add("- Select Measure & Pax -");
    for (var lb in mainController.listLineOfBusinessMeasurePax) {
      _measurePaxSelection.add(lb.description);
    }
    if (measurePax != null) {
      selectedLineOfBusiness = measurePax.line_of_business;
      selectedMeasurePax = measurePax.measure_description;
      numberOfUnitsController.text = numericFormatter.format(measurePax.number_of_units);
      capacityController.text = numericFormatter.format(measurePax.capacity);
    }
    return showDialog<MeasurePaxModel>(
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
                  Text("Measure and Pax", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800)),
                  SizedBox(height: 4),
                  InputControls.selectionFieldInput(
                    context, selectedLineOfBusiness,
                    ((val) {
                      setState(() {
                        selectedLineOfBusiness = val;
                      });
                    }),
                    _lineOfBusinessSelection, title: "Line of Business"
                  ),
                  SizedBox(height: 4),
                  Text("Description", style: TextStyle(fontSize: 12)),
                  SizedBox(height: 4),
                  Autocomplete<String>(
                    initialValue: TextEditingValue(text: selectedMeasurePax == "- Select Measure & Pax -" ? "" : selectedMeasurePax),
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<String>.empty();
                      }
                      List<String> retList = [];
                      retList.add(textEditingValue.text);
                      retList.addAll(_measurePaxSelection.where((String option) {
                        selectedMeasurePax = textEditingValue.text;
                        return option.contains(textEditingValue.text.toLowerCase());
                      }));
                      return retList;
                    },
                    onSelected: (String selection) {
                      selectedMeasurePax = selection;
                    },
                    fieldViewBuilder: (context, controller, focusNode, onEditingComplete) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 30,
                        child: TextField(
                          controller: controller,
                          focusNode: focusNode,
                          onEditingComplete: onEditingComplete,
                          style: TextStyle(fontSize: 12),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: const BorderRadius.all(Radius.circular(4.0))),
                            contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          )
                        ),
                      );
                    },
                  ),
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
                        onTap: () => saveMeasurePax(context, measurePax),
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

  saveMeasurePax(BuildContext context, MeasurePaxModel lineofBusiness) {
    if (selectedLineOfBusiness == "- Select Line of Business -") {
      showSnackbar("Error", "Please select Line of Business");
      return;
    }
    if (selectedMeasurePax == "- Select Measure & Pax -") {
      showSnackbar("Error", "Please select Measure & Pax");
      return;
    }
    MeasurePaxModel retLineOfBusiness = MeasurePaxModel(
      id: lineofBusiness == null ? "" : lineofBusiness.id,
      line_of_business: selectedLineOfBusiness,
      measure_description: selectedMeasurePax,
      number_of_units: numberOfUnitsController.text == "" ? 0 : int.parse(numberOfUnitsController.text.replaceAll(",", "")),
      capacity: capacityController.text == "" ? 0 : int.parse(capacityController.text.replaceAll(",", "")),
      remarks: lineofBusiness == null ? "" : lineofBusiness.remarks,
    );
    Navigator.pop(context, retLineOfBusiness);
  }
}