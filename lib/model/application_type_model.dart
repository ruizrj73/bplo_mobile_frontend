// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class ApplicationTypeModel {
  String id = "";
  String code = "";
  String permit_type = "";
  String group = "";

  ApplicationTypeModel(
    this.id,
    this.code,
    this.permit_type,
    this.group,
  );

  ApplicationTypeModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    permit_type = json["permit_type"];
    group = json["group"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["permit_type"] = permit_type;
    data["group"] = group;
    return data;
  }
}