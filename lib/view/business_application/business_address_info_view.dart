// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
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

String businessZipcode = zipcodeSelection.first;
String businessRegion = regionSelection.first;
String businessProvince = provinceSelection.first;
String businessCityMunicipality = cityMunicipalitySelection.first;
String businessBarangay = barangaySelection.first;
final businessHouseBldgNo = TextEditingController();
final businessBldgName = TextEditingController();
final businessLotUnitNo = TextEditingController();
final businessBlockFloorNo = TextEditingController();
final businessStreet = TextEditingController();
final businessSubdivision = TextEditingController();

String ownerZipcode = zipcodeSelection.first;
String ownerRegion = regionSelection.first;
String ownerProvince = provinceSelection.first;
String ownerCityMunicipality = cityMunicipalitySelection.first;
String ownerBarangay = barangaySelection.first;
final ownerHouseBldgNo = TextEditingController();
final ownerBldgName = TextEditingController();
final ownerLotUnitNo = TextEditingController();
final ownerBlockFloorNo = TextEditingController();
final ownerStreet = TextEditingController();
final ownerSubdivision = TextEditingController();

// #endregion

class BusinessAddressInfoView extends StatefulWidget {
  final BusinessApplication xBusinessApplication;

  const BusinessAddressInfoView({Key key, this.xBusinessApplication}) : super(key: key);
  @override
  BusinessAddressInfoViewState createState() => BusinessAddressInfoViewState();

  static Future<String> businessAddressInfoEntry() async { 
    return BusinessAddressInfoViewState().businessAddressInfoEntry();
  }
}

class BusinessAddressInfoViewState extends State<BusinessAddressInfoView> {
  String isSameAddress = "No";
  BusinessApplication _businessApplication = userController.activeBusinessApplication.value;
  
  @override
  void initState() {
    super.initState(); 

    setValues();
  }

  setValues() {
    if ((_businessApplication.business_address_info ?? []).isNotEmpty) {
      businessZipcode = _businessApplication.business_address_info.first.zip_code;
      businessRegion = _businessApplication.business_address_info.first.region;
      businessProvince = _businessApplication.business_address_info.first.province;
      businessCityMunicipality = _businessApplication.business_address_info.first.city_municipality;
      businessBarangay = _businessApplication.business_address_info.first.barangay;
      businessHouseBldgNo.text = _businessApplication.business_address_info.first.house_bldg_no;
      businessBldgName.text = _businessApplication.business_address_info.first.building_name;
      businessLotUnitNo.text = _businessApplication.business_address_info.first.lot_unit_no;
      businessBlockFloorNo.text = _businessApplication.business_address_info.first.block_floor_no;
      businessStreet.text = _businessApplication.business_address_info.first.street;
      businessSubdivision.text = _businessApplication.business_address_info.first.subdivision;
    } else {
      businessZipcode = zipcodeSelection.first;
      businessRegion = regionSelection.first;
      businessProvince = provinceSelection.first;
      businessCityMunicipality = cityMunicipalitySelection.first;
      businessBarangay = barangaySelection.first;
      businessHouseBldgNo.text = "";
      businessBldgName.text = "";
      businessLotUnitNo.text = "";
      businessBlockFloorNo.text = "";
      businessStreet.text = "";
      businessSubdivision.text = "";
    }
    if ((_businessApplication.business_owner_address_info ?? []).isNotEmpty) {
      ownerZipcode = _businessApplication.business_owner_address_info.first.zip_code;
      ownerRegion = _businessApplication.business_owner_address_info.first.region;
      ownerProvince = _businessApplication.business_owner_address_info.first.province;
      ownerCityMunicipality = _businessApplication.business_owner_address_info.first.city_municipality;
      ownerBarangay = _businessApplication.business_owner_address_info.first.barangay;
      ownerHouseBldgNo.text = _businessApplication.business_owner_address_info.first.house_bldg_no;
      ownerBldgName.text = _businessApplication.business_owner_address_info.first.building_name;
      ownerLotUnitNo.text = _businessApplication.business_owner_address_info.first.lot_unit_no;
      ownerBlockFloorNo.text = _businessApplication.business_owner_address_info.first.block_floor_no;
      ownerStreet.text = _businessApplication.business_owner_address_info.first.street;
      ownerSubdivision.text = _businessApplication.business_owner_address_info.first.subdivision;
    } else {
      ownerZipcode = zipcodeSelection.first;
      ownerRegion = regionSelection.first;
      ownerProvince = provinceSelection.first;
      ownerCityMunicipality = cityMunicipalitySelection.first;
      ownerBarangay = barangaySelection.first;
      ownerHouseBldgNo.text = "";
      ownerBldgName.text = "";
      ownerLotUnitNo.text = "";
      ownerBlockFloorNo.text = "";
      ownerStreet.text = "";
      ownerSubdivision.text = "";
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
        Text("Business Address", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
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
                context, businessRegion,
                ((val) {
                  setState(() {
                    businessRegion = val;
                  });
                }),
                regionSelection, title: "Region"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, businessProvince,
                ((val) {
                  setState(() {
                    businessProvince = val;
                  });
                }),
                provinceSelection, title: "Province"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, businessCityMunicipality,
                ((val) {
                  setState(() {
                    businessCityMunicipality = val;
                  });
                }),
                cityMunicipalitySelection, title: "City/Municipality"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, businessBarangay,
                ((val) {
                  setState(() {
                    businessBarangay = val;
                  });
                }),
                barangaySelection, title: "Barangay"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, businessZipcode,
                ((val) {
                  setState(() {
                    businessZipcode = val;
                  });
                }),
                zipcodeSelection, title: "Zip Code"
              ),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessHouseBldgNo, title: "House/Bldg No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessBldgName, title: "Building Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessLotUnitNo, title: "Lot/Unit No"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessBlockFloorNo, title: "Block/Floor No"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessStreet, title: "Street"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, businessSubdivision, title: "Subdivision"),
            ],
          ),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Owner/Tax Payer Address", style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: Checkbox(
                    value: isSameAddress == "Yes",
                    onChanged: (bool value) {
                      isSameAddress = value ? "Yes" : "No";
                      if (value) {
                        setState(() {
                          ownerZipcode = businessZipcode;
                          ownerRegion = businessRegion;
                          ownerProvince = businessProvince;
                          ownerCityMunicipality = businessCityMunicipality;
                          ownerBarangay = businessBarangay;
                          ownerHouseBldgNo.text = businessHouseBldgNo.text;
                          ownerBldgName.text = businessBldgName.text;
                          ownerLotUnitNo.text = businessLotUnitNo.text;
                          ownerBlockFloorNo.text = businessBlockFloorNo.text;
                          ownerStreet.text = businessStreet.text;
                          ownerSubdivision.text = businessSubdivision.text;
                        });
                      } else {
                        setState(() {
                          ownerZipcode = zipcodeSelection.first;
                          ownerRegion = regionSelection.first;
                          ownerProvince = provinceSelection.first;
                          ownerCityMunicipality = cityMunicipalitySelection.first;
                          ownerBarangay = barangaySelection.first;
                          ownerHouseBldgNo.text = "";
                          ownerBldgName.text = "";
                          ownerLotUnitNo.text = "";
                          ownerBlockFloorNo.text = "";
                          ownerStreet.text = "";
                          ownerSubdivision.text = "";
                        });
                      }
                    },
                  )
                ),
                SizedBox(width: 8),
                SizedBox(
                  width: 130,
                  child: FittedBox(
                    alignment: Alignment.centerRight,
                    fit: BoxFit.scaleDown,
                    child: Text('Same as Business Address?', style: TextStyle(fontSize: 11)),
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
              InputControls.selectionFieldInput(
                context, ownerRegion,
                ((val) {
                  setState(() {
                    ownerRegion = val;
                  });
                }),
                regionSelection, title: "Region"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, ownerProvince,
                ((val) {
                  setState(() {
                    ownerProvince = val;
                  });
                }),
                provinceSelection, title: "Province"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, ownerCityMunicipality,
                ((val) {
                  setState(() {
                    ownerCityMunicipality = val;
                  });
                }),
                cityMunicipalitySelection, title: "City/Municipality"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, ownerBarangay,
                ((val) {
                  setState(() {
                    ownerBarangay = val;
                  });
                }),
                barangaySelection, title: "Barangay"
              ),
              SizedBox(height: 8),
              InputControls.selectionFieldInput(
                context, ownerZipcode,
                ((val) {
                  setState(() {
                    ownerZipcode = val;
                  });
                }),
                zipcodeSelection, title: "Zip Code"
              ),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ownerHouseBldgNo, title: "House/Bldg No."),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ownerBldgName, title: "Building Name"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ownerLotUnitNo, title: "Lot/Unit No"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ownerBlockFloorNo, title: "Block/Floor No"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ownerStreet, title: "Street"),
              SizedBox(height: 8),
              InputControls.textFieldInput(context, ownerSubdivision, title: "Subdivision"),
            ],
          ),
        ),
      ],
    );
  }

  businessAddressInfoEntry() {
    BusinessAddressInfoModel bai = BusinessAddressInfoModel(
      id: "",
      region: businessRegion,
      province: businessProvince,
      city_municipality: businessCityMunicipality,
      barangay: businessBarangay,
      zip_code: businessZipcode,
      house_bldg_no: businessHouseBldgNo.text,
      building_name: businessBldgName.text,
      lot_unit_no: businessLotUnitNo.text,
      block_floor_no: businessBlockFloorNo.text,
      street: businessStreet.text,
      subdivision: businessSubdivision.text,
      remarks: "",
    );
    _businessApplication.business_address_info = [bai];
    BusinessOwnerAddressInfoModel boai = BusinessOwnerAddressInfoModel(
      id: "",
      region: ownerRegion,
      province: ownerProvince,
      city_municipality: ownerCityMunicipality,
      barangay: ownerBarangay,
      zip_code: ownerZipcode,
      house_bldg_no: ownerHouseBldgNo.text,
      building_name: ownerBldgName.text,
      lot_unit_no: ownerLotUnitNo.text,
      block_floor_no: ownerBlockFloorNo.text,
      street: ownerStreet.text,
      subdivision: ownerSubdivision.text,
      remarks: "",
    );
    _businessApplication.business_owner_address_info = [boai];
  }
}
