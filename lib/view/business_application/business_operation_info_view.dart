// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

// #region Declaration

String businessActivity = "Main Office";
final businessArea = TextEditingController();
final totalFloorArea = TextEditingController();
final maleEmployees = TextEditingController();
final femaleEmployees = TextEditingController();
final totalEmployees = TextEditingController();
final employeesInLgu = TextEditingController();
bool isNoDeliveryVehicle = false;
final delVehicleVanTruck = TextEditingController();
final delVehicleMotorcycle = TextEditingController();
String placeOwnership = "Owned";
final taxDecNo = TextEditingController();
final pinNo = TextEditingController();
String govTaxIncentivesEnjoy = "Yes";
final ctcNo = TextEditingController();
String brgyMicroBusinessEnterpriseRegistered = "Yes";
String bangkoSentralRegistered = "No";

// #endregion

class BusinessOperationInfoView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessOperationInfoView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessOperationInfoViewState createState() => BusinessOperationInfoViewState();

  static Future<String> businessOperationInfoEntry() async { 
    return BusinessOperationInfoViewState().businessOperationInfoEntry();
  }
}

class BusinessOperationInfoViewState extends State<BusinessOperationInfoView> { 
  BusinessApplication _businessApplication = userController.activeBusinessApplication.value;
  List<String> _businessOperationSelection = ["Main Office","Branch Office","Admin Office","Others"];
  var numericFormatter = NumberFormat('#,###,##0');
  var currencyFormatter = NumberFormat('#,###,##0.00');
  
  @override
  void initState() {
    super.initState(); 

    setValues();
  }

  setValues() {
    if (_businessApplication.business_operation_info != null) {
      BusinessOperationInfoModel boi = _businessApplication.business_operation_info;
      businessActivity = boi.business_activity;
      businessArea.text = currencyFormatter.format(boi.business_area ?? 0);
      totalFloorArea.text = currencyFormatter.format(boi.total_floor_area ?? 0);
      maleEmployees.text = numericFormatter.format(boi.number_male_employee ?? 0);
      femaleEmployees.text = numericFormatter.format(boi.number_female_employee ?? 0);
      totalEmployees.text = numericFormatter.format(boi.total_number_employee_establishment ?? 0);
      employeesInLgu.text = numericFormatter.format(boi.total_number_employee_residing_lgu ?? 0);
      isNoDeliveryVehicle = boi.has_delivery_vehicles;
      delVehicleVanTruck.text = numericFormatter.format(boi.total_delivery_vehicle_van_truck ?? 0);
      delVehicleMotorcycle.text = numericFormatter.format(boi.total_delivery_vehicle_motorcycle ?? 0);
      placeOwnership = boi.place_owned_rented;
      taxDecNo.text = boi.taxdec_number;
      pinNo.text = boi.property_index_number;
      govTaxIncentivesEnjoy = boi.government_tax_incentives_enjoy;
      ctcNo.text = boi.community_tax_certificate;
      brgyMicroBusinessEnterpriseRegistered = boi.barangay_micro_business_enterprise_registered;
      bangkoSentralRegistered = boi.bangko_sentral_registered;
    } else {
      businessActivity = "Main Office";
      businessArea.text = "";
      totalFloorArea.text = "";
      maleEmployees.text = "";
      femaleEmployees.text = "";
      totalEmployees.text = "";
      employeesInLgu.text = "";
      isNoDeliveryVehicle = false;
      delVehicleVanTruck.text = "";
      delVehicleMotorcycle.text = "";
      placeOwnership = "Owned";
      taxDecNo.text = "";
      pinNo.text = "";
      govTaxIncentivesEnjoy = "Yes";
      ctcNo.text = "";
      brgyMicroBusinessEnterpriseRegistered = "Yes";
      bangkoSentralRegistered = "No";
    }
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
                context, businessActivity,
                ((val) {
                  setState(() {
                    businessActivity = val;
                  });
                }),
                _businessOperationSelection, title: "Business Activity"
              ),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessArea, title: "Business Area (in sq.m.)", suffixText: "sq.m.", keyboardType: TextInputType.number, isCurrency: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, totalFloorArea, title: "Total Floor Area", suffixText: "sq.m.", keyboardType: TextInputType.number, isCurrency: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, maleEmployees, title: "Number of Male Employee/s", keyboardType: TextInputType.number, onChangedx: computeTotal, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, femaleEmployees, title: "Number of Female Employee/s", keyboardType: TextInputType.number, onChangedx: computeTotal, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, totalEmployees, title: "Total Number of Employees in Establishment", readOnly: true, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, employeesInLgu, title: "Total Number of Employees Residing within the LGU", keyboardType: TextInputType.number, isNumeric: true),
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
                          value: isNoDeliveryVehicle,
                          onChanged: (bool value) {
                            setState(() {
                              isNoDeliveryVehicle = value;
                              if (isNoDeliveryVehicle) {
                                delVehicleVanTruck.text = "0";
                                delVehicleMotorcycle.text = "0";
                              } else {
                                delVehicleVanTruck.text = "";
                                delVehicleMotorcycle.text = "";
                              }
                            });
                          },
                        )
                      ),
                      SizedBox(width: 8),
                      SizedBox(
                        width: 120,
                        child: FittedBox(
                          alignment: Alignment.centerRight,
                          fit: BoxFit.scaleDown,
                          child: Text('Check if Not Applicable', style: TextStyle(fontSize: 11)),
                        ),
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 4),
              InputControls.textFieldInput(context, delVehicleVanTruck, title: "Van Truck", keyboardType: TextInputType.number, readOnly: isNoDeliveryVehicle, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, delVehicleMotorcycle, title: "Motorcycle", keyboardType: TextInputType.number, readOnly: isNoDeliveryVehicle, isNumeric: true),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(placeOwnership, "Owned", "Rented", (value) {
                setState(() {
                  placeOwnership = value;
                });
              }, title: "If Place is Owned or Rented"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, taxDecNo, title: "Tax Declaration Number"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, pinNo, title: "Property Index Number (PIN)"),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(govTaxIncentivesEnjoy, "Yes", "No", (value) {
                setState(() {
                  govTaxIncentivesEnjoy = value;
                });
              }, title: "Are you enjoying tax incentives from the govt entity?"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ctcNo, title: "Community Tax Certificate (CTC)"),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(brgyMicroBusinessEnterpriseRegistered, "Yes", "No", (value) {
                setState(() {
                  brgyMicroBusinessEnterpriseRegistered = value;
                });
              }, title: "Are you Barangay Micro Business Enterprise Registered?"),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(bangkoSentralRegistered, "Yes", "No", (value) {
                setState(() {
                  bangkoSentralRegistered = value;
                });
              }, title: "Are you Bangko Sentral ng Pilipinas Registered?"),
            ],
          ),
        ),
      ],
    );
  }

  computeTotal(String text) {
    totalEmployees.text = numericFormatter.format(((maleEmployees.text == "" ? 0 : int.parse(maleEmployees.text.replaceAll(",", ""))) + (femaleEmployees.text == "" ? 0 : int.parse(femaleEmployees.text.replaceAll(",", "")))));
    totalEmployees.text = numericFormatter.format(((maleEmployees.text == "" ? 0 : int.parse(maleEmployees.text.replaceAll(",", ""))) + (femaleEmployees.text == "" ? 0 : int.parse(femaleEmployees.text.replaceAll(",", "")))));
  }

  businessOperationInfoEntry() {
    BusinessOperationInfoModel boi = BusinessOperationInfoModel(
      id: "",
      business_activity: businessActivity,
      business_area: double.tryParse(businessArea.text.replaceAll(",", "")),
      total_floor_area: double.tryParse(totalFloorArea.text.replaceAll(",", "")),
      number_male_employee: int.tryParse(maleEmployees.text.replaceAll(",", "")),
      number_female_employee: int.tryParse(femaleEmployees.text.replaceAll(",", "")),
      total_number_employee_establishment: int.tryParse(totalEmployees.text.replaceAll(",", "")),
      total_number_employee_residing_lgu: int.tryParse(employeesInLgu.text.replaceAll(",", "")),
      has_delivery_vehicles: !isNoDeliveryVehicle,
      total_delivery_vehicle_van_truck: int.tryParse(delVehicleVanTruck.text.replaceAll(",", "")),
      total_delivery_vehicle_motorcycle: int.tryParse(delVehicleMotorcycle.text.replaceAll(",", "")),
      place_owned_rented: placeOwnership,
      taxdec_number: taxDecNo.text,
      property_index_number: pinNo.text,
      government_tax_incentives_enjoy: govTaxIncentivesEnjoy,
      community_tax_certificate: ctcNo.text,
      barangay_micro_business_enterprise_registered: brgyMicroBusinessEnterpriseRegistered,
      bangko_sentral_registered: bangkoSentralRegistered,
      remarks: "",
    );
    _businessApplication.business_operation_info = boi;
  }
}
