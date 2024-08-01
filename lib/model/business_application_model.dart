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
  String business_started_date = "";
  String business_permit_no = "";
  String business_permit_issued_date = "";
  String bir_permit_no = "";
  String bir_issued_date = "";
  String tin_no = "";
  String dtiseccda_registration_date = "";
  String dtiseccda_registration_no = "";
  String ctc_no = "";
  String ctc_issued_date = "";
  String plate_no = "";
  String signage_name = "";
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
  List<BusinessFindingsModel> business_findings = [];
  List<BusinessNoticeToComplyModel> business_notice_to_comply = [];
  BusinessRemarksModel business_remarks;
  LessorInfoModel lessor_info;
  BookkeeperInfoModel bookkeeper_info;
  AccountingFirmInfoModel accounting_firm_info;

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
    this.business_started_date,
    this.business_permit_no,
    this.business_permit_issued_date,
    this.bir_permit_no,
    this.bir_issued_date,
    this.tin_no,
    this.dtiseccda_registration_date,
    this.dtiseccda_registration_no,
    this.ctc_no,
    this.ctc_issued_date,
    this.plate_no,
    this.signage_name,
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
    this.business_findings,
    this.business_notice_to_comply,
    this.business_remarks,
    this.lessor_info,
    this.bookkeeper_info,
    this.accounting_firm_info,
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
    business_started_date = json["business_started_date"];
    business_permit_no = json["business_permit_no"];
    business_permit_issued_date = json["business_permit_issued_date"];
    bir_permit_no = json["bir_permit_no"];
    bir_issued_date = json["bir_issued_date"];
    tin_no = json["tin_no"];
    dtiseccda_registration_date = json["dtiseccda_registration_date"];
    dtiseccda_registration_no = json["dtiseccda_registration_no"];
    ctc_no = json["ctc_no"];
    ctc_issued_date = json["ctc_issued_date"];
    plate_no = json["plate_no"];
    signage_name = json["signage_name"];
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

    if (json['business_findings'] != null) {
      business_findings = [];
      json['business_findings'].forEach((a) {
        business_findings.add(BusinessFindingsModel.fromJson(a));
      });
    }

    if (json['business_notice_to_comply'] != null) {
      business_notice_to_comply = [];
      json['business_notice_to_comply'].forEach((a) {
        business_notice_to_comply.add(BusinessNoticeToComplyModel.fromJson(a));
      });
    }

    if (json['business_remarks'] != null) {
      business_remarks = BusinessRemarksModel.fromJson(json['business_remarks']);
    }

    if (json['lessor_info'] != null) {
      lessor_info = LessorInfoModel.fromJson(json['lessor_info']);
    }

    if (json['bookkeeper_info'] != null) {
      bookkeeper_info = BookkeeperInfoModel.fromJson(json['bookkeeper_info']);
    }

    if (json['accounting_firm_info'] != null) {
      accounting_firm_info = AccountingFirmInfoModel.fromJson(json['accounting_firm_info']);
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
    data["business_started_date"] = business_started_date;
    data["business_permit_no"] = business_permit_no;
    data["business_permit_issued_date"] = business_permit_issued_date;
    data["bir_permit_no"] = bir_permit_no;
    data["bir_issued_date"] = bir_issued_date;
    data["tin_no"] = tin_no;
    data["dtiseccda_registration_date"] = dtiseccda_registration_date;
    data["dtiseccda_registration_no"] = dtiseccda_registration_no;
    data["ctc_no"] = ctc_no;
    data["ctc_issued_date"] = ctc_issued_date;
    data["plate_no"] = plate_no;
    data["signage_name"] = signage_name;
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
      
      if (business_findings != null) {
        data['business_findings'] =
            business_findings.map((v) => v.toJson()).toList();
      }
      
      if (business_notice_to_comply != null) {
        data['business_notice_to_comply'] =
            business_notice_to_comply.map((v) => v.toJson()).toList();
      }
      
      if (business_remarks != null) {
        data['business_remarks'] = business_remarks.toJson();
      }
      
      if (lessor_info != null) {
        data['lessor_info'] = lessor_info.toJson();
      }
      
      if (bookkeeper_info != null) {
        data['bookkeeper_info'] = bookkeeper_info.toJson();
      }
      
      if (accounting_firm_info != null) {
        data['accounting_firm_info'] = accounting_firm_info.toJson();
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
  bool has_manager = false;
  bool is_same = false;
  String first_name = "";
  String middle_name = "";
  String last_name = "";
  String suffix = "";
  String gender = "";
  String corp_first_name = "";
  String corp_middle_name = "";
  String corp_last_name = "";
  String corp_suffix = "";
  String corp_gender = "";
  String remarks = "";

  BusinessOwnerInfoModel({
    this.id,
    this.has_manager,
    this.is_same,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.suffix,
    this.gender,
    this.corp_first_name,
    this.corp_middle_name,
    this.corp_last_name,
    this.corp_suffix,
    this.corp_gender,
    this.remarks,
  });

  BusinessOwnerInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    has_manager = json["has_manager"];
    is_same = json["is_same"];
    first_name = json["first_name"];
    middle_name = json["middle_name"];
    last_name = json["last_name"];
    suffix = json["suffix"];
    gender = json["gender"];
    corp_first_name = json["corp_first_name"];
    corp_middle_name = json["corp_middle_name"];
    corp_last_name = json["corp_last_name"];
    corp_suffix = json["corp_suffix"];
    gender = json["corp_gender"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["has_manager"] = has_manager;
    data["is_same"] = is_same;
    data["first_name"] = first_name;
    data["middle_name"] = middle_name;
    data["last_name"] = last_name;
    data["suffix"] = suffix;
    data["gender"] = gender;
    data["corp_first_name"] = corp_first_name;
    data["corp_middle_name"] = corp_middle_name;
    data["corp_last_name"] = corp_last_name;
    data["corp_suffix"] = corp_suffix;
    data["corp_gender"] = corp_gender;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessContactInfoModel {
  String id = "";
  String mobile_number = "";
  String tel_fax_number = "";
  String email_address = "";
  String business_mobile_number = "";
  String business_tel_fax_number = "";
  String business_email_address = "";
  String remarks = "";

  BusinessContactInfoModel({
    this.id,
    this.mobile_number,
    this.tel_fax_number,
    this.email_address,
    this.business_mobile_number,
    this.business_tel_fax_number,
    this.business_email_address,
    this.remarks,
});

  BusinessContactInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    mobile_number = json["mobile_number"];
    tel_fax_number = json["tel_fax_number"];
    email_address = json["email_address"];
    business_mobile_number = json["business_mobile_number"];
    business_tel_fax_number = json["business_tel_fax_number"];
    business_email_address = json["business_email_address"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["mobile_number"] = mobile_number;
    data["tel_fax_number"] = tel_fax_number;
    data["email_address"] = email_address;
    data["business_mobile_number"] = business_mobile_number;
    data["business_tel_fax_number"] = business_tel_fax_number;
    data["business_email_address"] = business_email_address;
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
  bool is_same = false;
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
    this.is_same,
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
    is_same = json["is_same"];
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
    data["is_same"] = is_same;
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
  int supervisor = 0;
  int rank_and_file = 0;
  int cashier = 0;
  int on_field = 0;
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
    this.supervisor,
    this.rank_and_file,
    this.cashier,
    this.on_field,
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
    supervisor = json["supervisor"];
    rank_and_file = json["rank_and_file"];
    cashier = json["cashier"];
    on_field = json["on_field"];
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
    data["supervisor"] = supervisor;
    data["rank_and_file"] = rank_and_file;
    data["cashier"] = cashier;
    data["on_field"] = on_field;
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

class BusinessFindingsModel {
  String id = "";
  String remarks = "";

  BusinessFindingsModel({
    this.id,
    this.remarks,
});

  BusinessFindingsModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessNoticeToComplyModel {
  String id = "";
  String remarks = "";

  BusinessNoticeToComplyModel({
    this.id,
    this.remarks,
});

  BusinessNoticeToComplyModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["remarks"] = remarks;
    return data;
  }
}

class BusinessRemarksModel {
  String id = "";
  String remarks = "";

  BusinessRemarksModel({
    this.id,
    this.remarks,
});

  BusinessRemarksModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["remarks"] = remarks;
    return data;
  }
}

class LessorInfoModel {
  String id = "";
  String first_name = "";
  String middle_name = "";
  String last_name = "";
  String suffix = "";
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
  String mobile_number = "";
  String tel_fax_number = "";
  String email_address = "";
  String remarks = "";

  LessorInfoModel({
    this.id,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.suffix,
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
    this.mobile_number,
    this.tel_fax_number,
    this.email_address,
    this.remarks,
});

  LessorInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    first_name = json["first_name"];
    middle_name = json["middle_name"];
    last_name = json["last_name"];
    suffix = json["suffix"];
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
    mobile_number = json["mobile_number"];
    tel_fax_number = json["tel_fax_number"];
    email_address = json["email_address"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["first_name"] = first_name;
    data["middle_name"] = middle_name;
    data["last_name"] = last_name;
    data["suffix"] = suffix;
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
    data["mobile_number"] = mobile_number;
    data["tel_fax_number"] = tel_fax_number;
    data["email_address"] = email_address;
    data["remarks"] = remarks;
    return data;
  }
}

class BookkeeperInfoModel {
  String id = "";
  String first_name = "";
  String middle_name = "";
  String last_name = "";
  String suffix = "";
  String mobile_number = "";
  String tel_fax_number = "";
  String email_address = "";
  String accounting_audit_certificate = "";
  String remarks = "";

  BookkeeperInfoModel({
    this.id,
    this.first_name,
    this.middle_name,
    this.last_name,
    this.suffix,
    this.mobile_number,
    this.tel_fax_number,
    this.email_address,
    this.accounting_audit_certificate,
    this.remarks,
});

  BookkeeperInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    first_name = json["first_name"];
    middle_name = json["middle_name"];
    last_name = json["last_name"];
    suffix = json["suffix"];
    mobile_number = json["mobile_number"];
    tel_fax_number = json["tel_fax_number"];
    email_address = json["email_address"];
    accounting_audit_certificate = json["accounting_audit_certificate"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["first_name"] = first_name;
    data["middle_name"] = middle_name;
    data["last_name"] = last_name;
    data["suffix"] = suffix;
    data["mobile_number"] = mobile_number;
    data["tel_fax_number"] = tel_fax_number;
    data["email_address"] = email_address;
    data["accounting_audit_certificate"] = accounting_audit_certificate;
    data["remarks"] = remarks;
    return data;
  }
}

class AccountingFirmInfoModel {
  String id = "";
  String name = "";
  String address = "";
  String mobile_number = "";
  String tel_fax_number = "";
  String email_address = "";
  String accounting_audit_certificate = "";
  String remarks = "";

  AccountingFirmInfoModel({
    this.id,
    this.name,
    this.address,
    this.mobile_number,
    this.tel_fax_number,
    this.email_address,
    this.accounting_audit_certificate,
    this.remarks,
});

  AccountingFirmInfoModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    address = json["address"];
    mobile_number = json["mobile_number"];
    tel_fax_number = json["tel_fax_number"];
    email_address = json["email_address"];
    accounting_audit_certificate = json["accounting_audit_certificate"];
    remarks = json["remarks"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["name"] = name;
    data["address"] = address;
    data["mobile_number"] = mobile_number;
    data["tel_fax_number"] = tel_fax_number;
    data["email_address"] = email_address;
    data["accounting_audit_certificate"] = accounting_audit_certificate;
    data["remarks"] = remarks;
    return data;
  }
}