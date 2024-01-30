// ignore_for_file: unnecessary_new, prefer_collection_literals, non_constant_identifier_names

class ApplicationStatusModel {
  String id = "";
  String code = "";
  String application_type = "";
  String group = "";

  ApplicationStatusModel(
    this.id,
    this.code,
    this.application_type,
    this.group,
  );

  ApplicationStatusModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    code = json["code"];
    application_type = json["application_type"];
    group = json["group"];
  }

  Map<String, dynamic> toJson({bool forLocalDb = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = id;
    data["code"] = code;
    data["application_type"] = application_type;
    data["group"] = group;
    return data;
  }
}