// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class BusinessTypeModel {
  String id = "";
  String code = "";
  String organization_type = "";

  BusinessTypeModel(
    this.id,
    this.code,
    this.organization_type,
  );

  BusinessTypeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    organization_type = json["organization_type"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["organization_type"] = organization_type;
    return data;
  }
}