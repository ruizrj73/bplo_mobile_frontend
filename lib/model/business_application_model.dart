// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

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
  String business_address = "";
  String tin_no = "";
  int requirement1 = 0;
  int requirement2 = 0;
  int requirement3 = 0;
  int requirement4 = 0;
  int requirement5 = 0;
  String remarks = "";
  String application_status = "";
  DateTime dateSaved;
  List<AttachmentModel> attachment = [];

  BusinessApplication(
    this.id,
    this.transaction_no,
    this.user_id,
    this.user_name,
    this.application_type,
    this.payment_type,
    this.tax_year,
    this.organization_type,
    this.business_name,
    this.business_address,
    this.tin_no,
    this.requirement1,
    this.requirement2,
    this.requirement3,
    this.requirement4,
    this.requirement5,
    this.remarks,
    this.application_status,
    this.dateSaved,
    this.attachment,
  );

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
    business_address = json["business_address"];
    tin_no = json["tin_no"];
    requirement1 = json["requirement1"];
    requirement2 = json["requirement2"];
    requirement3 = json["requirement3"];
    requirement4 = json["requirement4"];
    requirement5 = json["requirement5"];
    remarks = json["remarks"];
    application_status = json["application_status"];
    dateSaved = json["dateSaved"].toString() != "null" ? DateTime.parse(json["dateSaved"]) : null;

    if (json['attachment'] != null) {
      attachment = [];
      json['attachment'].forEach((a) {
        attachment.add(AttachmentModel.fromJson(a));
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
    data["business_address"] = business_address;
    data["tin_no"] = tin_no;
    data["requirement1"] = requirement1;
    data["requirement2"] = requirement2;
    data["requirement3"] = requirement3;
    data["requirement4"] = requirement4;
    data["requirement5"] = requirement5;
    data["remarks"] = remarks;
    data["application_status"] = application_status;
    data["dateSaved"] = dateSaved.toString();
    
    if (attachment != null) {
      data['attachment'] =
          attachment.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class AttachmentModel {
  String id = "";
  String file_type = "";
  String file_name = "";
  String file_url = "";
  String remarks = "";
  String status = "";

  AttachmentModel(
    this.id,
    this.file_type,
    this.file_name,
    this.file_url,
    this.remarks,
    this.status,
  );

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    file_type = json["file_type"];
    file_name = json["file_name"];
    file_url = json["file_url"];
    remarks = json["remarks"];
    status = json["status"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["file_type"] = file_type;
    data["file_name"] = file_name;
    data["file_url"] = file_url;
    data["remarks"] = remarks;
    data["status"] = status;
    return data;
  }
}