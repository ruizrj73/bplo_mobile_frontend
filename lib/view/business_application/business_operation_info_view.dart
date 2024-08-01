// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lgu_bplo/model/business_application_model.dart';
import 'package:lgu_bplo/utils/input_controls.dart';
import 'package:lgu_bplo/utils/request/backend_request.dart';
import 'package:lgu_bplo/utils/theme_color.dart';

List<String> zipcodeSelection = ["", "6000"];
List<String> regionSelection = ["", "Region 7"];
List<String> provinceSelection = ["", "Cebu"];
List<String> cityMunicipalitySelection = ["", "Cebu City"];
List<String> barangaySelection = [
  "",
  "Adlaon",
  "Agsungot",
  "Apas",
  "Babag",
  "Bacayan",
  "Banilad",
  "Basak Pardo",
  "Basak San Nicolas",
  "Binaliw",
  "Bonbon",
  "Budlaan",
  "Buhisan",
  "Bulacao",
  "Buot",
  "Busay",
  "Calamba",
  "Cambinocot",
  "Capitol Site",
  "Carreta",
  "Cogon Pardo",
  "Cogon Ramos",
  "Day-as",
  "Duljo Fatima",
  "Ermita",
  "Guadalupe",
  "Guba",
  "Hipodromo",
  "Inayawan",
  "Kalubihan",
  "Kalunasan",
  "Kamagayan",
  "Kamputhaw (Camputhaw)",
  "Kasambagan",
  "Kinasang-an Pardo",
  "Labangon",
  "Lahug",
  "Lorega San Miguel",
  "Lusaran",
  "Luz",
  "Mabini",
  "Mabolo",
  "Malubog",
  "Mambaling",
  "Pahina Central",
  "Pahina San Nicolas",
  "Pamutan",
  "Pari-an",
  "Paril",
  "Pasil",
  "Pit-os",
  "Poblacion Pardo",
  "Pulangbato",
  "Pung-ol Sibugay",
  "Punta Princesa",
  "Quiot Pardo",
  "Sambag I",
  "Sambag II",
  "San Antonio",
  "San Jose",
  "San Nicolas Proper",
  "San Roque",
  "Santa Cruz",
  "Santo Niño (Poblacion)",
  "Sapangdaku",
  "Sawang Calero",
  "Sinsin",
  "Sirao",
  "Suba",
  "Sudlon I",
  "Sudlon II",
  "T. Padilla",
  "Tabunan",
  "Tagba-o",
  "Talamban",
  "Taptap",
  "Tejero (Villa Gonzalo)",
  "Tinago",
  "Tisa",
  "To-ong",
  "Zapatera",
];

// #region Declaration

String businessActivity = "Main Office";
final businessArea = TextEditingController();
final totalFloorArea = TextEditingController();
final maleEmployees = TextEditingController();
final femaleEmployees = TextEditingController();
final totalEmployees = TextEditingController();
final employeesInLgu = TextEditingController();
final supervisor = TextEditingController();
final rankAndFile = TextEditingController();
final cashier = TextEditingController();
final onField = TextEditingController();
bool isNoDeliveryVehicle = false;
final delVehicleVanTruck = TextEditingController();
final delVehicleMotorcycle = TextEditingController();
String placeOwnership = "Owned";
String accountant = "None";
final taxDecNo = TextEditingController();
final pinNo = TextEditingController();
String govTaxIncentivesEnjoy = "Yes";
final ctcNo = TextEditingController();
String brgyMicroBusinessEnterpriseRegistered = "Yes";
String bangkoSentralRegistered = "No";

final lessorFirstName = TextEditingController();
final lessorMiddleName = TextEditingController();
final lessorLastName = TextEditingController();
final lessorSuffix = TextEditingController();
String lessorZipcode = zipcodeSelection.first;
String lessorRegion = regionSelection.first;
String lessorProvince = provinceSelection.first;
String lessorCityMunicipality = cityMunicipalitySelection.first;
String lessorBarangay = barangaySelection.first;
final lessorHouseBldgNo = TextEditingController();
final lessorBldgName = TextEditingController();
final lessorLotUnitNo = TextEditingController();
final lessorBlockFloorNo = TextEditingController();
final lessorStreet = TextEditingController();
final lessorSubdivision = TextEditingController();
final lessorMobileNumber = TextEditingController();
final lessorTelFaxNumber = TextEditingController();
final lessorEmailAddress = TextEditingController();

final bookkeeperFirstName = TextEditingController();
final bookkeeperMiddleName = TextEditingController();
final bookkeeperLastName = TextEditingController();
final bookkeeperSuffix = TextEditingController();
final bookkeeperMobileNumber = TextEditingController();
final bookkeeperTelFaxNumber = TextEditingController();
final bookkeeperEmailAddress = TextEditingController();
final bookkeeperAccountingAuditCertificate = TextEditingController();

final accountingFirmName = TextEditingController();
final accountingFirmAddress = TextEditingController();
final accountingFirmMobileNumber = TextEditingController();
final accountingFirmTelFaxNumber = TextEditingController();
final accountingFirmEmailAddress = TextEditingController();
final accountingFirmAccountingAuditCertificate = TextEditingController();

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
    accountant = _businessApplication.bookkeeper_info != null ? "Bookkeeper" : _businessApplication.accounting_firm_info != null ? "Accounting Firm" : "None";
    if (_businessApplication.business_operation_info != null) {
      BusinessOperationInfoModel boi = _businessApplication.business_operation_info;
      businessActivity = boi.business_activity;
      businessArea.text = currencyFormatter.format(boi.business_area ?? 0);
      totalFloorArea.text = currencyFormatter.format(boi.total_floor_area ?? 0);
      maleEmployees.text = numericFormatter.format(boi.number_male_employee ?? 0);
      femaleEmployees.text = numericFormatter.format(boi.number_female_employee ?? 0);
      totalEmployees.text = numericFormatter.format(boi.total_number_employee_establishment ?? 0);
      employeesInLgu.text = numericFormatter.format(boi.total_number_employee_residing_lgu ?? 0);
      supervisor.text = numericFormatter.format(boi.supervisor ?? 0);
      rankAndFile.text = numericFormatter.format(boi.rank_and_file ?? 0);
      cashier.text = numericFormatter.format(boi.cashier ?? 0);
      onField.text = numericFormatter.format(boi.on_field ?? 0);
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
      supervisor.text = "";
      rankAndFile.text = "";
      cashier.text = "";
      onField.text = "";
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

    if (_businessApplication.lessor_info != null) {
      lessorFirstName.text = _businessApplication.lessor_info.first_name ?? "";
      lessorMiddleName.text = _businessApplication.lessor_info.middle_name ?? "";
      lessorLastName.text = _businessApplication.lessor_info.last_name ?? "";
      lessorSuffix.text = _businessApplication.lessor_info.suffix ?? "";
      lessorZipcode = _businessApplication.lessor_info.zip_code ?? "";
      lessorRegion = _businessApplication.lessor_info.region ?? "";
      lessorProvince = _businessApplication.lessor_info.province ?? "";
      lessorCityMunicipality = _businessApplication.lessor_info.city_municipality ?? "";
      lessorBarangay = _businessApplication.lessor_info.barangay ?? "";
      lessorHouseBldgNo.text = _businessApplication.lessor_info.house_bldg_no ?? "";
      lessorBldgName.text = _businessApplication.lessor_info.building_name ?? "";
      lessorLotUnitNo.text = _businessApplication.lessor_info.lot_unit_no ?? "";
      lessorBlockFloorNo.text = _businessApplication.lessor_info.block_floor_no ?? "";
      lessorStreet.text = _businessApplication.lessor_info.street ?? "";
      lessorSubdivision.text = _businessApplication.lessor_info.subdivision ?? "";
      lessorMobileNumber.text = _businessApplication.lessor_info.mobile_number ?? "";
      lessorTelFaxNumber.text = _businessApplication.lessor_info.tel_fax_number ?? "";
      lessorEmailAddress.text = _businessApplication.lessor_info.email_address ?? "";
    } else {
      lessorFirstName.text = "";
      lessorMiddleName.text = "";
      lessorLastName.text = "";
      lessorSuffix.text = "";
      lessorZipcode = "";
      lessorRegion = "";
      lessorProvince = "";
      lessorCityMunicipality = "";
      lessorBarangay = "";
      lessorHouseBldgNo.text = "";
      lessorBldgName.text = "";
      lessorLotUnitNo.text = "";
      lessorBlockFloorNo.text = "";
      lessorStreet.text = "";
      lessorSubdivision.text = "";
      lessorMobileNumber.text = "";
      lessorTelFaxNumber.text = "";
      lessorEmailAddress.text = "";
    }

    if (_businessApplication.bookkeeper_info != null) {
      bookkeeperFirstName.text = _businessApplication.bookkeeper_info.first_name ?? "";
      bookkeeperMiddleName.text = _businessApplication.bookkeeper_info.middle_name ?? "";
      bookkeeperLastName.text = _businessApplication.bookkeeper_info.last_name ?? "";
      bookkeeperSuffix.text = _businessApplication.bookkeeper_info.suffix ?? "";
      bookkeeperMobileNumber.text = _businessApplication.bookkeeper_info.mobile_number ?? "";
      bookkeeperTelFaxNumber.text = _businessApplication.bookkeeper_info.tel_fax_number ?? "";
      bookkeeperEmailAddress.text = _businessApplication.bookkeeper_info.email_address ?? "";
      bookkeeperAccountingAuditCertificate.text = _businessApplication.bookkeeper_info.accounting_audit_certificate ?? "";
    } else {
      bookkeeperFirstName.text = "";
      bookkeeperMiddleName.text = "";
      bookkeeperLastName.text = "";
      bookkeeperSuffix.text = "";
      bookkeeperMobileNumber.text = "";
      bookkeeperTelFaxNumber.text = "";
      bookkeeperEmailAddress.text = "";
      bookkeeperAccountingAuditCertificate.text = "";
    }

    if (_businessApplication.accounting_firm_info != null) {
      accountingFirmName.text = _businessApplication.accounting_firm_info.name ?? "";
      accountingFirmAddress.text = _businessApplication.accounting_firm_info.address ?? "";
      accountingFirmMobileNumber.text = _businessApplication.accounting_firm_info.mobile_number ?? "";
      accountingFirmTelFaxNumber.text = _businessApplication.accounting_firm_info.tel_fax_number ?? "";
      accountingFirmEmailAddress.text = _businessApplication.accounting_firm_info.email_address ?? "";
      accountingFirmAccountingAuditCertificate.text = _businessApplication.accounting_firm_info.accounting_audit_certificate ?? "";
    } else {
      accountingFirmName.text = "";
      accountingFirmAddress.text = "";
      accountingFirmMobileNumber.text = "";
      accountingFirmTelFaxNumber.text = "";
      accountingFirmEmailAddress.text = "";
      accountingFirmAccountingAuditCertificate.text = "";
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
              InputControls.textFieldInput(context, supervisor, title: "Supervisor", keyboardType: TextInputType.number, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, rankAndFile, title: "Rank and File", keyboardType: TextInputType.number, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, cashier, title: "Cashier", keyboardType: TextInputType.number, isNumeric: true),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, onField, title: "On Field", keyboardType: TextInputType.number, isNumeric: true),
            ],
          ),
        ),
        SizedBox(height: 8),
        Text("Other Details", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
                        width: 100,
                        child: FittedBox(
                          alignment: Alignment.centerRight,
                          fit: BoxFit.scaleDown,
                          child: Text('Check if Not Applicable', style: TextStyle(fontSize: 11)),
                        ),
                      ),
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
              InputControls.textFieldInput(context, taxDecNo, title: "Land or Building Tax Dec No."),
              SizedBox(height: 8),
              InputControls.radioButtonSelection(accountant, "None", "Bookkeeper", (value) {
                setState(() {
                  accountant = value;
                });
              }, title: "If Place is Owned or Rented", value3: "Accounting Firm"),
              SizedBox(height: 8),

              // SizedBox(height: 8),
              // InputControls.textFieldInput(context, pinNo, title: "Property Index Number (PIN)"),
              // SizedBox(height: 8),
              // InputControls.radioButtonSelection(govTaxIncentivesEnjoy, "Yes", "No", (value) {
              //   setState(() {
              //     govTaxIncentivesEnjoy = value;
              //   });
              // }, title: "Are you enjoying tax incentives from the govt entity?"),
              // SizedBox(height: 8),
              // InputControls.textFieldInput(context, ctcNo, title: "Community Tax Certificate (CTC)"),
              // SizedBox(height: 8),
              // InputControls.radioButtonSelection(brgyMicroBusinessEnterpriseRegistered, "Yes", "No", (value) {
              //   setState(() {
              //     brgyMicroBusinessEnterpriseRegistered = value;
              //   });
              // }, title: "Are you Barangay Micro Business Enterprise Registered?"),
              // SizedBox(height: 8),
              // InputControls.radioButtonSelection(bangkoSentralRegistered, "Yes", "No", (value) {
              //   setState(() {
              //     bangkoSentralRegistered = value;
              //   });
              // }, title: "Are you Bangko Sentral ng Pilipinas Registered?"),
            ]
          ),
        ),
        placeOwnership == "Owned" ? Container() : SizedBox(height: 8),
        placeOwnership == "Owned" ? Container() : Text("Lessor's Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        placeOwnership == "Owned" ? Container() : SizedBox(height: 8),
        placeOwnership == "Owned" ? Container() : Container(
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
              InputControls.textFieldInput(context, lessorLastName, title: "Last Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorFirstName, title: "First Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorMiddleName, title: "Middle Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorSuffix, title: "Suffix"),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, lessorRegion,
                ((val) {
                  setState(() {
                    lessorRegion = val;
                  });
                }),
                regionSelection, title: "Region"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, lessorProvince,
                ((val) {
                  setState(() {
                    lessorProvince = val;
                  });
                }),
                provinceSelection, title: "Province"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, lessorCityMunicipality,
                ((val) {
                  setState(() {
                    lessorCityMunicipality = val;
                  });
                }),
                cityMunicipalitySelection, title: "City/Municipality"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, lessorBarangay,
                ((val) {
                  setState(() {
                    lessorBarangay = val;
                  });
                }),
                barangaySelection, title: "Barangay"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, lessorZipcode,
                ((val) {
                  setState(() {
                    lessorZipcode = val;
                  });
                }),
                zipcodeSelection, title: "Zip Code"
              ),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorHouseBldgNo, title: "House/Bldg No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorBldgName, title: "Building Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorLotUnitNo, title: "Lot/Unit No"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorBlockFloorNo, title: "Block/Floor No"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorStreet, title: "Street"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorSubdivision, title: "Subdivision"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorMobileNumber, title: "Mobile Number", prefixText: "+639", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorTelFaxNumber, title: "Tel/Fax Number", prefixText: "+6332", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, lessorEmailAddress, title: "Email Address", keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
            ]
          ),
        ),
        accountant == "Bookkeeper" ? SizedBox(height: 8) : Container(),
        accountant == "Bookkeeper" ? Text("Bookkeeper's Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)) : Container(),
        accountant == "Bookkeeper" ? SizedBox(height: 8) : Container(),
        accountant == "Bookkeeper" ? Container(
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
              InputControls.textFieldInput(context, bookkeeperLastName, title: "Last Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperFirstName, title: "First Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperMiddleName, title: "Middle Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperSuffix, title: "Suffix"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperMobileNumber, title: "Mobile Number", prefixText: "+639", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperTelFaxNumber, title: "Tel/Fax Number", prefixText: "+6332", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperEmailAddress, title: "Email Address", keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, bookkeeperAccountingAuditCertificate, title: "Accounting / Audit Certificate"),
            ]
          ),
        ) : Container(),
        accountant == "Accounting Firm" ? SizedBox(height: 8) : Container(),
        accountant == "Accounting Firm" ? Text("Accounting Firm Information", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)) : Container(),
        accountant == "Accounting Firm" ? SizedBox(height: 8) : Container(),
        accountant == "Accounting Firm" ? Container(
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
              InputControls.textFieldInput(context, accountingFirmName, title: "Name of the Accounting Firm"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, accountingFirmAddress, title: "Address of the Accounting Firm"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, accountingFirmMobileNumber, title: "Mobile Number", prefixText: "+639", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, accountingFirmTelFaxNumber, title: "Tel/Fax Number", prefixText: "+6332", keyboardType: TextInputType.number),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, accountingFirmEmailAddress, title: "Email Address", keyboardType: TextInputType.emailAddress, textCapitalization: TextCapitalization.none),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, accountingFirmAccountingAuditCertificate, title: "Accounting / Audit Certificate"),
            ]
          ),
        ) : Container(),
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
      business_area: double.tryParse(businessArea.text.replaceAll(",", "")) ?? 0,
      total_floor_area: double.tryParse(totalFloorArea.text.replaceAll(",", "")) ?? 0,
      number_male_employee: int.tryParse(maleEmployees.text.replaceAll(",", "")) ?? 0,
      number_female_employee: int.tryParse(femaleEmployees.text.replaceAll(",", "")) ?? 0,
      total_number_employee_establishment: int.tryParse(totalEmployees.text.replaceAll(",", "")) ?? 0,
      total_number_employee_residing_lgu: int.tryParse(employeesInLgu.text.replaceAll(",", "")) ?? 0,
      supervisor: int.tryParse(supervisor.text.replaceAll(",", "")) ?? 0,
      rank_and_file: int.tryParse(rankAndFile.text.replaceAll(",", "")) ?? 0,
      cashier: int.tryParse(cashier.text.replaceAll(",", "")) ?? 0,
      on_field: int.tryParse(onField.text.replaceAll(",", "")) ?? 0,
      has_delivery_vehicles: !isNoDeliveryVehicle,
      total_delivery_vehicle_van_truck: int.tryParse(delVehicleVanTruck.text.replaceAll(",", "")) ?? 0,
      total_delivery_vehicle_motorcycle: int.tryParse(delVehicleMotorcycle.text.replaceAll(",", "")) ?? 0,
      place_owned_rented: placeOwnership,
      taxdec_number: taxDecNo.text,
      property_index_number: pinNo.text,
      government_tax_incentives_enjoy: govTaxIncentivesEnjoy,
      community_tax_certificate: ctcNo.text,
      barangay_micro_business_enterprise_registered: brgyMicroBusinessEnterpriseRegistered,
      bangko_sentral_registered: bangkoSentralRegistered,
      remarks: "",
    );

    if (placeOwnership == "Owned") {
      _businessApplication.lessor_info = null;
    } else {
      LessorInfoModel li = LessorInfoModel(
        first_name: lessorFirstName.text,
        middle_name: lessorMiddleName.text,
        last_name: lessorLastName.text,
        suffix: lessorSuffix.text,
        zip_code: lessorZipcode,
        region: lessorRegion,
        province: lessorProvince,
        city_municipality: lessorCityMunicipality,
        barangay: lessorBarangay,
        house_bldg_no: lessorHouseBldgNo.text,
        building_name: lessorBldgName.text,
        lot_unit_no: lessorLotUnitNo.text,
        block_floor_no: lessorBlockFloorNo.text,
        street: lessorStreet.text,
        subdivision: lessorSubdivision.text,
        mobile_number: lessorMobileNumber.text,
        tel_fax_number: lessorTelFaxNumber.text,
        email_address: lessorEmailAddress.text,
        remarks: "",
      );
      _businessApplication.lessor_info = li;
    }

    if (accountant == "Bookkeeper") {
      BookkeeperInfoModel bi = BookkeeperInfoModel(
        first_name: bookkeeperFirstName.text,
        middle_name: bookkeeperMiddleName.text,
        last_name: bookkeeperLastName.text,
        suffix: bookkeeperSuffix.text,
        mobile_number: bookkeeperMobileNumber.text,
        tel_fax_number: bookkeeperTelFaxNumber.text,
        email_address: bookkeeperEmailAddress.text,
        accounting_audit_certificate: bookkeeperAccountingAuditCertificate.text,
        remarks: "",
      );
      _businessApplication.bookkeeper_info = bi;
      _businessApplication.accounting_firm_info = null;
    } else if (accountant == "Accounting Firm") {
      AccountingFirmInfoModel ai = AccountingFirmInfoModel(
        name: accountingFirmName.text,
        address: accountingFirmAddress.text,
        mobile_number: accountingFirmMobileNumber.text,
        tel_fax_number: accountingFirmTelFaxNumber.text,
        email_address: accountingFirmEmailAddress.text,
        accounting_audit_certificate: accountingFirmAccountingAuditCertificate.text,
        remarks: "",
      );
      _businessApplication.accounting_firm_info = ai;
      _businessApplication.bookkeeper_info = null;
    } else {
      _businessApplication.bookkeeper_info = null;
      _businessApplication.accounting_firm_info = null;
    }

    _businessApplication.business_operation_info = boi;
  }
}
