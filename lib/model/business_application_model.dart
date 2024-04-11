// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

import 'dart:typed_data';

class BusinessApplicationList {
  List<BusinessApplication> application = [];

  BusinessApplicationList({this.application});

  BusinessApplicationList.fromJson(Map<String, dynamic> json) {
    if (json['application'] != null) {
      application = [];
      json['application'].forEach((v) {
        application.add(BusinessApplication.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (application != null) {
      data['application'] =
          application.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusinessApplication {
  String id = "";
  String transaction_no = "";
  String user_id = "";
  String user_name = "";
  String application_type = "";
  String payment_type = "";
  String tax_year = "";
  String organization_type = "";
  String business_name = "";
  String trade_name = "";
  String tin_no = "";
  String dtiseccda_registration_date = "";
  String dtiseccda_registration_no = "";
  String remarks = "";
  String application_status = "";
  List<AttachmentModel> attachment = [];
  List<BusinessOwnerInfoModel> business_owner_info = [];
  List<BusinessContactInfoModel> business_contact_info = [];
  List<BusinessAddressInfoModel> business_address_info = [];
  List<BusinessOwnerAddressInfoModel> business_owner_address_info = [];
  BusinessOperationInfoModel business_operation_info;
  List<LineOfBusinessModel> line_of_business = [];
  List<MeasurePaxModel> line_of_business_measure_pax = [];

  BusinessApplication({
    this.id,
    this.transaction_no,
    this.user_id,
    this.user_name,
    this.application_type,
    this.payment_type,
    this.tax_year,
    this.organization_type,
    this.business_name,
    this.trade_name,
    this.tin_no,
    this.dtiseccda_registration_date,
    this.dtiseccda_registration_no,
    this.remarks,
    this.application_status,
    this.attachment,
    this.business_owner_info,
    this.business_contact_info,
    this.business_address_info,
    this.business_owner_address_info,
    this.business_operation_info,
    this.line_of_business,
    this.line_of_business_measure_pax,
  });

  BusinessApplication.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    transaction_no = json["transaction_no"];
    user_id = json["user_id"];
    user_name = json["user_name"];
    application_type = json["application_type"];
    payment_type = json["payment_type"];
    tax_year = json["tax_year"];
    organization_type = json["organization_type"];
    business_name = json["business_name"];
    trade_name = json["trade_name"];
    tin_no = json["tin_no"];
    dtiseccda_registration_date = json["dtiseccda_registration_date"];
    dtiseccda_registration_no = json["dtiseccda_registration_no"];
    remarks = json["remarks"];
    application_status = json["application_status"];

    if (json['attachment'] != null) {
      attachment = [];
      json['attachment'].forEach((a) {
        attachment.add(AttachmentModel.fromJson(a));
      });
    }

    if (json['business_owner_info'] != null) {
      business_owner_info = [];
      json['business_owner_info'].forEach((a) {
        business_owner_info.add(BusinessOwnerInfoModel.fromJson(a));
      });
    }

    if (json['business_contact_info'] != null) {
      business_contact_info = [];
      json['business_contact_info'].forEach((a) {
        business_contact_info.add(BusinessContactInfoModel.fromJson(a));
      });
    }

    if (json['business_address_info'] != null) {
      business_address_info = [];
      json['business_address_info'].forEach((a) {
        business_address_info.add(BusinessAddressInfoModel.fromJson(a));
      });
    }

    if (json['business_owner_address_info'] != null) {
      business_owner_address_info = [];
      json['business_owner_address_info'].forEach((a) {
        business_owner_address_info.add(BusinessOwnerAddressInfoModel.fromJson(a));
      });
    }

    if (json['business_operation_info'] != null) {
      business_operation_info = BusinessOperationInfoModel.fromJson(json['business_operation_info']);
    }

    if (json['line_of_business'] != null) {
      line_of_business = [];
      json['line_of_business'].forEach((a) {
        line_of_business.add(LineOfBusinessModel.fromJson(a));
      });
    }

    if (json['line_of_business_measure_pax'] != null) {
      line_of_business_measure_pax = [];
      json['line_of_business_measure_pax'].forEach((a) {
        line_of_business_measure_pax.add(MeasurePaxModel.fromJson(a));
      });
    }
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["transaction_no"] = transaction_no;
    data["user_id"] = user_id;
    data["user_name"] = user_name;
    data["application_type"] = application_type;
    data["payment_type"] = payment_type;
    data["tax_year"] = tax_year;
    data["organization_type"] = organization_type;
    data["business_name"] = business_name;
    data["trade_name"] = trade_name;
    data["tin_no"] = tin_no;
    data["dtiseccda_registration_date"] = dtiseccda_registration_date;
    data["dtiseccda_registration_no"] = dtiseccda_registration_no;
    data["remarks"] = remarks;
    data["application_status"] = application_status;

    if (!forLocalDb) {
      if (attachment != null) {
        data['attachment'] =
            attachment.map((v) => v.toJson()).toList();
      }
      
      if (business_owner_info != null) {
        data['business_owner_info'] =
            business_owner_info.map((v) => v.toJson()).toList();
      }
      
      if (business_contact_info != null) {
        data['business_contact_info'] =
            business_contact_info.map((v) => v.toJson()).toList();
      }
      
      if (business_address_info != null) {
        data['business_address_info'] =
            business_address_info.map((v) => v.toJson()).toList();
      }
      
      if (business_owner_address_info != null) {
        data['business_owner_address_info'] =
            business_owner_address_info.map((v) => v.toJson()).toList();
      }
      
      if (business_operation_info != null) {
        data['business_operation_info'] = business_operation_info.toJson();
      }
      
      if (line_of_business != null) {
        data['line_of_business'] =
            line_of_business.map((v) => v.toJson()).toList();
      }
      
      if (line_of_business_measure_pax != null) {
        data['line_of_business_measure_pax'] =
            line_of_business_measure_pax.map((v) => v.toJson()).toList();
      }
    }

    return data;
  }
}

class AttachmentModel {
  String id = "";
  String file_type = "";
  String file_name = "";
  String file_description = "";
  String file_url = "";
  String remarks = "";
  String status = "";
  Uint8List xfile;

  AttachmentModel(
    this.id,
    this.file_type,
    this.file_name,
    this.file_description,
    this.file_url,
    this.remarks,
    this.status,
    this.xfile,
  );

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    file_type = json["file_type"];
    file_name = json["file_name"];
    file_description = json["file_description"];
    file_url = json["file_url"];
    remarks = json["remarks"];
    status = json["status"];
    xfile = json["xfile"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["file_type"] = file_type;
    data["file_name"] = file_name;
    data["file_description"] = file_description;
    data["file_url"] = file_url;
    data["remarks"] = remarks;
    data["status"] = status;
    data["xfile"] = xfile;
    return data;
  }
}

class BusinessOwnerInfoModel {
  String id = "";
  String first_name = "";
  String middle_name = "";
  String last_name = "";
  String suffix = "";
  String gender = "";
  String remarks = "";

  BusinessOwnerInfoModel({
    this.id,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.suffix,
    this.gender,
    this.remarks,
  });

  BusinessOwnerInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    first_name = json["first_name"];
    middle_name = json["middle_name"];
    last_name = json["last_name"];
    suffix = json["suffix"];
    gender = json["gender"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["first_name"] = first_name;
    data["middle_name"] = middle_name;
    data["last_name"] = last_name;
    data["suffix"] = suffix;
    data["gender"] = gender;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessContactInfoModel {
  String id = "";
  String mobile_number = "";
  String tel_fax_number = "";
  String email_address = "";
  String remarks = "";

  BusinessContactInfoModel({
    this.id,
    this.mobile_number,
    this.tel_fax_number,
    this.email_address,
    this.remarks,
});

  BusinessContactInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    mobile_number = json["mobile_number"];
    tel_fax_number = json["tel_fax_number"];
    email_address = json["email_address"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["mobile_number"] = mobile_number;
    data["tel_fax_number"] = tel_fax_number;
    data["email_address"] = email_address;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessAddressInfoModel {
  String id = "";
  String region = "";
  String province = "";
  String city_municipality = "";
  String barangay = "";
  String zip_code = "";
  String house_bldg_no = "";
  String building_name = "";
  String lot_unit_no = "";
  String block_floor_no = "";
  String street = "";
  String subdivision = "";
  String remarks = "";

  BusinessAddressInfoModel({
    this.id,
    this.region,
    this.province,
    this.city_municipality,
    this.barangay,
    this.zip_code,
    this.house_bldg_no,
    this.building_name,
    this.lot_unit_no,
    this.block_floor_no,
    this.street,
    this.subdivision,
    this.remarks,
  });

  BusinessAddressInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    region = json["region"];
    province = json["province"];
    city_municipality = json["city_municipality"];
    barangay = json["barangay"];
    zip_code = json["zip_code"];
    house_bldg_no = json["house_bldg_no"];
    building_name = json["building_name"];
    lot_unit_no = json["lot_unit_no"];
    block_floor_no = json["block_floor_no"];
    street = json["street"];
    subdivision = json["subdivision"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["region"] = region;
    data["province"] = province;
    data["city_municipality"] = city_municipality;
    data["barangay"] = barangay;
    data["zip_code"] = zip_code;
    data["house_bldg_no"] = house_bldg_no;
    data["building_name"] = building_name;
    data["lot_unit_no"] = lot_unit_no;
    data["block_floor_no"] = block_floor_no;
    data["street"] = street;
    data["subdivision"] = subdivision;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessOwnerAddressInfoModel {
  String id = "";
  String region = "";
  String province = "";
  String city_municipality = "";
  String barangay = "";
  String zip_code = "";
  String house_bldg_no = "";
  String building_name = "";
  String lot_unit_no = "";
  String block_floor_no = "";
  String street = "";
  String subdivision = "";
  String remarks = "";

  BusinessOwnerAddressInfoModel({
    this.id,
    this.region,
    this.province,
    this.city_municipality,
    this.barangay,
    this.zip_code,
    this.house_bldg_no,
    this.building_name,
    this.lot_unit_no,
    this.block_floor_no,
    this.street,
    this.subdivision,
    this.remarks,
  });

  BusinessOwnerAddressInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    region = json["region"];
    province = json["province"];
    city_municipality = json["city_municipality"];
    barangay = json["barangay"];
    zip_code = json["zip_code"];
    house_bldg_no = json["house_bldg_no"];
    building_name = json["building_name"];
    lot_unit_no = json["lot_unit_no"];
    block_floor_no = json["block_floor_no"];
    street = json["street"];
    subdivision = json["subdivision"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["region"] = region;
    data["province"] = province;
    data["city_municipality"] = city_municipality;
    data["barangay"] = barangay;
    data["zip_code"] = zip_code;
    data["house_bldg_no"] = house_bldg_no;
    data["building_name"] = building_name;
    data["lot_unit_no"] = lot_unit_no;
    data["block_floor_no"] = block_floor_no;
    data["street"] = street;
    data["subdivision"] = subdivision;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessOperationInfoModel {
  String id = "";
  String business_activity = "";
  double business_area = 0;
  double total_floor_area = 0;
  int number_male_employee = 0;
  int number_female_employee = 0;
  int total_number_employee_establishment = 0;
  int total_number_employee_residing_lgu = 0;
  bool has_delivery_vehicles = false;
  int total_delivery_vehicle_van_truck = 0;
  int total_delivery_vehicle_motorcycle = 0;
  String place_owned_rented = "";
  String taxdec_number = "";
  String property_index_number = "";
  String government_tax_incentives_enjoy = "";
  String community_tax_certificate = "";
  String barangay_micro_business_enterprise_registered = "";
  String bangko_sentral_registered = "";
  String remarks = "";

  BusinessOperationInfoModel({
    this.id,
    this.business_activity,
    this.business_area,
    this.total_floor_area,
    this.number_male_employee,
    this.number_female_employee,
    this.total_number_employee_establishment,
    this.total_number_employee_residing_lgu,
    this.has_delivery_vehicles,
    this.total_delivery_vehicle_van_truck,
    this.total_delivery_vehicle_motorcycle,
    this.place_owned_rented,
    this.taxdec_number,
    this.property_index_number,
    this.government_tax_incentives_enjoy,
    this.community_tax_certificate,
    this.barangay_micro_business_enterprise_registered,
    this.bangko_sentral_registered,
    this.remarks,
  });

  BusinessOperationInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    business_activity = json["business_activity"];
    business_area = double.parse((json["business_area"] ?? 0).toString());
    total_floor_area = double.parse((json["total_floor_area"] ?? 0).toString());
    number_male_employee = json["number_male_employee"];
    number_female_employee = json["number_female_employee"];
    total_number_employee_establishment = json["total_number_employee_establishment"];
    total_number_employee_residing_lgu = json["total_number_employee_residing_lgu"];
    has_delivery_vehicles = json["has_delivery_vehicles"] == "1" || json["has_delivery_vehicles"].toString() == "true" ? true : false;
    total_delivery_vehicle_van_truck = json["total_delivery_vehicle_van_truck"];
    total_delivery_vehicle_motorcycle = json["total_delivery_vehicle_motorcycle"];
    place_owned_rented = json["place_owned_rented"];
    taxdec_number = json["taxdec_number"];
    property_index_number = json["property_index_number"];
    government_tax_incentives_enjoy = json["government_tax_incentives_enjoy"];
    community_tax_certificate = json["community_tax_certificate"];
    barangay_micro_business_enterprise_registered = json["barangay_micro_business_enterprise_registered"];
    bangko_sentral_registered = json["bangko_sentral_registered"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["business_activity"] = business_activity;
    data["business_area"] = business_area;
    data["total_floor_area"] = total_floor_area;
    data["number_male_employee"] = number_male_employee;
    data["number_female_employee"] = number_female_employee;
    data["total_number_employee_establishment"] = total_number_employee_establishment;
    data["total_number_employee_residing_lgu"] = total_number_employee_residing_lgu;
    data["has_delivery_vehicles"] = has_delivery_vehicles;
    data["total_delivery_vehicle_van_truck"] = total_delivery_vehicle_van_truck;
    data["total_delivery_vehicle_motorcycle"] = total_delivery_vehicle_motorcycle;
    data["place_owned_rented"] = place_owned_rented;
    data["taxdec_number"] = taxdec_number;
    data["property_index_number"] = property_index_number;
    data["government_tax_incentives_enjoy"] = government_tax_incentives_enjoy;
    data["community_tax_certificate"] = community_tax_certificate;
    data["barangay_micro_business_enterprise_registered"] = barangay_micro_business_enterprise_registered;
    data["bangko_sentral_registered"] = bangko_sentral_registered;
    data["remarks"] = remarks;
    return data;
  }
}

class LineOfBusinessModel {
  String id = "";
  String code;
  String line_of_business;
  String application_type;
  double capital_investment;
  double gross_essential;
  double gross_non_essential;
  int units;
  String remarks;

  LineOfBusinessModel({
    this.id,
    this.code,
    this.line_of_business,
    this.application_type,
    this.capital_investment,
    this.gross_essential,
    this.gross_non_essential,
    this.units,
    this.remarks,
  });

  LineOfBusinessModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    line_of_business = json["line_of_business"];
    application_type = json["application_type"];
    capital_investment = double.parse(json["capital_investment"].toString());
    gross_essential = double.parse(json["gross_essential"].toString());
    gross_non_essential = double.parse(json["gross_non_essential"].toString());
    units = json["units"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["line_of_business"] = line_of_business;
    data["application_type"] = application_type;
    data["capital_investment"] = capital_investment;
    data["gross_essential"] = gross_essential;
    data["gross_non_essential"] = gross_non_essential;
    data["units"] = units;
    data["remarks"] = remarks;
    return data;
  }
}

class MeasurePaxModel {
  String id = "";
  String line_of_business;
  String measure_description;
  int number_of_units;
  int capacity;
  String remarks;

  MeasurePaxModel({
    this.id,
    this.line_of_business,
    this.measure_description,
    this.number_of_units,
    this.capacity,
    this.remarks,
  });

  MeasurePaxModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    line_of_business = json["line_of_business"];
    measure_description = json["measure_description"];
    number_of_units = json["number_of_units"];
    capacity = json["capacity"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["line_of_business"] = line_of_business;
    data["measure_description"] = measure_description;
    data["number_of_units"] = number_of_units;
    data["capacity"] = capacity;
    data["remarks"] = remarks;
    return data;
  }
}
